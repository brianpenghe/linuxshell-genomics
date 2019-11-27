#!/bin/bash
#This script was created by Peng He based on Krzysztof Polanski's original method to generate fastq files
set -e
samtools view -uF 0xB00 $1 | samtools sort -n - -T $1.qnsorted_tmp | samtools fastq - -1 $1\_R1_001.fastq.gz -2 $1\_R2_001.fastq.gz --i1 $1\_I1_001.fastq.gz --i2 $1\_I2_001.fastq.gz -c 4 -i --index-format i8n1i16
