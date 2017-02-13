normalize.medians <- function(df) {

    print("Normalizing across samples (median of nonzero values)...")

    dfNew = df

    samps = c()
    meds = c()

    ## use median normalization, nonzero values only
    for (i in 1:dim(dfNew)[2]) {
        med = median(as.matrix(dfNew)[dfNew[,i]>0,i])
        dfNew[,i] = dfNew[,i]/med
        samps = c(samps, i)
        meds = c(meds, med)
    }

    cat(samps, sep="\t")
    cat("\n")
    cat(meds, sep="\t")
    cat("\n")
    
    ## scale the whole thing back by the overall median
    med = median(as.matrix(df)[df>0])
    print(paste("rescale *",med))
    dfNew = dfNew*med

    return(dfNew)

}
