Depending on how all the programs are run, files for all of the models may all be in one folder. If you would like to move all files corresponding to one model into their own folder, this script can do that for you.

```
$ ./dirReorg.sh
```

<br>

```
#!/usr/bin/bash

input_dir="/core/labs/Oneill/jstorer/aus_workshop/fire_ant/stk/extended/con_elements/"

# The directory you want to move files from
DIR1="/core/labs/Oneill/jstorer/aus_workshop/fire_ant/stk/extended/con_elements/"

# Output base directory
out_base="/core/labs/Oneill/jstorer/aus_workshop/fire_ant"

mkdir -p "$out_base"

# Loop through each .ali file
for infile in "$input_dir"/*.ali; do

    # get filename without path
    fname=$(basename "$infile")

    # extract prefix before first dot
    prefix=$(echo "$fname" | cut -d "." -f 1)

    # make output directory for this prefix
    outdir="$out_base/$prefix"
    mkdir -p "$outdir"

    echo "Processing prefix: $prefix"

    # move matching files from DIR1 and DIR2
    mv "$DIR1"/${prefix}.* "$outdir"/ 
    mv "$DIR1"/${prefix}-* "$outdir"/

done
```

Make sure to change ```input_dir```, ```DIR1```, and ```out_base```
