#!/bin/sh
#usage:  ./Extract3primeFromFastq.sh FastqFile.fq 30 > 3prime.30.fq
paste <(cat $1 | paste - - | cut -f1 | tr "\t" "\n") <(cat $1 | paste - - | cut -f2 | tr "\t" "\n" | grep -o '.\{$2\}$' ) | tr "\t" "\n"
