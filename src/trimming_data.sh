#! /bin/bash

#This script uses trimmomatic to filter and trimme RNAseq data from fastq zipped files
sudo apt-get update -y 
sudo apt-get install -y trimmomatic 
 
Data="SRR5564855
SRR5564856
SRR5564857
SRR5564858
SRR5564859
SRR5564860
"

cd ~/mydatalocal/tp_nematode_2021/


#Drop if read length < 75 nucleotides
for Srr in Data
 do
trimmomatic \
  PE \
  data_test/${Srr}_1.fastq.gz \
  data_test/${Srr}_2.fastq.gz \
  results/trimmed_data/${Srr}_1_output_paired.fastq.gz \
  results/trimmed_data/${Srr}_1_output_unpaired.fastq.gz \
  results/trimmed_data/${Srr}_2_output_paired.fastq.gz \
  results/trimmed_data/${Srr}_2_output_unpaired.fastq.gz \
  -threads 4 \
  SLIDINGWINDOW:4:28 MINLEN:75
 done
 