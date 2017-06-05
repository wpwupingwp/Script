#!/bin/sh
#PBS -N flash
#PBS -l nodes=1:ppn=8
#PBS -l walltime=300:00:00 
#PBS -q batch             
#PBS -S /bin/bash        

workdir=/home/zhangxianchun/lichanghao/wp/October
cd $workdir
#time flash -t 8 -M 200 E31_1_clean.fq E31_2_clean.fq
time python3 join_fastq.py out.notCombined_1.fastq out.notCombined_2.fastq
