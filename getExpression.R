source("~/R/getConnection.R")
source("~/R/getLocusName.R")

##
## pull the requested gene's expression from the expression table in the given schema for the given condition
##

getExpression = function(schema, condition, gene) {

  con = getConnection()
  
  if (nchar(gene)==9 & toupper(substr(gene,1,2))=="AT") {
    locusname = toupper(gene)
  } else {
    locusname = getLocusName(gene)
  }

  expr = dbGetQuery(con, paste("SELECT * FROM ",schema,".expression WHERE id='",locusname,"'",sep=""))
  samples = dbGetQuery(con, paste("SELECT * FROM ",schema,".samples ORDER BY num",sep=""))

  dbDisconnect(con)

  ## parse values from PostgreSQL vector string
  values = as.numeric(strsplit(substr(expr$values,2,nchar(expr$values)-1), split=",", fixed=TRUE)[[1]])
  
  if (condition=="ALL") {
    ## all samples across conditions
    return(values)
  } else {
    ## only samples for given condition
    sampleNums = samples$num[samples$condition==condition]
    return(values[sampleNums])
  }

}
