source("~/R/getConnection.R")

##
## pull the samples into a data frame; supply optional condition to only pull samples for that condition
##

getSamples = function(schema, condition) {

  con = getConnection()

  if (is.na(condition)) {
    samples = dbGetQuery(con, paste("SELECT * FROM ",schema,".samples ORDER BY num",sep=""))
  } else {
    samples = dbGetQuery(con, paste("SELECT * FROM ",schema,".samples WHERE condition='",condition,"' ORDER BY num",sep="")) 
  }
  rownames(samples) = samples$label
  samples$label = NULL

  dbDisconnect(con)

  return(samples)

}

