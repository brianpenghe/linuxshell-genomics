#!/bin/bash
set -e
ProcessSample () {
        echo "Processing: "$1
        mkdir -p fastq-$1
        cd fastq-$1
        printf '#!/bin/bash\nset -e\n\n----\n' > imeta$1.sh
        imeta qu -z seq -d sample = $1 and target = 1 and library_type = 'Chromium single cell BCR'>> imeta$1.sh
        sed ':a;N;$!ba;s/----\ncollection:/iget -K/g' -i imeta$1.sh
        sed ':a;N;$!ba;s/\ndataObj: /\//g' -i imeta$1.sh
        bash imeta$1.sh
        parallel bash ~/tools/linuxshell-genomics/cramfastq.sh ::: *.cram
        rm -f *.cram
        count=1
        for file in *I1_001.fastq.gz
            do
                mv "${file}" "${file/*.cram/$SAMPLE\_S$count\_L001}"
                file=$(sed 's/I1/R1/g' <<< $file)
                mv "${file}" "${file/*.cram/$SAMPLE\_S$count\_L001}"
                file=$(sed 's/R1/R2/g' <<< $file)
                mv "${file}" "${file/*.cram/$SAMPLE\_S$count\_L001}"
                (( count++ ))
            done
        cd ..
}

for SAMPLE in Immunodeficiency8708742 Pla_HDBR8708838 Pla_HDBR8708839 5891STDY87091{27..30}
    do 
        ProcessSample $SAMPLE & 
    done
