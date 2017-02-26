library("RPostgreSQL")

##
## Retrieve the gene's name from the given gene ID.
##
getName = function(id, host="localhost") {
    conn = getConnection(host=host)
    id = toupper(id)
    gene = dbGetQuery(conn, paste("SELECT * FROM genes WHERE id='",id,"'",sep=""))
    dbDisconnect(conn)
    return(gene$name[1])
}
