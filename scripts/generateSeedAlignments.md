## Generating seed alignments 

To visualize the models and extend for the next step, we need to generate seed alignments per RM2 predicted model. 
```
$ sbatch generateSeedAlign.sh
```
<br>

```
#!/bin/bash
#SBATCH --job-name=generateSeed_fire_ant
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
 
source ~/.bashrc
 
cd /core/labs/Oneill/jstorer/aus_workshop/fire_ant
 
STK_OUTPUT=/core/labs/Oneill/jstorer/aus_workshop/fire_ant/stk
GENOME=/core/labs/Oneill/jstorer/aus_workshop/fire_ant/GCF_047496725.1_ASM4749672v1_genomic.2bit
ALIGN=/core/labs/Oneill/jstorer/aus_workshop/fire_ant/fireant_RM/GCF_047496725.1_ASM4749672v1_genomic.fna.align
 
/core/labs/Oneill/jstorer/dfam-tetools.sh--singularity -- \
    /opt/RepeatModeler/util/generateSeedAlignments.pl -taxon "Solenopsis invicta" -assemblyFile ${GENOME} ${ALIGN}
```

You will need to specify the working directory, where to put the stk (```.stk``` Stockholm alignment) file output (```STK_OUTPUT```), the genome (```GENOME```), the location of the ```.align``` output from RepeatMasker (```ALIGN```). You will also need to update the ```-taxon``` option passed to the ```generateSeedAlignments.pl``` program. 
