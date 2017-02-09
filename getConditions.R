source("~/R/getConnection.R")

##
## get the array of conditions (per time) given schema
##

getConditions = function(schema) {

    con = getConnection()
    
    samples = dbGetQuery(con, paste("SELECT * FROM ",schema,".samples ORDER BY num",sep=""))

    dbDisconnect(con)

    return(samples$condition)
    
}
