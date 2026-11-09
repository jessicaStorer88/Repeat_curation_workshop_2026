https://github.com/Dfam-consortium/RepeatMasker 

https://github.com/Dfam-consortium/RepeatModeler

https://github.com/Dfam-consortium/FamDB 

<br>
<br>

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
