#Installation
BiocManager::install("limma")
install.packages("pls")
devtools::install_github("LBMC/RAPToR", build_vignettes = TRUE)
devtools::install_github("LBMC/wormRef")

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
colors = c("red","blue")
plot(ae_abdondance, group = ColData$treatment, color=colors[ColData$treatment], show.boot_estimates = T)



par(mfrow=c(2,3))
plot_cor.ae(ae_abdondance, subset = c(1:6))


getrefTP <- function(ref, ae_obj, ret.idx = T){
  # function to get the indices/GExpr of the reference matching sample age estimates.
  idx <- sapply(ae_obj$age.estimates[,1], function(t) which.min(abs(ref$time.series - t)))
  if(ret.idx)
    return(idx)
  return(ref$interpGE[,idx])
}

getrefTP(r_larv, ae_abdondance)


refCompare <- function(samp, ref, ae_obj, fac){
  # function to compute the reference changes and the observed changes
  ovl <- format_to_ref(samp, getrefTP(ref, ae_obj, ret.idx = F))
  lm_samp <- lm(t(ovl$samp)~fac)
  lm_ref <- lm(t(ovl$ref)~fac)
  return(list(samp=lm_samp, ref=lm_ref, ovl_genelist=ovl$inter.genes))
}
 results_compare<- refCompare(AbondNormLog, r_larv, ae_abdondance, ColData$treatment)

 
 #Coefficients de chaque gène pour la réference, et la différence du sample/wt
results_compare$samp$coefficients[,2]
plot(results_compare$samp$coefficients[2,], results_compare$ref$coefficients[2,], xlim = c(-3,3),ylim = c(-3,3))