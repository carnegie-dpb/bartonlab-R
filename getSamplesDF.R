source("~/R/getConnection.R")

##
## get the samples as a data frame
##

getSamplesDF = function(schema) {

  con = getConnection()
  
  samples = dbGetQuery(con, paste("SELECT * FROM ",schema,".samples ORDER BY num",sep=""))
  rownames(samples) = samples$label
  samples$label = NULL

  dbDisconnect(con)

  return(samples)

}
