##
## filter out genes with row-wise mean expression below a given cutoff
##

filter = function(df, minValue) {

  out = df[0,]
  ngenes = dim(FPKM)[1]
  nrows = dim(FPKM)[2]
  nremoved = 0
  nadded = 0
  rowMeans = rowSums(df)/nrows

  for (i in 1:ngenes) {

    if (rowMeans[i]>minValue) {
      out = rbind(out, df[i,])
      nadded = nadded + 1
    } else {
      nremoved = nremoved + 1
    }

    if ((i %% 1000)==0) {
      print(paste(i,nadded,signif(nadded/i*100,digits=4),"%",nremoved,signif(nremoved/i*100,digits=4),"%"))
    }

  }

  print(paste("number added =",nadded,"(",signif(nadded/ngenes*100,digits=4),"%)"))
  print(paste("number removed =",nremoved,"(",signif(nremoved/ngenes*100,digits=4),"%)"))

  return(out)

}
