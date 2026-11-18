#!/usr/bin/bash
WD=/path/to/your/working/directory
input_dir="$WD/stk/extended/con_elements/"

# The directory you want to move files from
DIR1="$WD/stk/extended/con_elements/"

# Output base directory
out_base="$WD/outdir"

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
