## Write out a text file with expression data for import into an expression table with PostgreSQL vector syntax holding the expression values
## Includes a header with the sample labels by default

write.vectors <- function(filename, data, col.names=TRUE) {

  if (col.names) {
    cat(colnames(data), file=filename, sep=" ", append=FALSE);
    cat("\n", file=filename, append=TRUE);
  } else {
    cat("", file=filename, append=FALSE);
  }
  
  
  for (i in 1:dim(data)[1]) {
    cat(rownames(data)[i],"{", sep=" ", file=filename, append=TRUE);
    cat(as.matrix(data[i,]), file=filename, sep=",", append=TRUE);
    cat("}\n", file=filename, append=TRUE);
  }

}
