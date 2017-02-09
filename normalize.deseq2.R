normalize.deseq2 <- function(df) {

  library(DESeq2)

  print("Normalizing across samples (estimateSizeFactors from DESeq2)...")

  sizeFactors = estimateSizeFactorsForMatrix(df)
  dfNorm = df

  for (i in 1:length(colnames(df))) {
    print(paste(colnames(df)[i],sizeFactors[i]))
    dfNorm[,i] = df[,i]/sizeFactors[i]
  }

  return(dfNorm)

}
