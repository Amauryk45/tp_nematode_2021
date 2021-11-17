DATA="SRR5564855
SRR5564856
SRR5564857
SRR5564858
SRR5564859
SRR5564860
"
cd ~/mydatalocal/tp_nematode_2021/data/
for SRR in $DATA
do
   fastq-dump --split-files --gzip $SRR
done


