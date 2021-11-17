#! /bin/bash

#This code use fastqc and multiqc functions to give informations on the quality of the data imported

cd ~/mydatalocal/tp_nematode_2021/
mkdir results/fastqc_raw
mkdir results/multiqc_raw
mkdir results/trimmed_data

fastqc -o results/fastqc_raw data/*.fastq.gz
multiqc -o results/multiqc_raw results/fastqc_raw
