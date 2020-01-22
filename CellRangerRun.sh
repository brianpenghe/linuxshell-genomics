#!/bin/bash -x
CPU=30
CELLRANGER=/home/ubuntu/tools/cellranger-3.0.2/cellranger
REFSEQ=/home/ubuntu/refseq/refdata-cellranger-GRCh38-3.0.0

### Non-CITE Samples
for PREFIX in 5841STDY79914{75..87} WSSS8011222
    do
        $CELLRANGER count --localcores $CPU --id=$PREFIX --transcriptome=$REFSEQ \
        --fastqs=fastq-$PREFIX \
        --sample=$PREFIX
        rm -r ./$PREFIX/SC_* ./$PREFIX/*.tgz ./$PREFIX/_* 
done

