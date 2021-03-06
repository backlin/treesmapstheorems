% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/themes.R
\name{bar_theme}
\alias{bar_theme}
\title{Bar plot themes}
\usage{
bar_theme(base_size = 10, orientation = c("vertical", "horizontal"))
}
\arguments{
\item{base_size}{Sent to \code{\link{theme_bw}}.}

\item{orientation}{Is it a vertical or horizontal bar plot?}
}
\description{
Bar plot themes
}
\examples{
library(ggplot2)
library(grid)
library(gridExtra)

plot_data <- data.frame(
  Language = c("French", "German", "Italian", "Spanish", "Swedish"),
  Estimate = c(4.123, 5.12, 2.312, 3.83, 2.48)
)

p_default <- ggplot(plot_data, aes(x = Language, y = Estimate)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(expand = c(0, 0))

p_default +
  coord_flip() +
  #tmt_label(aes(label = Estimate), nudge_y = .3) +
  expand_limits(y = c(0, 6)) +
  bar_theme(orientation = "hor")

grid.arrange(
  p_default,
  p_default + bar_theme(),
  p_default + coord_flip(),
  p_default + coord_flip() + bar_theme(orientation = "horizontal"),
  nrow = 2, ncol = 2
)

}
\seealso{
\code{\link{tmt_theme}}.
}
\author{
Christofer \enc{Bäcklin}{Backlin}
}
