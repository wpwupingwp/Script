#PBS -N  17-18-19-20
#PBS -l nodes=1:ppn=4
#PBS -l walltime=240:00:00
#PBS -q batch   
#PBS -V
#PBS -S /bin/bash
#sample=5
sspace=/home/zhangxianchun/lichanghao/CT/wp/bin/sspace/
workdir=/home/zhangxianchun/lichanghao/CT/wp/2015/data
soap=/home/zhangxianchun/lichanghao/CT/wp/bin/SOAPdenovo-127mer
gf=/home/zhangxianchun/lichanghao/CT/wp/bin/gapfiller/GapFiller.pl
for sample in 17 18 19 20 
    do
        cd $workdir/
        cd $sample
        cp -r "$sspace" ./
        $soap all -s config -p 8 -K 89 -o out
        perl sspace/SSPACE_Standard_v3.0.pl -l library -s out.contig -x 0
        cp standard_output/standard_output.final.scaffolds.fasta sspace.fasta
        mv standard_output scaffold
        perl $gf -l library -s sspace.fasta
    done
