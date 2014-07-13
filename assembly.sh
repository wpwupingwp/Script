for a in *.fasta
do
    runAssembly -o $a -p $a
done

for d in *
do
    if [-d "$d"]
        cd $d
        replace()
        sed -i 's/>/>'"$d"'/' *.fna
        sed -i 's/>/>'"$d"'/' *.qual
    fi
done
