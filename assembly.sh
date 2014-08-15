#PBS -N assembly-1
#PBS -l nodes=1:ppn=16
#PBS -l walltime=240:00:00
#PBS -q batch   
#PBS -V
#PBS -S /bin/bash

area=1
#workdir=/home/zhangxianchun/lichanghao/CT/wp/work/
workdir=/tmp/work
four54=/usr/bin
#four54="$workdir"/454/bin

echo 'Depend on : result/ sum/ maindb addname.py table.py devideraw.py primer.fasta list raw-trim.fastq devidefasta.pl devidedb.py usearch' 
#devideraw
cd $workdir
mkdir "$area"
#cp devide* "$area"/
cd $area
cp ../primer.* ./
python3 ../devideraw.py ../"$area".fastq primer.fasta
mkdir assembly
mv cp* assembly/

#Merge
cd assembly
for x in *
do
    python3 -c "import sys;from Bio import SeqIO;SeqIO.convert(sys.argv[1],'fastq',''.join([sys.argv[1],'.fasta']),'fasta')" $x
    ../../usearch -cluster_fast "$x".fasta -id 1.0 -centroids "$x"-merge.fasta --log "$x".log
done
cat *.log > ../usearch.log
rm *.log

#Assembly
for a in `seq -w 140`
do
    $four54/runAssembly -o "$a" -p cp"$a"
done

#Add primer name
for d in `ls`
do
    if [ -d "$d" ]
    then
        cd $d
        sed -i 's/>/>'"$d"'-/' 454AllContigs.fna
        sed -i 's/ //g' 454AllContigs.fna
        sed -i 's/ //g' 454AllContigs.qual
        sed -i 's/>/>'"$d"'-/' 454AllContigs.qual
        cat 454AllContigs.fna >> ../all.fna
        cat 454AllContigs.qual >> ../all.qual
        cd ..
    fi
done
cp all.fna ../"$area"in.fasta
cp all.qual ../result.qual
cd ..

#Makedb
python3 ../devidedb.py ../maindb ../list"$area"
makeblastdb -in db"$area" -dbtype nucl -out db"$area"

#Blast
blastn -db db"$area" -task megablast -use_index false -evalue 1e-05 -max_target_seqs 10 -num_threads 16 -outfmt "7 sseqid bitscore score length qcovs evalue pident" -query "$area"in.fasta -out "$area"Bout

#Devidefasta
perl ../devidefasta.pl "$area"in.fasta "$area"Bout > devidefasta.log
mv "$area"in.fasta_order devide

#Rename
cd devide
for x in `ls`
do
    mv -f  $x `echo $x |sed 's/\.fasta//'`
done
mv Statis.xls ../

#Add name info
for y in `ls`
do
    sed -i 's/>/>'"$y"'-/' $y
done

cat * > ../result.fna
cd ..
python3 ../addname.py result.fna result.qual
cp result.fna ../result/"$area".fna
cp result.qual ../result/"$area".qual
python3 ../table.py result.fna ../list"$area"
mv *.csv ../sum/
