## RepeatModeler2


### Utilities

```generateSeedAlignments.pl``` - uses ```<model>.align``` files to build seed alignments. Seed alignments are multiple sequence alignments of TE copies that are categorized by the same model. This program is essential for generating the stockholm files necessary for downstream processes like Linup which are used to isolate the instances of this TE family. 
```
generateSeedAlignments.pl -taxon ${taxon} -assemblyFile ${assemblyFile.2bit} ${alignFile.align}
```

<br>
<br>

```Linup``` - uses stockholm files to isolate (1) the consensus for the given TE model and (2) isolates fasta sequences for every instance of that TE copy into one fasta file. These products are then used to refine consensus calling of this TE family 
```
Linup ${infile.stk} -consensus > ${prefix}.con.fa
Linup ${infile.stk} -fasta > ${prefix}.elements.fa
```

<br>
<br>

```alignAndCallConsensus.pl``` - Aptly named, this tool aligns a putative TE family consensus to all the instances of that family in your genome. Alignments generated from this step are used to call a consensus. This step can be run iteratively to continue refining the consensus as more sequences are considered during extension via H-pads, a set of Hs at the flank(s) you want to extend.
```
alignAndCallConsensus.pl -c <model-extended.con.fa> -e <model-extended_rename.elements.fa> -ma 14 -ht -re
```
- ```-c``` specifies consensus file
- ```-e``` specifies elements file
- ```-ma``` is the matrix value, the higher the matrix value the more divergence you are allowing for
  - can choose from these values: ```14,18,20,25```
- ```-ht``` creates an html file for easier visualization of the models and instances 
- ```-re``` tells the tool to iterate, default is 5 iterations but an integer can be specified for more or less iterations  
- a useful command might be ```-ms``` which stands for minimum score, if there are a lot of alignments with low scores they may interfere with the contiguity of the aligned models 
- in order to tell this tool to extend, H-pads need to be added - if extension is warranted at **BOTH* 5' and 3' end, ```-hp```  can be used which adds a user-specified number of H's to both ends of the consensus 

<br>
<br>

```rmblast.pl``` - RepeatMasker's version of NCBI-BLAST paired with cross_match sensitivity. It leverages scoring logic from cross_match to reflect the complexity and accuracy of target sequences. It is used to identify similar repeat sequences in the genome and can be used to compare repeat models to existing curated libraries.
```
rmblast.pl <model-extended.con.fa> <model-extended.con.fa>
```
- this command by itself will print alignment matches with less than 80% overlap
- use ```-masklevel 101``` to print all alignment hits
- ```-ms``` to filter out low scoring regions
- ```-a``` to print out the alignment(s)

<br>
<br>

```AutoRunBlocker.pl``` - Due to the nature of aligning instances that vary in divergence, there is occasionally evidence of insertions or deletions within the called consensus. In order to assess if those variants are part of the consensus, this tool identifies gaps or regions of lower similarity. It analyzes the consensus sequences and instances in windows to correct for these low confidence regions.
```
AutoRunBlocker.pl -l <model>.ali -w <window size> -mc 50 -p -mr 0.3
```
- ```-l``` specifies alignment file
- ```-w``` is the window size, this may be tuned depending on the size of the consensus sequence that is being investigated 
- ```-mc```  is minimum copy agreement, how many copies need to be the same in these windows for a change to be committed 
- ```-p``` specifies prompt, this is used to interact with the program in real time to accept or deny proposed changes 
- ```-mr``` = minimum ratio agreement, should not be less than 0.3
