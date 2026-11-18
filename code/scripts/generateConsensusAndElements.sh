#!/bin/bash
#SBATCH --job-name=linup_yellow_crazy_ant
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
EXTENDED_STK=$WD/yellow_crazy_ant/stk/extended
CONSENSUS_ELEMENTS=$WD/yellow_crazy_ant/stk/extended/con_elements

mkdir -p $WD/stk/extended/con_elements

for infile in ${EXTENDED_STK}/*.stk
do
    prefix=$(basename ${infile} | cut -d "." -f 1)
    /opt/RepeatModeler/util/Linup ${infile} -consensus > ${CONSENSUS_ELEMENTS}/{prefix}.con.fa
    /opt/RepeatModeler/util/Linup ${infile} -fasta > ${CONSENSUS_ELEMENTS}/{prefix}.elements.fa
done
'
