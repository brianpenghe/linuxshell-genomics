#!/bin/bash
#Before uploading, please make sure you have installed hca-util
#To install that, please run these on OpenStack:
#sudo pip3 install hca-util
#hca-util config ************ *******************************
#hca-util select <YOUR IDENTIFIER>
#This algorithm has been created by Krzysztof Polanski
#210312, there was an update
#hca-util select <UPLOAD AREA>
set -e

for SAMPLE in 5891STDY80386{51..58} 5891STDY8038667 5891STDY86429{53..58} WSSS_F_LNG87827{06..17}
do
    echo "Processing: "$SAMPLE
    printf '#!/bin/bash\nset -e\n\n----\n' > imeta.sh
    imeta qu -z seq -d sample = $SAMPLE and type = cram and target = 1 >> imeta.sh
    sed ':a;N;$!ba;s/----\ncollection:/iget -K/g' -i imeta.sh
    sed ':a;N;$!ba;s/\ndataObj: /\//g' -i imeta.sh
    bash imeta.sh
    rm imeta.sh
    rm -f *#888.cram
    parallel bash ~/tools/linuxshell-genomics/cramfastq10XATAC.sh ::: *.cram
    cat *I1_001.fastq.gz > $SAMPLE\_S1_L001_I1_001.fastq.gz
    cat *I2_001.fastq.gz > $SAMPLE\_S1_L001_I2_001.fastq.gz
    cat *R1_001.fastq.gz > $SAMPLE\_S1_L001_R1_001.fastq.gz
    cat *R2_001.fastq.gz > $SAMPLE\_S1_L001_R2_001.fastq.gz
    rm *cram*
    #this might be file on older versions of the uploader
    hca-util upload *.fastq.gz
    rm *.fastq.gz
done

