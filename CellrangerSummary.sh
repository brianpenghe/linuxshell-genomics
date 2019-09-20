#!/bin/bash
#CellrangerSummary.sh 5891STDY80386{51..67}
echo -n "sample," > summary.csv
head -1 $1/outs/summary.csv >> summary.csv
for sample in "$@"
    do
         echo -n $sample"," >> summary.csv; tail -1 $sample/outs/summary.csv >> summary.csv
    done

