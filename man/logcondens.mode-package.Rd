\name{logcondens.mode-package}
\alias{logcondens.mode-package}
\alias{logcondens.mode}
\docType{package}

\title{
  Computation of Log-Concave Densities on R with fixed mode and Inference
  for the Mode.
}

\description{ Extension of the logcondens package. Computes maximum
  likelihood estimate of a log-concave density with fixed and known
  location of the mode. Performs inference about the mode via a likelihood
  ratio test comparing the unconstrained log-concave estimator to the
  constrained one. 
}
  
\details{
\tabular{ll}{
Package: \tab logcondens.mode\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2013-05-24\cr
License: \tab GPL (>= 2)\cr
Depends: \tab logcondens\cr
Imports: \tab distr\cr
Suggests: \tab distr\cr
LazyLoad: \tab yes\cr
Packaged: \tab 2013-07-10 07:59:40 UTC; cdoss\cr
Built: \tab R 2.15.2; ; 2013-07-10 07:59:41 UTC; unix\cr
}

Index:
\preformatted{
LCLRCImode              Compute Log-Concave Likelihood-Ratio Confidence
                        interval for the mode.
LRmodeTest              Computes an Asymptotic Confidence Interval for
                        the mode of a Log-Concave Density
LocalExtend             Auxiliary Numerical Routine for the Function
                        activeSetLogCon.mode
activeSetLogCon         Computes a Log-Concave Probability Density
                        Estimate via an Active Set Algorithm
activeSetLogCon.mode    Computes the Modally-Constrained Log-Concave
                        Probability Density Maximum Likelihood Estimate
                        via an Active Set Algorithm.
dir.exists              Utility for checking existence of a directory.
estimateLRdistn         Estimate "the" limiting distribution of the
                        likelihood ratio statistic for location of
                        mode.
intECDFfn               Gives the Integrated Empirical Distribution
                        Function
intF                    Computes the Integral of the estimated CDF at
                        Arbitrary Real Numbers in s
intFfn                  Computes the Integral of a log-concave CDF at
                        Arbitrary Real Numbers
logConDens              Compute log-concave density estimator and
                        related quantities
                      }

The main functions of this package are \code{LCLRCImode},
\code{LRmodeTest}, and \code{activeSetLogCon.mode}.  The latter computes
a log-concave density estimate with known and fixed location of the
mode. In addition to being of interest on its own, this estimator is of
interest for likelihood ratio tests for the mode. LRmodeTest runs this test
by using \code{\link{activeSetLogCon}} and \code{\link{activeSetLogCon.mode}}
to compute the likelihood ratio statistic and \code{\link{LCTLLRdistn}}
to compute the quantiles.  \code{LCLRCImode} inverts the test to form
confidence intervals. 

}
\author{
Charles Doss

Maintainer:   Charles R. Doss, \email{cdoss@stat.washington.edu}, \cr
  \url{http://www.stat.washington.edu/people/cdoss/} 

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


\keyword{ package }
\keyword{htest}
\keyword{nonparametric}

\seealso{ See the package
  \code{\link[logcondens:logcondens-package]{logcondens}}, from which
  this package derives much of its code.  }

\examples{


nn <- 200
myxx <- rnorm(nn) ## no need to sort
TRUEMODE <- 0

res.MC <- activeSetLogCon.mode(myxx, mode=TRUEMODE)
LRmodeTest(mode=TRUEMODE, x=myxx, xgrid=.05, alpha=.05)
CI <- LCLRCImode(x=myxx, alpha=0.05)
print(CI[1] <= TRUEMODE && TRUEMODE <= CI[2]) ## approx 95\% coverage probability



}
