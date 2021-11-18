#! /bin/bash

#This code aligns RNAseq data to the C.elegans reference transcirptome using salmon

cd ~/mydatalocal/tp_nematode_2021/
Data=$(ls data/samples_data/ | sed 's/_[0-9].fastq.gz/ /g'| uniq)

#Creation of salmon index of C.elegans transcriptome
salmon index -t data/Celegans_cDNA/Caenorhabditis_elegans.WBcel235.cdna.all.fa \
-i results/alignment_data/Caenorhabditis_elegans.WBcel235_idx


for Srr in $Data
 do
 echo "Processing sample ${Srr}"
 salmon quant \
 --index results/alignment_data/Caenorhabditis_elegans.WBcel235_idx \
 -l A \
 -1 results/trimmed_data/${Srr}_1_output_paired.fastq.gz \
 -2 results/trimmed_data/${Srr}_2_output_paired.fastq.gz \
 --threads 4 \
 --validateMappings \
 --output results/alignment_data/quants/${Srr}_quant
done 