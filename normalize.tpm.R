normalize.tpm <- function(df) {

    print("Normalizing across samples (TPM using <RPKM> for all samples...")

    ## Sum all the expression values
    normFactors = apply(df, 2, sum)

    ## scale to 1e6 since it's per million
    normFactors = normFactors/1e6

    ## scale
    dfNorm = df
    for (i in 1:dim(dfNorm)[2]) {
        dfNorm[,i] = dfNorm[,i]/normFactors[i]
    }

    cat(colnames(dfNorm), sep="\t")
    cat("\n")
    cat(normFactors, sep="\t")
    cat("\n")

    return(dfNorm)

}
