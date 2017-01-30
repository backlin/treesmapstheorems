#' Save a plot
#'
#' Sets a few default values for \code{\link{ggsave}}.
#'
#' @param filename Output filename.
#' @param plot Plot drawn with ggplot.
#' @param width Output width (in cm unless \code{units} is set).
#' @param height Output height (in cm unless \code{units} is set).
#' @param units Unit for \code{width} and \code{height}.
#' @param ... Sent to \code{\link{ggsave}}.
#' @author Christofer \enc{Bäcklin}{Backlin}
#' @importFrom ggplot2 ggsave
#' @export
tmt_save <- function(filename, plot, width, height, units="cm", ...){
  ggsave(filename=filename, plot=plot, width=width, height=height, units=units, ...)
}
