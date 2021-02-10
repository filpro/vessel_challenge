parseDateTime = function(string) {
  as.POSIXct(string, format="%Y-%m-%dT%H:%M:%SZ")
}