source("~/R/getConnection.R")

##
## Get the entire expression matrix (all genes, all samples) as a data frame
## If (scaled) then divide values by samples$internalscale.
##

getExpressionDF = function(schema, host="localhost", scaled=TRUE) {

    conn = getConnection(host);
    samples = dbGetQuery(conn, paste("SELECT * FROM ",schema,".samples ORDER BY num",sep=""))
    expr = dbGetQuery(conn, paste("SELECT * FROM ",schema,".expression ORDER BY id",sep=""))
    dbDisconnect(conn)

    ## parse values
    nsamples = length(samples$label)
    ngenes = length(expr$id)
    id = array(dim=ngenes)
    values = array(dim=c(ngenes,nsamples))
    
    for (i in 1:ngenes) {
        id[i] = expr$id[i]
        temp = as.numeric(strsplit(substr(expr$values[i],2,nchar(expr$values[i])-1), split=",", fixed=TRUE)[[1]])
        if (length(temp)==nsamples) {
            if (scaled) {
                values[i,] = temp/samples$internalscale
            } else {
                values[i,] = temp
            }
        }
    }

    df = data.frame(values=values)
    rownames(df) = id
    colnames(df) = samples$label
    
    return(df)

}
