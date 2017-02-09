normalize.upperquartile <- function(df) {

  print("Normalizing across samples (upper quartile of nonzero values)...")

  dfNew <- df

  ## upper quartile normalization, nonzero values only
  for (i in 1:dim(df)[2]) {
    q75 <- quantile(as.matrix(df)[df[,i]>0,i])[4]
    print(paste("sample",i,"/",q75))
    dfNew[,i] <- df[,i]/q75
  }

  ## scale the whole thing back by the overall upper quartile
  q75 <- quantile(as.matrix(df)[df>0])[4]
  print(paste("rescale *",q75))
  dfNew <- dfNew*q75

  return(dfNew)

}
