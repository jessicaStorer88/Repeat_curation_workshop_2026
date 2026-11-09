# Table of contents

- [Programs](#Programs) 
  - [UCSC tools](#UCSC-tools)
  - [RepeatModeler2](#RepeatModeler2)
  - [RepeatMasker](#RepeatMasker)


## Programs

Below are the programs we will discuss as part of the workshop. For each program there is a short description as well as how it would be run on the command line.

### UCSC tools
The University of California, Santa Cruz (UCSC) has built a set of utilities for handling sequences and assemblies. The two programs are:
- faToTwoBit
- twoBitInfo

faToTwoBit converts a fasta file to a 2bit genome. While fasta files are a human-readable, plain-text format the 2bit format is a compact, binary-encoded format developed by the UCSC Genome Browser that encodes each DNA base using just 2 bits, vs 8 bits per character utilized by the fasta text format, cutting file size down by about 75%.

```
faToTwoBit <genome.fa> <genome.2bit> 
```

<genome.2bit> is a user-specified name.

twoBitInfo is used internally by <b>list programs here</b>, but can also be used on the command line:
```
twoBitInfo <genome.2bit> <genome.info> 
```
<genome.info> is a user-specified name, and is a plain text file that includes chromosome names and sizes. 

### RepeatModeler2
* Utilities

```generateSeedAlignments.pl``` - uses ```<model>.align``` files to build seed alignments. Seed alignments are multiple sequence alignments of TE copies that are categorized by the same model. This program is essential for generating the stockholm files necessary for downstream processes like Linup which are used to isolate the instances of this TE family. 
```
generateSeedAlignments.pl -taxon ${taxon} -assemblyFile ${assemblyFile.2bit} ${alignFile.align}
```


```Linup``` - uses stockholm files to isolate (1) the consensus for the given TE model and (2) isolates fasta sequences for every instance of that TE copy into one fasta file. These products are then used to refine consensus calling of this TE family 
```
Linup ${infile.stk} -consensus > ${prefix}.con.fa
Linup ${infile.stk} -fasta > ${prefix}.elements.fa
```


```alignAndCallConsensus.pl``` - Aptly named, this tool aligns a putative TE family consensus to all the instances of that family in your genome. Alignments generated from this step are used to call a consensus. This step can be run iteratively to continue refining the consensus as more sequences are considered during extension via H-pads, a set of Hs at the flank(s) you want to extend.
```
alignAndCallConsensus.pl -c <model-extended.con.fa> -e <model-extended_rename.elements.fa> -ma 14 -ht -re
```
- ```-c``` = consensus file
- ```-e``` = elements file
- ```-ma``` is the matrix value, the higher the matrix value the more divergence you are allowing for
  - can choose from these values: ```14,18,20,25```
- ```-ht```  creates an html file for easier visualization of the models and instances 
- ```-re``` tells the tool to iterate, default is 5 iterations but an integer can be specified for more or less iterations  
- a useful command might be ```-ms``` which stands for minimum score, if there are a lot of alignments with low scores they may interfere with the contiguity of the aligned models 
- in order to tell this tool to extend, H-pads need to be added - if extension is warranted at **BOTH* 5' and 3' end, ```-hp```  can be used which adds a user-specified number of H's to both ends of the consensus 


```rmblast.pl``` - RepeatMasker's version of NCBI-BLAST paired with cross_match sensitivity. It leverages scoring logic from cross_match to reflect the complexity and accuracy of target sequences. It is used to identify similar repeat sequences in the genome and can be used to compare repeat models to existing curated libraries.
```
rmblast.pl <model-extended.con.fa> <model-extended.con.fa>
```
- this command by itself will print alignment matches with less than 80% overlap
- use ```-masklevel 101``` to print all alignment hits
- ```-ms``` to filter out low scoring regions
- ```-a``` to print out the alignment(s)


```AutoRunBlocker.pl``` - Due to the nature of aligning instances that vary in divergence, there is occasionally evidence of insertions or deletions within the called consensus. In order to assess if those variants are part of the consensus, this tool identifies gaps or regions of lower similarity. It analyzes the consensus sequences and instances in windows to correct for these low confidence regions.
```
AutoRunBlocker.pl -l <model>.ali -w <window size> -mc 50 -p -mr 0.3
```
- ```-l``` = alignment file
- ```-w``` is the window size, this may be tuned depending on the size of the consensus sequence that is being investigated 
- ```-mc```  is minimum copy agreement, how many copies need to be the same in these windows for a change to be committed 
- ```-p``` = prompt, this is used to interact with the program in real time to accept or deny proposed changes 
- ```-mr``` = minimum ratio agreement, should not be less than 0.3
    
### RepeatMasker
* Utilities

```buildSummary.pl``` is used to summarize annotations in *.out files generated by RepeatMasker
```
buildSummary.pl <file>.out
```
- ```-minDiv```  can be used to set a threshold for how many mismatches can be tolerated (scale is 0-1)
- ```-maxDiv```  similar to minDiv, this will keep entries with mismatch values below this number (scale is 0-1)
- ```-species``` if you ran RepeatMasker with the ```-species``` option, this will further categorize repeat annotations into lineage-specific and species-specific. This option does not apply if RepeatMasker was not run with the ```-species```  flag.
- ```-genome```, a ```<genome>.2bit``` file can be used as input here so that calculations are more accurate accounting for genome size (and not calculated from repeat annotation entries). It also can be used to filter out annotations on unplaced scaffolds by generating a 2bit file with only chromosomes
- ```-useAbsoluteGenomeSize``` can be used with the ```-genome``` option to use the sum of all sequences in the provided ```<genome>.2bit```


```calcDivergenceFromAlign.pl``` is a tool that calculates sequence divergence, this time accounting for higher mutation rates at CpG sites, transitions and transversions. In the original ```.out```, RepeatMasker excludes these regions from mutation rate calculations and only retains transitions and transversions at non-CpG loci. These calculations are important for properly aging TEs as highly methylated CpG islands may artificially inflate age estimates. 
```
calcDivergenceFromAlign.pl -s <summary_file>.divsum <file>.align
```
* Notes:
  - Make sure to use ```-a``` option in the original RepeatMasker run if you want to use this utility downstream! 
  - Not all organisms exhibit methylation (ex: Drosophila) so this may not be applicable to every organism. 
- ```-s``` generates a summary file, needed for ```createRepeatLandscape.pl```
- ```-a``` generate new alignment files with the recalculated divergence 
- ```-noCpGMod``` does not modify transition counts at CpG sites 



```createRepeatLandscape.pl``` uses the summary output from ```calcDivergenceFromAlign.pl``` to generate a repeat landscape graph. The histogram depicts the Kimura substitution level (with or without CpGs) per TE subfamily across the genome. The accompanying pie chart shows the fraction of transposable element families within the genome. 
```
createRepeatLandscape.pl -div <summary_file>.divsum > <out_file>.html
```
- ```-div``` the divergence summary file (```<summary_file>.divsum```) generated from ```calcDivergenceFromAlign.pl```
- ```-g``` the genome size for percentage calculations 
- ```-twoBit```,  use the ```<genome>.2bit``` file for genome size estimate 


### RepeatAfterMe
