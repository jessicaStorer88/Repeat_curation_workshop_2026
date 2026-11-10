## RepeatAfterMe

### Utilities

```extend-stk.pl``` extends RepeatModelers seed alignments. Some TEs captured by de novo repeat discovery pipelines may be fragmented and extension is necessary to get to the edges.
```
perl extend-stk.pl -assembly ${assemblyFile} -input ${infile} -output ${out_dir}/${prefix}-extended.stk -repeatmodeler_dir ${RepeatModeler}
```
- ```-assembly``` is the assembly file you are curating repeats from
- ```-input``` requires stockholm (```.stk```) files generated from the ```generateSeedAlignment``` step
- ```-output``` is the name of the resulting extended ```.stk```
- ```repeatmodeler_dir``` points to the path where ```RepeatModeler``` is
