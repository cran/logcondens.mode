\name{estimateLRdistn}
\alias{estimateLRdistn}
\title{
  Estimate "the" limiting distribution of the likelihood ratio statistic
  for location of mode.
}
\description{
  Sampling from a given distribution, we estimate via Monte Carlo
  the limiting distribution of 2-log-likelihood-ratio of
  the modally-constrained log-concave MLE to the
  (unconstrained) log-concave MLE.
}
\usage{

estimateLRdistn(rdist = rnorm, mode = 0, N.MC = 1e2, n.SS = 10000,
xgrid=NULL, prec = 10^-10, seedVal = NULL, debugging = NULL)

}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{rdist}{

    A function taking an integer argument \code{n} and returning n values
    simulated from a distribution.  The distribution is generally
    log-concave (otherwise we are in a misspecified setting).
    
  }
  \item{mode}{
    fixed/known location of mode for constrained estimator.
  }
  \item{N.MC}{
    Number of Monte Carlo simulations to do for the limiting
    distribution.
  }
  \item{n.SS}{
    Sample Size used for each Monte Carlo.  (Each MC simulates \code{n.SS} values
    from rdist and computes constrained and unconstrained MLE).
  }
  \item{xgrid}{
    Governs the generation of weights for observations. \code{NULL}
    then data are used as they are.  Otherwise can be a single numeric
    of a numeric vector of length \code{n.SS}.     Please see
    \code{\link[logcondens:logcondens-package]{preProcess}} for details.
  }
  \item{prec}{
    Precision variable
  }
  \item{seedVal}{
    An optional seed value
  }
  \item{debugging}{

    Turns off/on debugging. Any non-character value turns debugging off.
    If debugging is a character string, then this string gives the name
    of an output file to which \code{myxx} (the simulated data from
    rdist), \code{myxx.uniq} (the corresponding unique values), and
    \code{rdist} are saved.  If the code crashes, this can be examined.
    If debugging is on (i.e., is a character) then if \code{TLLRs[i]} is
    less than \eqn{0}, the value of \code{myxx} will be saved to a file
    with name given by \verb{paste(debugging, "tmpxxs", i, ".rsav",
    sep="")}, along with corresponding weights \code{myww} and the
    \code{mode} passed in.
    
  }
}

\details{


  Computes an estimate of the asymptotic distribution of the likelihood
  ratio statistic  \eqn{2 (\mbox{log} \hat{f}_n - \mbox{log}
    \hat{f}_n^0) } under the assumption that the true log-concave density \eqn{f_0}
  satisfies \eqn{f_0''(m)<0} where \eqn{m} is the true mode of
  \eqn{f_0}.  The estimate is computed based on a sample of size
  \code{n.SS} from \code{rdist} via \code{N.MC} Monte Carlo iterations.

  Note: the object \code{\link{LCTLLRdistn}} was created by output from
  this function with \code{n.SS} set to 1.2e3 and \code{N.MC} set to 1e4.
  Thus, \code{estimateLRdistn} is _NOT_ needed to simply compute fairly
  accurate quantiles of the limit distribution of the likelihood ratio
  statistic.  \code{estimateLRdistn} is more useful for research
  purposes.  For instance, by passing to \code{mode} values that are not
  the true mode of \code{myr}, the statistic can be studied under the
  alternative hypothesis.

  
}

\value{
  
  A \code{list(LRs,TLLRs)}, i.e., "likelihood ratio" and "two log
  likelihood ratios". Both are numeric vectors of length \code{N.MC}.

  Note that theoretically all elements of \code{LRs} should be
  nonnegative, but in practice some rounding errors can occur when
  \code{n.SS} is very large.

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
  Charles Doss \email{cdoss@stat.washington.edu}, \cr
  \url{http://www.stat.washington.edu/people/cdoss/}
}

\seealso{
  See \code{\link{activeSetLogCon}} and \code{\link{activeSetLogCon.mode}},
  which compute the unconstrained and constrained MLEs, which form the
  likelihood ratio.  The object \code{\link{LCTLLRdistn}} was created by output
  from this function.
}

\examples{

myseed <- 561

{if(require(distr)){
  mydistn <- Norm() ##demonstrate use of distr package
  myr <- mydistn@r
}
else {
  myr <- rnorm
}}

hypothesis.mode <- 0
N.MC <- 100 ## should increase these values for better estimate
n.SS <- 50

LRres <- estimateLRdistn(rdist=myr, mode=hypothesis.mode, N.MC=N.MC, prec=10^-10,
               n.SS=n.SS, seedVal=myseed,
               debugging=FALSE)
TLLRs <- sort(LRres$TLLRs) ##sort is unnecessary, just for examining data
negIdcs <- TLLRs<=0; ## rounding errors 
Nneg <- sum(negIdcs)
print(Nneg)
TLLRs[negIdcs] <- 0

cdf.empirical.f <- ecdf(TLLRs)
xlims <- c(min(TLLRs), max(TLLRs))
xpts <- seq(from=xlims[1], to=xlims[2], by=.001)
plot(xpts, cdf.empirical.f(xpts), type="l",
     xlab="TLLRs", ylab="Probability")


#### LCTLLRdistn used 1e4 Monte Carlos with 1.2e3 samples each Monte
####Carlo.
##lines(xpts, LCTLLRdistn@p(xpts), col="blue") ## "object
##'C_R_approxfun' not found" error on winbuilder


}

\keyword{nonparametric}
