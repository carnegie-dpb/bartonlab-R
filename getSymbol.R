source("~/R/getConnection.R")

##
## get the gene symbol for the given locus name (ID)
##

getSymbol = function(locusname) {

    symbols = c()
    
    con = getConnection()
    for (i in 1:length(locusname)) {
        gene = dbGetQuery(con, paste("SELECT * FROM genes WHERE id='",toupper(locusname[i]),"'",sep=""))
        if (is.null(gene$name[1])) {
            symbols = c(symbols, locusname[i])
        } else {
            symbols = c(symbols, gene$name[1])
        }
    }
    dbDisconnect(con)

    return(symbols)

}
