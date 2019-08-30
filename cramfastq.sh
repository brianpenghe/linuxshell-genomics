#!/bin/bash
set -e

samtools fastq -1 $1\_R1_001.fastq.gz -2 $1\_R2_001.fastq.gz --i1 $1\_I1_001.fastq.gz -n -i --index-format i8 $1
