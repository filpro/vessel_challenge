#' vessel_type_selector UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_vessel_type_selector_ui <- function(id){
  ns <- NS(id)
  tagList(
    div(class = "ui horizontal divider", "Vessel type"),
    selectInput(ns("vessel_type"), choices = NA, label = "")
  )
}

#' vessel_type_selector Server Function
#'
#' @noRd 
mod_vessel_type_selector_server <- function(input, output, session, selectedVesselType){
  ns <- session$ns
  memFuncs = memoizedFunctions()
  
  updateSelectInput(
    session,"vessel_type", 
    choices = memFuncs(function(memo) memo$getVesselTypes()) %>% columnsToNamedVector(), 
    label = ""
  )
  
  observeEvent(input$vessel_type, {
    req(input$vessel_type)
    selectedVesselType(input$vessel_type)
  })
}

## To be copied in the UI
# mod_vessel_type_selector_ui("vessel_type_selector_ui_1")

## To be copied in the server
# callModule(mod_vessel_type_selector_server, "vessel_type_selector_ui_1")

