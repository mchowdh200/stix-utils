#!/usr/bin/env bash

set -euo pipefail

while getopts "i:o:" opt; do
    case $opt in
        i) input_dir="$OPTARG";; # directory with the beds to index
        o) output_dir="$OPTARG";; # the directory containing the index
        c) container="$OPTARG";;
        \?) echo "Invalid option: -$OPTARG" >&2; exit 1;;
    esac
done

singularity exec --bind $input_dir:/$input_dir --bind $output_dir:/$output_dir \
    $container \
    giggle index -i "${input_dir}/*.bed.gz" -o "${output_dir}" -s -f



