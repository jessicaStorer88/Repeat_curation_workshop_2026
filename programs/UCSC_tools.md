## UCSC tools
The University of California, Santa Cruz (UCSC) has built a set of utilities for handling sequences and assemblies. The two programs are:
- faToTwoBit
- twoBitInfo

```faToTwoBit``` converts a fasta file to a 2bit genome. While fasta files are a human-readable, plain-text format the 2bit format is a compact, binary-encoded format developed by the UCSC Genome Browser that encodes each DNA base using just 2 bits, vs 8 bits per character utilized by the fasta text format, cutting file size down by about 75%.

```
faToTwoBit <genome.fa> <genome.2bit> 
```
```<genome.2bit>``` is a user-specified name.

<br>
<br>

```twoBitInfo``` is used internally by <b>list programs here</b>, but can also be used on the command line:
```
twoBitInfo <genome.2bit> <genome.info> 
```
```<genome.info>``` is a user-specified name, and is a plain text file that includes chromosome names and sizes. 
