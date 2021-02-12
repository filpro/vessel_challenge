#' @importFrom shiny.semantic grid_template
pageGridTemplate <- grid_template(
  default = list(
    areas = rbind(
      c("logo","logo", "logo"),
      c("longest_path_section","selectors", "selectors"),
      c("longest_path_section","map","map"),
      c("longest_path_section", "map", "map")
    ),
    cols_width = c("30%", "40%", "auto"),
    rows_height = c("5%", "85px","60%", "10%")
  ),
  mobile = list(
    areas = rbind(
      "logo",
      "selectors",
      "map",
      "longest_path_section"
    ),
    rows_height = c("auto", "auto", "40%", "auto"),
    cols_width = c("100%")
  )
)
#' @importFrom shiny.semantic grid_template
selectorsGridTemplate <- grid_template(
  default = list(
    areas = rbind(
      c("vessel_type","vessel_id","max_time_interval")
    ),
    cols_width = c("30%", "30%","30%"),
    rows_height = c("15vh")
  ),
  mobile = list(
    areas = rbind(
      "vessel_type",
      "vessel_id",
      "max_time_interval"
    ),
    rows_height = c("auto", "auto","auto"),
    cols_width = c("100%")
  )
)
#' @importFrom shiny.semantic grid_template
boxGridTemplate <- grid_template(
  default = list(
    areas = rbind(
      c("title","value")
    ),
    cols_width = c("50%", "50%"),
    rows_height = c("auto")
  ),
  mobile = list(
    areas = rbind(
      "title",
      "value"
    ),
    rows_height = c("auto", "auto"),
    cols_width = c("100%")
  )
)
#' @importFrom shiny.semantic grid_template
notesSectionGridTemplate = grid_template(
  default = list(
    areas = rbind(
      "general",
      "distance",
      "interval",
      "scatterplot"
    ),
    cols_width = c("100%"),
    rows_height = c("auto","auto","auto","auto")
  ),
  mobile = list(
    areas = rbind(
      "general",
      "distance",
      "interval",
      "scatterplot"
    ),
    rows_height = c("auto","auto","auto","auto"),
    cols_width = c("100%")
  )
)

