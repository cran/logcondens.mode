\name{intFfn}
\alias{intFfn}

\title{

  Computes the Integral of a log-concave CDF at Arbitrary Real Numbers
  
}


\description{Based on output from the function \code{\link{logConDens}},
  \code{\link{activeSetLogCon}}, or \code{\link{activeSetLogCon.mode}},
  this function gives a function \eqn{\widehat I} given by 

  \deqn{\widehat I(l,r) = \int_{l}^{r} \widehat{F}(u) d u}{\hat I(l,r) =
    \int_{l}^{r} \hat{F}(u) du}

  or by

  \deqn{\widehat I(l,r) = \int_{l}^{r} (1-\widehat{F}(u)) d u}{\hat I(l,r) =
    \int_{l}^{r} (1-\hat{F}(u)) du}

  Note that \eqn{l} and \eqn{r} must lie in \eqn{[x_1,x_m]}. For exact formulas
  related to these integrals, see the \code{intF} function.

}



\usage{
intFfn(x, phi, Fhat, prec = 1e-10, side = "left")
}
\arguments{
  
  \item{x}{
    Vector of (unique) observations from which the (modally-constrained or
    -unconstrained) log-concave density
    is estimated. This corresponds to output of
    \code{\link{preProcess}}, potentially with a constrained mode value
    inserted.
    Weights associated with \code{x} are not
    passed in since we pass in the estimated values  \code{phi} and \code{Fhat}.
  }
  \item{phi}{
    Numeric vector of same length as \code{x} that gives the log-concave
    estimate's values at \code{x}. 
  }
  \item{Fhat}{
    Numeric vector of same length as \code{x} that gives the log-concave
    estimate CDF's values at \code{x}.
  }
  \item{prec}{
    Precision argument for the \code{intF} function.
  }
  \item{side}{
    String taking values "left" or "right".  If "left" then returns the
    first integral given in the description (integral of
    \eqn{\widehat{F}}). If "right" then returns the second integral
    given in the description (integral of \eqn{1-\widehat{F}}). 
  }

}


\value{
  Returns a function \eqn{H}. If \code{side} is "left" then the return is of type
  \preformatted{
    function(upper, lower=rep(x[1],length(upper))).} %% \preformatted is
  %% like \code, but verbaitm so can place enters in ... .......
  If \code{side} is "right" then the return is of type
  \preformatted{
    function(lower, upper=rep(x[length(x)],length(lower))).}  Note
  that the order of the arguments are changed, so that passing an
  unnamed numeric value or vector has a default behavior of integrating
  "from the outside-in". 

}

\author{

  Kaspar Rufibach, \email{kaspar.rufibach@gmail.com}, \cr \url{http://www.kasparrufibach.ch} 

  Lutz Duembgen, \email{duembgen@stat.unibe.ch}, \cr
  \url{http://www.staff.unibe.ch/duembgen}

  Charles Doss, \email{cdoss@stat.washington.edu}, \cr
  \url{http://www.stat.washington.edu/people/cdoss/}

}


\seealso{
  
  This function uses the output of \code{\link{activeSetLogCon}} or
  \code{\link{activeSetLogCon.mode}}. The function \code{\link{intECDFfn}}
  is similar, but based on the empirical distribution function. The
  function \code{\link{intF}} behaves similarly but returns a vector
  instead of a function. 


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



\examples{

## estimate gamma density
set.seed(1977)
x <- rgamma(200, 2, 1)
res <- activeSetLogCon.mode(x, mode=1)

##  res$x is not equal to x
myIntF <- intFfn( res$x,  res$phi, res$Fhat, side="left")


s <- seq(min(res$x), max(res$x), by = 10 ^ -3)
D1 <- myIntF(s)

}

\keyword{htest}
\keyword{nonparametric}


