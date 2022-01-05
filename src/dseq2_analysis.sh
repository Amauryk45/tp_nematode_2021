#! /bin/bash

#This script uses DESeq2 to conduct a Differential Expression (DE) analysis

cd ~/mydatalocal/tp_nematode_2021/

library(tximport)
paths=c("SRR5564861","SRR5564862","SRR5564863","SRR5564855","SRR5564856","SRR5564857")
for i in paths {
  i <- i+'_quant'
  print(i)
}
fullpaths=file.path("data/results/alignment_data/quants", paths,"quant.sf")

cts=tximport(fullpaths,'salmon',txOut=TRUE)
dds <- DESeqDataSetFromTximport(countData =cts)
dds <- DESeq(dds)
resultsNames(dds)

colData=data.frame(paths,c("Arg1","Arg1","Arg1","WT","WT","WT"))
colnames(colData)=c("sample","treatment")
dp=DESeqDataSetFromMatrix(round(data$counts),colData = colData,design=~treatment)
results=DESeq(dp,test="Wald")

plotMA(results,ylim=c(-12,12))

tx2gn <- read.table("path/to/tx2gn.csv", h=T, sep=',', as.is=T)
data <- tximport(...., tx2gene = tx2gn) # enlever l'option txOut si vous l'avez mise