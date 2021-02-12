my_server <- VesselChallenge::app_server
server <- function(id) {
  shiny::moduleServer(id, my_server)
}


testServer(server, {
  vesselId = 3636
  selectedVesselId(vesselId)
  selectedVessel() %...>% (function(table) {
    test_that("Changing the vessel id reactive changes vessel reactive object", {
      expect_type(table, "list")
      expect_equal(table$SHIP_ID %>% unique(), vesselId)
    })
  })
  
  maxTimeInterval(24 * 60 * 60)
  refDist = getLongestPathByVesselId(vesselId)
  longestPath() %...>% (function(path) {
    test_that("Longest path reactive returns appropriate observation", {
      expect_type(path, "list")
      expect_equal(path$dist, refDist$dist)
    })
  })
})


