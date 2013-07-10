\name{intECDFfn}
\alias{intECDFfn}
\title{
  Gives the Integrated Empirical Distribution Function 
}

\description{Like \code{\link{intECDF}}, except returns a function
  \eqn{\bar I} instead of a value. The function \eqn{\bar I(l,r)} is given
  by

  \deqn{\bar{I}(l,r) = \int_{l}^{r} \bar{F}(u) d \, u}{\bar{I}(l,r) = \int_{l}^{r} \bar{F}(u) du}

  where \eqn{\bar F} is the empirical distribution function of
  \eqn{x_1,\ldots,x_m}. Note that \eqn{l} and \eqn{r} must lie in
  \eqn{[x_1,x_m]}.

  For an exact formula related to \eqn{\bar{I}}, see \code{\link{intECDF}}.

}

\usage{
intECDFfn(x)
}

\arguments{

  \item{x}{Vector \eqn{{\bold{x}} = (x_1, \ldots, x_m)}{x = (x_1,
      \ldots, x_m)} of original observations, which are used to define
      the empirical CDF, \eqn{\bar{F}}.}
}



\value{

  The function \eqn{\bar I}.
  
}


\references{
     Duembgen, L, Huesler, A. and Rufibach, K. (2010) Active set and EM
     algorithms for log-concave densities based on complete and
     censored data.  Technical report 61, IMSV, Univ. of Bern,
     available at \url{http://arxiv.org/abs/0707.4643}.

     Duembgen, L. and Rufibach, K. (2009) Maximum likelihood estimation
     of a log-concave density and its distribution function: basic
     properties and uniform consistency.  \emph{Bernoulli},
     \bold{15(1)}, 40--68.

     Duembgen, L. and Rufibach, K. (2011) logcondens: Computations
     Related to Univariate Log-Concave Density Estimation.
     \emph{Journal of Statistical Software}, \bold{39(6)},
     1--28. \url{http://www.jstatsoft.org/v39/i06}

     Doss, C. R. (2013). Shape-Constrained Inference for
     Concave-Transformed Densities and their Modes. PhD thesis,
     Department of Statistics, University of Washington, in preparation.

     Doss, C. R. and Wellner, J. A. (2013). Inference for the mode of a
     log-concave density. Technical Report, University of Washington, in
     preparation.
     
}



\seealso{

  See \code{\link{intECDF}} which returns values instead of a function.

}

\examples{

set.seed(100)
xx <- runif(50) ## min .056, max .88

myIntECDF <- intECDFfn(xx);
evalpts <- c(.3, .5) ## lie within [ min(xx) , max(xx) ]
myIntECDF(evalpts)
## equal to
intECDF(evalpts, xx)

}
\keyword{htest}
\keyword{nonparametric}
