

scale_colour_viridis <- function(..., palette = "viridis", direction=1){
  
  scale_colour_gradientn(
}

scale_fill_tmt <- function(...){
  scale_fill_manual(..., values = colour(c("data_dark", "data_light")))
}

scale_fill_paired <- function(..., direction=1){
  scale_fill_brewer(..., type="seq", palette = "Paired", direction = direction)
}
