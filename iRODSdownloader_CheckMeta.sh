#!/bin/bash
set -e
CPU=30
CELLRANGER=/home/ubuntu/tools/cellranger-3.0.2/cellranger
REFSEQ=/home/ubuntu/refseq/refdata-cellranger-GRCh38-3.0.0

for SAMPLE in 5841STDY7991475 
    do
        echo "Processing: "$SAMPLE
        printf '#!/bin/bash\nset -e\n\n----\n' > imeta$SAMPLE.sh
        imeta qu -z seq -d sample = $SAMPLE and type = cram and target = 1 >> imeta$SAMPLE.sh
        sed ':a;N;$!ba;s/----\ncollection:/imeta ls -d/g' -i imeta$SAMPLE.sh
        sed ':a;N;$!ba;s/\ndataObj: /\//g' -i imeta$SAMPLE.sh
done

