#' @import dplyr
#' @export
getVesselById = function(id) {
  oCC = openCloseConnection()
  oCC(function(con) {
    table = tbl(con,"data") %>% 
      filter(SHIP_ID == id) %>% 
      collect() %>% 
      mutate(DATETIME = parseDateTime(DATETIME)) %>%
      arrange(DATETIME)%>% 
      mutate(DATETIME = DATETIME %>% parseDateTime()) %>%
      mutate(
        LAT_LAG = lag(LAT), 
        LON_LAG = lag(LON), 
        DATETIME_LAG = lag(DATETIME), 
        ROW_NO_LAG = lag(ROW_NO),
        TIME_DIFF = DATETIME - lag(DATETIME)
      )  %>% 
      (function(table) {
        if(nrow(table) == 0) {
          NULL
        } else {
          table %>% rowwise() %>%
            mutate(dist = distanceBetweenCoordinates(LON_LAG,LAT_LAG,LON,LAT)) %>%
            ungroup()
        }
      })
  })
}