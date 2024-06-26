% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/loo.trophicSDMfit.R
\name{loo.trophicSDMfit}
\alias{loo.trophicSDMfit}
\title{Computes an approximation of loo for the whole model}
\usage{
\method{loo}{trophicSDMfit}(x, ...)
}
\arguments{
\item{x}{A trophicSDMfit object obtained with trophicSDM()}

\item{...}{additional arguments}
}
\value{
The value of the loo for the whole model
}
\description{
Only works if method = 'stan_glm'. The global loo is computed by summing the loo of all the local models (since the likelihood factorises, the log-likelihood can be summed)This is an implementation of the methods described in Vehtari, Gelman, and Gabry (2017) and Vehtari, Simpson, Gelman, Yao, and Gabry (2019).
}
\examples{
data(Y, X, G)
# define abiotic part of the model
env.formula = "~ X_1 + X_2"
# Run the model with bottom-up control using stan_glm as fitting method and no penalisation
m = trophicSDM(Y,X,G, env.formula,
               family = binomial(link = "logit"), penal = NULL, iter = 50,
               mode = "prey", method = "stan_glm")
\donttest{brms::loo(m)}
}
\author{
Giovanni Poggiato
}
