##
## return time-by-time standard deviations
##

sampleSDs = function(t,expr) {

  ut = unique(t)
  stdev = vector()
  for (i in 1:length(ut)) {
    stdev = c(stdev, sd(expr[t==ut[i]]))
  }
  return(stdev)

}
