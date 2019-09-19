#!/bin/sh
#SubsetCellrangerBam.sh ../possorted_bam.bam  barcodes.tsv subset.bam

cat <(samtools view -H $1) <(grep -f <(awk '{print "CB:Z:"$0 }' $2) <(samtools view $1)) | samtools view -S -b - > $3
