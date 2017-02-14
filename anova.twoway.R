##
## Runs two-way ANOVA on the supplied expression data, one gene at a time
##
## Requires dataframes expr and samples, with samples rows = expr columns; also need array of conditions to be included in analysis
##
## set takeLog2=TRUE to take log2(values+1) before ANOVA
##
## samples:
## [label] num condition control time comment replicate internalscale

anova.twoway = function(expr, samples, conditions, takeLog2=FALSE) {

    ## factors have to be strings! (at least by default)
    samples$time = as.character(samples$time)

    geneID = rownames(expr)

    laneID = vector()
    for (i in 1:length(conditions)) {
        laneID = c(laneID, rownames(samples[samples$condition==conditions[i],]))
    }

    ## store results in a data frame
    anovaResult = data.frame(
        condition_df=integer(), condition_meansq=double(), condition_f=double(), condition_p=double(),
        time_df=integer(), time_meansq=double(), time_f=double(), time_p=double(),
        condition_time_df=integer(), condition_time_meansq=double(), condition_time_f=double(), condition_time_p=double(),
        residuals_df=integer(), residuals_meansq=double(),
        check.names=TRUE
    )

    ## count every 100 genes, give completion estimate
    t0 = proc.time()[3]
    tStart = proc.time()[3]

    ## crank out ANOVA across times and conditions for each gene
    for (i in 1:length(geneID)) {
        
        if ((i %% 100)==0) {
            tEnd = proc.time()[3]
            duration = tEnd - tStart
            estimate = (length(geneID)-i)/100*duration/60 + 1
            elapsed = (tEnd-t0)/60
            print(paste("=== Elapsed time:",round(elapsed),"minutes; Estimated completion in",round(estimate),"minutes"), quote=FALSE)
            tStart = tEnd
        }

        ## build the expression dataframe for this gene
        df = data.frame( condition=character(), control=logical(), time=character(), comment=character(), internalscale=double(), expr=double(), check.names=TRUE )
        for (j in 1:length(laneID)) {
            ## normalize using samples.internalscale
            val = expr[geneID[i],laneID[j]] / samples[laneID[j],"internalscale"]
            if (takeLog2) {
                ## take log2(value+1)
                row = cbind( samples[laneID[j],], expr=log2(val+1) )
            } else {
                ## straight-up values (could already be log2 transformed, of course)
                row = cbind( samples[laneID[j],], expr=val )
            }
            df = rbind(df, row)
        }

        ## want first condition to be first factor, treated as "intercept"
        df$condition = factor(df$condition, levels=conditions)

        ## establish time as factor as well (not sure if this is needed)
        df$time = factor(df$time, levels=unique(samples$time))

        ## do LM + ANOVA separately
        geneLM = lm(expr ~ condition*time, data=df)
        geneAnova = anova(geneLM)

        if (!is.nan(geneAnova["condition","Pr(>F)"])) {
            
            anovaResult[geneID[i],] = cbind(
                
                geneAnova["condition","Df"],
                geneAnova["condition","Mean Sq"],
                geneAnova["condition","F value"],
                geneAnova["condition","Pr(>F)"],
                
                geneAnova["time","Df"],
                geneAnova["time","Mean Sq"],
                geneAnova["time","F value"],
                geneAnova["time","Pr(>F)"],
                
                geneAnova["condition:time","Df"],
                geneAnova["condition:time","Mean Sq"],
                geneAnova["condition:time","F value"],
                geneAnova["condition:time","Pr(>F)"],
                
                geneAnova["Residuals","Df"],
                geneAnova["Residuals","Mean Sq"]
            )
            
        }
        
    }

    ## add BH-adjusted p values
    print("=== Adding q values", quote=FALSE);
    anovaResult$condition_q = p.adjust(anovaResult$condition_p, method="BH")
    anovaResult$time_q = p.adjust(anovaResult$time_p, method="BH")
    anovaResult$condition_time_q = p.adjust(anovaResult$condition_time_p, method="BH")

    return(anovaResult)

}
