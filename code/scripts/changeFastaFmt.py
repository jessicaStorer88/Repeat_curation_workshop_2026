#!/usr/bin/env python3

import os
import sys
from Bio import SeqIO

# path to folder containing the subdirectories
root = sys.argv[1]  

for prefix in sorted(os.listdir(root)):
    dir_path = os.path.join(root, prefix)
    if not os.path.isdir(dir_path):
        continue

    infile_path  = os.path.join(dir_path, f"{prefix}-extended.elements.fa")
    outfile_path = os.path.join(dir_path, f"{prefix}-extended_rename.elements.fa")

    if not os.path.exists(infile_path):
        print(f"[skip] {infile_path} not found")
        continue

    with open(infile_path, 'r') as infile, open(outfile_path, 'w') as outfile:
        for record in SeqIO.parse(infile, "fasta"):
            split_id = record.id.split('_')
            outfile.write(f">{split_id[0]}_{split_id[1]}\n{record.seq}\n")

    print(f"[done] {prefix}")
