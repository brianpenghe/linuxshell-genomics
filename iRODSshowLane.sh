#!/bin/bash
#CellrangerSummary.sh 5891STDY80386{51..67}
for SAMPLE in "$@"
    do
        echo $SAMPLE
        imeta qu -z seq -d sample = $SAMPLE and type = cram and target = 1 | grep dataObj |  cut -d ' ' -f2 | cut -d# -f1 | sort | uniq
    done
