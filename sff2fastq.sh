#!/bin/sh
cd /media/F/cp
mkdir sff-trim
cd sff
for i in `seq 12`
do
    cd $i
    for m in *.sff
    do
        python3 -c "import sys;from Bio import SeqIO;SeqIO.convert(sys.argv[1],'sff-trim',str(sys.argv[1]).replace('.sff','.fastq'),'fastq');" $m
    done
    cat *.fastq>../../sff-trim/"$i".fastq
    cd ..
done

