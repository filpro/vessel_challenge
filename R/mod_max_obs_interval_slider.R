#' min_obs_interval_slider UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_max_obs_interval_slider_ui <- function(id){
  ns <- NS(id)
  tagList(
    div(class = "time-slider",
        div(class = "ui horizontal divider", "max time interval"),
        shiny::sliderInput(ns('time_slider'), value = 24, min = 0, max = 48, label = NULL)
    )
  )
}
    
#' min_obs_interval_slider Server Function
#'
#' @noRd 
mod_max_obs_interval_slider_server <- function(input, output, session,maxTimeInterval){
  ns <- session$ns
  observeEvent(input$time_slider, {
    maxTimeInterval(input$time_slider)
  })
}
    
## To be copied in the UI
# mod_max_obs_interval_slider_ui("max_obs_interval_slider_ui_1")
    
## To be copied in the server
# callModule(mod_max_obs_interval_slider_server, "max_obs_interval_slider_ui_1")
 
