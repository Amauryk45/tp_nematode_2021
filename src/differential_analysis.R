library(DESeq2)
library(tximport)
###Construction d'une liste des paths des résultats de quantification
paths=c("SRR5564855","SRR5564856","SRR5564857","SRR5564858","SRR5564859","SRR5564860")
paths_quant <-  unlist(lapply(paths, paste0, "_quant"))
quant_files=file.path("results/alignment_data/quants", paths_quant,"quant.sf")

###Remplacement des noms de gènes par leur version annotée
tx2gn <- read.table('~/mydatalocal/tp_nematode_2021/data/tx2gn.csv', h=T, sep=',', as.is=T)

#tximport des résultats salmon
txi_salmon <- tximport(quant_files,
                       type = 'salmon', 
                       tx2gene = tx2gn          
)
colnames(txi_salmon$abundance) = c("SRR5564855","SRR5564856","SRR5564857","SRR5564858","SRR5564859","SRR5564860")

colData <- c("wt","alg-5 (tm")
#head(txi_salmon$counts)


#Métadonnées
ColData <- data.frame(samples = paths, 
                      treatment = factor(rep(c("wt", "alg-5(tm1163) I"), e=3),
                                         levels = c("wt", "alg-5(tm1163) I")))
# colnames(ColData) <- c("samples", "treatment")

#Construction du DESeqDataSet 
dds <- DESeqDataSetFromMatrix(round(txi_salmon$counts), colData = ColData , design = ~ treatment)

#Analyse DESeq
quantif <- DESeq(dds, test = "Wald")
res <- results(quantif) #extracts log2(fold_change) and form DESeq output
res

plot(x = res$log2FoldChange, y = -log10(res$padj), ylim = c(0,4)) #raw plot
abline(v=c(-1, 1), col='red')
abline(h=-log10(0.05), col='green')

plotMA(res, ylim = c(-12,12))  #nice plot

plot(res$padj)


pval_threshold = 0.05
fold_change_threshold = 0.5  #article

#BE CAREFUL WITH LOG2

#we split the significantly up and downregulated genes (fold change > thr and < -thr)

sel_pv <- res$padj < 0.05

forGO=res$padj<0.05 & abs(res$log2FoldChange)>1
differently_regulated_genes <- rownames(res)[which(forGO==TRUE)]


forGOup=res$padj<0.05 & res$log2FoldChange>1
differently_regulated_genes_up <- rownames(res)[which(forGOup==TRUE)]

forGOdw=res$padj<0.05 & res$log2FoldChange<(-1)
differently_regulated_genes_down <- rownames(res)[which(forGOdw==TRUE)]

GO = file("~/mydatalocal/tp_nematode_2021/results/genes_of_interest.data", "w")
cat(differently_regulated_genes, sep='\n', file = GO) #save ind

GOup = file("~/mydatalocal/tp_nematode_2021/results/genes_of_interest_up.data", "w")
cat(differently_regulated_genes_up, sep='\n', file = GOup) #save ind

GOdw = file("~/mydatalocal/tp_nematode_2021/results/genes_of_interest_dw.data", "w")
cat(differently_regulated_genes_down, sep='\n', file = GOdw) #save ind



