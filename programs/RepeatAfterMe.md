## RepeatAfterMe

### Utilities

```extend-stk.pl``` extends RepeatModelers seed alignments. Some TEs captured by de novo repeat discovery pipelines may be fragmented and extension is necessary to get to the edges.
```
/opt/RepeatAfterMe/extend-stk.pl -assembly <genome.2bit> -input <models.stk> -output <output_directory> 
```
- ```-assembly``` is the assembly file you are curating repeats from
- ```-input``` requires stockholm (```.stk```) files generated from the ```generateSeedAlignment``` step
- ```-output``` is the name of the resulting extended ```.stk```
