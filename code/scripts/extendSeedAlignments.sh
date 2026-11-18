#!/bin/bash
#SBATCH --job-name=ramExtend_yellow_crazy_ant
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
STK_OUTPUT=$WD/yellow_crazy_ant/stk
EXTENDED_STK=$WD/yellow_crazy_ant/stk/extended
GENOME=$WD/yellow_crazy_ant/GCF_047496725.1_ASM4749672v1_genomic.2bit

for infile in ${STK_OUTPUT}/*.stk
do
  prefix=$(basename ${infile} | cut -d "." -f 1)
  perl /opt/RepeatAfterMe/util/extend-stk.pl \
    -assembly ${GENOME} \
    -input ${infile} \
    -output ${EXTENDED_STK}/${prefix}-extended.stk
done
'
