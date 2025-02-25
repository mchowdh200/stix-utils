#!/usr/bin/env bash

set -euo pipefail

while getopts ":i:b:p:d:" opt; do
    case $opt in
        i) giggle_index="$OPTARG" ;;
        b) bed_dir="$OPTARG" ;;
        p) ped="$OPTARG" ;;
        d) ped_db="$OPTARG" ;;
        \?) echo "Invalid option -$OPTARG" >&2 ;;
    esac
done

echo -e "Sample\tAlt_File" > $ped
for bed_file in $bed_dir/*.bed.gz; do
    bname=$(basename $bed_file)
    sample_name=${bname%%.bed.gz}
    echo -e "${sample_name}\t${bname}" >> $ped
done
    
