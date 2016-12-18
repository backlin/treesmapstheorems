library(ggplot2)

set.seed(123)
plot_data <- data.frame(
  Time = as.Date('2016-01-01') + 0:100,
  Estimate = cumsum(rnorm(101)),
  s = cumsum(rgamma(101, .1, 10))
)
p <- ggplot(plot_data, aes(x = Time, y = Estimate)) +
  geom_line() +
  geom_ribbon(aes(ymin = Estimate - s, ymax = Estimate + s), fill = "#00000022") +
  scale_x_date(breaks = range(plot_data$Time)) +
  scale_y_continuous(
    breaks = c(0, range(plot_data$Estimate)),
    labels = function(x) sprintf("%.2f USD", x)
  )
p + line_theme(16, box=FALSE)
p + line_theme(16, box=TRUE)
