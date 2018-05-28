#' Geoms with TMT defaults
#'
#' @param ... Sent to \pkg{ggplot2} geoms.
#' @param colour Colour.
#' @author Christofer \enc{Bäcklin}{Backlin}
#' @importFrom ggplot2 geom_text
#' @export
tmt_label <- function(..., colour = colour("annotation_light")){
  ggplot2::geom_text(..., colour = colour)
}
