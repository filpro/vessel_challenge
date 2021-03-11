#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
#' @import memoise
#' @import cachem
#' @import rappdirs
#' @export


app_server <- function( input, output, session ) {
  callModule(mod_leaflet_map_server, "leaflet_map_ui")
  callModule(mod_vessel_type_selector_server, "vessel_type_selector_ui_1")
  callModule(mod_vessel_id_selector_server, "vessel_id_selector_ui_1")
  callModule(mod_general_note_server, "general_note_ui_1")
  callModule(mod_max_obs_interval_slider_server, "max_obs_interval_slider_ui_1")
  callModule(mod_dist_timediff_scatterplot_server, "dist_timediff_scatterplot_ui_1")
  callModule(mod_longest_path_interval_note_server, "longest_path_interval_note_ui_1")
  callModule(mod_longest_path_distance_note_server, "longest_path_distance_note_ui_1")
}
