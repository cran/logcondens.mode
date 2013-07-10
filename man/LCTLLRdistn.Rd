\name{LCTLLRdistn}
\alias{LCTLLRdistn}
\docType{data}

\title{
  Limit Distribution of the Likelihood Ratio Statistic
}

\description{

  The \code{LCTLLRdistn} object gives the (estimated) limit distribution
  of Two times the log likelihood ratio for the location of the mode of
  a log-concave density \eqn{f_0}, under the assumption that
  \eqn{f_0''(m)<0}, where \eqn{m} is the mode of \eqn{f_0}.

  
}

\usage{LCTLLRdistn}

\format{
  \code{LCTLLRdistn} is an object with formal (S4)
  class 'distr' and subclass 'DiscreteDistribution' [package "distr"]
  with 12 slots.  It is an estimate of a continuous limit distribution
  by a discrete one.
  \describe{
    \item{@support}{ Gives the (discrete) support, i.e., the simulated
      values on which the estimate is based.}
    \item{@img}{ Formal class 'Reals' [package "distr"] with
      2 slots
      \describe{
        \item{@dimension}{1}
        \item{@name}{"Real Space"}
    }}
    \item{@param}{NULL; unused slot.}
    \item{@r}{function (n); simulates \code{n} values.}
    \item{@d}{function (x, log = FALSE); constant \eqn{0} function. }
    \item{@p}{function (q, lower.tail = TRUE, log.p = FALSE); the
      cumulative distribution function.}
    \item{@q}{        function (p, lower.tail = TRUE, log.p = FALSE);
      the quantile function.  }
    \item{@.withSim}{ logi FALSE; for internal use}
    \item{@.withArith}{ logi FALSE; for internal use}
    \item{@.logExact}{  logi FALSE; for internal use}
    \item{@.lowerExact}{logi TRUE; for internal use}
    \item{@Symmetry}{  Formal class 'NoSymmetry' [package "distr"]
      with 2 slots
      \describe{
        \item{@type}{character "non-symmetric distribution"}
        \item{@SymmCenter}{NULL}
      }
    }
  }
}
\details{

  \code{LCTLLRdistn} is an object of class "distr" and subclass
  "DiscreteDistribution" from the package \code{distr}.  The main uses
  are the three functions \code{q} (the quantile function), \code{p}
  (the cumulative distribution function) and \code{r} (which returns
  random samples).  Note that \code{d} always returns \eqn{0} since the
  distribution is estimated discretely.

  See the \code{distr} package for more details.

  
}

\source{
  Obtained via simulation from a Gamma(3,1) distribution with density
  proportional to \eqn{x^2 e^{-x}} on \eqn{(0,\infty)}.  We simulated
  the log likelihood ratio statistic \eqn{10^4} times, each time with a
  sample size of \eqn{1.2}*\eqn{10^3}.  The statistic was computed via
  the \code{\link{activeSetLogCon}} and
  \code{\link{activeSetLogCon.mode}} functions. 
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
     Department of Statistics, University of Washington, in prepa-
     ration.

     Doss, C. R. and Wellner, J. A. (2013). Inference for the mode of a
     log-concave density. Technical Report, University of Washington, in
     preparation.
     
}

\examples{

LCTLLRdistn@q(.95); ##~1.06 is the 95\% quantile

}

\seealso{ See the "distr" package.  The \code{\link{LRmodeTest}} and
  \code{\link{LCLRCImode}} functions use LCTLLRdistn.

}

\keyword{datasets}
