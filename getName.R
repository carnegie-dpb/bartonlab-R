##
## Retrieve the gene's name from the given gene ID.
##

library("RPostgreSQL")

getName = function(id) {

  drv = dbDriver("PostgreSQL")
  con = dbConnect(drv, dbname="bartonlab")
  
  id = toupper(id)

  gene = dbGetQuery(con, paste("SELECT * FROM genes WHERE id='",id,"'",sep=""))

  dbDisconnect(con)

  return(gene$name[1])

}
