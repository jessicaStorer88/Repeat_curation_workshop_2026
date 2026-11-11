## Running alignAndCallConsensus.pl for each model

In order to get the initial visualizations and starting input/output for each model, you will need to run ```alignAndCallConsensus.pl``` on each generated consensus/element fasta file pair. The program below is designed to loop through all putative models.

```
$ sbatch alignAndCallCon.sh
```

<br>

```
#!/bin/bash
#SBATCH --job-name=alignAndCall_fire_ant
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mail-type=END
#SBATCH --mem=50G
#SBATCH --mail-user=jessica.storer@uconn.edu
#SBATCH -o %x_%j.stdout
#SBATCH -e %x_%j.stderr
#SBATCH --partition=general
#SBATCH --qos=general


/core/labs/Oneill/jstorer/dfam-tetools.sh --singularity -- bash -c '
CONSENSUS_ELEMENTS=/core/labs/Oneill/jstorer/aus_workshop/fire_ant/stk/extended/con_elements

for infile in ${CONSENSUS_ELEMENTS}/*.con.fa
do
    prefix=$(basename ${infile} | cut -d "." -f 1)
    
    /opt/RepeatModeler/util/alignAndCallConsensus.pl -c ${infile} -e ${CONSENSUS_ELEMENTS}/${prefix}.elements.fa -ht -re 

done
'
```

You will need to change ```CONSENSUS_ELEMENTS``` (output from previous step)
