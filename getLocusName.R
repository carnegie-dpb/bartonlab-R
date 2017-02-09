source("~/R/getConnection.R")

##
## pull the requested gene's ID (Locus Name) from the genes table given its name
##

getLocusName = function(name) {

    con = getConnection();

    tair = dbGetQuery(con, paste("SELECT * FROM genes WHERE name='",name,"'",sep=""))

    dbDisconnect(con)

    return(tair$id[1])

}
