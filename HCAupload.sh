#!/bin/bash
#Before uploading, please make sure you have installed hca-util
#To install that, please run these on OpenStack:
#sudo pip3 install hca-util
#hca-util config AKIA4WBQCFL3O2EEJK5G G1HNqQ0d2D4ffesC6GVYk2wtp/9E7jijf7M/JtMh

#This algorithm has been created by Krzysztof Polanski
#210312, there was an update

set -e

for SAMPLE in 5891STDY80386{51..67}
do
    printf '#!/bin/bash\nset -e\n\n----\n' > imeta.sh
    imeta qu -z seq -d sample = $SAMPLE and type = cram and target = 1 >> imeta.sh
    sed ':a;N;$!ba;s/----\ncollection:/iget -K/g' -i imeta.sh
    sed ':a;N;$!ba;s/\ndataObj: /\//g' -i imeta.sh
    bash imeta.sh
    rm imeta.sh
    rm -f *#888.cram
    parallel bash /mnt/mapcloud/scripts/10x/cramfastq.sh ::: *.cram
    cat *I1_001.fastq.gz > $SAMPLE\_S1_L001_I1_001.fastq.gz
    cat *R1_001.fastq.gz > $SAMPLE\_S1_L001_R1_001.fastq.gz
    cat *R2_001.fastq.gz > $SAMPLE\_S1_L001_R2_001.fastq.gz
    rm *cram*
    #this might be file on older versions of the uploader
    hca-util upload files *.fastq.gz
    rm *.fastq.gz
done

