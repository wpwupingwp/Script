#!/bin/bash

rsync -avvv -P rsync://ftp.ncbi.nlm.nih.gov/refseq/release/plant/*gbff.gz plant/
