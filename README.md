# TP Next Generation Sequencing 2021 - Groupe RNAseq et modélisation

### Présentation du projet


### Présentation des données 
Original article: *Brown et al. 2017 Nucleic Acid Res.* 

DOI: 10.1093/nar/gkx536

All the high-throughput sequencing data are deposited in the Gene Expression Omnibus (GEO) and are available under accession number **GSE98935**.

Link : https://www.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA386876&o=acc_s%3Aa&s=SRR5564855,SRR5564856,SRR5564857

Dowloading samples data (3 WT + 3 alg-5 tm)
script: `~/mydatalocal/tp_nematode_2021/src/download_data.sh`

Downloading C.elegans cDNA
script: `~/mydatalocal/tp_nematode_2021/src/download_cDNA.sh`

Fastqc and Multiqc analysis 
script : `~/mydatalocal/tp_nematode_2021/src/quality_data.sh`

Filtering and trimming of data
script: 

Parameters : 
- Removal of adaptaters: ILLUMINACLIP:TruSeq3-PE.fa:2:30:10


