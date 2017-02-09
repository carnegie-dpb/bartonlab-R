## box plot the experimental samples
box.plot = function(df, normalized=FALSE) {
  
  keep = apply(df,1,min)>1e-4
  mainTitle = "TopHat2/Cufflinks FPKM (row min > 1e-4)"
  if (normalized) mainTitle = paste(mainTitle, " - geometric (DESeq) normalization")
  boxplot(log2(df[keep,]), main=mainTitle, xlab="Sample", ylab="log2(FPKM)")
}

