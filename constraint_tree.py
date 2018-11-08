#!/usr/bin/python3
# given ML tree as constraint,
# use mafft-add to append sequence
from glob import glob
from subprocess import run

files = list(glob('*.clean'))
model = 'GTR+F+R4'
for i in files:
    sample, gene, *_ = i.split('.')
    ref = '~/work/S5/ref/{}.aln'.format(gene)
    ref_tree = ref + '.treefile'
    aln = i + '.merge.aln'
    run('mafft --add {} --keeplength --thread 14 {} > {}'.format(i, ref, aln),
        shell=True)
    run('iqtree -g {} -s {} -m {} -nt 14'.format(ref_tree, aln, model),
        shell=True)
