% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vec-chr.R
\name{set_chr_encoding}
\alias{set_chr_encoding}
\alias{chr_encoding}
\alias{set_str_encoding}
\alias{str_encoding}
\title{Set encoding of a string or character vector}
\usage{
set_chr_encoding(x, encoding = c("unknown", "UTF-8", "latin1", "bytes"))

chr_encoding(x)

set_str_encoding(x, encoding = c("unknown", "UTF-8", "latin1", "bytes"))

str_encoding(x)
}
\arguments{
\item{x}{A string or character vector.}

\item{encoding}{Either an encoding specially handled by R
(\code{"UTF-8"} or \code{"latin1"}), \code{"bytes"} to inhibit all encoding
conversions, or \code{"unknown"} if the string should be treated as
encoded in the current locale codeset.}
}
\description{
R has specific support for UTF-8 and latin1 encoded strings. This
mostly matters for internal conversions. Thanks to this support,
you can reencode strings to UTF-8 or latin1 for internal
processing, and return these strings without having to convert them
back to the native encoding. However, it is important to make sure
the encoding mark has not been lost in the process, otherwise the
output will be treated as if encoded according to the current
locale (see \code{\link[=mut_utf8_locale]{mut_utf8_locale()}} for documentation about locale
codesets), which is not appropriate if it does not coincide with
the actual encoding. In those situations, you can use these
functions to ensure an encoding mark in your strings.
}
\examples{
# Encoding marks are always ignored on ASCII strings:
str_encoding(set_str_encoding("cafe", "UTF-8"))

# You can specify the encoding of strings containing non-ASCII
# characters:
cafe <- string(c(0x63, 0x61, 0x66, 0xC3, 0xE9))
str_encoding(cafe)
str_encoding(set_str_encoding(cafe, "UTF-8"))


# It is important to consistently mark the encoding of strings
# because R and other packages perform internal string conversions
# all the time. Here is an example with the names attribute:
latin1 <- string(c(0x63, 0x61, 0x66, 0xE9), "latin1")
latin1 <- set_names(latin1)

# The names attribute is encoded in latin1 as we would expect:
str_encoding(names(latin1))

# However the names are converted to UTF-8 by the c() function:
str_encoding(names(c(latin1)))
as_bytes(names(c(latin1)))

# Bad things happen when the encoding marker is lost and R performs
# a conversion. R will assume that the string is encoded according
# to the current locale:
\dontrun{
bad <- set_names(set_str_encoding(latin1, "unknown"))
mut_utf8_locale()

str_encoding(names(c(bad)))
as_bytes(names(c(bad)))
}
}
\seealso{
\code{\link[=mut_utf8_locale]{mut_utf8_locale()}} about the effects of the locale, and
\code{\link[=as_utf8_string]{as_utf8_string()}} about encoding conversion.
}
