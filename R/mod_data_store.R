#' @import memoise
#' @import cachem
#' @import rappdirs
dataStore = modules::module({
  memFuncs = memoizedFunctions()
  
  ## The reactives are split into getters and setters so that we prevent uncontrolled 
  ## assignment of new value. 
  
  .selectedVesselType = reactiveVal(NA) # Not exposed directly
  selectedVesselType = function() .selectedVesselType() # getter
  setSelectedVesselType = function(newVal) .selectedVesselType(newVal) # setter
  
  .selectedVesselId = reactiveVal(NULL)
  selectedVesselId = function() .selectedVesselId()
  setSelectedVesselId = function(newVal) .selectedVesselId(newVal)

  selectedVessel = reactive({
    req(selectedVesselId())
    future(memFuncs(function(memo) memo$getVesselById(selectedVesselId())),seed=TRUE)
  }) # in this case there is no need for split
  
  .maxTimeInterval = reactiveVal(NA)
  maxTimeInterval = function() .maxTimeInterval()
  setMaxTimeInterval = function(newVal) .maxTimeInterval(newVal)
  
  
  longestPath = reactive({
    req(selectedVesselId())
    req(maxTimeInterval())
    future(memFuncs(function(memo) memo$getLongestPathByVesselId(selectedVesselId(),maxTimeInterval() * 60 * 60)),seed=TRUE)
  })
  
})