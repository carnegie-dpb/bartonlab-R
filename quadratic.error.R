##
## Return the error from a quadratic y = a*t^2 + b*t + c

quadratic.error = function(p, t, dataTimes, dataValues) {

  ## variables
  a = p[1]
  b = p[2]
  c = p[3]

  ## error metric is mean square relative deviation
  meansq = 0.0
  for (i in 1:length(dataTimes)) {
    val = a*dataTimes[i]^2 + b*dataTimes[i] + c
    delta = ((dataValues[i]-val)/val)^2
    meansq = meansq + delta
  }

  return(meansq)

}

