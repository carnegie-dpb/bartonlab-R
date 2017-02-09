normalize.tpm <- function(df) {

  print("Normalizing across samples (TPM using <RPKM> for all samples...")

  ## use TPKM normalization; df should be a dataframe of RPKM values, not counts
  normFactors = apply(df, 2, mean)

  ## scale back to get a number that is sort of like counts
  normFactors = normFactors/1000

  ## scale
  dfNew <- df
  for (i in 1:dim(dfNew)[2]) {
    print(paste("sample",i,"/",normFactors[i]))
    dfNew[,i] <- dfNew[,i]/normFactors[i]
  }

  return(dfNew)

}
