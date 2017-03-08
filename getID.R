source("~/R/getConnection.R")

##
## get the IDs for the given gene names
##

getID = function(name, host="localhost") {

    ids = c()
    
    conn = getConnection(host=host)
    for (i in 1:length(name)) {
        gene = dbGetQuery(conn, paste("SELECT id FROM genes WHERE genus='Arabidopsis' AND name='",name[i],"'",sep=""))
        if (is.null(gene$id[1])) {
            ids = c(ids, name[i])
        } else {
            for (j in 1:dim(gene)[1]) {
                if (substr(gene$id[j],1,4)!="ENSG" && substr(gene$id[j],1,4)!="GRMZ") {
                    ids = c(ids, gene$id[j])
                }
            }
        }
    }
    dbDisconnect(conn)

    return(ids)

}
