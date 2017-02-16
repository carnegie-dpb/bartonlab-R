##
## dot plot one condition against another from the full expression dataframe
##

compare.conditions = function(expr, samples, cond1, cond2, title="") {

    cond1.labels = rownames(samples[samples$condition==cond1,])
    cond2.labels = rownames(samples[samples$condition==cond2,])

    expr1 = expr[,cond1.labels]
    expr2 = expr[,cond2.labels]

    print(cond1)
    print(head(expr1))
    print(cond2)
    print(head(expr2))

    mean1 = rowMeans(expr1)
    mean2 = rowMeans(expr2)

    alim = c(1e-1,1e+3)
    plot(mean1,mean2, log="xy", xlim=alim, ylim=alim, pch=1, cex=0.5, xlab=cond1, ylab=cond2, main=title)
    lines(alim, alim, col="red", lwd=2)
    
}

    
