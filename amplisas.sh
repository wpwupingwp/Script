#!/bin/sh

info=info.csv
L=test-l
R=test-r
merge=merged.fastq

output="shaoyao"
thread=8
parameter=parameters.txt
workdir=`pwd`

cat "$parameter" "$info" > info.txt
mkdir "$output"

echo "Merge"
./flash "$L" "$R"
python3 join_fastq.py out.notCombined_1.fastq out.notCombined_2.fastq
cat out.extendedFrags.fastq combine.fastq > "$merge"
echo "Cut"
python3 cut_barcode.py "$merge" -o "$merge"-cut -f info.txt
echo "SAS"
perl ./ampliSAS.pl -thr "$thread" -i "$merge"-cut -d info.txt -t 'Illumina' -o "$output"/sas > "$output"/sas.log
echo "Check"
perl ./ampliCHECK.pl -thr "$thread" -i "$merge"-cut -d info.txt -t 'Illumina' -o "$output"/check > "$output"/check.log
echo "Compare"
perl ./ampliCOMPARE.pl -1 "$output"/check/results.xlsx -2 "$output"/SAS/results.xlsx -o "$output"/compare.xlsx > "$output"/compare.log
echo "Rename"
python3 bop.py --path "$workdir"/"$output"/check/allseqs
python3 bop.py --path "$workdir"/"$output"/SAS/filtered

