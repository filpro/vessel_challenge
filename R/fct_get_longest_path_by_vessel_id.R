#' The function aimed to find the longest two consecutives observations
#' for a given vessel
#' @importFrom geosphere distm
#' @import dplyr
getLongestPathByVesselId = function(vesselId) {
  occ = openCloseConnection()
  occ(function(con) {
    tbl(con, "data") %>% 
      filter(vesselId == SHIP_ID) %>% 
      collect()
  }) %>%
    # DATABASE HAS DONE ITS JOB, NOW WE ARE CALCULATING IN MEMORY
    mutate(LAT_LAG = lag(LAT), LON_LAG = lag(LON))  %>% 
    rowwise() %>%
    mutate(dist = distanceBetweenCoordinates(LON_LAG, LAT_LAG,LON,LAT)) %>%
    ungroup() %>%
    filter(dist == max(dist, na.rm = TRUE)) %>%
    arrange(DATETIME %>% parseDateTime() %>% desc()) %>%
    slice(1L)
}
