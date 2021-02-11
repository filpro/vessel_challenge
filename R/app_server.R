#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
#' @import memoise
#' @import cachem
#' @import rappdirs
#' 

global <- quote({
  memoGetLongestPathByVesselId = memoise(getLongestPathByVesselId)
  memoGetVesselTypes = memoise(getVesselTypes)
  memoGetVesselsByType = memoise(getVesselsByType)
  memoGetVesselById = memoise(getVesselById)
})


app_server <- function( input, output, session ) {

  
  # List the first level callModules here
  selectedVesselType = reactiveVal(NA)
  selectedVesselId = reactiveVal(NA)
  selectedVessel = reactive({
    req(selectedVesselId())
    future(memoGetVesselById(selectedVesselId()))
  })
  longestPath = reactive({
    req(selectedVesselId())
    req(maxTimeInterval())
    future(memoGetLongestPathByVesselId(selectedVesselId(),maxTimeInterval() * 60 * 60))
  })
  maxTimeInterval = reactiveVal(NA)
  
  callModule(mod_leaflet_map_server, "leaflet_map_ui", selectedVesselId, longestPath, selectedVessel)
  callModule(mod_vessel_type_selector_server, "vessel_type_selector_ui_1", selectedVesselType)
  callModule(mod_vessel_id_selector_server, "vessel_id_selector_ui_1", selectedVesselType, selectedVesselId)
  callModule(mod_general_note_server, "general_note_ui_1",longestPath)
  callModule(mod_max_obs_interval_slider_server, "max_obs_interval_slider_ui_1",maxTimeInterval)
  
  callModule(mod_dist_timediff_scatterplot_server, "dist_timediff_scatterplot_ui_1", selectedVessel)
  callModule(mod_longest_path_interval_note_server, "longest_path_interval_note_ui_1", longestPath)
  callModule(mod_longest_path_distance_note_server, "longest_path_distance_note_ui_1",longestPath)
  
  session$onSessionEnded(function(close) {
    forget(memoGetLongestPathByVesselId)
    forget(memoGetVesselTypes)
    forget(memoGetVesselsByType)
    forget(memoGetVesselById)
  })
  
}
