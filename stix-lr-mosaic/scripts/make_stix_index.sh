#!/bin/env bash

set -euo pipefail

suffix="bed.gz" # default suffix if not provided

while getopts "g:b:n:s:o:" opt; do
    case $opt in
        g)
            giggle_index=$OPTARG
            ;;
        b)
            bed_dir=$OPTARG
            ;;
        n)
            name=$OPTARG
            ;;
        s)
            suffix=$OPTARG # eg bed.gz, or filtered.bed.gz, etc.
            ;;
        o)
            outdir=$OPTARG
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            ;;
    esac
done


# make ped file from list of bed.gz files in provided directory
echo -e "Sample\tAlt_File" > "$outdir/$name.ped"
for bed_file in "$bed_dir/*.$suffix"; do
    relative_path=$(basename $bed_file)
    sample_name=$(echo $relative_path | cut -d'.' -f1)
    echo -e "$sample_name\t$relative_path" >> "$outdir/$name.ped"
done

# make stix db
# -c denotes column of the Alt_File in ped
stix -i $giggle_index -p "$outdir/$name.ped" -d "$outdir/$name.ped.db" -c 2
