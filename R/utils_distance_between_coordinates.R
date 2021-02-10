#' @importFrom geosphere distm
distanceBetweenCoordinates = function(lon1, lat1, lon2, lat2) {
  result = distm(c(lon1, lat1), c(lon2,lat2))[[1]]
  ifelse(is.na(result), 0, result)
}