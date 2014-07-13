functions replace()
{
    rename 's/\.fasta/_/' *.fasta
    for i in *_
    do
        sed -i 's/>/>'"$i"'/' $i
    done
}

for a in *.fasta
do
    runAssembly -o $a -p $a
done

for d in *
do
    if [-d "$d"]
        cd $d
        replace()
    fi
done
