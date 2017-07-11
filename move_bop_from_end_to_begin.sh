#!/bin/sh
pattern="s/>(.*)([A-Z]{2}[0-9]{6,}\.?[0-9]*|[A-Z]{3}[0-9]{6,}\.?[0-9]*)$/>\2\|\1/"
echo 'old'
grep '>' *.fasta|head -n 30
echo 'new'
sed -i -s -E ${pattern} *.fasta|grep '>'|head -n 30
