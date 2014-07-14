#PBS -N 454work
#PBS -l nodes=2:ppn=16
#PBS -l walltime=240:00:00
#PBS -q batch   
#PBS -V
#PBS -S /bin/bash

area=9
workdir=/home/zhangxianchun/lichanghao/CT/wp/work/
four54="$workdir"/454/bin
$pldir=$workdir/

#devideraw
cd $workdir
cd $area
perl "$pldir"/devideraw.pl "$area".fasta primer_list.xt
mv "$area".fasta_cp_regions assembly

#Rename
cd assembly
for x in `ls`
do
    mv -f  $x `echo $x |sed 's/\.fasta//'`
done

#Assembly
for a in *
do
    $four54/runAssembly -o "$a"_ -p $a
done

#Add primer name
rm -rf assembly.sh_
mkdir all
for d in *
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
cd ../all
cat *fna >all.fna
cp all.fna ../"$area"in.fasta
cat *qual >../all.qual
cd ..

#Makedb
perl "$pldir"/devidedb.pl maindb list"$area"
mv maindb.Order.Extracted.fas db"$area"
makeblastdb -in db"$area" -dbtype nucl -out db"$area"

#Blast
blastn -db db"$area" -task megablast -use_index false -evalue 1e-05 -max_target_seqs 10 -num_threads 16 -outfmt "7 sseqid bitscore score length qcovs evalue pident" -query "$area"in.fasta -out "$area"Bout

#Devidefasta
perl "$pldir"/devidefasta.pl "$area"in.fasta "$area"Bout
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
    sed -i 's/\>/\>'"$y"'_/' $y
done

cat *>../result.fna
cd ..
cp all.qual result.qual
python addname.py result.qual result.fna



















