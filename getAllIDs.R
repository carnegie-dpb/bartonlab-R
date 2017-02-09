##
## return an array of ALL gene IDs with expression from the given schema; limited to AT_G_____
##

getAllIDs = function(schema) {

  con = getConnection();
  
  all = dbGetQuery(con, paste("SELECT id FROM ",schema,".expression WHERE id LIKE 'AT_G_____' ORDER BY id",sep=""))

  dbDisconnect(con)

  return(all$id)

}
