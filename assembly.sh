#rename 's/\.fasta//' ./*.fasta
cd assembly
for x in `ls`
do
    mv -f  $x `echo $x |sed 's/\.fasta//'`
done

for a in *
do
    #runAssembly -o $a"_" -p $a
    /home/zhangxian/chun/lichanghao/CT/wp/work/454/bin/runAssembly -o $a"_" -p $a
    echo '1'
done
rm -rf assembly.sh_
rm -rf statis.xls
for d in *
do
    if [ -d "$d" ]
    then
        {
            cd $d
            sed -i 's/>/>'"$d"'/' 454AllContigs.fna
            sed -i 's/>/>'"$d"'/' 454AllContigs.qual
            cd ..
        }
    fi
done
