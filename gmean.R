## calculate the geometric mean of a data frame
gmean = function(df) {
  return(exp(rowMeans(log(df))))
}
  
