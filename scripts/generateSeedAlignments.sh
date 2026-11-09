#!/bin/bash
#SBATCH --job-name=seedAlign
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
assemblyFile=genome.2bit
alignFile=repeatMasked_genome.align
taxon="Taxon_name"
out_dir=/path/for/stks

cd ${out_dir} 
${RepeatModeler}/util/generateSeedAlignments.pl -taxon ${taxon} -assemblyFile ${assemblyFile} ${alignFile} > generateSeedAlignments.log 2>&1
