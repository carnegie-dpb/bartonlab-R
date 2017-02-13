library(edgeR)

normalize.tmm = function(df) {

    print("Normalizing across samples with TMM from edgeR...")

    ## use TMM normalization, rows with all zeros are automatically excluded
    normFactors = calcNormFactors(df, method="TMM")

    dfNew = df
    for (i in 1:length(colnames(dfNew))) {
        dfNew[,i] = dfNew[,i]/normFactors[i]
    }

    cat(colnames(dfNew), sep="\t")
    cat("\n")
    cat(normFactors, sep="\t")
    cat("\n")
    
    return(dfNew)

}
