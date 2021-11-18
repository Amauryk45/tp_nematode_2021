#! /bin/bash

#This code downloads SRR data from WT and alg-5 tm mutant nematode
#Paired data are converted in zipped fastq files 


#Defines variable with all 6 SRR samples (3 WT + 3 alg-5 tm)

#SRR5564855
#SRR5564856
#SRR5564857
#SRR5564858
Data="SRR5564859
SRR5564860
"

cd ~/mydatalocal/tp_nematode_2021/data/

for Srr in $Data
do
   parallel-fastq-dump --split-3 --gzip -s $Srr --threads 6
done
