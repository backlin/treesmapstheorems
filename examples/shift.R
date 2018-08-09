library(ggplot2)

break_fun <- function(v){
	c(mean(v), range(v))
}

shifted_cars <- shift_column(mtcars, "mpg", facet_col = "cyl", fun = break_fun)

plot_data <- shifted_cars[[1]]
mapping <- shifted_cars[[2]]

ggplot(plot_data, aes(x = disp, y = mpg)) +
  facet_wrap(~cyl, scales = "free_y") +
  geom_point() +
  scale_y_continuous(
    breaks = mapping$breaks,
    labels = numeric_label(mapping$labels),
    expand = c(0, 0)
  ) +
	line_theme(box = TRUE, grid = "y")

