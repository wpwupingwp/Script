#!/bin/bash
for i in *.fasta
do
    time mafft --reorder --adjustdirection --thread 15 --genafpair ${i} > ${i}.aln | tee ${i}.log
done
