rename 's/\.fasta//' *.fasta
for a in *
do
    runAssembly -o $a+"_" -p $a
done

for d in *
do
    if [-d "$d"]
        {
            cd $d
            sed -i 's/>/>'"$d"'/' 454AllContigs.fna
            sed -i 's/>/>'"$d"'/' 454AllContigs.qual
            cd ..
        }
    fi
done
