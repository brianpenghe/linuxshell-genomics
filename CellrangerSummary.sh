#!/bin/bash
#CellrangerSummary.sh 5891STDY80386{51..67}
cat <(echo "sample") <(head -1 $1/outs/summary.csv | tr , '\n') > summary.csv
for sample in "$@"
    do
        paste <(cat <(echo "sample") <(head -1 $sample/outs/summary.csv | tr , '\n')) \
              <(cat <(echo $sample)  <(tail -1 $sample/outs/summary.csv | tr , '\n')) > temp2
        join -1 1 -2 1 summary.csv temp2 > summary2.csv
        mv summary2.csv summary.csv
    done
