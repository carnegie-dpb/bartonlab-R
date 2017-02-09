##
## Plot histograms and sample-to-sample boxplot of Cufflinks output
##

## define minimum row value allowed to keep a gene
keep = apply(FPKM,1,min)>1e-4

## sample boxplot
boxplot(log2(FPKM[keep,]), main="TopHat2/Cufflinks FPKM", ylab="log2(FPKM)")

## histogram each sample
labels = rownames(samples)
for (i in 1:length(labels)) {
  hist(log2(FPKM[keep,labels[i]]), breaks=100, main=labels[i], xlim=c(-5,15), xlab="FPKM")
}
