#PBS -N 454work
#PBS -l nodes=1:ppn=16
#PBS -l walltime=240:00:00
#PBS -q batch   
#PBS -V
#PBS -S /bin/bash

area=1
workdir=/home/zhangxianchun/lichanghao/CT/wp/work/
four54="$workdir"/454/bin

echo 'Depend on : maindb addname.py primer.fasta list raw-trim.fastq .pl usearch' 
#devideraw
cd $workdir
mkdir "$area"
cp devide* "$area"/
cd $area
mkdir assembly
python3 ../devideraw.py ../"$area".fastq ../primer.fasta
mv cp* assembly/

#Merge
cd assembly
for x in `ls`
do
    python3 -c "from Bio import SeqIO;SeqIO.convert(sys.argv[1],'fastq',''.join([sys.argv[1],'.fasta']),'fasta)" $x
    ../../usearch -cluster_fast "$x".fasta -id 1.0 -centroids "$x"-merge.fasta --log "$x".log
done
cat *.log >../usearch.log
rm *.log

#Assembly
for a in `seq -w 139`
do
    $four54/runAssembly -o "$a" -p cp"$a"
done

#Add primer name
mkdir all
for d in `ls`
do
    if [ -d "$d" ]
    then
        cd $d
        sed -i 's/>/>'"$d"'/' 454AllContigs.fna
        sed -i 's/>/>'"$d"'/' 454AllContigs.qual
#        cp 454AllContigs.fna ../all/"$d".fna
        cat 454AllContigs.fna >> ../all.fna
        cat 454AllContigs.qual >> ../all.qual
#        cp 454AllContigs.qual ../all/"$d".qual
        cd ..
    fi
done
#cd all
#cat *.fna >all.fna
#cat *qual>all.qual
cp all.fna ../../"$area"in.fasta
cp all.qual ../../result.qual
cd ..
cd ..

#Makedb
perl devidedb.pl ../maindb ../list"$area" >log2
mv maindb.Order.Extracted.fas db"$area"
makeblastdb -in db"$area" -dbtype nucl -out db"$area"

#Blast
blastn -db db"$area" -task megablast -use_index false -evalue 1e-05 -max_target_seqs 10 -num_threads 16 -outfmt "7 sseqid bitscore score length qcovs evalue pident" -query "$area"in.fasta -out "$area"Bout
rm db*

#Devidefasta
perl devidefasta.pl "$area"in.fasta "$area"Bout>log3
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

cat *>../result.fna
cd ..
python3 addname.py result.fna result.qual
cp result.fna ../result/"$area".fna
cp result.qual ../result/"$area".qual
python3 table.py result.fna list"$area"
c *.csv ../sum/
