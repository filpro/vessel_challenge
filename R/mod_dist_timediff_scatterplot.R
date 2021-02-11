#' dist_timediff_scatterplot UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @import plotly
mod_dist_timediff_scatterplot_ui <- function(id){
  ns <- NS(id)
  tagList(
    card(
      div(class = "content",
          div(class = "description",plotlyOutput(ns("dist_timediff"), height="27vh"))
      )
    )
  )
}
    
#' dist_timediff_scatterplot Server Function
#'
#' @noRd 
mod_dist_timediff_scatterplot_server <- function(input, output, session, selectedVessel){
  ns <- session$ns
  
  x <- list(
    title = "Distance between observations [meters]"
  )
  y <- list(
    title = "Time interval [minutes]"
  )
  
  output$dist_timediff = renderPlotly({
    req(selectedVessel())
    selectedVessel() %...>% 
      plot_ly(x = ~dist, y = ~TIME_DIFF/60, text = ~paste("DATE TIME: ", DATETIME_LAG, ' / ',DATETIME,'<br>ROW:', ROW_NO)) %...>% 
      layout(xaxis = x, yaxis = y)
  })
}
    
## To be copied in the UI
# mod_dist_timediff_scatterplot_ui("dist_timediff_scatterplot_ui_1")
    
## To be copied in the server
# callModule(mod_dist_timediff_scatterplot_server, "dist_timediff_scatterplot_ui_1")
 