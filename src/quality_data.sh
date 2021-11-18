#! /bin/bash

#This code use fastqc and multiqc functions to give informations on the quality of the data imported

cd ~/mydatalocal/tp_nematode_2021/

fastqc -o results/fastqc_raw data/samples_data/*.fastq.gz
multiqc -o results/multiqc_raw results/fastqc_raw
