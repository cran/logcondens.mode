\name{LRmodeTest}
\alias{LRmodeTest}

\title{
  Computes an Asymptotic Confidence Interval for the mode of a
  Log-Concave Density
}

\description{
  
  A likelihood ratio test to test whether \code{mode} is the location of
  the mode of a (log-concave) density.  Uses
  \code{\link{activeSetLogCon}} and \code{\link{activeSetLogCon.mode}}
  to compute the log-concave MLE and the log-concave MLE where the mode
  is restricted to be \code{mode}, respectively.  
  
}

\usage{

LRmodeTest(mode, x, xgrid = NULL, w, nn = length(x), alpha, prec=1e-10,
print=FALSE)

}

\arguments{
  \item{mode}{
    Numeric value giving the constrained value of the mode location. 
  }
  \item{x}{
    Points at which to compute the unconstrained and constrained
    estimators. Either iid data observations (from a log-concave
    density) or, such data binned.  If \code{x} is binned, there should
    be corresponding weights \code{w}.  Binning is usually handled by
    passing in a non-\code{NULL} value for \code{xgrid}.
  }
  \item{xgrid}{
    Governs binning of \code{x} and generation of corresponding weights
    \code{w}.  See \code{logcondens::preProcess}. 
    If \code{w} is not \code{NA} then \code{xgrid}
    should be \code{NULL}.
  }
  \item{w}{
    Numeric vector of length \code{length(x)} or \code{NA}.  Weights corresponding to
    \code{x}. Can be \code{NA} (regardless of the value of \code{xgrid})
    which indicates the weights are uniform (equal to
    \code{1/length(x)}). If \code{w} is not \code{NA} then \code{xgrid}
    should be \code{NULL}. If \code{nn} is not equal to \code{length(x)}
    then \code{w} should be given a non-\code{NA} value.
    If \code{w} is not \code{NA}, then we assume that \code{x} has no
    duplicate entries. 
  }
  \item{nn}{

    The number of data points initially observed.  Numeric of length
    1. Usually equal to \code{length(x)}. If some sort of
    \code{preProcess}ing is done in advance, may be not equal to
    \code{length(x)}.  To pass in a non-default value for \code{nn}
    (i.e. something other than \code{length(x)}), \code{w} must also be
    passed in a (numeric vector) value, and \code{xgrid} must be
    \code{NULL}.
    
  }
  \item{alpha}{
    Numeric value in \code{[0,1]}, the level for the test.
  }
  \item{prec}{
    Numeric value, giving the precision passed to \code{\link{activeSetLogCon}} and
    \code{\link{activeSetLogCon.mode}}. 
  }
  \item{print}{
    \code{TRUE} or \code{FALSE}, depending on whether debugging
    information should be printed or not, respectively.
  }
}

\details{

  Uses \code{\link{activeSetLogCon}} and
  \code{\link{activeSetLogCon.mode}} to compute the log-concave MLE
  \eqn{\hat{f}_n} and the log-concave MLE where the mode is restricted
  to be \code{mode}, \eqn{\hat{f}_n^0}. The statistic, Two times the Log
  Likelihood Ratio (TLLR) is then defined to be \eqn{2( \mbox{log} \hat{f}_n -
  \mbox{log} \hat{f}_n^0)}.

  Our test is based on the assumption
  that the true log-concave density \code{f_0} is twice differentiable
  at its true mode \code{m}, and \code{f_0} satisfies
  \code{f_0''(m)<0}. Under that condition, Doss (2013) conjectures that
  the log likelihood ratio statistic is asymptotically pivotal (i.e.,
  its limit distribution does not depend on the true log-concave
  density).

  Using the pivotal nature of TLLR, its limit distribution can be
  simulated from any given known log-concave density (e.g., a standard
  normal), and the estimated distribution function of this limit is
  given by the \code{\link{LCTLLRdistn}} object.  The quantiles of the limit
  distribution are used to either reject or not reject the test.

}
\value{

  Returns \code{TRUE} or \code{FALSE} for not reject or to reject
  \code{mode}, respectively. 

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



\author{
  Charles R. Doss, \email{cdoss@stat.washington.edu}, \cr
  \url{http://www.stat.washington.edu/people/cdoss/} 
}


\seealso{

  \code{\link{LCLRCImode}} uses \code{LRmodeTest} to compute asymptotic confidence sets.
  
}

\examples{
nn <- 200
myxx <- rnorm(nn) ## no need to sort

## Under null/true hypothesis with or without grid
LRmodeTest(mode=0, x=myxx, xgrid=NULL, alpha=.05)
LRmodeTest(mode=0, x=myxx, xgrid=.05, alpha=.05)

## Under alternative/false hypothesis
LRmodeTest(mode=3, x=myxx, xgrid=NULL, alpha=.05)

}


\keyword{htest}
\keyword{nonparametric}
