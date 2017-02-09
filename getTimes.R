source("~/R/getConnection.R")

##
## get the array of sample times for the given schema and condition
##

getTimes = function(schema, condition) {

    con = getConnection()
    
    samples = dbGetQuery(con, paste("SELECT * FROM ",schema,".samples ORDER BY num",sep=""))

    dbDisconnect(con)

    if (condition=="ALL") {
        ## return all samples
        return(samples$time)
    } else {
        ## return subset for desired condition
        sampleNums = samples$num[samples$condition==condition]
        return(samples$time[sampleNums])
    }
    
}
