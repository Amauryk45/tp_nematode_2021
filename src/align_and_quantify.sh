#! /bin/bash

#This code align RNAseq data to C.elegans reference transcirptome using salmon

Data="SRR5564855
SRR5564856
SRR5564857
SRR5564858
SRR5564859
SRR5564860
"

#Creation of salmon index of C.elegans transcriptome
salmon index -t ~/mydatalocal/tp_nematode_2021/data/Celegans_cDNA/Caenorhabditis_elegans.WBcel235.cdna.all.fa -i ~/mydatalocal/tp_nematode_2021/results/alignment_data/Caenorhabditis_elegans.WBcel235_idx

for Srr in $Data
 do
 samp=`basename ${Srr}`
 echo "Processing sample ${samp}"
 salmon quant -i ~/mydatalocal/tp_nematode_2021/results/alignment_data/Caenorhabditis_elegans.WBcel235_idx -l A \
         -1 data/samples_data/${Srr}_1.fastq.gz \
         -2 data/samples_data/${Srr}_2.fastq.gz \
         -p 4 --validateMappings -o quants/${samp}_quant
done 



for fn in data/DRR0161{25..40};
do
samp=`basename ${Srr}`
echo "Processing sample ${samp}"
salmon quant -i athal_index -l A \
         -1 ${fn}/${samp}_1.fastq.gz \
         -2 ${fn}/${samp}_2.fastq.gz \
         -p 8 --validateMappings -o quants/${samp}_quant
done 