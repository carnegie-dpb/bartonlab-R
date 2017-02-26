library("RPostgreSQL")
source("~/R/getConnection.R")

##
## Retrieve the gene's name from the given gene ID.
##
getName = function(id, host="localhost") {
    conn = getConnection(host=host)
    id = toupper(id)
    gene = dbGetQuery(conn, paste("SELECT * FROM genes WHERE id='",id,"'",sep=""))
    name = gene$name[1]
    if (name==id) {
        aliases = dbGetQuery(conn, paste("SELECT * FROM public.genealiases WHERE id='",id,"'",sep=""))
        if (length(aliases$name)>0) name=aliases$name[1]
    }
    dbDisconnect(conn)
    return(name)
}
