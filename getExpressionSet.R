library("RPostgreSQL")
library("affy")

source("~/R/getID.R")
source("~/R/getExpressionDF.R")

##
## Create an affy package ExpressionSet instance from an experiment given by the schema
##

## assayData: A ‘matrix’ of expression values, or an ‘environment’.
##           When ‘assayData’ is a ‘matrix’, the rows represent probe sets
##           (‘features’ in ‘ExpressionSet’ parlance).  Columns represent
##           samples. When present, row names identify features and column
##           names identify samples. Row and column names must be unique,
##           and consistent with row names of ‘featureData’ and
##           ‘phenoData’, respectively. The assay data can be retrieved
##           with ‘exprs()’.
##           When ‘assayData’ is an environment, it contains identically
##           dimensioned matrices like that described in the previous
##           paragraph. One of the elements of the environment must be
##           named ‘exprs’; this element is returned with ‘exprs()’.
##
## phenoData: An optional ‘AnnotatedDataFrame’ containing information
##           about each sample. The number of rows in ‘phenoData’ must
##           match the number of columns in ‘assayData’. Row names of
##           ‘phenoData’ must match column names of the matrix / matricies
##           in ‘assayData’.
##
## featureData: An optional ‘AnnotatedDataFrame’ containing information
##           about each feature. The number of rows in ‘featureData’ must
##           match the number of rows in ‘assayData’. Row names of
##           ‘featureData’ must match row names of the matrix / matricies
##           in ‘assayData’.
##
## experimentData: An optional ‘MIAME’ instance with meta-data (e.g., the
##           lab and resulting publications from the analysis) about the
##           experiment.
##
## annotation: A ‘character’ describing the platform on which the samples
##           were assayed. This is often the name of a Bioconductor chip
##           annotation package, which facilitated down-stream analysis.
##
## protocolData: An optional ‘AnnotatedDataFrame’ containing
##           equipment-generated information about protocols. The number
##           of rows and row names of ‘protocolData’ must agree with the
##           dimension and column names of ‘assayData’.

getExpressionSet = function(schema, takeLog2=FALSE, host="bartontools.dpb.carnegiescience.edu", dbname="bartonlab", user="sam", password="xenon5416") {

    ## get expression as a data frame
    expr = getExpressionDF(schema, host=host, dbname=dbname, user=user, password=password);

    ## remove rows that contain a zero expression sample
    print("Removing rows that contain a zero expression value.")
    row_sub = apply(expr, 1, function(row) all(row!=0))
    expr = expr[row_sub,]

    ## log2(values) when takeLog2=TRUE
    if (takeLog2) {
        print("Taking log2(expression).");
        expr = log2(expr)
    }

    ## return affy ExpressionSet
    return(ExpressionSet(assayData=as.matrix(expr)));

}
