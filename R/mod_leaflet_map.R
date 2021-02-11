#' leaflet_map UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' 

library(htmltools)
library(htmlwidgets)


popupMessage = function(datetime, row_no, lon, lat) {
  sprintf('<div class="ui card ">
  <div class="content">
    <div class="header">Observation: %s</div>
    <div class="meta">%s</div>
    <div class="description">
      <p>
        Lon: 
        %s
      </p>
    </div>
    <div class="description">
      <p>
        Lat: 
        %s
      </p>
    </div>
  </div>
</div>', datetime, row_no, lon, lat)
  
}

mod_leaflet_map_ui <- function(id){
  ns <- NS(id)
  tagList(
    card(
      div(
        class = "content", 
        div(class = "header", icon("map"),"Longest distance between observations"),
        div(class = "description", leafletOutput(ns("map"),width = "100%", height = "100%")),
        style="z-index:0")
    )
  )
}

#' leaflet_map Server Function
#'
#' @noRd 
#' @import leaflet
#' @import geosphere
mod_leaflet_map_server <- function(input, output, session, selectedVesselId, longestPath, selectedVessel){
  ns <- session$ns
  
  output$map = renderLeaflet({
    leaflet() %>% 
      addProviderTiles(providers$CartoDB.Positron)
  })
  
  
  output$map = renderLeaflet({
    req(selectedVessel())
    req(longestPath())
    longestPath() %...>% (function(object) {
      selectedVessel() %...>% (function(vessel) {
          gcIntermediate(c(object$LON,object$LAT), c(object$LON_LAG,object$LAT_LAG),
                         n=10, 
                         addStartEnd=TRUE,
                         sp=TRUE) %>%
            leaflet() %>% 
            addProviderTiles(providers$CartoDB.Positron) %>%
            clearMarkers() %>%
            addMarkers(
              lng = object$LON_LAG, 
              lat = object$LAT_LAG, 
              popup = popupMessage(
                object$ROW_NO_LAG, 
                object$DATETIME_LAG, 
                object$LON_LAG, 
                object$LAT_LAG
              )
            ) %>% 
            addMarkers(
              lng = object$LON, 
              lat = object$LAT, 
              popup = popupMessage(
                object$ROW_NO, 
                object$DATETIME, 
                object$LON, 
                object$LAT
              )
            ) %>% 
            addPolylines(layerId = "line", color = "red")%>% 
            addCircleMarkers(
              lng = vessel$LON, 
              lat= vessel$LAT, 
              weight = 2, 
              opacity = 0.3, 
              radius = 3, 
              popup = 
                popupMessage(
                  vessel$ROW_NO,
                  vessel$DATETIME,
                  vessel$LON,
                  vessel$LAT
                ), 
              clusterOptions = markerClusterOptions()
            )
        })
      })
  })
}




