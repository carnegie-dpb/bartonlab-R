source("~/R/getConnection.R")

##
## get the ID corresponding to the given gene name
##

library("RPostgreSQL")

getID = function(name) {
    
    con = getConnection()
    
    gene = dbGetQuery(con, paste("SELECT * FROM genes WHERE name='",name,"'",sep=""))
    
    dbDisconnect(con)
    
    return(gene$id[1])
    
}
