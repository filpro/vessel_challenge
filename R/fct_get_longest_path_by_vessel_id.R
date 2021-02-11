#' The function aimed to find the longest two consecutives observations
#' for a given vessel
#' @import dplyr
getLongestPathByVesselId = function(vesselId, maxTimeInterval = NA) {
  memoGetVesselById(vesselId)  %>%
    (function(x) {
      if(is.na(maxTimeInterval) | maxTimeInterval == 0) {
        return(x)
      } else {
        x %>% filter(TIME_DIFF <= maxTimeInterval)
      }
    }) %>%        
    filter(dist == max(dist, na.rm = TRUE)) %>%
    arrange(DATETIME %>% desc()) %>%
    slice(1L) 
}


