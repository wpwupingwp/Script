#!/bin/sh
#PBS -N merge
#PBS -l nodes=1:ppn=8
#PBS -l walltime=300:00:00 
#PBS -q batch             
#PBS -S /bin/bash        

workdir=/home/zhangxianchun/lichanghao/wp/October
cd $workdir
L=$workdir/L.fastq
R=$workdir/R.fastq
time flash -t 8 -M 200 $L $R
time python3 join_fastq.py out.notCombined_1.fastq out.notCombined_2.fastq
cat out.extendedFrags.fastq combine.fastq > merged.fastq
