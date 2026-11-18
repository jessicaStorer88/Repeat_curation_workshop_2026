#!/bin/bash
#SBATCH --job-name=generateSeed_yellow_crazy_ant
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

STK_OUTPUT=$WD/yellow_crazy_ant/stk
GENOME=$WD/yellow_crazy_ant/GCF_047496725.1_ASM4749672v1_genomic.2bit
ALIGN=$WD/yellow_crazy_ant/yellow_crazy_ant_RM/GCF_047496725.1_ASM4749672v1_genomic.fna.align

$PATH_TO_CONTAINER/dfam-tetools.sh--singularity -- \
    /opt/RepeatModeler/util/generateSeedAlignments.pl -taxon "Anoplolepis gracilipes" -assemblyFile ${GENOME} ${ALIGN}
