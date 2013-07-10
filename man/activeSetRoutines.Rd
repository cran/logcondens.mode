\name{activeSetRoutines.mode.Rd}
\alias{LocalExtend}
\title{Auxiliary Numerical Routine for the Function activeSetLogCon.mode}
\description{Function used by activeSetLogCon.mode.}

\usage{
LocalExtend(x, IsKnot, x2, phi2, constr=NULL) 
}

\arguments{
  \item{x}{Vector of independent and identically distributed numbers, with strictly increasing entries.}
  \item{IsKnot}{Vector with entries IsKnot\eqn{_i = 1\{\phi} has a kink at \eqn{x_i\}.}}
  \item{x2}{Vector of same type as \eqn{{\bold{x}}}{x}.}
  \item{phi2}{Vector of same type as \eqn{{\bold{\phi}}}{\phi}.}
  \item{constr}{If doing  unconstrained optimization then constr can be
    of length less or equal to 1 (e.g. \code{NULL}) or have two identical
    entries.
    If modally constrained optimization, then
    \code{constr} is a numeric vector of
    length two containing two integer indices for x2 corresponding to
    the knots on either side of the mode.     }
}
\author{

  Kaspar Rufibach, \email{kaspar.rufibach@gmail.com}, \cr
  \url{http://www.kasparrufibach.ch} 

Lutz Duembgen, \email{duembgen@stat.unibe.ch}, \cr
\url{http://www.staff.unibe.ch/duembgen}

Charles Doss, \email{cdoss@stat.washington.edu}, \cr
\url{www.stat.washington.edu/people/cdoss}
}


\seealso{
  Used by \code{\link{activeSetLogCon.mode}} to estimate a log-concave
  probability density with known location of mode.
}

\keyword{htest} \keyword{nonparametric}

