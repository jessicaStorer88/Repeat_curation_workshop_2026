#!/bin/bash
#SBATCH --job-name=callConsensus
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 1
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mem=100g
#SBATCH -o %x_%j.stdout
#SBATCH -e %x_%j.stderr

source ${HOME}/.bashrc

RepeatModeler=/path/to/RepeatModeler-2.0.7
linup=/path/to/linup_dir


for infile in ${linup}/*.con.fa
do
prefix=$(echo ${infile} | cut -d "/" -f 10 | cut -d "." -f 1,2)
echo "running : ${prefix}"
${RepeatModeler}/util/alignAndCallConsensus.pl -c ${infile} -e ${linup}/${prefix}.elements.fa -ht
echo "done: ${prefix}"
done > callConsensus.log 2>&1
