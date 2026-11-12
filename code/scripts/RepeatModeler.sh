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