library("RPostgreSQL")

##
## One-stop shop for your database connection needs. Under one roof.
##

getConnection = function() {
    
    drv = dbDriver("PostgreSQL")
    ##  con = dbConnect(drv, host="bartontools.dpb.carnegiescience.edu", dbname="bartonlab", user="sam", password="xenon5416")
    con = dbConnect(drv, host="localhost", dbname="bartonlab", user="sam")

    return(con)

}
