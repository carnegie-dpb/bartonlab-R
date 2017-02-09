normalize.medians <- function(df) {

  print("Normalizing across samples (median of nonzero values)...")

  dfNew <- df

  ## use median normalization, nonzero values only
  for (i in 1:dim(dfNew)[2]) {
    med <- median(as.matrix(dfNew)[dfNew[,i]>0,i])
    print(paste("sample",i,"/",med))
    dfNew[,i] <- dfNew[,i]/med
  }

  # scale the whole thing back by the overall median
  med <- median(as.matrix(df)[df>0])
  print(paste("rescale *",med))
  dfNew <- dfNew*med

  return(dfNew)

}
