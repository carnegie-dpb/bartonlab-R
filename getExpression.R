source("~/R/getID.R")

##
## pull the requested gene's expression from the expression table in the given schema for the given condition
##

getExpression = function(schema, host="localhost", condition, gene, scaled=TRUE) {

    if (nchar(gene)==9 & toupper(substr(gene,1,2))=="AT") {
        id = toupper(gene)
    } else {
        id = getID(gene)
        if (length(id)>1) {
            print(paste("Gene name",gene,"is ambiguous. Terminating."))
            return(NULL)
        }
    }

    conn = getConnection(host=host)
    expr = dbGetQuery(conn, paste("SELECT * FROM ",schema,".expression WHERE id='",id,"'",sep=""))
    samples = dbGetQuery(conn, paste("SELECT * FROM ",schema,".samples ORDER BY num",sep=""))
    dbDisconnect(conn)

    if (dim(expr)[1]==0) {

        print(paste("No data returned for ",gene,". Terminating."))
        return(NULL)

    } else {
        
        ## parse values from PostgreSQL vector string
        values = as.numeric(strsplit(substr(expr$values,2,nchar(expr$values)-1), split=",", fixed=TRUE)[[1]])
        if (scaled) values = values/samples$internalscale
        
        if (condition=="ALL") {
            ## all samples across conditions
            return(values)
        } else {
            ## only samples for given condition
            sampleNums = samples$num[samples$condition==condition]
            return(values[sampleNums])
        }

    }

}
