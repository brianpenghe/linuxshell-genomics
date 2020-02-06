#!/bin/bash -x
CPU=22
CELLRANGER=/home/ubuntu/tools/cellranger-3.0.2/cellranger
REFSEQ=/home/ubuntu/refseq/refdata-cellranger-vdj-GRCh38-alts-ensembl-3.1.0

### Non-CITE Samples
for PREFIX in 5891STDY80623{33..48}
    do
        $CELLRANGER vdj --localcores $CPU --id=$PREFIX --reference=$REFSEQ \
--fastqs=fastq-$PREFIX \
--sample=$PREFIX
rm -r ./$PREFIX/SC_* *.tgz _* 
done

