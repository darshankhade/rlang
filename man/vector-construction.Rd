% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vec-new.R
\name{vector-construction}
\alias{vector-construction}
\alias{lgl}
\alias{int}
\alias{dbl}
\alias{cpl}
\alias{chr}
\alias{bytes}
\alias{ll}
\title{Create vectors}
\usage{
lgl(...)

int(...)

dbl(...)

cpl(...)

chr(..., .encoding = NULL)

bytes(...)

ll(...)
}
\arguments{
\item{...}{Components of the new vector. Bare lists and explicitly
spliced lists are spliced.}

\item{.encoding}{If non-null, passed to \code{\link[=set_chr_encoding]{set_chr_encoding()}} to add
an encoding mark. This is only declarative, no encoding
conversion is performed.}
}
\description{
The atomic vector constructors are equivalent to \code{\link[=c]{c()}} but allow
you to be more explicit about the output type. Implicit coercions
(e.g. from integer to logical) follow the rules described in
\link{vector-coercion}. In addition, all constructors support splicing:
if you supply \link[=is_bare_list]{bare} lists or \link[=is_spliced]{explicitly
spliced} lists, their contents are spliced into the
output vectors (see below for details). \code{ll()} is a list
constructor similar to \code{\link[base:list]{base::list()}} but with splicing semantics.
}
\section{Splicing}{


Splicing is an operation similar to flattening one level of nested
lists, e.g. with \code{\link[=unlist]{base::unlist(x, recursive =
FALSE)}} or \code{purrr::flatten()}. \code{ll()} returns its arguments as a
list, just like \code{list()} would, but inner lists qualifying for
splicing are flattened. That is, their contents are embedded in the
surrounding list. Similarly, \code{chr()} concatenates its arguments and
returns them as a single character vector, but inner lists are
flattened before concatenation.

Whether an inner list qualifies for splicing is determined by the
type of splicing semantics. All the atomic constructors like
\code{chr()} have \emph{list splicing} semantics: \link[=is_bare_list]{bare} lists
and \link[=is_spliced]{explicitly spliced} lists are spliced.

There are two list constructors with different splicing
semantics. \code{ll()} only splices lists explicitly marked with
\code{\link[=splice]{splice()}}.
}

\examples{
# These constructors are like a typed version of c():
c(TRUE, FALSE)
lgl(TRUE, FALSE)

# They follow a restricted set of coercion rules:
int(TRUE, FALSE, 20)

# Lists can be spliced:
dbl(10, list(1, 2L), TRUE)


# They splice names a bit differently than c(). The latter
# automatically composes inner and outer names:
c(a = c(A = 10), b = c(B = 20, C = 30))

# On the other hand, rlang's ctors use the inner names and issue a
# warning to inform the user that the outer names are ignored:
dbl(a = c(A = 10), b = c(B = 20, C = 30))
dbl(a = c(1, 2))

# As an exception, it is allowed to provide an outer name when the
# inner vector is an unnamed scalar atomic:
dbl(a = 1)

# Spliced lists behave the same way:
dbl(list(a = 1))
dbl(list(a = c(A = 1)))

# bytes() accepts integerish inputs
bytes(1:10)
bytes(0x01, 0xff, c(0x03, 0x05), list(10, 20, 30L))

# The list constructor has explicit splicing semantics:
ll(1, list(2))

# Note that explicitly spliced lists are always spliced:
ll(!!! list(1, 2))
}
\seealso{
\code{\link[=ll]{ll()}}
}
