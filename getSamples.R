source("~/R/getConnection.R")

##
## pull the samples into a data frame; supply optional condition to only pull samples for that condition
##

getSamples = function(schema, condition=NULL, host="localhost") {

  conn = getConnection(host)

  if (is.null(condition)) {
    samples = dbGetQuery(conn, paste("SELECT * FROM ",schema,".samples ORDER BY num",sep=""))
  } else {
    samples = dbGetQuery(conn, paste("SELECT * FROM ",schema,".samples WHERE condition='",condition,"' ORDER BY num",sep="")) 
  }
  rownames(samples) = samples$label
  samples$label = NULL

  dbDisconnect(conn)

  return(samples)

}

