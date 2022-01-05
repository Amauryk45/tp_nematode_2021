
#This script conduct a real age estimation and its comparison between samples using RAPToR

#Installation
#BiocManager::install("limma")
#install.packages("pls")
#devtools::install_github("LBMC/RAPToR", build_vignettes = TRUE)
#devtools::install_github("LBMC/wormRef")

#Librory import
library(RAPToR)
vignette("RAPToR")

ColData <- data.frame(samples = paths, 
                      treatment = factor(rep(c("wt", "alg-5(tm1163) I"), e=3),
                                         levels = c("wt", "alg-5(tm1163) I")))

#Choosing the reference dataset
list_refs("wormRef")
(plot_refs("wormRef"))
r_larv <- prepare_refdata("Cel_larv_YA", "wormRef", n.inter = 800)

#Normalisation and log of abundance quantification data
AbonNorm <- limma::normalizeBetweenArrays(txi_salmon$abundance, method = "quantile")
AbondNormLog <- log1p(AbonNorm)
ae_abdondance <- ae(samp = AbondNormLog,                         # input gene expression matrix
                          refdata = r_larv$interpGE,            # reference gene expression matrix
                          ref.time_series = r_larv$time.series)

#Plotting
colors = c("blue","red")
plot(ae_abdondance, group = ColData$treatment, color=colors[ColData$treatment], show.boot_estimates = T, xlim=c(41,46))


ae_algram2 <- ae(samp = txi_salmon$lognorm,                  # input gene expression matrix
                 refdata = r_larv$interpGE,            # reference gene expression matrix
                 ref.time_series = r_larv$time.series)
colors <- c("blue", "red")
plot(ae_algram2, group = ColData$treatment, color = colors[ColData$treatment],show.boot_estimates = TRUE)

par(mfrow=c(1,1))
plot_cor.ae(ae_abdondance, subset = c(1:6))

# Fuunction to get the indices/GExpr of the reference matching sample age estimates.
getrefTP <- function(ref, ae_obj, ret.idx = T){
  idx <- sapply(ae_obj$age.estimates[,1], function(t) which.min(abs(ref$time.series - t)))
  if(ret.idx)
    return(idx)
  return(ref$interpGE[,idx])
}


getrefTP(r_larv, ae_abdondance)

#Function to compute the reference changes and the observed changes
refCompare <- function(samp, ref, ae_obj, fac){
  ovl <- format_to_ref(samp, getrefTP(ref, ae_obj, ret.idx = F))
  lm_samp <- lm(t(ovl$samp)~fac)
  lm_ref <- lm(t(ovl$ref)~fac)
  return(list(samp=lm_samp, ref=lm_ref, ovl_genelist=ovl$inter.genes))
}
comparaison<- refCompare(AbondNormLog, r_larv, ae_abdondance, ColData$treatment)

 
#Plotting each gene coefficient 
comparaison$samp$coefficients[,2]
plot(comparaison$ref$coefficients[2,], comparaison$samp$coefficients[2,], xlim = c(-5,5),ylim = c(-5,5))












#In the comparaison object, the coefficients stand for the intercept (beta_0) intra-samples (not explained by development)
#and the inter-samples coefficient (beta_1), explaining the percentage of the dvt on the observed effect

lm_de_lm <- lm(comparaison$ref$coefficients[2,] ~ comparaison$samp$coefficients[2,])

plot(x =comparaison$ref$coefficients[2,],
     y =comparaison$samp$coefficients[2,],
     xlab = "Reference",
     ylab = "Sample",
     xlim = c(-5,5),
     ylim = c(-5,5)
)
abline(lm_de_lm)



#est-ce que els gènes up ou down régulés sont les gènes corrélés avec le développement ? pas trop 
cor_comparaison <-cor(comparaison$ref$coefficients[2,],comparaison$samp$coefficients[2,])
plot(comparaison$ref$coefficients[2,],
     comparaison$samp$coefficients[2,],
     main = " Up- and Down- regulated genes correlation with developmental stages ",
     ylim=c(-3,3),
     xlim=c(-3,3),
     xlab = "Reference",
     ylab = "Sample",
     col=1,
    )
text(2,3,cor_comparaison,col = "darkgreen")

points(comparaison$ref$coefficients[2, comparaison$ovl_genelist %in% differently_regulated_genes_up],
       comparaison$samp$coefficients[2,comparaison$ovl_genelist %in% differently_regulated_genes_up],col=2)
points(comparaison$ref$coefficients[2, comparaison$ovl_genelist %in% differently_regulated_genes_down],
       comparaison$samp$coefficients[2,comparaison$ovl_genelist %in% differently_regulated_genes_down],col=3)
legend(x = "bottomright", 
       c("Up-regulated","Down-regulated","other"),
       pch= 1,
       col = c(2,3,1000)
       )





par(pty='s')


plot(comparaison$ref$coefficients[2,],comparaison$samp$coefficients[2,],
     ylim=c(-5,5),xlim=c(-5,5),col=1,pch=16,xlab='log2fold ref',ylab='log2fold sample',main="alg-5(tm1163)")

points(comparaison$ref$coefficients[2, comparaison$ovl_genelist %in% differently_regulated_genes_up],
       comparaison$samp$coefficients[2,comparaison$ovl_genelist %in% differently_regulated_genes_up],col=3,pch=16)
points(comparaison$ref$coefficients[2, comparaison$ovl_genelist %in% differently_regulated_genes_down],
       comparaison$samp$coefficients[2,comparaison$ovl_genelist %in% differently_regulated_genes_down],col=2,pch=16)
#abline(0,cor(comparaison$ref$coefficients[2,],comparaison$samp$coefficients[2,]),col=4,cex=5)
legend('bottomright',legend=c("upregulated","downregulated","not significant"),
       col=c(3,2,1), pch=16, lwd=2, lty=NA,x.intersp = 0.05, bty="n")
