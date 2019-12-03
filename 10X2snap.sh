#!/bin/sh
#This script is organized by Peng He ph12@sanger.ac.uk based on instructions of snapATAC on GitHub

cat <( samtools view possorted_bam.bam -H ) \
<( samtools view possorted_bam.bam | \
awk '{for (i=12; i<=NF; ++i) { if ($i ~ "^CB:Z:"){ td[substr($i,1,2)] = substr($i,6,length($i)-5); } }; printf "%s:%s\n", td["CB"], $0 }' ) \
| samtools view -bS - > possorted_bam.snap.bam

samtools sort -n -@ 10 -m 1G possorted_bam.snap.bam -o possorted_bam.snap.nsrt.bam && rm possorted_bam.snap.bam

samtools faidx /home/ubuntu/refseq/refdata-cellranger-atac-GRCh38-1.1.0/fasta/genome.fa
cut -f1,2  /home/ubuntu/refseq/refdata-cellranger-atac-GRCh38-1.1.0/fasta/genome.fa.fai > /home/ubuntu/refseq/refdata-cellranger-atac-GRCh38-1.1.0/fasta/genome.sizes
snaptools snap-pre  \
	--input-file=possorted_bam.snap.nsrt.bam  \
	--output-snap=possorted_bam.snap  \
	--genome-name=hg38  \
	--genome-size=/home/ubuntu/refseq/refdata-cellranger-atac-GRCh38-1.1.0/fasta/genome.sizes  \
	--min-mapq=30  \
	--min-flen=50  \
	--max-flen=1000  \
	--keep-chrm=TRUE  \
	--keep-single=FALSE  \
	--keep-secondary=False  \
	--overwrite=True  \
	--max-num=20000  \
	--min-cov=500  \
	--verbose=True

rm possorted_bam.snap.nsrt.bam

snaptools snap-add-bmat \
    --snap-file=possorted_bam.snap \
    --bin-size-list 1000 5000 10000 \
    --verbose=True
