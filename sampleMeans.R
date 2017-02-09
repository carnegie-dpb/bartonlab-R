##
## return time-by-time mean values
##

sampleMeans = function(t,expr) {

  ut = unique(t)
  avg = vector()
  for (i in 1:length(ut)) {
    avg = c(avg, mean(expr[t==ut[i]]))
  }
  return(avg)

}
