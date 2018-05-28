#' @importFrom grDevices rgb col2rgb
col2hex <- function(x){
  do.call(rgb, as.data.frame(t(col2rgb(x))/255))
}

#' Colours and palettes
#'
#' @param name Name of colour.
#' @param palette Named character vector. See  
#' @author Christofer \enc{Bäcklin}{Backlin}
#' @rdname colour
#' @export
colour <- function(name, palette = get_palette()){
  validate_palette(palette)
  palette[name]
}

#' @rdname colour
#' @export
default_palette <- c(
  highlight = "orange",
  data_dark = "dodgerblue4",
  data_light ="steelblue2",
  annotation_dark = "grey60",
  annotation_light = "grey80"
)

#' @rdname colour
#' @export
get_palette <- function(){
  getOption("treesmapstheoroms_palette", default_palette)
}

#' @rdname colour
#' @export
validate_palette <- function(palette){
  assert_that(
    is.character(palette),
    is.character(col2hex(palette)),
    all(names(default_palette) %in% names(palette))
  )
}

#' @rdname colour
#' @export
set_palette <- function(palette){
  validate_palette(palette)
  options(treesmapstheorems_palette = palette)
}

thin_line_size <- .3
medium_line_size <- 1
