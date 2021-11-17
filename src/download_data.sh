#! /bin/bash

#This code downloads SRR data from WT and alg-5 tm mutant nematode
#Paired data are converted in zipped fastq files 


#Defines variable with all 6 SRR samples (3 WT + 3 alg-5 tm)
Data="SRR5564855
SRR5564856
SRR5564857
SRR5564858
SRR5564859
SRR5564860
"

cd ~/mydatalocal/tp_nematode_2021/data/

for Srr in $Data
do
   fastq-dump --split-3 --gzip $Srr
done


