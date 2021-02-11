#' @import dplyr
#' @return ID of ships belonging to given type
getVesselsByType = function(vesselType) {
  oCC = openCloseConnection()
  oCC(function(con) {
    table = tbl(con, "data") %>% 
      filter(SHIPTYPE == vesselType) %>% 
      distinct(SHIP_ID, SHIPNAME) %>%
      arrange(SHIP_ID, SHIPNAME) %>%
      collect()
  })
}