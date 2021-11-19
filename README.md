# TP Next Generation Sequencing 2021 - Team RNAseq and modelisation

## Project presentation
Caenorhabditis elegans is a tiny, hermaphrodite nematode with a fixed number of somatic cells (cf. Figure 1). It is widely used as a model organism for fundamental research in a broad range of topics and notably in the study of small RNAs which are often implicated in RNA silencing mechanisms, and consequently have an
important role in the regulation of gene expression.
Argonautes proteins are known to interact with a subclass of small RNAs called microRNAs. 
Here, Brown and colleagues sequenced transcriptome of worms with defective argonautes proteins to study the effect of the mutations on gene expression. 


**We will reproduce the transcriptomic analysis done by Brown et al. and use a cutting-edge tool developed in the lab (Bulteau and Francesconi (2021)) to assess the impact of developmental variation on the analysis of this dataset.**

## Data presentation
Original article: *Brown et al. 2017 Nucleic Acid Res.* 
DOI: 10.1093/nar/gkx536

Dataset is composed of 3 replicates of 5 strains (1 WT and 4 mutants alg-1(gk214), alg-2(ok304), alg-5 (tm1163) and alg-5(ram2))

All the high-throughput sequencing data are deposited in the Gene Expression Omnibus (GEO) and are available under accession number **GSE98935**.

Link : https://www.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA386876&o=acc_s%3Aa&s=SRR5564855,SRR5564856,SRR5564857



## Documentation

### 0. Cloning git hub directory

`git clone https://github.com/Amauryk45/tp_nematode_2021.git`

### 1. Launch master script

`~/mydatalocal/tp_nematode_2021/src/master_script.sh`

This script will launch the entire analysis. Steps are detailed below. 

### 2. Prepare utilities

`~/mydatalocal/tp_nematode_2021/src/initiation.sh`

This script will create the utilities directories that have to be configured and installed


### 3. Importing data 
1. Samples data

`~/mydatalocal/tp_nematode_2021/src/download_data.sh`

2. C.elegans reference transcriptome

Available at http://ftp.ensembl.org/pub/release-104/fasta/caenorhabditis_elegans/cdna/

`~/mydatalocal/tp_nematode_2021/src/download_cDNA.sh`

### 4. Quality analysis:  Fastqc and Multiqc 
`~/mydatalocal/tp_nematode_2021/src/quality_data.sh`

The script takes two arguments:

- The input_dir of the files (e.g. "data/samples_data/")
- The suffixe of the output directories (e.g. "raw")

### 5. Trimming the data
We will use Trimmomatic version 0.39. More info at http://www.usadellab.org/cms/?page=trimmomatic

Cleaning parameters have been chose according to the results of the quality analysis : 

- Removal of adaptaters:   ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 
- LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36


`~/mydatalocal/tp_nematode_2021/src/trimming_data.sh`

You can procede to an other quality analysis after trimming the data. 

### 6. Transcript quantification
Indexation and quantification made with Salmon.

More info at https://salmon.readthedocs.io/en/latest/index.html

`~/mydatalocal/tp_nematode_2021/src/align_and_quantify.sh`


