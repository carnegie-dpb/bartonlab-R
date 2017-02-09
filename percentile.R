## calculates the percentile distribution and returns a data frame with breaks and percentile values

percentile = function(values, numbreaks) {

  breaks = seq(0, max(values), by=max(values)/numbreaks)
  
  values.cut = cut(values, breaks, right=TRUE)
  values.freq = table(values.cut)
  values.cumfreq = cumsum(values.freq)
  values.percentile = values.cumfreq / max(values.cumfreq)

  return(data.frame(breaks=breaks[1:length(breaks)-1], percentile=values.percentile))
  
}
