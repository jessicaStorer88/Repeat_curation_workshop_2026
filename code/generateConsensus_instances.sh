#!/bin/bash
#SBATCH --job-name=linup
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
out_dir=/out/directory/linup
stks=/path/to/extended_stks/

for infile in ${stks}/*-extended.stk
do 
prefix=$(echo ${infile} | cut -d "/" -f 10 | cut -d "." -f 1,2)
${RepeatModeler}/util/Linup ${infile} -consensus > ${out_dir}/${prefix}.con.fa
${RepeatModeler}/util/Linup ${infile} -fasta > ${out_dir}/${prefix}.elements.fa
echo "done: ${prefix}"
done
