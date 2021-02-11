#' Function for opening and closing connection
#' @importFrom RSQLite SQLite
#' @import DBI
#' @import future
#' @import promises
openCloseConnection = function() {
  function(FUN){
    con <- dbConnect(RSQLite::SQLite(), "db/vessels.db")
    result = FUN(con)
    future(dbDisconnect(con))
    return(result)
  }
}