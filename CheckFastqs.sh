#!/bin/sh
#CheckFastqs ../rep1/fastqFolder 

count=1
for FID in $1/*.fastq
	do
		if [ $(( count % 100)) -eq 0 ]
			then
				echo "checked "$count" files"
		fi
		if [ $(cat $FID | paste - - - - | grep -c -v ^@ -) -gt 0 ]
			then
				echo $FID
				cat $FID | paste - - - - | grep -v ^@ 
		fi
		if [ $(cat $FID | paste - - - - | awk -F"\t" '{ if (length($2) != length($4)) print $0 }' | wc -l) -gt 0 ]
                        then
                                echo $FID
                                cat $FID | paste - - - - | awk -F"\t" '{ if (length($2) != length($4)) print $0 }' | wc -l
                fi
		count=$(($count+1))
	done
