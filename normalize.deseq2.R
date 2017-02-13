library(DESeq2)

normalize.deseq2 = function(df) {

    print("Normalizing across samples using DESeq2 estimateSizeFactors...")
    
    sizeFactors = estimateSizeFactorsForMatrix(df)

    dfNorm = df
    for (i in 1:length(colnames(df))) {
        dfNorm[,i] = df[,i]/sizeFactors[i]
    }

    cat(colnames(dfNorm), sep="\t")
    cat("\n")
    cat(sizeFactors, sep="\t")
    cat("\n")

    return(dfNorm)

}
