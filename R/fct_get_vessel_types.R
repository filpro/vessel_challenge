#' @import dplyr
getVesselTypes = function() {
  oCC = openCloseConnection()
  oCC(function(con) {
    tbl(con, "data") %>%
      select(SHIPTYPE, ship_type) %>%
      distinct(SHIPTYPE, ship_type) %>%
      arrange(SHIPTYPE) %>%
      collect()
  })
}