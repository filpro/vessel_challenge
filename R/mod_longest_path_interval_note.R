#' longest_path_interval_note UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_longest_path_interval_note_ui <- function(id){
  ns <- NS(id)
  tagList(
    card(
      div(class = "content", 
          div(class = "header", 
              grid(
                boxGridTemplate,
                title = HTML(paste0(icon("clock"), " Time interval")),
                value = p(uiOutput(ns("time_interval"), inline = TRUE), style="text-align: end")
                
                ,
                container_style = "justify-content: space-between"
              )
          ),
          div(class = "meta", "between these observations (HH:MM:SS)")
      )
    )
  )
}
    
#' longest_path_interval_note Server Function
#'
#' @noRd 
mod_longest_path_interval_note_server <- function(input, output, session){
  ns <- session$ns
  observeEvent(dataStore$longestPath(), {
    dataStore$longestPath() %...>% (function(object) {
      output$time_interval = renderText({
        interval(object$DATETIME_LAG, object$DATETIME) %>% 
          as.duration() %>% 
          as.period() %>% 
          (function(x) sprintf('%02d:%02d:%02d', day(x) * 24 + hour(x), minute(x), second(x)))
      })
    })
    
  })
}
    
## To be copied in the UI
# mod_longest_path_interval_note_ui("longest_path_interval_note_ui_1")
    
## To be copied in the server
# callModule(mod_longest_path_interval_note_server, "longest_path_interval_note_ui_1")
 
