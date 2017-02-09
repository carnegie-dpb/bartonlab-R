source("~/R/getConnection.R")

##
## pull the requested gene's expression from the expression table in the given schema for the given condition
##

getSymbol = function(locusnames) {

    ids = toupper(locusnames)
    symbols = c()

    con = getConnection()

    for (i in 1:length(ids)) {
        rec = dbGetQuery(con, paste("SELECT name FROM genes WHERE id='",ids[i],"'",sep=""))
        symbols = c(symbols, rec$name[1])
    }

    dbDisconnect(con)
    
    return(symbols)

}
