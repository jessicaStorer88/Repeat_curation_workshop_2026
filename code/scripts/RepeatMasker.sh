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