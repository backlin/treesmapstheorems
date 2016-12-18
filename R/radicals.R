xy_attribute <- function(side="xy", values=list(major=main_colour, minor=light_colour)){
  stopifnot(tolower(side) %in% c("x", "y", "xy"))
  sides <- strsplit(side, "")[[1]]
  structure(
    lapply(sides, function(s) if(s %in% LETTERS) values$major else values$minor),
    names = tolower(sides),
    class = "xy_attribute"
  )
}

parse_attribute_list <- function(side="x", ...){
  lapply(list(...), function(a){
    if(inherits(a, "xy_attribute")){
      a[[side]]
    } else {
      a
    }
  })
}

make_xy_element <- function(name, element, side, ...){
  structure(list(do.call(element, parse_attribute_list(side, ...))),
            names = sprintf("%s.%s", name, tolower(side)))
}

make_xy_element_pair <- function(name, element, side, ...){
  requireNamespace("ggplot2")
  c(
    if(tolower(side) %in% c("x", "xy")){
      make_xy_element(name, element, "x", ...)
    } else {
      make_xy_element(name, ggplot2::element_blank, "x")
    },
    if(tolower(side) %in% c("y", "xy")){
      make_xy_element(name, element, "y", ...)
    } else {
      make_xy_element(name, ggplot2::element_blank, "y")
    }
  )
}


# Axis
tmt_axis <- function(line = "", text = "Xy", ticks = "xy", title="Y"){
  requireNamespace("ggplot2")
  text_elements <- make_xy_element_pair(
    "axis.text",
    ggplot2::element_text,
    text,
    colour = xy_attribute(text, list(major=main_colour, minor=pale_colour))
  )
  line_elements <- make_xy_element_pair(
    "axis.line",
    ggplot2::element_line,
    line,
    colour = light_colour,
    size = thin_line_size
  )
  ticks_elements <- make_xy_element_pair(
    "axis.ticks",
    ggplot2::element_line,
    ticks,
    colour = light_colour,
    size = thin_line_size
  )
  title_elements <- make_xy_element_pair(
    "axis.title",
    ggplot2::element_text,
    title,
    colour = xy_attribute(title, list(major=main_colour, minor=light_colour)),
    angle = 0,
    vjust = .5
  )
  c(text_elements, line_elements, ticks_elements, title_elements)
}


# Box
tmt_panel <- function(border=TRUE, grid="xy"){
  requireNamespace("ggplot2")
  border_elements <- if(border){
    box_colour <- if(grid == "") faint_colour else light_colour
    list(panel.border = ggplot2::element_rect(colour = box_colour, size = thin_line_size))
  } else {
    list(panel.border = ggplot2::element_blank())
  }
  grid_major_elements <- make_xy_element_pair(
    "panel.grid.major",
    ggplot2::element_line,
    grid,
    colour = faint_colour,
    size = thin_line_size
  )
  grid_minor_elements <- list(panel.grid.minor = ggplot2::element_blank())
  c(border_elements, grid_major_elements, grid_minor_elements)
}

