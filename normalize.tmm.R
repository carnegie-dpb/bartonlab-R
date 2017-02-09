normalize.tmm <- function(df) {

  library(edgeR)

  print("Normalizing across samples (TMM from edgeR)...")

  ## use TMM normalization, rows with all zeros are automatically excluded
  normFactors <- calcNormFactors(df, method="TMM")

  dfNew <- df
  for (i in 1:dim(dfNew)[2]) {
    print(paste("sample",i,"/",normFactors[i]))
    dfNew[,i] <- dfNew[,i]/normFactors[i]
  }

  return(dfNew)

}
