\name{activeSetLogCon.mode}
\alias{activeSetLogCon.mode}
\title{  Computes the Modally-Constrained Log-Concave Probability
  Density Maximum Likelihood  Estimate  via an Active Set Algorithm.

}


\description{
  This is an adapted version of activeSetLogCon from the logcondens
  package for computing the MLE of a log-concave density with known
  location of mode.

  Given a vector of observations \eqn{{\bold{x}_n} = (x_1, \ldots,
    x_n)}{x_n = (x_1, \ldots, x_n)} with potentially distinct or
  nondistinct entries, \code{\link{activeSetLogCon.mode}} first
  computes vectors \eqn{{\bold{x}_m} = (x_1, \ldots, x_m)}{x_m = (x_1,
    \ldots, x_m)} and \eqn{{\bold{w}} = (w_1, \ldots, w_m)}{w = (w_1,
    \ldots, w_m)} where \eqn{w_i} is the weight of each \eqn{x_i} s.t.
  \eqn{\sum_{i=1}^m w_i = 1}. The vector \eqn{\bold{x}_m} contains the
  fixed location of the mode, \code{mode}.  Then,
  \code{\link{activeSetLogCon.mode}} computes a concave, piecewise
  linear function \eqn{\widehat \phi_m^0}{\widehat \phi_m^0} on
  \eqn{[x_1, x_m]} with \eqn{p} knots only in \eqn{\{x_1, \ldots,
    x_m\}}{{x_1, \ldots, x_m}} and with mode value, \code{mode}, such
  that
  
  \deqn{L(\phi) = \sum_{i=1}^m w_i \phi(x_i) - \int_{-\infty}^\infty \exp(\phi(t)) dt}{L(\phi) = \sum_{i=1}^m w_i \phi(x_i) - int_{-\infty}^\infty exp(\phi(t)) dt}
  
  is maximal. To accomplish this, an active set algorithm is used.

 
}


\usage{activeSetLogCon.mode(x, xgrid = NULL, mode=x[1], print = FALSE, w
= NA, prec=10^-10)
}

\arguments{
  \item{x}{Vector of independent and identically distributed numbers, not necessarily unique.}
  \item{xgrid}{Governs the generation of weights for observations. See
    \code{\link{preProcess}} for details.}
  \item{mode}{This is the constrained value for the location of the mode.}
  \item{print}{\code{print = TRUE} outputs the log-likelihood in every
    loop,  \code{print = FALSE} does not. Make sure to tell \code{R} to output (press CTRL+W).}
  \item{w}{Optional vector of weights. If weights are provided, i.e., if
    \code{w != NA}, then \code{xgrid} is ignored.}
  \item{prec}{Governs precision of various subfunctions,
    e.g., the Newton-Raphson procedure.}
}

\value{
  \item{xn}{Vector with initial observations \eqn{x_1, \ldots, x_n}.}  
  \item{x}{Vector of observations \eqn{x_1, \ldots, x_m} that was used
    to estimate the density, i.e., points that include all possible
    knots of the estimate.
    Note that \eqn{\bold{x}} always includes the mode
    value \code{mode}, since that point is a possible knot!  Note also that
    this \eqn{x} is not identical to the \eqn{x} passed in (\code{xn} is identical).
    This vector is referred to as 'z' in Doss (2013).  
  }
  \item{w}{The vector of weights that had been used. Depends on the
    chosen setting for \code{xgrid}.  Of the same length as x. The weight
    corresponding to the mode will be 0 if the mode is not a data point,
    and otherwise will be nonzero.
  }
  \item{L}{The value \eqn{L(\widehat {\bold{\phi}}_m^0)}{L(\phi_m^0)} of the
    log-likelihood-function \eqn{L} at the maximum \eqn{\widehat
      {\bold{\phi}}_m^0}{\widehat \phi_m^0}.
  }
    \item{MI}{Numeric vector of length 2 giving the endpoints of the modal
      interval.
    }
  \item{IsKnot}{Vector with entries IsKnot\eqn{_i = 1\{\widehat{\phi}_m^0}
    has a kink at \eqn{x_i}\}.
  }
  %%note brackets above are weird bc of \eqns 
  \item{IsMIC}{Analogous to IsKnot; stands for "Is Modally Inactive
    Constraint," i.e., denotes whether the modal constraints are active or
    inactive.  It is a numeric vector of length 2, corresponding to
    whether the mode is a left-knot or a right-knot.  Just as with IsKnot,
    a 1 denotes an inactive constraint and a 0 denotes an active one. Thus
    a 0 indicates that the constraint that the estimate be equal in value
    at the mode and the nearest knot to the left or to the right,
    respectively, is active.  Note also that if max(IsMIC)==1 then the
    corresponding index in IsKnot is a 1 (i.e., IsKnot[dlcMode$idx] ==1
    ).
  }
  \item{constr}{knots[constr] is equal to MI; that is, constr is
    a numeric (integral) vector of length two with values in \eqn{1,
      \ldots, p} indicating which of the \eqn{p} knots are the left and
    right of the modal interval.
  }
  \item{knots}{
    \code{knots} equals x[IsKnot>0], gives the values of the points that are knots.
  }
  \item{phi}{Vector with entries \eqn{\widehat \phi_m(x_i)}, \eqn{i=1,\ldots,m}.  Named
  "phi" not "phihat" for backwards compatibility. 
  }
  \item{fhat}{
    Vector with entries \eqn{\widehat{f}_m^0(x_i) =  e^{\widehat{\phi}_m^0(x_i)}}, \eqn{i=1,\ldots, m}.
  }

  \item{Fhat}{A vector \eqn{(\widehat F_{m,i}^0)_{i=1}^m} of the same size
  as \eqn{{\bold{x}}}{x} with entries

    \deqn{\widehat F_{m,i}^0 = \int_{x_1}^{x_i} \exp(\widehat \phi_m^0(t))
      dt.}
  }

  \item{H}{
    Numeric vector \eqn{(H_1, \ldots, H_{m})'} where \eqn{H_i} is the derivative of 
    
    \deqn{t \to L(\phi + t\Delta_i)}
    
    at zero and \eqn{\Delta_i(x) = \min(x - x_i, 0)} if \eqn{x_i} is
    less than \code{dlcMode$val} or     
    \eqn{\Delta_i(x) = \min(x_i - x, 0)} if \eqn{x_i} is greater than dlcMode$val.
    If \eqn{x_i} is the mode (i.e., equals dlcMode$val)
    \eqn{H_i},
    is set to \eqn{0}.
    The corresponding values for the mode are accessed via H.m.

    Note that in the unconstrained problems the derivatives in the
    directions \eqn{\min(x_i - x, 0)} and
    \eqn{\min(x-x_i,0)} are equal, but in the constrained problem these
    derivatives are not equal.
    
  }
  \item{H.m}{
    Vector \eqn{(H.m_1, H.m_2)'} where \eqn{H.m_1} is the derivative of 
    
    \deqn{t \to L(\phi + t\Delta_i)}
    
    at zero and \eqn{\Delta_1(x) = \min(x - a, 0)}
    and     \eqn{\Delta_2(x) = \min(a-x, 0)}, where \eqn{a} is the mode.
  }
  \item{n}{Number of initial observations, i.e., length of \code{xn}.}
  \item{m1}{Number of unique observations. This count excludes the mode
    if the mode is not a data point (or if \code{xgrid} is not
    \code{NULL} then excludes the mode if it is not in the output of \code{\link{preProcess}}).
  }
  \item{m}{Number of points used to compute the estimator, i.e., unique
    observations as well as the mode, i.e., length of \code{x}.  So is
    either \eqn{m_1 + 1} or \eqn{m_1} depending on whether \code{dlcMode$isx}
    is FALSE or TRUE, respectively.
  }
  \item{dlcMode}{
    
    A list, of class "dlc.mode", with components \code{$val},
    \code{$idx}, and \code{$isx}.  \code{dlcMode$val} gives the
    constrained mode value, \code{dlcMode$idx} gives the corresponding
    index in \code{x}, and \code{dlcMode$isx} is \code{TRUE} or
    \code{FALSE} depending on whether the value is or is not equal to an
    element of the vector \code{preProcess(x, xgrid)$x} (where \code{x}
    is the argument passed in, not the value returned).

    Note, when the mode is not an \code{x} value,
    \code{w[dlcMode$idx] == 0}. 
    This can often be used in place of an explicit check via
    \code{$isx} as to whether the mode is or is not an \code{x} value.

  }
  \item{sig}{The standard deviation of the initial sample \eqn{x_1,
      \ldots, x_n}.}
  \item{phi.f}{
    All outputs named "name.f" are functions corresponding to name.  So,
    \code{phi.f(x)} equals \eqn{\widehat{\phi}^0_m(x)}.    
  }
  \item{fhat.f}{
    Is a function such that \code{fhat.f(x)} equals \eqn{\widehat{f}_m^0(x)}.
  }
  \item{Fhat.f}{
    Is a function such that \code{Fhat.f(x)} equals \eqn{\widehat{F}_m^0(x)}.
  }
  \item{EL.f}{ %% NOTE used to be called HL.f
    \code{EL.f(l,u)} \eqn{= \int_{l}^{u} \widehat{F}_m^0(t) dt}

    Note that this is not analogous to \code{H} or \code{H.m}, which are derivatives
    of the log likelihood and so have subtracted an integral of the
    empirical cdf.
  }
  \item{ER.f}{ %% NOTE: Used to be called HR.f
    \code{ER.f(l,u)} \eqn{= \int_{l}^{u} (1-\widehat{F}_m^0(t)) dt}
  }
  \item{E.f}{
    Equals \code{EL.f}.  Included so as to be compatible (i.e., follow
    inheritance
    principles) with \code{\link{activeSetLogCon}}, which returns an
    \code{E.f} variable.
  }
  \item{phiPL}{
    Numeric vector of length \eqn{m} with values
    \eqn{(\widehat{\phi}_m^0)'(x_i-) }
  }
  \item{phiPR}{
    Numeric vector of length \eqn{m} with values
    \eqn{(\widehat{\phi}_m^0)'(x_i+) }
  }
  \item{phiPL.f}{
    Is a function such that \code{phiPL.f(x)} equals
    \eqn{(\widehat{\phi}_m^0)'(x-) }.
  }
  \item{phiPR.f}{
    Is a function such that \code{phiPR.f(x)} equals
    \eqn{(\widehat{\phi}_m^0)'(x+) }.
  }
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
  
  Kaspar Rufibach, \email{kaspar.rufibach@gmail.com}, \cr
  \url{http://www.kasparrufibach.ch}
  
  Lutz Duembgen, \email{duembgen@stat.unibe.ch}, \cr
  \url{http://www.staff.unibe.ch/duembgen}

  Charles R. Doss, \email{cdoss@stat.washington.edu}, \cr
  \url{http://www.stat.washington.edu/people/cdoss/}
}


\seealso{ 
  The following functions are used by \code{\link{activeSetLogCon.mode}}: 

  \code{\link{J00}}, \code{\link{J10}}, \code{\link{J11}},
  \code{\link{J20}},   % \code{\link{Local_LL.mode}},
  \code{Local_LL.mode},   %  \code{\link{Local_LL_all}},
  \code{LocalLLall.mode},  %\code{\link{LocalCoarsen.mode}}, \code{\link{LocalConvexity.mode}},
  \code{LocalCoarsen.mode}, \code{LocalConvexity.mode},
  \code{\link{LocalExtend}}, \code{\link{LocalF}},  %\code{\link{LocalMLE.mode}},
  \code{LocalMLE.mode},
  \code{\link{LocalNormalize}},   %\code{\link{MLE.mode}}
  \code{MLE.mode}

  \code{\link{logConDens}} (or \code{\link{activeSetLogCon}}) can be used to estimate an unconstrained
  log-concave density. 
}

  \examples{
## estimate gamma density

set.seed(1977)
n <- 200
x <- rgamma(n, 2, 1)
TRUEMODE <- 1; ## (2-1)*1
res <- activeSetLogCon.mode(x, mode=TRUEMODE, w = rep(1 / n, n), print = FALSE)

## plot resulting functions
par(mfrow = c(2, 2), mar = c(3, 2, 1, 2))
plot(res$x, res$fhat, type = 'l'); rug(res$xn)
plot(res$x, res$phi, type = 'l'); rug(res$xn)
plot(res$x, res$Fhat, type = 'l'); rug(res$xn)
plot(res$x, res$H, type = 'l'); rug(res$xn)

## Or can use the ".f" functions 
xpts <- seq(from=0, to=9, by=.01)
par(mfrow = c(2, 2), mar = c(3, 2, 1, 2))
plot(xpts, res$fhat.f(xpts), type = 'l'); rug(res$xn) 
plot(xpts, res$phi.f(xpts), type = 'l'); rug(res$xn) 
## these are not analogous to res$H.
plot(xpts, res$EL.f(upper=xpts), type = 'l'); rug(res$xn) 
plot(xpts, res$ER.f(lower=xpts), type = 'l'); rug(res$xn)


## compute and plot function values at an arbitrary point
x0 <- (res$x[100] + res$x[101]) / 2
Fx0 <- evaluateLogConDens(x0, res, which = 3)[, "CDF"]
plot(res$x, res$Fhat, type = 'l'); rug(res$x)
abline(v = x0, lty = 3); abline(h = Fx0, lty = 3)

## compute and plot 0.9-quantile of Fhat
alpha <- .1
q <- quantilesLogConDens(1-alpha, res)[2]
plot(res$x, res$Fhat, type = 'l'); rug(res$x)
abline(h = 1-alpha, lty = 3); abline(v = q, lty = 3)
}

\keyword{htest}
\keyword{nonparametric}


\note{ Adapted from
  \code{\link[logcondens:logcondens-package]{activeSetLogCon}} in the
  package \code{\link[logcondens:logcondens-package]{logcondens}}.
  
}
