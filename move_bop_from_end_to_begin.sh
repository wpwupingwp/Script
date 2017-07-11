#!/bin/sh
pattern="s/>(.*)([A-Z]{2}[0-9]{6,}\.?[0-9]*|[A-Z]{3}[0-9]{6,}\.?[0-9]*)$/>\2\|\1/"
#sed -i -s -E 's/>(.*)([A-Z]{2,3}[0-9]{6,}\.?[0-9]*[a-z]*)(.*$)/>\2\|\1\2\3/' *.fasta
echo 'old'
grep '>' *.fasta|head -n 30
echo 'new'
sed -i -s -E ${pattern} *.fasta|grep '>'|head -n 30
