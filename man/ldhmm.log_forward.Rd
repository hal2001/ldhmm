% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ldhmm-log_forward.R
\name{ldhmm.log_forward}
\alias{ldhmm.log_forward}
\alias{ldhmm.log_backward}
\title{Computing the log forward and backward probabilities}
\usage{
ldhmm.log_forward(object, x)

ldhmm.log_backward(object, x)
}
\arguments{
\item{object}{an ldhmm object}

\item{x}{numeric, the observations.}
}
\value{
numeric, the log probabilities
}
\description{
This utility computes the logarithms of the forward and backward probabilities, 
aka alpha and beta. 
The logarithm keeps the computation away from floating point under/over-flow. 
(Zucchini, 5.4)
}
\author{
Stephen H. Lihn
}
\keyword{pdf}
