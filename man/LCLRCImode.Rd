\name{LCLRCImode}
\alias{LCLRCImode}
\title{
  Compute Log-Concave Likelihood-Ratio Confidence interval for the mode.
}
\description{
  
  Compute the confidence interval (CI) for the mode of a log-concave
  density by "inverting" the likelihood ratio statistic, i.e. the
  \eqn{1-\alpha} CI is composed of mode values at which the likelihood
  ratio test does not reject at the \eqn{\alpha}-level.
     
}

\usage{

LCLRCImode(x, xgrid = NULL, w = NA, nn = length(x), alpha = 0.05, prec =
1e-10, CIprec = 1e-04, print = F)

}

\arguments{
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
    Numeric vector of length \code{length(x)} or \code{NA}.
    Weights corresponding to \code{x}. Can be \code{NA} (regardless of
    the value of \code{xgrid}) which indicates the weights are uniform
    (equal to \code{1/length(x)}). If \code{w} is not \code{NA} then
    \code{xgrid} should be \code{NULL}. If \code{nn} is not equal to
    \code{length(x)} then \code{w} should be given a non-\code{NA}
    value.  If \code{w} is not \code{NA}, then we assume that \code{x}
    has no duplicate entries.
    
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
    Numeric value in \code{[0,1]}, the coverage probability for the
    confidence interval (i.e., the level for the corresponding test). 
  }
  \item{prec}{

    Numeric value, giving the precision passed to
    \code{\link{activeSetLogCon}} and to
    \code{\link{activeSetLogCon.mode}}.
    
  }
  \item{CIprec}{
    Numeric value giving precision for the endpoints of the confidence interval.
  }
  \item{print}{
    \code{TRUE} or \code{FALSE}, depending on whether debugging
    information should be printed or not, respectively.
  }
}

\details{

  The confidence set is given by the values of the mode that
  \code{\link{LRmodeTest}} does not reject.  See the details of that
  function.
  
}

\value{

  Returns a numeric vector of length 2, giving the asymptotic confidence
  interval for the mode location.

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

  See also \code{\link{LRmodeTest}} for the corresponding test. 
  
}

\examples{

nn <- 200
myxx <- rnorm(nn) ## no need to sort

LCLRCImode(x=myxx,
           xgrid=NULL,
           w=NA,
           ##nn=nn, 
           alpha=0.05,
           CIprec=1e-04,
           print=FALSE)

LCLRCImode(x=myxx,
           xgrid=.05,
           w=NA,
           ##nn=nn, 
           alpha=0.05,
           CIprec=1e-04,
           print=FALSE)


}

\keyword{htest}
\keyword{nonparametric}
