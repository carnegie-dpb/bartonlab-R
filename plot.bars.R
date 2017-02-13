##
## plot means with error bars
##

plot.bars = function(x, y, pch=0, cex=1, col="black", bg="white", ylim=c(0,0), over=F, log="", xlab="", ylab="", main="") {
  
  xu = unique(x)
  yu = xu
  su = xu
  for (i in 1:length(xu)) {
    yu[i] = mean(y[x==xu[i]])
    su[i] = sd(y[x==xu[i]])
  }
  if (over) {
    points(xu, yu, pch=pch, cex=cex, col=col, bg=bg)
  } else {
    if (ylim[1]!=0 || ylim[2]!=0) {
      plot(xu, yu, pch=pch, cex=cex, ylim=ylim, col=col, bg=bg, log=log, xlab=xlab, ylab=ylab, main=main)
    } else {
      plot(xu, yu, pch=pch, cex=cex, col=col, bg=bg, log=log, xlab=xlab, ylab=ylab)
    }
  }
  segments(xu, (yu-su), xu, (yu+su), col=col)


}
