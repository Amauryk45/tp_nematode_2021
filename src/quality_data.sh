#! /bin/bash

#This code uses fastqc and multiqc functions to give informations on the quality of the data imported
input_dir=$1
suffix_out=$2

echo input_dir $input_dir 
echo suffix_out $suffix_out

cd ~/mydatalocal/tp_nematode_2021/

mkdir -p results/fastqc_${suffix_out}
mkdir -p results/multiqc_${suffix_out}

fastqc -o results/fastqc_${suffix_out} ${input_dir}/*.fastq.gz
multiqc -o results/multiqc_${suffix_out} results/fastqc_${suffix_out}
