#PBS -N 454work
#PBS -l nodes=2:ppn=16
#PBS -l walltime=240:00:00
#PBS -q batch   
#PBS -V
#PBS -S /bin/bash

#area=9
#workdir=/home/zhangxianchun/lichanghao/CT/wp/work/
#four54="$workdir"/454/bin
#$pldir=$workdir/
area=5
workdir=/tmp/work
four54=/opt/454/bin

echo 'Depend on : maindb primer_list.txt list raw.fasta .pl ' 
#devideraw
cd $workdir
mkdir "$area"
cp ./* "$area"/
cd $area
perl devideraw.pl "$area".fasta primer_list.txt
mv "$area"_cp_regions assembly

#Rename
cd assembly
for x in `ls`
do
    mv -f  $x `echo $x |sed 's/\.fasta//'`
done

#Assembly
for a in *
do
    sed -i 's/>/>'"$d"'/' 454AllContigs.fna
    $four54/runAssembly -o "$a"_ -p $a
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
        cp 454AllContigs.fna ../all/"$d".fna
        cp 454AllContigs.qual ../all/"$d".qual
        cd ..
    fi
done
cd all
cat *.fna >all.fna
cat *qual>all.qual
cp all.fna ../../"$area"in.fasta
cp all.fna ../../../result.fna
cp all.qual ../../../result.qual
cd ..
cd ..

#Makedb
perl devidedb.pl maindb list"$area" >log
mv maindb.Order.Extracted.fas db"$area"
makeblastdb -in db"$area" -dbtype nucl -out db"$area"

#Blast
blastn -db db"$area" -task megablast -use_index false -evalue 1e-05 -max_target_seqs 10 -num_threads 16 -outfmt "7 sseqid bitscore score length qcovs evalue pident" -query "$area"in.fasta -out "$area"Bout

#Devidefasta
perl devidefasta.pl "$area"in.fasta "$area"Bout
mv "$area"in.fasta_order devide

#Rename
cd devide
for x in `ls`
do
    mv -f  $x `echo $x |sed 's/\.fasta//'`
done

#Add name info
for y in `ls`
do
    sed -i 's/>/>'"$y"'_/' $y
done

cat *>../result.fna
cd ..
python addname.py result.fna result.qual

