source("~/R/db.parseVector.R")
source("~/R/getConnection.R")

##
## load bartonlab.schema.expression into a data frame
##

db.expression = function(schema, host="bartontools.dpb.carnegiescience.edu", dbname="bartonlab", user="sam", password="xenon5416") {

    conn = getConnection(host, dbname, user, password)
    print(paste("Querying",schema,"..."))

    ## column names from samples
    samples = dbGetQuery(conn, paste(sep="","SELECT * FROM ",schema,".samples ORDER BY num"))

    ## expression rows come over as PostgreSQL vectors in "values" column which then require parsing
    vectors = dbGetQuery(conn, paste(sep="", "SELECT * FROM ",schema,".expression ORDER BY id"));
    
    ## disconnect!
    dbDisconnect(conn)

    ## output header
    print("Dumping data to /tmp/expression.txt...")
    cat(samples$label, file="/tmp/expression.txt", sep=" ", append=FALSE);
    cat("\n", file="/tmp/expression.txt", append=TRUE);
    
    ## parse out each row of vectors into the table
    for (i in 1:length(vectors$values)) {
        if (i%%1000==0) print(i)
        cat(vectors$id[i],db.parseVector(vectors$values[i])[[1]], file="/tmp/expression.txt", sep=" ", append=TRUE)
        cat("\n", file="/tmp/expression.txt", append=TRUE);
    }
    
    ## return the table
    print("Reading back the table...")
    return(read.table("/tmp/expression.txt"));

}





