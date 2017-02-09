##
## prune out any genes with any zero values
##

pruneZeros = function(expr) {
    for (i in 1:dim(expr)[1]) {
        if (min(expr[,i])==0) print(rownames(expr)[i])
    }

    return()
}
