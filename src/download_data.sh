#! /bin/bash

#This code downloads SRR data from WT and alg-5 tm mutant nematode
#Paired data are converted in zipped fastq files 


#Defines variable with all 6 SRR samples (3 WT + 3 alg-5 tm)

cd ~/mydatalocal/tp_nematode_2021/data/
Data=$(ls data/samples_data/ | sed 's/_[0-9].fastq.gz/ /g'| uniq)

for Srr in $Data
do
   parallel-fastq-dump --split-3 --gzip -s $Srr --threads 6
done
