source("~/R/getConnection.R")

##
## get the entire expression matrix (all genes, all samples) as a data frame
##

getExpressionDF = function(schema) {

    con = getConnection();
    
    samples = dbGetQuery(con, paste("SELECT * FROM ",schema,".samples ORDER BY num",sep=""))
    expr = dbGetQuery(con, paste("SELECT * FROM ",schema,".expression ORDER BY id",sep=""))

    dbDisconnect(con)

    ## parse values
    nsamples = length(samples$label)
    ngenes = length(expr$id)
    id = array(dim=ngenes)
    values = array(dim=c(ngenes,nsamples))
    
    for (i in 1:ngenes) {
        id[i] = expr$id[i]
        temp = as.numeric(strsplit(substr(expr$values[i],2,nchar(expr$values[i])-1), split=",", fixed=TRUE)[[1]])
        if (length(temp)==nsamples) {
            values[i,] = temp
        }
    }

    df = data.frame(values=values)
    rownames(df) = id
    colnames(df) = samples$label
    
    return(df)

}
