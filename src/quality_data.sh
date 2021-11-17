#! /bin/bash


cd ~/mydatalocal/tp_nematode_2021/
mkdir results/fastqc_raw
mkdir results/multiqc_raw

fastqc -o results/fastqc_raw data/*.fastq.gz
multiqc -o results/multiqc_raw data/
