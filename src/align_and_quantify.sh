#! /bin/bash

#This code align RNAseq data to C.elegans reference transcirptome using salmon

salmon index -t ~/mydatalocal/tp_nematode_2021/data/Celegans_cDNA/Caenorhabditis_elegans.WBcel235.cdna.all.fa.gz \  
-i ~/mydatalocal/tp_nematode_2021/results/alignment_data/Caenorhabditis_elegans.WBcel235_idx