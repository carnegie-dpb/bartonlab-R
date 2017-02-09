##
## Runs one-way time-wise ANOVA on the supplied expression data, one gene at a time
##
## Requires dataframes expr and samples, with samples rows = expr columns; also need single condition for the times
##
## set takeLog2=TRUE to take log2 of values before ANOVA

anova.oneway = function(expr, samples, condition, takeLog2=FALSE) {

  ## floor of log2 values; use 1 if expr is counts
  log2floor = 1.0e-4;

  ## factors have to be strings! (at least by default)
  samples$time = as.character(samples$time)

  ## gene and lane IDs for data we're analyzing
  geneID = rownames(expr)
  laneID = rownames(samples[samples$condition==condition,])

  ## store results in a data frame
  anovaResult = data.frame(
    time_df=integer(), time_meansq=double(), time_f=double(), time_p=double(),
    residuals_df=integer(), residuals_meansq=double(),
    check.names=TRUE
    )

  ## count every 1000 genes, give completion estimate
  t0 = proc.time()[3]
  tStart = proc.time()[3]

  ## crank out ANOVA across times for each gene
  for (i in 1:length(geneID)) {
  
    if ((i %% 1000)==0) {
      tEnd = proc.time()[3]
      duration = tEnd - tStart
      estimate = (length(geneID)-i)/1000*duration/60
      elapsed = (tEnd-t0)/60
      print(paste("=== Elapsed time:",round(elapsed),"minutes; Estimated completion in",round(estimate),"minutes"), quote=FALSE)
      tStart = tEnd
    }
  
    ## form the dataframe for this gene's ANOVA analysis
    if (takeLog2) {
      df = data.frame( time=samples[laneID,2], expr=log2(as.numeric(expr[geneID[i],laneID])), check.names=TRUE )
    } else {
      df = data.frame( time=samples[laneID,2], expr=as.numeric(expr[geneID[i],laneID]), check.names=TRUE )
    }
    ## do ANOVA
    geneLM = lm(expr ~ time, data=df)
    geneAnova = anova(geneLM)

    if (!is.nan(geneAnova["time","Pr(>F)"])) {
      
      anovaResult[geneID[i],] = cbind(

                   geneAnova["time","Df"],
                   geneAnova["time","Mean Sq"],
                   geneAnova["time","F value"],
                   geneAnova["time","Pr(>F)"],
                    
                   geneAnova["Residuals","Df"],
                   geneAnova["Residuals","Mean Sq"]
                   
                   )
    }
  
  }

  ## add BH-adjusted p values
  print("=== Adding q values", quote=FALSE);
  anovaResult$time_q = p.adjust(anovaResult$time_p, method="BH")

  return(anovaResult)

}
