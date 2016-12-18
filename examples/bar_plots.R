library(ggplot2)

plot_data <- data.frame(
  category = LETTERS[1:5],
  value = c(4, 5, 2, 3, 2)
)
p <- ggplot(plot_data, aes(x = category, y = value)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(expand = c(0, 0))
p + bar_theme(16)
p + coord_flip() + bar_theme(16, orientation="horizontal")

