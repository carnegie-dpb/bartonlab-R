##
## plot two genes across sample number
##

plot2 = function(df, samples, gene1, gene2, logValues=FALSE, ymin=0.1, ymax=1000) {

  values1 = df[gene1,]
  values2 = df[gene2,]
  if (logValues) {
    values1 = 2^values1
    values2 = 2^values2
  }
  
  plot(samples$num, values1, xlab="Sample Number", ylab="FPKM", log="y", ylim=c(ymin,ymax) )
  points(samples$num, values2, pch=19)
  
  for (i in 1:length(samples$num)) {
    lines(c(samples$num[i],samples$num[i]), c(values1[i],values2[i]))
  }

  ## redo points so they overlap lines
  points(samples$num, values1, pch=19, col="green")
  points(samples$num, values2, pch=19, col="blue")
  
  lines(samples$num, sqrt(values1*values2), col="gray", lty=1)
  points(samples$num, values1/values2, pch=19, cex=0.5, col="red")

  legend(1, ymax, c(gene1,gene2,"ratio"), pch=c(19,19,19), col=c("green","blue","red"))
  
  
}
