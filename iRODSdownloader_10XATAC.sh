#!/bin/bash
set -e
ProcessSample () {
        echo "Processing: "$1
        mkdir -p fastq-$1
        cd fastq-$1
        printf '#!/bin/bash\nset -e\n\n----\n' > imeta$1.sh
        imeta qu -z seq -d sample = $1 and type = cram and target = 1 >> imeta$1.sh
        sed ':a;N;$!ba;s/----\ncollection:/iget -K/g' -i imeta$1.sh
        sed ':a;N;$!ba;s/\ndataObj: /\//g' -i imeta$1.sh
        bash imeta$1.sh
        parallel bash ~/tools/linuxshell-genomics/cramfastq10XATAC.sh ::: *.cram
        rm -f *.cram
        count=1
        for file in *I1_001.fastq.gz
            do
                mv "${file}" "${file/*.cram/$1\_S$count\_L001}"
                file=$(sed 's/I1/R1/g' <<< $file)
                mv "${file}" "${file/*.cram/$1\_S$count\_L001}"
                file=$(sed 's/R1/R2/g' <<< $file)
                mv "${file}" "${file/*.cram/$1\_S$count\_L001}"
		file=$(sed 's/R2/I2/g' <<< $file)
		mv "${file}" "${file/*.cram/$1\_S$count\_L001}"
                (( count++ ))
            done
	for file in *I1_001.fastq.gz
	    do
		mv "$(sed 's/I1/R2/g' <<< $file)" "$(sed 's/I1/R3/g' <<< $file)" #R2 reads are R3
		mv "$(sed 's/I1/I2/g' <<< $file)" "$(sed 's/I1/R2/g' <<< $file)" #I2 reads are R2;But Cellranger ATAC now can accept unmodified format!
	    done
        cd ..
}

for SAMPLE in 5891STDY80386{51..67}
    do 
        ProcessSample $SAMPLE & 
    done
