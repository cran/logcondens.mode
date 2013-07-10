\name{intF}
\alias{intF}
\title{Computes the Integral of the estimated CDF at Arbitrary Real Numbers in s}
\description{Based on the output of the function \code{\link{activeSetLogCon}}, this gives values of 

\deqn{\widehat I(t) = \int_{x_1}^t \widehat{F}(r) d r}

at all numbers in \eqn{\bold{s}}. Note that \eqn{t} (so all elements in \eqn{\bold{s}}) must lie in \eqn{[x_1,x_m]}.
The exact formula for \eqn{\widehat I(t)} is

\deqn{\widehat I(t) = \Bigl(\sum_{i=1}^{i_0}
\widehat{I}_i(x_{i+1})\Bigr)+\widehat{I}_{i_0}(t) }

where \eqn{i_0 = \ }min\eqn{\{ m-1 \,  , \ \{i \ : \ x_i \le t \} \} } and

\deqn{I_j(x) = \int_{x_j}^x \widehat{F}(r) d r =
(x-x_j)\widehat{F}(x_j)+\Delta x_{j+1}\Bigl(\frac{\Delta x_{j+1}}{\Delta
\widehat\varphi_{j+1}}J\Bigl(\widehat\varphi_j,\widehat\varphi_{j+1},
\frac{x-x_j}{\Delta x_{j+1}}\Bigr)-\frac{\widehat f(x_j)(x-x_j)}{\Delta
  \widehat \varphi_{j+1}}\Bigr)}

for \eqn{x \in [x_j, x_{j+1}], \ j = 1,\ldots,m-1}, \eqn{\Delta v_{i+1}
  = v_{i+1}-v_i} for any vector \eqn{\bold{v}} and the function \eqn{J}
introduced in \code{\link{Jfunctions}}.

Note that this version of intF is similar to that in the logcondens package, versions
1.3.5 and earlier. Newer versions of that package have modified
arguments.  Here, we have also added the argument 'prec'. 

}
\usage{intF(s, x, phi, Fhat, prec=1e-10)}

\arguments{
  \item{s}{Vector of real numbers where the functions should be evaluated at.}
  \item{x}{Vector \eqn{{\bold{x}} = (x_1, \ldots, x_m)} of original observations (sorted).}
  \item{phi}{Vector \eqn{(\widehat \varphi_m(x_i))_{i=1}^m}, as computed by \code{\link{activeSetLogCon}}.}
  \item{Fhat}{Vector \eqn{(\widehat F_{m,i})_{i=1}^m} with entries
    \deqn{\widehat F_{m,i} = \int_{x_1}^{x_i} \exp(\widehat
      \varphi_m(t)) dt,} as computed by \code{\link{activeSetLogCon}}.}
  \item{prec}{Governs cutoff at which an approximation for the needed
    integral is used.}
}
\value{Vector of the same length as \eqn{\bold{s}}, containing the values of \eqn{\widehat I} at the elements of \eqn{\bold{s}}.}

\author{
Kaspar Rufibach, \email{kaspar.rufibach@ifspm.uzh.ch}, \cr \url{http://www.biostat.uzh.ch/aboutus/people/rufibach.html} 

Lutz Duembgen, \email{duembgen@stat.unibe.ch}, \cr
\url{http://www.staff.unibe.ch/duembgen}

}

\seealso{ This function uses the output of
\code{\link{activeSetLogCon}}. The function \code{\link{intECDF}} is
similar, but based on the empirical distribution function.  }

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
x <- sort(rgamma(200, 2, 1))
res <- activeSetLogCon(x, w = NA, print = FALSE)

## compute and plot the process D(t) in Duembgen and Rufibach (2009)
s <- seq(min(x), max(x), by = 10 ^ -3)
D1 <- intF(s, x, res$phi, res$Fhat)
D2 <- intECDF(s, x)
par(mfrow = c(2, 1))
plot(x, res$phi, type = 'l'); rug(x)
plot(s, D1 - D2, type = 'l'); abline(h = 0, lty = 2)
}
\keyword{htest}
\keyword{nonparametric}
