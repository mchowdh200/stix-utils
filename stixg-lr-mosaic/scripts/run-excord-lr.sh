#!/usr/bin/env bash

set -euo pipefail

usage() {
    echo "Usage: $0 -i <input_cram> -r <reference_genome> -o <output_bed> -c <singularity_container>"
    exit 1
}

while getopts "i:r:o:" opt; do
    case $opt in
        i) cram=$OPTARG;;
        r) ref_genome=$OPTARG;;
        o) output_bed=$OPTARG;;
        c) singularity_container=$OPTARG;;
        \?) echo "Invalid option: -$OPTARG" >&2; usage;;
    esac
done

input_dir=$(dirname "$cram")
output_dir=$(dirname "$output_bed")

singularity exec --bind "$input_dir:$input_dir" --bind "$output_dir:$output_dir" \
    "$singularity_container" \
    excord-lr --bam "$cram" --reference "$ref_genome" --output "$output_bed"
    




