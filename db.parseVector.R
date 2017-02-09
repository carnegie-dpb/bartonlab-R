## simple function to parse out a PostgreSQL vector string
db.parseVector = function(vector) {
  return(strsplit(substring(substring(vector, 1, nchar(vector)-1), 2), ","))
}
