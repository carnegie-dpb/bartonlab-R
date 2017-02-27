library("RPostgreSQL")
source("~/R/getConnection.R")

##
## Retrieve the gene's name from the given gene ID.
##
getName = function(id, host="localhost") {
    conn = getConnection(host=host)
    id = toupper(id)
    name = id
    gene = dbGetQuery(conn, paste("SELECT * FROM genes WHERE id='",id,"'",sep=""))
    if (length(gene$name)>0 && gene$name[1]!=id) {
        name = gene$name[1]
    } else {
        aliases = dbGetQuery(conn, paste("SELECT * FROM public.genealiases WHERE id='",id,"'",sep=""))
        if (length(aliases$name)>0) {
            name = aliases$name[1]
        }
    }
    dbDisconnect(conn)
    return(name)
}
