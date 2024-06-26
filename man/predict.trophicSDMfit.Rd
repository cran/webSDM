% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/predict.trophicSDMfit.R
\name{predict.trophicSDMfit}
\alias{predict.trophicSDMfit}
\title{Computes predicted values from the fitted trophicSDMfit model}
\usage{
\method{predict}{trophicSDMfit}(
  object,
  Xnew = NULL,
  prob.cov = FALSE,
  pred_samples = NULL,
  run.parallel = FALSE,
  verbose = FALSE,
  fullPost = TRUE,
  filter.table = NULL,
  ...
)
}
\arguments{
\item{object}{A trophicSDMfit object obtained with trophicSDM()}

\item{Xnew}{a matrix specifying the environmental covariates for the predictions to be made. If NULL (default), predictions are done on the training dataset (e.g. by setting Xnew = tSDM$data$X).}

\item{prob.cov}{Parameter to predict with trophicSDM with presence-absence data. Whether to use predicted probability of presence (prob.cov = T) or the transformed presence-absences (default, prov.cov = F) to predict species distribution.}

\item{pred_samples}{Number of samples to draw from species posterior predictive distribution when method = "stan_glm". If NULL, set by the default to the number of iterations/10.}

\item{run.parallel}{Whether to use parallelise code when possible. Can speed up computation time.}

\item{verbose}{Whether to print advances of the algorithm}

\item{fullPost}{Optional parameter for stan_glm only. Whether to give back the full posterior predictive distribution (default, fullPost = TRUE) or just the posterior mean, and 2.5\% and 97.5\% quantiles,}

\item{filter.table}{Optional, default to NULL, should be provided only if the users wants to filter some species predictions. A sites x species matrix of zeros and ones.}

\item{...}{additional arguments}
}
\value{
A list containing for each species the predicted value at each sites. If method = "stan_glm", then each element of the list is a sites x pred_samples matrix containing the posterior predictive distribution of the species at each sites.
}
\description{
Computes predicted values from the fitted trophicSDMfit model at environmental conditions specified by \code{Xnew}. Once predictions have been obtained, their quality can eventually be evaluated with \code{evaluateModelFit()}.
}
\examples{
data(Y, X, G)
# define abiotic part of the model
env.formula = "~ X_1 + X_2"
# Run the model with bottom-up control using stan_glm as fitting method and no penalisation
# (set iter = 1000 to obtain reliable results)
m = trophicSDM(Y, X, G, env.formula, iter = 50,
               family = binomial(link = "logit"), penal = NULL, 
               mode = "prey", method = "stan_glm")
# We can now evaluate species probabilities of presence for the environmental conditions c(0.5, 0.5)
predict(m, Xnew = data.frame(X_1 = 0.5, X_2 = 0.5))
# Obtain 50 draws from the posterior predictive distribution of species (pred_samples = 10)
# using predicted presence-absences of species to predict their predators (prob.cov = TRUE)
# Since we don't specify Xnew, the function sets Xnew = X by default
Ypred = predict(m, fullPost = TRUE, pred_samples = 10, prob.cov = FALSE)
# We can ask the function to only give back posterior mean and 95\% credible intervals with
# fullPost = F
\donttest{
Ypred = predict(m, fullPost = TRUE, pred_samples = 30, prob.cov = FALSE)
}
# If we fit the model using in a frequentist  way (e.g. glm)
m = trophicSDM(Y, X, G, env.formula, 
               family = binomial(link = "logit"), penal = NULL, 
               mode = "prey", method = "glm")
# We are obliged to set pred_samples = 1 
# (this is done by default if pred_samples is not provided)
# In the frequentist case, fullPost is useless.
 Ypred = predict(m, pred_samples = 1, prob.cov = FALSE)
}
\author{
Giovanni Poggiato and Jérémy Andréoletti
}
