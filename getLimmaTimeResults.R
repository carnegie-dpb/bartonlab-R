source("~/R/getConnection.R")
source("~/R/getLocusName.R")

##
## pull the requested gene's limma time results for the given schema/condition; returns a small data frame, one row per time
##

getLimmaTimeResults = function(schema, condition, gene) {

  con = getConnection()
  
  if (nchar(gene)==9 & toupper(substr(gene,1,2))=="AT") {
    locusname = toupper(gene)
  } else {
    locusname = getLocusName(gene)
  }

  res = dbGetQuery(con, paste("SELECT * FROM ",schema,".limmatimeresults WHERE condition='",condition,"' AND id='",locusname,"'", sep=""))

  dbDisconnect(con)

  if (length(res)==0) {
    
    return(NULL)

  } else {

    ## parse values from PostgreSQL vector string
    logfc = as.numeric(strsplit(substr(res$logfc,2,nchar(res$logfc)-1), split=",", fixed=TRUE)[[1]])
    aveexpr = as.numeric(strsplit(substr(res$aveexpr,2,nchar(res$aveexpr)-1), split=",", fixed=TRUE)[[1]])
    t = as.numeric(strsplit(substr(res$t,2,nchar(res$t)-1), split=",", fixed=TRUE)[[1]])
    p_value = as.numeric(strsplit(substr(res$p_value,2,nchar(res$p_value)-1), split=",", fixed=TRUE)[[1]])
    q_value = as.numeric(strsplit(substr(res$q_value,2,nchar(res$q_value)-1), split=",", fixed=TRUE)[[1]])
    
    time = unique(getTimes(schema,condition))[-1]
    
    return(data.frame(time=time, logfc=logfc, aveexpr=aveexpr, t=t, p_value=p_value, q_value=q_value))

  }

}
