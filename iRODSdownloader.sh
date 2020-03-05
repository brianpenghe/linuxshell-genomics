#!/bin/bash
set -e
ProcessSample () {
        echo "Processing: "$1
        mkdir -p fastq-$1
        cd fastq-$1
        printf '#!/bin/bash\nset -e\n\n----\n' > imeta$1.sh
        imeta qu -z seq -d sample = $1 and target = 1 and type = cram>> imeta$1.sh
        sed ':a;N;$!ba;s/----\ncollection:/iget -K/g' -i imeta$1.sh
        sed ':a;N;$!ba;s/\ndataObj: /\//g' -i imeta$1.sh
        bash imeta$1.sh
        parallel bash cramfastq.sh ::: *.cram
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

for SAMPLE in Immunodeficiency8103069 Pla_HDBR86244{34..35} 5841STDY7998693 5891STDY8062335 5891STDY80623{37..39}
    do 
        ProcessSample $SAMPLE & 
    done
