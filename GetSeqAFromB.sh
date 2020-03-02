#!/bin/bash
#This scripts gets sequences in B whose read IDs show up in A(trimmed reads etc.)
#usage:  ./GetSeqAFromB.sh A.fq B.fq > C.fq
grep -f <(cat $1 | paste - - - - | cut -f 1) <(cat $2 | sed 's/ /_/g' | paste - - - - ) | tr "\t" "\n" 
