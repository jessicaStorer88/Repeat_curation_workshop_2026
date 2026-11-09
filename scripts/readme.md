### Pipeline
Below is the series of steps needed to prepare your own repeat library for curation. Within each file is a script and description of the commands. For this workshop, the fire ant is used as an example. 
1. De novo repeat discovery
2. Collect more copies
3. Generate seed alignments
4. Extending seed alignments
5. Get fasta consensus and elements
6. Run ```alignAndCallConsensus.pl``` for each model 

<br>

**NOTE:**
Extended element files must be reformatted before proceeding, otherwise subsequent utilities with throw errors. This is a known bug. As a workaround, you can use [changeFastaFmt.py](changeFastaFmt.py) to strip the tailing orientation characters, and then polish with ```alignAndCallConsensus.pl```

Reformat:
```
python changeFastaFmt.py <extended.elements.fa> <extended_rename.elements.fa>
```
  The first argument is the current extended elements file that you have after running the initial pipeline, the second argument is the new name of this file. Typically the format is ```<model-name>-extended.elements.fa```

<br>

Polish: 
```
~/RepeatModeler-2.0.7/util/alignAndCallConsensus.pl -c <extended.con.fa> -e <extended_rename.elements.fa> -ma 14 -ht -re
```
  Running ```alignAndCallConsensus.pl``` will iterate across all instances to form a new consensus with the correct format. 

<br>

### Useful links
https://github.com/Dfam-consortium/RepeatMasker 

https://github.com/Dfam-consortium/RepeatModeler

https://github.com/Dfam-consortium/FamDB 
