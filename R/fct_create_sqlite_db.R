#' @import utils
#' @import dplyr
#' @import RSQLite
createSqliteDb = function() {
  if(!file.exists("db/vessels.db")) {
    unzip("db/ships.zip", exdir = "db")
    data = read.csv("db/ships.csv", encoding="UTF-8") %>% as_tibble() %>% mutate(ROW_NO = 1:n())
    file.remove("db/ships.csv")
    x = names(data)
    x[15] = "PORT_STANDARIZED"
    names(data) = x
    oCC = openCloseConnection()
    oCC(function(con) {
      dbWriteTable(con, "data",data)
    })
    rm(data)
  } else {
    print("SQLite already exists")
  }
}