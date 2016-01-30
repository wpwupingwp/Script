#!/bin/sh

parameter=parameter.txt
info=info.csv
left=left.fastq
right=right.fastq
output="output"
thread=16

cat "$parameter" >> "$info"
mkdir "$output"

echo "Merge"
./flash "$left" "$right"
python3 join_fastq.py out.notCombined_1.fastq out.notCombined_2.fastq
cat out.extendedFrags.fastq combine.fastq > merged.fastq
echo "Check"
perl ./ampliCHECK.pl -"$thread" 16 -i ./merged.fastq -d "$info" -t 'Illumina' -o "$output"/check > "$output"/check.log
echo "SAS"
perl ./ampliSAS.pl -"$thread" 16 -i ./merged.fastq -d "$info" -t 'Illumina' -o "$output"/SAS > "$output"/sas.log
echo "Compare"
perl ./ampliCOMPARE.pl -1 "$output"/check/results.xlsx -2 "$output"/SAS/results.xlsx -o "$output"/compare.xlsx > "$output"/compare.log
