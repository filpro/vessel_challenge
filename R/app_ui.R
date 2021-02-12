#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
#' @import shiny.semantic

# Below is to let shinyapps.io let know to install additional deps  
library(shiny.semantic)


app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    semanticPage(
      grid(
        pageGridTemplate,
        logo = div(h1("Vessel Challenge"),div(class = "ui divider")),
        title=div(),
        map = mod_leaflet_map_ui("leaflet_map_ui"),
        selectors = 
          grid(
            selectorsGridTemplate,
            vessel_type = mod_vessel_type_selector_ui("vessel_type_selector_ui_1"),
            vessel_id = mod_vessel_id_selector_ui("vessel_id_selector_ui_1"),
            max_time_interval = mod_max_obs_interval_slider_ui("max_obs_interval_slider_ui_1"),
            container_style = "grid-gap: 1vh"
          )
        ,
        longest_path_section = grid(
          notesSectionGridTemplate,
          general = mod_general_note_ui("general_note_ui_1"),
          distance = mod_longest_path_distance_note_ui("longest_path_distance_note_ui_1"),
          interval = mod_longest_path_interval_note_ui("longest_path_interval_note_ui_1"),
          scatterplot = mod_dist_timediff_scatterplot_ui("dist_timediff_scatterplot_ui_1"),
          container_style = "grid-gap: 1rem;align-content: start;text-overflow: ellipsis;white-space: nowrap;"
        ),
        none=div(),
        container_style = "grid-gap: 2.5vh;height:100%",
      )
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
#' @import shinybusy
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
  
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'VesselChallenge'
    ),
    add_busy_spinner(spin = "cube-grid", position = "bottom-right")
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

