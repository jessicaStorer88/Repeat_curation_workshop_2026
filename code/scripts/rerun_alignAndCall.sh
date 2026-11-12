#!/usr/bin/env bash
#SBATCH --job-name=rerun_alignAndCall
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 4
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mem=50g
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err


/path/to/dfam-tetools.sh --singularity -- bash -c '
root="/path/to/models"
tool="/opt/RepeatModeler/util/alignAndCallConsensus.pl"
for dir in ${root}/*; do
    prefix=$(basename ${dir})
    cd ${dir} || continue
    ${tool} -c "${prefix}-extended.con.fa" -e "${prefix}-extended_rename.elements.fa" -ht -re 1
    cd -
done
'
