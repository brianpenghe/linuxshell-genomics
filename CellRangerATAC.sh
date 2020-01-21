#!/bin/bash -x
CPU=28
CELLRANGER=~/tools/cellranger-atac-1.2.0/cellranger-atac
REFSEQ=~/refseq/refdata-cellranger-atac-GRCh38-1.2.0/
### Non-CITE Samples
for PREFIX in 5891STDY80386{51..67}
    do
        $CELLRANGER count --localcores $CPU --id=$PREFIX --reference=$REFSEQ \
        --fastqs=/mnt/190829Lung/fastq-$PREFIX/ \
        --sample=$PREFIX --localmem=100
        rm -r ./$PREFIX/SC_* ./$PREFIX/*.tgz ./$PREFIX/_* 
    done
