#' vessel_id_selector UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_vessel_id_selector_ui <- function(id){
  ns <- NS(id)
  tagList(
    div(class = "ui horizontal divider", "Vessel name"),
    selectInput(ns("vessel_id"), choices = NA, label = "")
  )
}

#' vessel_id_selector Server Function
#'
#' @noRd 
#' 
mod_vessel_id_selector_server <- function(input, output, session, selectedVesselType, selectedVesselId){
  ns <- session$ns
  memFuncs = memoizedFunctions()
  
  observeEvent(selectedVesselType(), {
    req(selectedVesselType())

    choices = memFuncs(function(memo) memo$getVesselsByType(selectedVesselType())) %>% columnsToNamedVector()
    updateSelectInput(
      session,"vessel_id",
      selected= choices[1], 
      choices = choices, 
      label = ""
    )
    
  }, ignoreInit = TRUE)
  
  observeEvent(input$vessel_id, {
    selectedVesselId(input$vessel_id)
  }, ignoreInit = TRUE)
}

## To be copied in the UI
# mod_vessel_id_selector_ui("vessel_id_selector_ui_1")

## To be copied in the server
# callModule(mod_vessel_id_selector_server, "vessel_id_selector_ui_1")

