BiocManager::install("limma")
install.packages("pls")
devtools::install_github("LBMC/RAPToR", build_vignettes = TRUE)
devtools::install_github("LBMC/wormRef")


library(RAPToR)
vignette("RAPToR")




list_refs("wormRef")
(plot_refs("wormRef"))
r_larv <- prepare_refdata("Cel_larv_YA", "wormRef", n.inter = 600)


#FIchier tpm: abondance des fichiers de quantification
head(txi_salmon$abundance)


AbonNorm <- limma::normalizeBetweenArrays(txi_salmon$abundance, method = "quantile")
AbondNormLog <- log1p(AbonNorm)
ae_abdondance <- ae(samp = AbondNormLog,                         # input gene expression matrix
                          refdata = r_larv$interpGE,            # reference gene expression matrix
                          ref.time_series = r_larv$time.series)

colors = c("red","blue")
plot(ae_abdondance, group = ColData$treatment ,show.boot_estimates = T)

cc <- cor(AbondNormLog, AbondNormLog, method = "spearman")
plot(cc)

