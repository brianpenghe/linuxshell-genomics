#!/bin/bash
set -e
CPU=50
CELLRANGER=/lustre/scratch117/cellgen/team205/ph12/tools/cellranger-atac-1.2.0/cellranger-atac
REFSEQ=/lustre/scratch117/cellgen/team205/ph12/refseq/refdata-cellranger-atac-GRCh38-1.2.0
for SAMPLE in 5891STDY86429{53..54}
    do
        echo "Processing: "$SAMPLE
#        printf '#!/bin/bash\nset -e\n\n----\n' > imeta$SAMPLE.sh
#        imeta qu -z seq -d sample = $SAMPLE and type = cram and target = 1 >> imeta$SAMPLE.sh
#        sed ':a;N;$!ba;s/----\ncollection:/iget -K/g' -i imeta$SAMPLE.sh
#        sed ':a;N;$!ba;s/\ndataObj: /\//g' -i imeta$SAMPLE.sh
#        bash imeta$SAMPLE.sh
#        bash /lustre/scratch117/cellgen/team205/ph12/tools/cramfastq10XATAC.sh ::: *.cram
#        rm -f *.cram
#        count=1
#        for file in *I1_001.fastq.gz
#            do
#                mv "${file}" "${file/*.cram/$SAMPLE\_S$count\_L001}"
#                file=$(sed 's/I1/R1/g' <<< $file)
#                mv "${file}" "${file/*.cram/$SAMPLE\_S$count\_L001}"
#                file=$(sed 's/R1/R2/g' <<< $file)
#                mv "${file}" "${file/*.cram/$SAMPLE\_S$count\_L001}"
#		file=$(sed 's/R2/I2/g' <<< $file)
#		mv "${file}" "${file/*.cram/$SAMPLE\_S$count\_L001}"
#                (( count++ ))
#            done
#        mkdir -p fastq-$SAMPLE && mv *.fastq.gz fastq-$SAMPLE
#	for file in fastq-$SAMPLE/*I1_001.fastq.gz
#	    do
#		mv "$(sed 's/I1/R2/g' <<< $file)" "$(sed 's/I1/R3/g' <<< $file)"
#		mv "$(sed 's/I1/I2/g' <<< $file)" "$(sed 's/I1/R2/g' <<< $file)"
#	    done
        $CELLRANGER count --localcores $CPU --id=$SAMPLE --reference=$REFSEQ \
        --fastqs=./fastq-$SAMPLE/ \
        --sample=$SAMPLE
        rm -r ./$SAMPLE/SC_* ./$SAMPLE/*.tgz ./$SAMPLE/_* fastq-$SAMPLE
    done
