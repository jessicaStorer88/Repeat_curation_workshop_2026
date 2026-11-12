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