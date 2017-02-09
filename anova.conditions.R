##
## Runs a standard one-way cross-condition ANOVA on the supplied expression data, one gene at a time
##
## Gets the sample and expression data from the database schema; supply a 2-element conditions vector
##
## set takeLog2=TRUE to take log2 of values before ANOVA

source("/home/sam/R/getAllIDs.R")
source("/home/sam/R/getExpression.R")
source("/home/sam/R/getSamples.R")

anova.conditions = function(schema, conditions, takeLog2=FALSE) {

  ## get all the loci in the experiment schema
  locus = getAllIDs(schema)
  
  ## conds vector stores conditions for ANOVA samples
  samples1 = getSamples(schema, conditions[1])
  samples2 = getSamples(schema, conditions[2])
  print(samples1)
  print(samples2)
  conds = vector()
  for (j in 1:length(samples1$condition)) {
    conds = c(conds, conditions[1])
  }
  for (j in 1:length(samples2$condition)) {
    conds = c(conds, conditions[2])
  }
  print(conds)

  ## store results in a data frame
  anovaResult = data.frame(
    condition_df=integer(), condition_meansq=double(), condition_f=double(), condition_p=double(),
    residuals_df=integer(), residuals_meansq=double(),
    check.names=TRUE
    )
  
  ## count every 1000 genes, give completion estimate
  t0 = proc.time()[3]
  tStart = proc.time()[3]

  ## crank out ANOVA across times for each gene
  for (i in 1:length(locus)) {

    if ((i %% 1000)==0) {
      tEnd = proc.time()[3]
      duration = tEnd - tStart
      estimate = (length(locus)-i)/1000*duration/60
      elapsed = (tEnd-t0)/60
      print(paste("===",locus[i],"=== Elapsed time:",round(elapsed),"minutes; Estimated completion in",round(estimate),"minutes"), quote=FALSE)
      tStart = tEnd
    }
  
    ## form the dataframe for this gene's ANOVA analysis
    expr1 = getExpression(schema, conditions[1], locus[i])
    expr2 = getExpression(schema, conditions[2], locus[i])
    if (takeLog2) {
      df = data.frame( condition=conds, expr=log2(c(expr1,expr2)), check.names=TRUE )
    } else {
      df = data.frame( condition=conds, expr=c(expr1,expr2), check.names=TRUE )
    }

    ## do ANOVA
    geneLM = lm(expr ~ condition, data=df)
    geneAnova = anova(geneLM)

    if (!is.nan(geneAnova["condition","Pr(>F)"])) {

      if (geneAnova["condition","Pr(>F)"]<1e-3) {
        print(paste(locus[i],geneAnova["condition","Pr(>F)"]), quote=FALSE)
      }

      anovaResult[locus[i],] = cbind(
                   geneAnova["condition","Df"],
                   geneAnova["condition","Mean Sq"],
                   geneAnova["condition","F value"],
                   geneAnova["condition","Pr(>F)"],
                   geneAnova["Residuals","Df"],
                   geneAnova["Residuals","Mean Sq"]
                   )

    }
  
  }

  ## add BH-adjusted p values
  print("=== Adding q values", quote=FALSE);
  anovaResult$condition_q = p.adjust(anovaResult$condition_p, method="BH")

  return(anovaResult)

}
