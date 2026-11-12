#!/usr/bin/env python3

import sys
from Bio import SeqIO

with open(sys.argv[1],'r') as infile:
    with open(sys.argv[2],'w') as outfile:
        for record in SeqIO.parse(infile,"fasta"):
            recordID = record.id
            split_id = recordID.split('_')
            outfile.write(">"+split_id[0]+"_"+split_id[1]+"\n"+str(record.seq)+"\n")