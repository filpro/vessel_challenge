#' longest_path_note UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_general_note_ui <- function(id){
  ns <- NS(id)
  tagList(
    div(class = "ui horizontal divider", "General details"),
    card(
      div(class = "content", 
          div(class = "header", icon("ship"),textOutput(ns("ship_name"), inline = TRUE)), 
          div(class = "meta", "No. ", textOutput(ns("ship_id"), inline = TRUE)), 
          div(class = "description", HTML(
            paste0(
              "Destination: ", strong(textOutput(ns("ship_destination"), inline = TRUE)),
              br(),
              "Ship type: ", strong(textOutput(ns("ship_type"), inline = TRUE)),
              br(),
              "Ship deadweight: ", strong(textOutput(ns("ship_dwt"), inline = TRUE))
            )
          )
          )
      )
    )
  )
}

#' longest_path_note Server Function
#'
#' @noRd 
#' @import lubridate
mod_general_note_server <- function(input, output, session){
  ns <- session$ns
  
  observeEvent(dataStore$longestPath(), {
    dataStore$longestPath() %...>% (function(object) {
      
      output$ship_name = renderText({
        object$SHIPNAME
      })
      
      output$ship_id = renderText({
        object$SHIP_ID
      })
      
      output$ship_destination = renderText({
        object$DESTINATION
      })
      
      output$ship_type = renderText({
        object$ship_type
      })
      
      output$ship_dwt = renderText({
        object$DWT
      })
    })
    
  })
}

## To be copied in the UI
# mod_general_note_ui("general_note_ui_1")

## To be copied in the server
# callModule(mod_general_note_server, "general_note_ui_1")

