#! /bin/bash

#This code aligns RNAseq data to the C.elegans reference transcirptome using salmon

Data="SRR5564855
SRR5564856
SRR5564857
SRR5564858
SRR5564859
SRR5564860
"
cd ~/mydatalocal/tp_nematode_2021/

#Creation of salmon index of C.elegans transcriptome
salmon index -t data/Celegans_cDNA/Caenorhabditis_elegans.WBcel235.cdna.all.fa \
-i results/alignment_data/Caenorhabditis_elegans.WBcel235_idx


for Srr in $Data
 do
 echo "Processing sample ${Srr}"
 salmon quant -i results/alignment_data/Caenorhabditis_elegans.WBcel235_idx -l A \
         -1 results/trimmed_data/${Srr}_1_output_paired.fastq.gz \
         -2 results/trimmed_data/${Srr}_2_output_paired.fastq.gz \
         -p 4 --validateMappings -o results/alignment_data/quants/${Srr}_quant
done 


#for fn in *;
#do
#samp=`basename ${fn}`
#echo "${samp}"
#done