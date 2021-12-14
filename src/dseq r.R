library(DESeq2)
library(tximport)


paths=c("SRR5564855","SRR5564856","SRR5564857","SRR5564858","SRR5564859","SRR5564860")
paths_quant <-  unlist(lapply(paths, paste0, "_quant"))
quant_files=file.path("results/alignment_data/quants", paths_quant,"quant.sf")


tx2gn <- read.table('~/mydatalocal/tp_nematode_2021/data/tx2gn.csv', h=T, sep=',', as.is=T)

txi_salmon <- tximport(quant_files,
                       type = 'salmon', 
                       tx2gene = tx2gn          
)



head(txi_salmon$counts)



ColData <- data.frame(paths, rep(c("wt", "alg-5(tm1163) I"), e=3))
colnames(ColData) <- c("samples", "treatment")

dds <- DESeqDataSetFromMatrix(round(txi_salmon$counts), colData = ColData , design = ~ treatment)

quantif <- DESeq(dds, test = "Wald")
res <- results(quantif) #extracts log2(fold_change) and form DESeq output
res

plot(x = res$log2FoldChange, y = -log10(res$pvalue), ylim = c(0,4)) #raw plot
plotMA(res, ylim = c(-12,12))  #nice plot

plot(res$padj)

### Extract the output table of DESeq ###

pval_threshold = 0.05
fold_change_threshold = 0.5  #article

#get the indexes of relevant sequences
ind <- na.omit(rownames(res)[ (res$padj <= pval_threshold) & (res$log2FoldChange > fold_change_threshold) ])
length(ind)
cat(ind) 


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