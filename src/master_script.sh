#!/bin/bash

#Execute this script to launch the analysis

cd ~/mydatalocal/tp_nematode_2021/

echo "Initiation..."
bash ./src/initiation.sh
echo "Downloading data..."
bash ./src/download_data.sh
echo "Downloading reference transcriptome..."
bash ./src/download_cdna.sh
echo "Assessing quality of the imported data..."
bash ./src/quality_data.sh data/samples_data/ raw
echo "Trimming the data..."
bash ./src/trimming_data.sh
echo "Assessing quality of the trimmed data..."
bash ./src/quality_data.sh results/trimmed_data/ trimmed
echo "Quantifying the data..."
bash ./src/align_and_quantify.sh
echo "Assessing quality of the quantification..."
bash ./src/quality_alignment results/alignment_data/quants quant



