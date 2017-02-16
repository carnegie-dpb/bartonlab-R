source("~/R/getExpressionDF.R")
source("~/R/getSamples.R")
##
## dot plot one condition against another from the full expression dataframe
##
compare.conditions = function(schema, cond1, cond2, title="", scale=TRUE) {

    samples = getSamples(schema)
    expr = getExpressionDF(schema, scale=scale)

    cond1.labels = rownames(samples[samples$condition==cond1,])
    cond2.labels = rownames(samples[samples$condition==cond2,])

    expr1 = expr[,cond1.labels]
    expr2 = expr[,cond2.labels]

    mean1 = rowMeans(expr1)
    mean2 = rowMeans(expr2)

    alim = c(1e-1,1e+3)
    plot(mean1,mean2, log="xy", xlim=alim, ylim=alim, pch=1, cex=0.5, xlab=cond1, ylab=cond2, main=title)
    lines(alim, alim, col="red", lwd=2)
    
}

    
