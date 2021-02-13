#' @import memoise
#' @import rappdirs
#' @import cachem
memoizedFunctions <- function() {
  function(FUN) {
    cd <- cachem::cache_disk(rappdirs::user_cache_dir("VesselChallenge"), max_size = 100 * 1024^2)
    funcList = list()
    funcList$getLongestPathByVesselId = memoise::memoise(getLongestPathByVesselId, cache = cd)
    funcList$getVesselTypes = memoise::memoise(getVesselTypes, cache = cd)
    funcList$getVesselsByType = memoise::memoise(getVesselsByType, cache = cd)
    funcList$getVesselById = memoise::memoise(getVesselById, cache = cd)
    FUN(funcList)
  }
}
