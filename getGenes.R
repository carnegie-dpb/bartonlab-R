source("~/R/getConnection.R")

##
## get an array of gene IDs for the given genus and species
##

getGenes = function(genus="Arabidopsis", species="thaliana") {

    con = getConnection()
    
    records = dbGetQuery(con, paste("SELECT id FROM genes WHERE genus='",genus,"' AND species='",species,"' ORDER BY id", sep=""))

    dbDisconnect(con)

    return(records$id)
    
}
