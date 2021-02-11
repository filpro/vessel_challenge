columnsToNamedVector = function(df) {
  if(ncol(df) == 2) {
    return(setNames(as.character(df[,1] %>% pull()), df[,2] %>% pull()))
  } else {
    stop("Only two-columns data frames are allowed")
  }
}