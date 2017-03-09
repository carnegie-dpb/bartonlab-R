library("RPostgreSQL")
source("~/R/getConnection.R")

##
## Retrieve the gene's name from the given gene ID.
##
getName = function(id, host="localhost") {
    conn = getConnection(host=host)
    id = toupper(id)
    name = id
    for (i in 1:length(id)) {
        gene = dbGetQuery(conn, paste("SELECT * FROM genes WHERE id='",id[i],"'",sep=""))
        if (length(gene$name)>0 && gene$name[1]!=id) {
            name[i] = gene$name[1]
        } else {
            aliases = dbGetQuery(conn, paste("SELECT * FROM public.genealiases WHERE id='",id[i],"'",sep=""))
            if (length(aliases$name)>0) {
                name[i] = aliases$name[1]
            }
        }
    }
    dbDisconnect(conn)
    return(name)
}
