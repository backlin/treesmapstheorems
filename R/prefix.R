#' Unit prefixes
#' 
#' Data frames with unit prefixes designed for usage with
#' \code{\link{numeric_label}}.
#' Columns \code{symbol} and \code{power} are required and any additional
#' columns are only used for filtering (see the code of
#' \code{link{currency_label}} for an example).
#' 
#' @name prefix
NULL

#' @export
#' @rdname prefix
metric_prefix <- data.frame(
  symbol = c("a", "f", "p", "n", "\u03BC", "m", "c", "d", "", "da", "h", "k", "M", "G", "T", "P", "E"),
  base = 10,
  power = c(-6:-1*3L, -2:2, 1:6*3L),
  stringsAsFactors = FALSE
)

#' @export
#' @rdname prefix
monetary_prefix <- data.frame(
  language = rep(c("en", "sv"), c(6, 6)),
  symbol = c("", "k", "m", "bn", "tn", "qn", "", "t", "m", "md", "b", "bd"),
  base = 10,
  power = c(0:5, 0:5)*3L,
  stringsAsFactors = FALSE
)

currency_table <- data.frame(
  abbreviation = c(NA, "EUR", "USD", "GBP", "SEK"), # First row is default
  symbol = c("$", "\u20AC", "$", "\u00A3", "kr"),
  language = c(NA, NA, "en", "en", "sv"),
  position = c(rep("before", 4), "after"),
  stringsAsFactors = FALSE
)


