## Generating fasta consensus and elements 

In order to polish the consensus sequences and visualize each model, you will need to extract out the consensus and contributing elements in fasta format. This is accomplished via the ```Linup``` program:

```
$ sbatch linup.sh
```

<br>

```
#!/bin/bash
#SBATCH --job-name=linup_fire_ant
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
EXTENDED_STK=/core/labs/Oneill/jstorer/aus_workshop/fire_ant/stk/extended
CONSENSUS_ELEMENTS=/core/labs/Oneill/jstorer/aus_workshop/fire_ant/stk/extended/con_elements

mkdir -p /core/labs/Oneill/jstorer/aus_workshop/fire_ant/stk/extended/con_elements

for infile in ${EXTENDED_STK}/*.stk
do
    prefix=$(basename ${infile} | cut -d "." -f 1)
  
    /opt/RepeatModeler/util/Linup ${infile} -consensus > ${CONSENSUS_ELEMENTS}/{prefix}.con.fa
    /opt/RepeatModeler/util/Linup ${infile} -fasta > ${CONSENSUS_ELEMENTS}/{prefix}.elements.fa
done
'
```

You will need to change ```EXTENDED_STK``` (output from previous step) and ```CONSENSUS_ELEMENTS``` (output of the program)
