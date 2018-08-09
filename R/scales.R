#' Generate a temporary column name
#'
#' @param .data Data frame to match names against, to ensure uniqueness.
#' @return A random string not present in \code{names(.data)}.
#' @author Christofer \enc{Bäcklin}{Backlin}
#' @importFrom stats runif
#' @importFrom digest digest
temp_column_name <- function(.data){
  n <- digest(runif(1))
  while(n %in% names(.data)){
    n <- digest(runif(1))
  }
  return(n)
}


#' Groupwise shift the values of a column to make their ranges non-overlapping
#'
#' Intended to be used as a hack to get different y-axes breaks.
#'
#' @param .data Data frame.
#' @param value_col Name of the column to shift.
#' @param facet_col Name of the column that will later be used for faceting.
#' @param fun Function that produce axis breaks. If you wish to add more breaks
#'   please do so by manipulating the return value (2nd element).
#' @return A list of two elements:
#' \itemize{
#' 	 \item{A data frame with shifted data.}
#' 	 \item{A data frame with the mapping between original and shifted breaks.}
#' }
#' @example examples/shift.R
#' @importFrom dplyr %>% group_by_ ungroup summarize_ mutate_ do_ left_join select_
#' @export
#' @author Christofer \enc{Bäcklin}{Backlin}
shift_column <- function(.data, value_col, facet_col, fun = function(v) range(v, na.rm = TRUE)) {
  # Space inserted between the groups' ranges
  margin <- diff(range(.data[[value_col]], na.rm = TRUE))

  shift <- .data %>%
    group_by_(facet_col) %>%
    summarize_(shift = sprintf("min(%s)", value_col)) %>%
    mutate_(shift = "cumsum(shift) + 1:nrow(.) * margin")

  breaks <- .data %>%
    group_by_(facet_col) %>%
    do_("data.frame(labels = fun(.[[value_col]]))") %>%
    ungroup %>%
    left_join(shift, by = facet_col) %>%
    mutate_(breaks = "labels + shift") %>%
    select_("breaks", "labels")

  # Rename shift col to ensure it does not conflict with existing column names
  shift_col <- temp_column_name(.data)
  shift[[shift_col]] <- shift$shift
  shift$shift <- NULL

	shifted_data <- left_join(.data, shift, by = facet_col)
	shifted_data[[value_col]] <- shifted_data[[value_col]] + shifted_data[[shift_col]]
	shifted_data[[shift_col]] <- NULL

	return(list(shifted_data, breaks))
}

