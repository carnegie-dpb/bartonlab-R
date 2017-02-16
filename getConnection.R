library("RPostgreSQL")
##
## One-stop shop for your database connection needs. Under one roof.
##
getConnection = function(host="localhost", dbname="bartonlab", user="sam", password="xenon5416") {
    drv = dbDriver("PostgreSQL")
    conn = dbConnect(drv, host=host, dbname=dbname, user=user, password=password)
    return(conn)
}
