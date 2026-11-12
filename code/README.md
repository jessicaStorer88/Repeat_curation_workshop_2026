# Pipeline

Below is the series of steps needed to prepare your own repeat library for curation. We will go over them, one by one, and you can find the individual scripts in this folder. For this workshop, we are using the fire ant (*Solenopsis invicta*) as an example.

0. (Optional) [How to download a genome assembly from NCBI](#0-downloading-the-fire-ant-solenopsis-invicta-genome-assembly)
1. [*De novo* repeat discovery](#1-de-novo-repeat-discovery)
2. [Collect more copies](#2-collect-more-copies)
3. [Generate seed alignments](#3-generate-seed-alignments)
4. [Extending seed alignments](#4-extending-seed-alignments)
5. [Get fasta consensus and elements](#4-extending-seed-alignments)
6. [Run ```alignAndCallConsensus.pl``` for each model](#5-get-fasta-consensus-and-elements) 
7. [Directory reorganization](#7-directory-reorganization)


## 0. Downloading the fire ant (*Solenopsis invicta*) genome assembly

To download a genome assembly from NCBI, we need to know the accession number of the genome assembly. In our case, for fire ant (*Solenopsis invicta*), that is `GCF_047496725.1`.

Now, we need the `datasets` software that we can set up in a conda environment ([see here for more detailed information about it](https://github.com/ncbi/datasets))

```
conda install -n ncbi-datasets -c conda-forge ncbi-datasets-cli
```

Let's activate our conda environment and donwload the genome assembly: 

```
conda activate ncbi-datasets
datasets download genome accession GCF_047496725.1
```

This is going to download a `ncbi_dataset.zip` file, that we need to uncompress. Once that's done, we need to move the genome file out of the folder, and clean the rest of the files we will not be using.

```
unzip ncbi_dataset.zip
mv ncbi_dataset/data/GCF_047496725.1/GCF_047496725.1_ASM4749672v1_genomic.fna .
rm -rf ncbi_dataset md5sum.txt README.md ncbi_dataset.zip 
```

## 1. *De novo* repeat discovery (Running `RepeatModeler2`)

The first step in de novo repeat discovery is running a *de novo* program. Below is how to run `RepeatModeler2` via a submitted slurm script and a via the `dfam-tetools` container:

```
sbatch RepeatModeler.sh
```


``` 
#!/bin/bash
#SBATCH --job-name=modeler_fire
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mem=100G
#SBATCH --mail-type=END
#SBATCH --mail-user=<YOUREMAILHERE>
#SBATCH -o %x_%j.stdout
#SBATCH -e %x_%j.stderr
#SBATCH --partition=general
#SBATCH --qos=general
 
source ~/.bashrc
PATH_TO_CONTAINER=/path/to/your/dfam-tetools-script
WD=/path/to/your/working/directory 
cd $WD
 
GENOME=GCF_047496725.1_ASM4749672v1_genomic.fna
DB=fire_ant
 
# Step 1: build the database
$PATH_TO_CONTAINER/dfam-tetools.sh --singularity -- \
    BuildDatabase -name $DB $GENOME
 
# Step 2: run RepeatModeler (-LTRStruct adds the LTR structural pipeline)
$PATH_TO_CONTAINER/dfam-tetools.sh --singularity -- \
    RepeatModeler -database $DB -threads 16 -LTRStruct
```

 
The first step is to create a database using your genome of interest via `BuildDatabase`, while the second is to run `RepeatModeler2` based on the database generated in the first step. To make this script work for your genome, change the directory (`cd /path/to/working/directory`), `GENOME` and `DB` in the script above.


Although the `-LTRStuct` option is available, it often produces single-copy “families” in the RepeatModeler2 output. Unless your genome contains a higher number of ERV elements and/or you would like to have lower copy ERVs visualized, this option should be used with caution.


## 2. Collect more copies (Running `RepeatMasker`)

The second step is to run `RepeatMasker` to competitively collect more copies. The submitted slurm script is:

```
sbatch RepeatMasker.sh
```

```
#!/bin/bash
#SBATCH --job-name=masker_fireAnt
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mail-type=END
#SBATCH --mem=100G
#SBATCH --mail-user=<YOUREMAILHERE>
#SBATCH -o %x_%j.stdout
#SBATCH -e %x_%j.stderr
#SBATCH --partition=general
#SBATCH --qos=general
 
source ~/.bashrc
PATH_TO_CONTAINER=/path/to/your/dfam-tetools-script
WD=/path/to/your/working/directory 
cd $WD
 
OUTPUT_NAME="fireant_RM"
LIBRARY=$WD/fire_ant/fire_ant-families.fa
GENOME=$WD/fire_ant/GCF_047496725.1_ASM4749672v1_genomic.fna
 
$PATH_TO_CONTAINER/dfam-tetools.sh --singularity -- \
    RepeatMasker -s -pa 24 -lib ${LIBRARY} -a ${GENOME} -dir ${OUTPUT_NAME}

```

The `LIBRARY` is composed of the `RepeatModeler2` consensus sequences generated in the previous step. The `OUTPUT_NAME` is a user-generated directory where you would like the output placed. If a name is not specified, the output will be generated wherever the genome is.


FamDB git: https://github.com/Dfam-consortium/famdb

## 3. Generate seed alignments


To visualize the models and extend for the next step, we need to generate seed alignments per RM2 predicted model. 

```
sbatch generateSeedAlign.sh
```


```
#!/bin/bash
#SBATCH --job-name=generateSeed_fire_ant
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mail-type=END
#SBATCH --mem=50G
#SBATCH --mail-user=<YOUREMAILHERE>
#SBATCH -o %x_%j.stdout
#SBATCH -e %x_%j.stderr
#SBATCH --partition=general
#SBATCH --qos=general
 
source ~/.bashrc
PATH_TO_CONTAINER=/path/to/your/dfam-tetools-script
WD=/path/to/your/working/directory 
cd $WD
 
STK_OUTPUT=$WD/fire_ant/stk
GENOME=$WD/fire_ant/GCF_047496725.1_ASM4749672v1_genomic.2bit
ALIGN=$WD/fire_ant/fireant_RM/GCF_047496725.1_ASM4749672v1_genomic.fna.align
 
$PATH_TO_CONTAINER/dfam-tetools.sh--singularity -- \
    /opt/RepeatModeler/util/generateSeedAlignments.pl -taxon "Solenopsis invicta" -assemblyFile ${GENOME} ${ALIGN}
```

You will need to specify the working directory, where to put the stk (`.stk` Stockholm alignment) file output (`STK_OUTPUT`), the genome (`GENOME`), the location of the `.align` output from `RepeatMasker` (`ALIGN`). You will also need to update the `-taxon` option passed to the `generateSeedAlignments.pl` program. 

## 4. Extending seed alignments
 
The next step is to extend the models. *De novo* repeat finders are working with genomes that are a mix of old, young, truncated and full-length models, with a high potential to provide truncated models as output. Therefore, extension of the models discovered is necessary.

```
sbatch extendSeedAlignments.sh
```


```
#!/bin/bash
#SBATCH --job-name=ramExtend_fire_ant
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mail-type=END
#SBATCH --mem=50G
#SBATCH --mail-user=<YOUREMAILHERE>
#SBATCH -o %x_%j.stdout
#SBATCH -e %x_%j.stderr
#SBATCH --partition=general
#SBATCH --qos=general
 
PATH_TO_CONTAINER=/path/to/your/dfam-tetools-script
$PATH_TO_CONTAINER/dfam-tetools.sh --singularity -- bash -c '
STK_OUTPUT=$WD/fire_ant/stk
EXTENDED_STK=$WD/fire_ant/stk/extended
GENOME=$WD/fire_ant/GCF_047496725.1_ASM4749672v1_genomic.2bit
 
for infile in ${STK_OUTPUT}/*.stk
do
  prefix=$(basename ${infile} | cut -d "." -f 1)
  perl /opt/RepeatAfterMe/util/extend-stk.pl \
    -assembly ${GENOME} \
    -input ${infile} \
    -output ${EXTENDED_STK}/${prefix}-extended.stk
done
'
```
 
You will need to change the `STK_OUTPUT` (output from the previous step), `EXTENDED_STK` (output of the program), and `GENOME` parameters passed to the `extend-stk.pl` program.

> **Note** that there is a difference with the other scripts and this one in how the `dfam-tetools` container is called. On the mantis cluster, there is a limit to how many times a user can pull a singularity image. By calling the container in this way, you only pull the image once. 

> **IMPORTANT** :warning:
> If model extension is required as part of the manual curation process on a per-model basis, the extended element files <b><ins><i>must</b></ins></i> be reformatted before proceeding, otherwise subsequent utilities produce errors. This is a known bug. As a workaround, we have developed a short re-formatting script, [changeFastaFmt.py](changeFastaFmt.py) to strip the tailing orientation characters. Subsequent polishing with ```alignAndCallConsensus.pl``` is needed to re-name the the sequences in the .out file, as this is the input for the ```extendFlankingSeqs.pl``` program. 

### Steps

- [Step 1: reformat model instances](#step-1--reformat-model-instances)
- [Step 2: polish model with re-named sequences](#step-2--polish-model-with-re-named-sequences)
    - [The usage of ```extendFlankingSeqs.pl``` for each model](#the-usage-of-extendflankingseqspl-for-each-model)

#### Step 1: reformat model instances

> See more detailed explanation [here](./changeFastaFmt.md)

```
python changeFastaFmt.py <extended.elements.fa> <extended_rename.elements.fa>
```

The first argument is the current extended elements file that you have after running the initial pipeline, the second argument is the new name of this file. A suggested naming format is `<model-name>-extended.elements.fa`


#### Step 2 : polish model with re-named sequences

```
~/RepeatModeler-2.0.7/util/alignAndCallConsensus.pl -c <extended.con.fa> -e <extended_rename.elements.fa> -ma 14 -ht -re
```

Running `alignAndCallConsensus.pl` will iterate across all instances to form a new consensus with the correct format and allow for per-model extension using `extendFlankingSeqs.pl`


##### The usage of `extendFlankingSeqs.pl` for each model

```
extendFlankingSeqs.pl  -f(lank) ## -d(atabase) <2bit genome file> -i(nput) <cross_match .out file> -o(utput) <elements fasta file>
```

You must specify a number by which you would like to extend each side of your sequences via `-f(lank)`. The output produces longer element sequences which will be used in `alignAndCallConsensus.pl` to extend the edges of your model. 


## 5. Get `FASTA` consensus and elements

In order to polish the consensus sequences and visualize each model, you will need to extract out the consensus and contributing elements in FASTA format. This is accomplished via the `Linup` program:

```
sbatch linup.sh
```


```
#!/bin/bash
#SBATCH --job-name=linup_fire_ant
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mem=50G
#SBATCH --mail-type=END
#SBATCH --mail-user=<YOUREMAILHERE>
#SBATCH -o %x_%j.stdout
#SBATCH -e %x_%j.stderr
#SBATCH --partition=general
#SBATCH --qos=general

PATH_TO_CONTAINER=/path/to/your/dfam-tetools-script
$PATH_TO_CONTAINER/dfam-tetools.sh --singularity -- bash -c '
EXTENDED_STK=$WD/fire_ant/stk/extended
CONSENSUS_ELEMENTS=$WD/fire_ant/stk/extended/con_elements

mkdir -p $WD/stk/extended/con_elements

for infile in ${EXTENDED_STK}/*.stk
do
    prefix=$(basename ${infile} | cut -d "." -f 1)
    /opt/RepeatModeler/util/Linup ${infile} -consensus > ${CONSENSUS_ELEMENTS}/{prefix}.con.fa
    /opt/RepeatModeler/util/Linup ${infile} -fasta > ${CONSENSUS_ELEMENTS}/{prefix}.elements.fa
done
'
```

You will need to change `EXTENDED_STK` (output from previous step) and `CONSENSUS_ELEMENTS` (output of the program).


## 6. Run `alignAndCallConsensus.pl` for each model

In order to get the initial visualizations and starting input/output for each model, you will need to run `alignAndCallConsensus.pl` on each generated consensus/element fasta file pair. The program below is designed to loop through all putative models.

```
sbatch alignAndCallCon.sh
```



```
#!/bin/bash
#SBATCH --job-name=alignAndCall_fire_ant
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mail-type=END
#SBATCH --mem=50G
#SBATCH --mail-user=<YOUREMAILHERE>
#SBATCH -o %x_%j.stdout
#SBATCH -e %x_%j.stderr
#SBATCH --partition=general
#SBATCH --qos=general

PATH_TO_CONTAINER=/path/to/your/dfam-tetools-script

$PATH_TO_CONTAINER/dfam-tetools.sh --singularity -- bash -c '
CONSENSUS_ELEMENTS=$WD/fire_ant/stk/extended/con_elements

for infile in ${CONSENSUS_ELEMENTS}/*.con.fa
do
    prefix=$(basename ${infile} | cut -d "." -f 1)
    /opt/RepeatModeler/util/alignAndCallConsensus.pl -c ${infile} -e ${CONSENSUS_ELEMENTS}/${prefix}.elements.fa -ht -re 

done
'
```

You will need to change `CONSENSUS_ELEMENTS` (output from previous step)

### 7. Directory reorganization

Depending on how all the programs are run, files for all of the models may all be in one folder. If you would like to move all files corresponding to one model into their own folder, this script can do that for you.

```
./dirReorg.sh
```


```
#!/usr/bin/bash
WD=/path/to/your/working/directory
input_dir="$WD/aus_workshop/fire_ant/stk/extended/con_elements/"

# The directory you want to move files from
DIR1="$WD/aus_workshop/fire_ant/stk/extended/con_elements/"

# Output base directory
out_base="$WD/aus_workshop/fire_ant"

mkdir -p "$out_base"

# Loop through each .ali file
for infile in "$input_dir"/*.ali; do

    # get filename without path
    fname=$(basename "$infile")

    # extract prefix before first dot
    prefix=$(echo "$fname" | cut -d "." -f 1)

    # make output directory for this prefix
    outdir="$out_base/$prefix"
    mkdir -p "$outdir"

    echo "Processing prefix: $prefix"

    # move matching files from DIR1 and DIR2
    mv "$DIR1"/${prefix}.* "$outdir"/ 
    mv "$DIR1"/${prefix}-* "$outdir"/

done
```

Make sure to change `input_dir`, `input_dir`, `DIR1`, and `out_base`


### Useful links

- RepeatMasker: https://github.com/Dfam-consortium/RepeatMasker 
- RepeatModeler: https://github.com/Dfam-consortium/RepeatModeler
- FamDB: https://github.com/Dfam-consortium/FamDB 
- RepeatAfterMe: https://github.com/Dfam-consortium/RepeatAfterMe
