source("~/R/getLocusName.R")

##
## pull the requested gene's cuffdiff time results for the given schema/condition; returns a small data frame, one row per time
##

getCuffdiffTimeResults = function(schema, condition, gene) {

  con = getConnection()
  
  if (nchar(gene)==9 & toupper(substr(gene,1,2))=="AT") {
    locusname = toupper(gene)
  } else {
    locusname = getLocusName(gene)
  }

  res = dbGetQuery(con, paste("SELECT * FROM ",schema,".cuffdifftimeresults WHERE condition='",condition,"' AND id='",locusname,"'", sep=""))

  dbDisconnect(con)

  if (length(res)==0) {
    
    return(NULL)
    
  } else {
    
    ## parse values from PostgreSQL vector string
    value_1 = as.numeric(strsplit(substr(res$value_1,2,nchar(res$value_1)-1), split=",", fixed=TRUE)[[1]])
    value_2 = as.numeric(strsplit(substr(res$value_2,2,nchar(res$value_2)-1), split=",", fixed=TRUE)[[1]])
    logfc = as.numeric(strsplit(substr(res$logfc,2,nchar(res$logfc)-1), split=",", fixed=TRUE)[[1]])
    test_stat = as.numeric(strsplit(substr(res$test_stat,2,nchar(res$test_stat)-1), split=",", fixed=TRUE)[[1]])
    p_value = as.numeric(strsplit(substr(res$p_value,2,nchar(res$p_value)-1), split=",", fixed=TRUE)[[1]])
    q_value = as.numeric(strsplit(substr(res$q_value,2,nchar(res$q_value)-1), split=",", fixed=TRUE)[[1]])
    
    time = unique(getTimes(schema,condition))[-1]
    
    if (length(logfc)==length(time)) {
      return(data.frame(time=time, value_1=value_1, value_2=value_2, logfc=logfc, test_stat=test_stat, p_value=p_value, q_value=q_value))
    } else {
      return(NULL)
    }
    
  }
  
}
