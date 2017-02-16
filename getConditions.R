source("~/R/getConnection.R")
##
## get the array of conditions (per time) given schema
##
getConditions = function(schema, host="localhost") {
    conn = getConnection(host=host)
    samples = dbGetQuery(conn, paste("SELECT * FROM ",schema,".samples ORDER BY num",sep=""))
    dbDisconnect(conn)
    return(samples$condition)
}
