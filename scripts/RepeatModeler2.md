## Running RepeatModeler2
The first step in de novo repeat discovery is running a de novo program. Below is how to run ```RepeatModeler2``` via a submitted slurm script and a via the dfam-tetools container:
```
$ sbatch modeler_fireant.sh
```

<br>

``` 
#!/bin/bash
#SBATCH --job-name=modeler_fire
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 16
#SBATCH --mail-type=END
#SBATCH --mem=100G
#SBATCH --mail-user=jessica.storer@uconn.edu
#SBATCH -o %x_%j.stdout
#SBATCH -e %x_%j.stderr
#SBATCH --partition=general
#SBATCH --qos=general
 
source ~/.bashrc
 
cd /core/labs/Oneill/jstorer/aus_workshop/fire_ant
 
GENOME=GCF_047496725.1_ASM4749672v1_genomic.fna
DB=fire_ant
 
# Step 1: build the database
/core/labs/Oneill/jstorer/dfam-tetools.sh --singularity -- \
    BuildDatabase -name $DB $GENOME
 
# Step 2: run RepeatModeler (-LTRStruct adds the LTR structural pipeline)
/core/labs/Oneill/jstorer/dfam-tetools.sh --singularity -- \
    RepeatModeler -database $DB -threads 16 -LTRStruct
```
 
The first step is to create a database using your genome of interest via ```BuildDatabase```, while the second is to run ```RepeatModeler2``` based on the database generated in the first step. To make this script work for your genome, change the directory (cd ```/path/to/working/directory```), ```GENOME``` and ```DB``` in the script above.
Although the ```-LTRStuct``` option is available, it often produces single-copy “families” in the RepeatModeler2 output. Unless your genome contains a higher number of ERV elements and/or you would like to have lower copy ERVs visualized, this option should be used with caution.
