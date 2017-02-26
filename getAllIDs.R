##
## return an array of ALL gene IDs with expression from the given schema; limited to AT_G_____
##
getAllIDs = function(schema, host="localhost") {
  conn = getConnection(host=host);
  all = dbGetQuery(conn, paste("SELECT id FROM ",schema,".expression WHERE id LIKE 'AT_G_____' ORDER BY id",sep=""))
  dbDisconnect(conn)
  return(all$id)
}
