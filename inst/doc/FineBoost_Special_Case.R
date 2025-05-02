## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  dpi = 50
)

## ----setup--------------------------------------------------------------------
library(colocboost)

## ----load-example-individual--------------------------------------------------
# Load example data
data(Ind_5traits)
X <- Ind_5traits$X[[2]]
Y <- Ind_5traits$Y[[2]]

res <- colocboost(X = X, Y = Y)
colocboost_plot(res)

## ----load-example-sumstat-----------------------------------------------------
# Load example data
data(Sumstat_5traits) 
sumstat <- Sumstat_5traits$sumstat[[2]]
LD <- get_cormat(Ind_5traits$X[[2]])

res <- colocboost(sumstat = sumstat, LD = LD)
colocboost_plot(res)

## ----ld-free------------------------------------------------------------------
# Load example data
res <- colocboost(sumstat = sumstat)
colocboost_plot(res)

