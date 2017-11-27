#!/bin/bash

python3 ~/git/python/parallel.py  "ete3 compare -r  %i -t *.tree --unrooted --taboutput --treeko --min_support_ref 50 --min_support_src 50 >> %i-bmin50.csv" "*.tree"
python3 ~/git/python/parallel.py  "ete3 compare -r  %i -t *.tree --unrooted --taboutput --treeko >> %i-bmin0.csv" "*.tree"
