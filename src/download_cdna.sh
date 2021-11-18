#! /bin/bash


#This code downloads cDNA data from C.elegans from http://ftp.ensembl.org/pub/release-104/fasta/caenorhabditis_elegans/cdna/
cd ~/mydatalocal/tp_nematode_2021/

wget -P data/Celegans_cDNA/ http://ftp.ensembl.org/pub/release-104/fasta/caenorhabditis_elegans/cdna/Caenorhabditis_elegans.WBcel235.cdna.all.fa.gz
gunzip -k ~/mydatalocal/tp_nematode_2021/data/Celegans_cDNA/Caenorhabditis_elegans.WBcel235.cdna.all.fa.gz 
