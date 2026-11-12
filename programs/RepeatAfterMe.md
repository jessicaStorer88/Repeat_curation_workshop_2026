## RepeatAfterMe

Developed by Robert Hubley, RAMExtend takes a multiple sequence alignment that may cover only a fragment of a longer repetitive family and extends it outward using flanking genomic sequence. Given per-sequence coordinates, it performs a local alignment extension, generates a consensus for the left and right extensions, and can write the full set of extended sequences as FASTA. While RepeatModeler2 internal algorithms do attempt to extend models, the threshold for extension is much higher and less sensitive than this tool. 

The extension algorithm builds on the RepeatScout approach of Alkes Price, Neil Jones, and Pavel Pevzner. It adds multiple scoring schemes and affine gap penalties for sensitivity, and it detects satellites and tries not to extend past a single unit.

RepeatAfterMe traces its roots to the work of Alkes Price, Neil Jones, and Pavel Pevzner, who developed an automated method for detecting repetitive DNA by building and extending multiple sequence alignments anchored on abundant exact words:

- Price A.L., Jones N.C., Pevzner P.A. (2005). De novo identification of repeat families in large genomes. Proceedings of the 13th Annual International Conference on Intelligent Systems for Molecular Biology (ISMB-05), Detroit, Michigan.

RepeatScout scored with a simple match/mismatch/gap model. This project began as an attempt to give it affine gap penalties and custom scoring matrices, and became a separate tool as the changes grew. RAMExtend and extend-stk.pl were the first tools built on the result.

### Utilities

`extend-stk.pl` extends RepeatModelers seed alignments. Some TEs captured by de novo repeat discovery pipelines may be fragmented and extension is necessary to get to the edges.

```
/opt/RepeatAfterMe/extend-stk.pl -assembly <genome.2bit> -input <models.stk> -output <output_directory> 
```

- `-assembly` is the assembly file you are curating repeats from
- `-input` requires stockholm (`.stk`) files generated from the `generateSeedAlignment` step
- `-output` is the name of the resulting extended `.stk`
