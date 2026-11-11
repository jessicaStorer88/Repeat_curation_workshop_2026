## Extending seed alignments 

The next step is to extend the models. De novo repeat finders are working with genomes that are a mix of old, young, truncated and full-length models, with a high potential to provide truncated models as output. Therefore, extension of the models discovered is necessary.
```
$ sbatch ram_extend.sh
```

<br>

```
#!/bin/bash
#SBATCH --job-name=ramExtend_fire_ant
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mail-type=END
#SBATCH --mem=50G
#SBATCH --mail-user=jessica.storer@uconn.edu
#SBATCH -o %x_%j.stdout
#SBATCH -e %x_%j.stderr
#SBATCH --partition=general
#SBATCH --qos=general
 
/core/labs/Oneill/jstorer/dfam-tetools.sh --singularity -- bash -c '
STK_OUTPUT=/core/labs/Oneill/jstorer/aus_workshop/fire_ant/stk
EXTENDED_STK=/core/labs/Oneill/jstorer/aus_workshop/fire_ant/stk/extended
GENOME=/core/labs/Oneill/jstorer/aus_workshop/fire_ant/GCF_047496725.1_ASM4749672v1_genomic.2bit
 
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
 
You will need to change the ```STK_OUTPUT``` (output from the previous step), ```EXTENDED_STK``` (output of the program), and ```GENOME``` parameters passed to the ```extend-stk.pl``` program.

<b>Note</b> that there is a difference with the other scripts and this one in how the dfam-tetools container is called. On the mantis cluster, there is a limit to how many times a user can pull a singularity image. By calling the container in this way, you only pull the image once. 

**IMPORTANT**
If model extension is required as part of the manual curation process on a per-model basis, the extended element files <b><ins><i>must</b></ins></i> be reformatted before proceeding, otherwise subsequent utilities produce errors. This is a known bug. As a workaround, we have developed a short re-formatting script, [changeFastaFmt.py](changeFastaFmt.py) to strip the tailing orientation characters. Subsequent polishing with ```alignAndCallConsensus.pl``` is needed to re-name the the sequences in the .out file, as this is the input for the ```extendFlankingSeqs.pl``` program. 

#### Step 1 : reformat model instances

```
python changeFastaFmt.py <extended.elements.fa> <extended_rename.elements.fa>
```

The first argument is the current extended elements file that you have after running the initial pipeline, the second argument is the new name of this file. A suggested naming format is ```<model-name>-extended.elements.fa```

<br>

#### Step 2 : polish model with re-named sequences
```
$ ~/RepeatModeler-2.0.7/util/alignAndCallConsensus.pl -c <extended.con.fa> -e <extended_rename.elements.fa> -ma 14 -ht -re
```
Running ```alignAndCallConsensus.pl``` will iterate across all instances to form a new consensus with the correct format and allow for per-model extension using ```extendFlankingSeqs.pl```

<br>

The usage of ```extendFlankingSeqs.pl``` for each model

```
$ extendFlankingSeqs.pl  -f(lank) ## -d(atabase) <2bit genome file> -i(nput) <cross_match .out file> -o(utput) <elements fasta file>
```

You must specify a number by which you would like to extend each side of your sequences via ```-f(lank)```. The output produces longer element sequences which will be used in ```alignAndCallConsensus.pl``` to extend the edges of your model. 
