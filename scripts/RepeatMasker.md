## Running RepeatMasker
The second step is to run ```RepeatMasker``` to competitively collect more copies. The submitted slurm script is:
```
$ sbatch masker_fire_ant.sh
```
<br>

```
#!/bin/bash
#SBATCH --job-name=masker_fireAnt
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mail-type=END
#SBATCH --mem=100G
#SBATCH --mail-user=jessica.storer@uconn.edu
#SBATCH -o %x_%j.stdout
#SBATCH -e %x_%j.stderr
#SBATCH --partition=general
#SBATCH --qos=general
 
source ~/.bashrc
 
cd /core/labs/Oneill/jstorer/aus_workshop/fire_ant
 
OUTPUT_NAME="fireant_RM"
LIBRARY=/core/labs/Oneill/jstorer/aus_workshop/fire_ant/fire_ant-families.fa
GENOME=/core/labs/Oneill/jstorer/aus_workshop/fire_ant/GCF_047496725.1_ASM4749672v1_genomic.fna
 
/core/labs/Oneill/jstorer/dfam-tetools.sh --singularity -- \
    RepeatMasker -s -pa 24 -lib ${LIBRARY} -a ${GENOME} -dir ${OUTPUT_NAME}
```
 
The ```LIBRARY``` is composed of the ```RepeatModeler2``` consensus sequences generated in the previous step. The ```OUTPUT_NAME``` is a user-generated directory where you would like the output placed. If a name is not specified, the output will be generated wherever the genome is. 

FamDB git: [https://github.com/Dfam-consortium/famdb](https://github.com/Dfam-consortium/famdb)
