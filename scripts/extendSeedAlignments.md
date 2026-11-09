## Extending seed alignments 

The next step is to extend the models. De novo repeat finders are working with genomes that are a mix of old, young, truncated and full-length models, with a high potential to provide truncated models as output. Therefore, extension of the models discovered is necessary.
```
$ sbatch ram_extend.sh
```

<br>

```
#!/bin/bash
#SBATCH --job-name=ramExtend_fire_ant
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
STK_OUTPUT=/core/labs/Oneill/jstorer/aus_workshop/fire_ant/stk
EXTENDED_STK=/core/labs/Oneill/jstorer/aus_workshop/fire_ant/stk/extended
GENOME=/core/labs/Oneill/jstorer/aus_workshop/fire_ant/GCF_047496725.1_ASM4749672v1_genomic.2bit
 
for infile in ${STK_OUTPUT}/*.stk
do
  prefix=$(basename ${infile} | cut -d "." -f 1)
  perl /opt/RepeatAfterMe/util/extend-stk.pl \
    -assembly ${GENOME} \
    -input ${infile} \
    -output ${EXTENDED_STK}/${prefix}-extended.stk
done
'
```
 
You will need to change the ```STK_OUTPUT``` (output from the previous step), ```EXTENDED_STK``` (output of the program), and ```GENOME``` parameters passed to the ```extend-stk.pl``` program.

**Note** that there is a difference with the other scripts and this one in how the dfam-tetools container is called. On the mantis cluster, there is a limit to how many times a user can pull a singularity image. By calling the container in this way, you only pull the image once. 
