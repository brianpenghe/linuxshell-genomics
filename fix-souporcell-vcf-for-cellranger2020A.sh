#!/bin/sh
awk '{if($0 !~ /^#/) print "chr"$0; else print $0}' $1 > $2
