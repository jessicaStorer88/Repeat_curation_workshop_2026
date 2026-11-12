If model extension is required as part of the manual curation process, the extended element files <b><ins><i>must</b></ins></i> be reformatted before proceeding, otherwise subsequent utilities produce errors. This is a known bug. As a workaround, you can use this script to strip the tailing orientation characters, and then polish with ```alignAndCallConsensus.pl```

Reformat:

```
python3 changeFastaFmt.py <extended.elements.fa> <extended_rename.elements.fa>
```
  The first argument is the current extended elements file that you have after running the initial pipeline, the second argument is the new name of this file. Typically the format is ```<model-name>-extended.elements.fa```

<br>

Polish: 
```
~/RepeatModeler-2.0.7/util/alignAndCallConsensus.pl -c <extended.con.fa> -e <extended_rename.elements.fa> -ma 14 -ht -re
```
  Running ```alignAndCallConsensus.pl``` will iterate across all instances to form a new consensus with the correct format. 

<br>

```
#!/usr/bin/env python3

import sys
from Bio import SeqIO

with open(sys.argv[1],'r') as infile:
    with open(sys.argv[2],'w') as outfile:
        for record in SeqIO.parse(infile,"fasta"):
            recordID = record.id
            split_id = recordID.split('_')
            outfile.write(">"+split_id[0]+"_"+split_id[1]+"\n"+str(record.seq)+"\n")
```
