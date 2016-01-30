#!/bin/sh

info=info.csv
L=test-l
R=test-r
merge=merged.fastq

output="test"
thread=8
parameter=parameter.txt
workdir=`pwd`

cat "$parameter" "$info" >> info.txt
mkdir "$output"

echo "Merge"
./flash "$L" "$R"
python3 join_fastq.py out.notCombined_1.fastq out.notCombined_2.fastq
cat out.extendedFrags.fastq combine.fastq > "$merge"
echo "Check"
perl ./ampliCHECK.pl -thr "$thread" -i "$merge" -d info.txt -t 'Illumina' -o "$output"/check > "$output"/check.log
echo "SAS"
perl ./ampliSAS.pl -thr "$thread" -i "$merge" -d info.txt -t 'Illumina' -o "$output"/SAS > "$output"/sas.log
echo "Compare"
perl ./ampliCOMPARE.pl -1 "$output"/check/results.xlsx -2 "$output"/SAS/results.xlsx -o "$output"/compare.xlsx > "$output"/compare.log
echo "Rename"
python3 bop.py --path "$workdir"/"$output"/check/allseqs"
python3 bop.py --path "$workdir"/"$output"/SAS/filtered

