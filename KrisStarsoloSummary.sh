#!/bin/bash
#CellrangerSummary.sh 5891STDY80386{51..67}
cat $1/counts/Gene/Summary.csv | csvcut -c 1 > summary.csv
for sample in "$@"
    do
        csvjoin -c 1 summary.csv $sample/counts/Gene/Summary.csv > temp2
        mv temp2 summary.csv
	rm tempfilesforcsvtool.$sample
    done

csvformat -T summary.csv > summary.tsv
rm summary.csv
