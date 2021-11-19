#! /bin/bash

#This code uses multiqc function to give informations on the quality of the data quantification
input_dir=$1
suffix_out=$2

echo input_dir $input_dir 
echo suffix_out $suffix_out

cd ~/mydatalocal/tp_nematode_2021/
#make output directory in results with the choosen suffix
mkdir -p results/multiqc_${suffix_out}
#Give output in this directory, and take in intput a given directory
multiqc -o results/multiqc_${suffix_out} ${input_dir}