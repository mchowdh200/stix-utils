#!/usr/bin/env bash

set -euo pipefail

while getopts ":i:b:g:" opt; do
    case $opt in
        i) input_beds="$OPTARG" ;; # quoted string of space separated bed files
        b) bed_outdir="$OPTARG" ;;
        g) giggle_index="$OPTARG" ;;
        \?) echo "Invalid option -$OPTARG" >&2 ;;
    esac
done

mkdir -p $bed_outdir
mkdir -p $giggle_index

for bed in $input_beds; do
    cp $bed $bed_outdir
done

giggle index -i "${bed_outdir}/*.bed.gz" -o $giggle_index -s -f
