#' longest_path_distance_note UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_longest_path_distance_note_ui <- function(id){
  ns <- NS(id)
  tagList(
    div(class = "ui horizontal divider", "Measuring details"),
    card(
      div(class = "content", 
          div(class = "header", 
              grid(
                boxGridTemplate,
                title = HTML(paste0(icon("route"), " Largest distance")),
                value = p(textOutput(ns("distance"), inline = TRUE), style="text-align: end"),
                container_style = "justify-content: space-between"
              )
          ),
          div(class = "meta", "between two consecutive observations (meters)")
      )
    )
  )
}

#' longest_path_distance_note Server Function
#'
#' @noRd 
mod_longest_path_distance_note_server <- function(input, output, session, longestPath){
  ns <- session$ns
  
  observeEvent(longestPath(), {
    longestPath() %...>% (function(object) {
      output$distance = renderText({
        format(round(object$dist, 1), nsmall=1, big.mark=" ")
      })
      
    })
    
  })
}

## To be copied in the UI
# mod_longest_path_distance_note_ui("longest_path_distance_note_ui_1")

## To be copied in the server
# callModule(mod_longest_path_distance_note_server, "longest_path_distance_note_ui_1")

