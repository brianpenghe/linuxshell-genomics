#!/bin/bash
set -e
for SAMPLE in 5891STDY80386{51..67}
    do
        echo "Processing: "$SAMPLE
        printf '#!/bin/bash\nset -e\n\n----\n' > imeta$SAMPLE.sh
        imeta qu -z seq -d sample = $SAMPLE and type = cram and target = 1 >> imeta$SAMPLE.sh
        sed ':a;N;$!ba;s/----\ncollection:/iget -K/g' -i imeta$SAMPLE.sh
        sed ':a;N;$!ba;s/\ndataObj: /\//g' -i imeta$SAMPLE.sh
        bash imeta$SAMPLE.sh
        parallel bash cramfastq10XATAC.sh ::: *.cram
        rm -f *.cram
        count=1
        for file in *I1_001.fastq.gz
            do
                mv "${file}" "${file/*.cram/$SAMPLE\_S$count\_L001}"
                file=$(sed 's/I1/R1/g' <<< $file)
                mv "${file}" "${file/*.cram/$SAMPLE\_S$count\_L001}"
                file=$(sed 's/R1/R2/g' <<< $file)
                mv "${file}" "${file/*.cram/$SAMPLE\_S$count\_L001}"
		file=$(sed 's/R2/R3/g' <<< $file)
		mv "${file}" "${file/*.cram/$SAMPLE\_S$count\_L001}"
                (( count++ ))
            done
        mkdir -p fastq-$SAMPLE && mv *.fastq.gz fastq-$SAMPLE
	for file in fastq-$SAMPLE/*I1_001.fastq.gz
	    do
		mv "$(sed 's/I1/R2/g' <<< $file)" "$(sed 's/I1/R3/g' <<< $file)"
		mv "$(sed 's/I1/I2/g' <<< $file)" "$(sed 's/I1/R2/g' <<< $file)"
	    done
    done
