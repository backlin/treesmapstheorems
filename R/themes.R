#' Create trees-maps-and-theorems theme
#' 
#' This function provides the lowest level entry point to the tmt-engine
#' intended for the end user.
#' 
#' @param base_size Sent to \code{\link{theme_bw}}.
#' @param axis.line Axis lines (xy-string).
#' @param axis.text Axis tick labels (xy-string).
#' @param axis.ticks Axis tick lines (xy-string).
#' @param axis.title Axis titles (xy-string).
#' @param panel.border Box surrounding each panel (logical).
#' @param panel.grid Grid lines (xy-string). Only major grid lines are ever used.
#' @seealso \code{\link{bar_theme}}, \code{\link{line_theme}}.
#' @author Christofer \enc{Bäcklin}{Backlin}
#' @importFrom ggplot2 theme theme_bw
#' @importFrom grid unit
#' @export
tmt_theme <- function(base_size=12, axis.line="xy", axis.text="xy", axis.ticks="xy",
                      axis.title="XY", panel.border=FALSE, panel.grid=""){
  axes <- tmt_axis(line = axis.line, text = axis.text, ticks = axis.ticks, title = axis.title)
  panel <- tmt_panel(border = panel.border, grid = panel.grid)
  return(
    ggplot2::theme_bw(base_size = base_size) +
    theme(
      legend.key.size = grid::unit(3, "mm")
    ) +
    do.call(ggplot2::theme, c(axes, panel))
  )
}

#' Bar plot themes
#'
#' @param base_size Sent to \code{\link{theme_bw}}.
#' @param orientation Is it a vertical or horizontal bar plot?
#' @example examples/bar_plots.R
#' @seealso \code{\link{line_theme}}.
#' @author Christofer \enc{Bäcklin}{Backlin}
#' @export
bar_theme <- function(base_size = 10, orientation=c("vertical", "horizontal")){
  switch(match.arg(orientation),
    vertical = tmt_theme(base_size = base_size, axis.line = "y",
      axis.text = "xy", axis.ticks = "y", axis.title = "XY",
      panel.border = FALSE, panel.grid = ""),
    horizontal = tmt_theme(base_size = base_size, axis.line = "x",
      axis.text = "xY", axis.ticks = "x", axis.title = "X",
      panel.border = FALSE, panel.grid = "")
  )
}

#' Line plot themes
#'
#' @param base_size Sent to \code{\link{theme_bw}}
#' @param box Whether to draw box or not.
#' @param grid Which grid lines to draw (xy-string).
#' @example examples/line_plots.R
#' @seealso \code{\link{bar_theme}}.
#' @author Christofer \enc{Bäcklin}{Backlin}
#' @export
line_theme <- function(base_size = 10, box=FALSE, grid=if(box) "" else "y"){
  if(box){
    tmt_theme(base_size = base_size, axis.line = "", axis.text = "xy",
      axis.ticks = "xy", axis.title = "XY", panel.border = TRUE, panel.grid = grid)
  } else {
    tmt_theme(base_size = base_size, axis.line = "y", axis.text = "xy",
      axis.ticks = "y", axis.title = "XY", panel.border = FALSE, panel.grid = grid)
  }
}
