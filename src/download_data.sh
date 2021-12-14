#! /bin/bash

#This code downloads SRR data from WT and alg-5 tm mutant nematode
#Paired data are converted in zipped fastq files 


#Defines variable with all 6 SRR samples (3 WT + 3 alg-5 tm)

cd ~/mydatalocal/tp_nematode_2021/data/samples_data
###Data=$(ls samples_data/ | sed 's/_[0-9].fastq.gz/ /g'| uniq)

Data="SRR5564858
SRR5564859
SRR5564860
SRR5564855
SRR5564856
SRR5564857"
for Srr in $Data
do
   parallel-fastq-dump --split-3 --gzip -s $Srr --threads 6
done
