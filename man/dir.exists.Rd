\name{dir.exists}
\alias{dir.exists}
\title{
  Utility for checking existence of a directory.
}
\description{
  Utility using a system interface to check whether a directory exists.
}
\usage{
dir.exists(path)
}
\arguments{
  \item{path}{
    Character string.
  }
}
\details{
  Uses \code{system} function to test if the directory specified by
  \code{path} exists.  
}
\value{
  Returns TRUE or FALSE.
}
\author{
  Charles Doss <cdoss@stat.washington.edu>, \cr 
  \url{http://www.stat.washington.edu/people/cdoss/}
}

\examples{
dir.exists("/") ## true (on *nix) 
dir.exists("~/") ## probably true
}

\keyword{IO}
\keyword{file}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.