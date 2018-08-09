#' Numeric labels for internal use and special cases
#' 
#' Low level function for generating all other types of numeric labels.
#' The end-user should primarily use functions listed in
#' \code{\link{quantity_label}}, whereas this function is intended for internal
#' use and special cases. If you find that you are
#' regularly using \code{numeric_label} for a case not covered by the end-user
#' functions, please file an issue on GitHub for adding it.
#' 
#' @param x Numeric values.
#' @param prefix A data frame containing prefix symbols and powers,
#'   see \link{prefix}.
#' @param unit Unit symbol.
#' @param unit_position Whether to put the unit before or after the numerical
#'   value.
#' @param digits Number of significant digits, sent to \code{\link{signif}}.
#' @param space Whether to put a space between numeric value and unit.
#' @examples
#' # Physical quantities
#' n <- 12
#' x <- 10^rnorm(n, sd = 6) * ifelse(runif(n) < .5, -1, 1)
#' 
#' data.frame(
#'   x = x,
#'   label = quantity_label(x, unit = "g")
#' )
#' 
#' # Currencies
#' x <- round(10^c(rgamma(n/2, 3, 1) - 2, rgamma(n/2, 5, 1)), digits = 2) * ifelse(runif(n) < .5, -1, 1)
#' 
#' data.frame(
#'   x = x,
#'   EUR = currency_label(x, prefix = TRUE, currency = "EUR"),
#'   USD = currency_label(x, prefix = TRUE, currency = "USD"),
#'   GBP = currency_label(x, prefix = TRUE, currency = "GBP"),
#'   SEK = currency_label(x, prefix = TRUE, currency = "SEK")
#' )
#' @return Character vector.
#' @author Christofer \enc{Bäcklin}{Backlin}
#' @seealso \code{\link{quantity_label}}, \code{\link{prefix}}.
#' @importFrom dplyr arrange_ filter_
#' @export
numeric_label <- function(x, prefix=NULL, unit="", unit_position = c("after", "before"), digits=3, space=TRUE){
  if(is.null(prefix)){
    prefix <- data.frame(symbol = "")
    i <- 1L
    my_x <- x
  } else if(is.data.frame(prefix)){
    prefix <- arrange_(prefix, "power")
    lax <- ifelse(x == 0, 0, log10(abs(x)))
    i <- pmax(vapply(lax, function(lx) sum(prefix$power <= lx), integer(1)), 1L)
    power_diff <- lax - prefix$power[i]
    if(any(power_diff < -2, na.rm = TRUE))
      warning("Value of lower power than smallest prefix found. Check formatting.")
    if(any(lax - prefix$power[i] > 3, na.rm = TRUE))
      warning("Value of much larger power than largest prefix found. Check formatting.")
    my_x <- x/10^prefix$power[i]
  } else {
    stop("Invalid prefix.")
  }
  
  unit_position <- match.arg(unit_position)
  if(unit_position == "after"){
    unit_before <- ""
    unit_after <- unit
  } else {
    unit_before <- unit
    unit_after <- ""
  }
  
  my_prefix <- as.character(prefix$symbol)[i]
  sprintf("%s%s%g%s%s%s",
    ifelse(x < 0, "-", ""),
    unit_before,
    abs(signif(my_x, digits = digits)),
    ifelse(space & my_prefix != "", " ", ""),
    my_prefix,
    unit_after
  )
}

#' Labels for common cases
#' 
#' @param x Numeric values.
#' @param prefix Whether to use unit prefix, e.g. "k" for "kilo".
#' @param unit Unit of the quantity, e.g. "m" for "meter".
#' @param ... Sent to the low level function \code{\link{numeric_label}}.
#' @importFrom assertthat assert_that
#' @importFrom dplyr filter_
#' @export
quantity_label <- function(x, prefix = TRUE, unit = "", ...){
  assert_that(is.logical(prefix))
  my_prefix <- if(prefix) filter_(metric_prefix, "power %% 3 == 0") else NULL
  numeric_label(x, prefix = my_prefix, unit = unit, ...)
}

#' @param currency Currency abbreviation. So far only EUR, GBP, USD, and SEK are
#'   supported.
#' @export
#' @importFrom utils head
#' @rdname quantity_label
currency_label <- function(x, prefix = TRUE, currency = "EUR", ...){
  assert_that(is.logical(prefix))
  my_currency <- currency_table[match(currency, currency_table$abbreviation),]
  if(nrow(my_currency) == 0){
    my_currency <- head(currency_table, 1)
  }
  my_prefix <- if(prefix){
    if(is.na(my_currency$language)){
      filter_(metric_prefix, "power >= 0 & power %% 3 == 0")
    } else {
      monetary_prefix[monetary_prefix$language == my_currency$language,]
    }
  } else {
    NULL
  }
  numeric_label(x, prefix = my_prefix, unit = my_currency$symbol,
                unit_position = my_currency$position, ...)
}

#' @export
#' @rdname quantity_label
percentage_label <- function(x, unit="%", ...){
  numeric_label(x * 100, unit = unit, space = FALSE, ...)
}

#' Logical labels
#' 
#' @param levels Which level to keep. Note that the order determines the factor
#'   level order.
#' @return Factor.
#' @author Christofer \enc{Bäcklin}{Backlin}
#' @seealso \code{\link{numeric_label}}.
#' @rdname quantity_label
#' @export
logical_label <- function(x, levels=c(FALSE, NA, TRUE)){
  labels <- c("No", "Unknown", "Yes")[match(levels, c(FALSE, NA, TRUE))]
  factor(x, levels, labels, exclude = NULL)
}
