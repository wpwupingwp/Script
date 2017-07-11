#!/bin/bash
for i in *.fasta
do
    time mafft --reorder --adjustdirection --thread 15 --genafpair --maxiterate 1000 ${i} > ${i}.aln | tee ${i}.log
done
