#!/bin/bash
#SBATCH --job-name=stkExtend
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 1
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mem=100g
#SBATCH -o %x_%j.stdout
#SBATCH -e %x_%j.stderr

source ${HOME}/.bashrc

RAMExtend=/path/to/RepeatAfterMe-RepeatAfterMe_V0.0.7
RepeatModeler=/path/to/RepeatModeler-2.0.7
assemblyFile=genome.2bit
stks=/path/to/stks
out_dir=/path/to/extension

cd ${RAMExtend}

for infile in ${stks}/*.stk
do
prefix=$(echo ${infile} | cut -d "/" -f 10 | cut -d "." -f 1,2)
perl util/extend-stk.pl -assembly ${assemblyFile} -input ${infile} -output ${out_dir}/${prefix}-extended.stk -repeatmodeler_dir ${RepeatModeler}
done
