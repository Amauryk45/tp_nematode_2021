#! /bin/bash

#This script uses trimmomatic to filter and trimme RNAseq data from fastq zipped files
#Variable data with SRA numbers of samples
Data="SRR5564855
SRR5564856
SRR5564857
SRR5564858
SRR5564859
SRR5564860
"
#defines global path
cd ~/mydatalocal/tp_nematode_2021/


for Srr in $Data
 do
java -jar /softwares/Trimmomatic-0.39/trimmomatic-0.39.jar \
  PE \ 
  #pair-end
  data_test/${Srr}_1.fastq.gz \
  data_test/${Srr}_2.fastq.gz \
  #both input files in /data_test
  results/trimmed_data/${Srr}_1_output_paired.fastq.gz \
  results/trimmed_data/${Srr}_1_output_unpaired.fastq.gz \
  results/trimmed_data/${Srr}_2_output_paired.fastq.gz \
  results/trimmed_data/${Srr}_2_output_unpaired.fastq.gz \
  #four output files (paired/unpaired) in /results/trimmed_data (mkdir)
  -threads 4 \
  ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:25 TRAILING:25 SLIDINGWINDOW:4:28 MINLEN:75
  #Illuminaclip: remove adapters in TruSeq3 file (specific for Hiseq)
  #Slidingwindow: Perform a sliding window trimming, cutting once the average quality within the window falls below a threshold. (every 4 if mean quality < 28)
  #Leading: Cut bases off the start of a read, if below a threshold quality (25)
  #Trailing: Cut bases off the end of a read, if below a threshold quality (25)
  #Minlen:  Drop the read if it is below a specified length (75)
 done
 