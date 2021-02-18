#!/bin/bash
#CellrangerSummary.sh 5891STDY80386{51..67}
cat <(echo "sample") <(csvtool transpose $1/outs/*metrics_summary.csv | csvcut -c 1) > summary.csv
for sample in "$@"
    do
        cat <(echo ""$sample","$sample"") <(csvtool transpose $sample/outs/*summary.csv) > tempfilesforcsvtool.$sample
        csvjoin -c 1 summary.csv tempfilesforcsvtool.$sample > temp2
        mv temp2 summary.csv
	rm tempfilesforcsvtool.$sample
    done

csvformat -T summary.csv > summary.tsv
rm summary.csv
