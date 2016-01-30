#!/bin/sh

workdir=~/Shaoyao
cd "$workdir"
cat info.txt >> info.csv
mkdir output
echo "Merge"
flash left.fastq right.fastq
python3 join_fq.py out.notCombined_1.fastq out.notCombined_2.fastq
cat out.extendedFrags.fastq combine.fastq > merged.fastq
#echo "Clean"
#perl ./ampliCLEAN.pl -thr 16 -i ./output/merge.fq -d ./info.csv -mqual 20 -o ./output/clean > ./output/clean.log
echo "Check"
perl ./ampliCHECK.pl -thr 16 -i ./output/combine.fastq -d ./info.csv -t 'Illumina' -o ./output/check > ./output/check.log
echo "SAS"
perl ./ampliSAS.pl -thr 16 -i ./output/combine.fastq -d ./info.csv -t 'Illumina' -o ./output/SAS > ./output/sas.log
echo "Compare"
perl ./ampliCOMPARE.pl -1 ./output/check/allseqs/results.xlsx -2
./output/SAS/allseqs/SAS/results.xlsx -o ./output/compare.xlsx > ./output/compare.log
