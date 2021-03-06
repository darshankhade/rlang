% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/attr.R
\name{set_names}
\alias{set_names}
\title{Set names of a vector}
\usage{
set_names(x, nm = x, ...)
}
\arguments{
\item{x}{Vector to name.}

\item{nm, ...}{Vector of names, the same length as \code{x}.

You can specify names in the following ways:
\itemize{
\item If you do nothing, \code{x} will be named with itself.
\item If \code{x} already has names, you can provide a function or formula
to transform the existing names. In that case, \code{...} is passed
to the function.
\item If \code{nm} is \code{NULL}, the names are removed (if present).
\item In all other cases, \code{nm} and \code{...} are passed to \code{\link[=chr]{chr()}}. This
gives implicit splicing semantics: you can pass character
vectors or list of character vectors indistinctly.
}}
}
\description{
This is equivalent to \code{\link[stats:setNames]{stats::setNames()}}, with more features and
stricter argument checking.
}
\examples{
set_names(1:4, c("a", "b", "c", "d"))
set_names(1:4, letters[1:4])
set_names(1:4, "a", "b", "c", "d")

# If the second argument is ommitted a vector is named with itself
set_names(letters[1:5])

# Alternatively you can supply a function
set_names(1:10, ~ letters[seq_along(.)])
set_names(head(mtcars), toupper)

# `...` is passed to the function:
set_names(head(mtcars), paste0, "_foo")
}
