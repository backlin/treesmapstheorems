% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/prefix.R
\docType{data}
\name{prefix}
\alias{prefix}
\alias{metric_prefix}
\alias{monetary_prefix}
\title{Unit prefixes}
\format{An object of class \code{data.frame} with 17 rows and 3 columns.}
\usage{
metric_prefix

monetary_prefix
}
\description{
Data frames with unit prefixes designed for usage with
\code{\link{numeric_label}}.
Columns \code{symbol} and \code{power} are required and any additional
columns are only used for filtering (see the code of
\code{link{currency_label}} for an example).
}
\keyword{datasets}
