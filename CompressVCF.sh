#/bin/sh
bcftools view $1 -Oz -o $1.gz
bcftools index $1.gz
