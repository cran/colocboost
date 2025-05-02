## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  dpi = 80
)

## ----setup--------------------------------------------------------------------
library(colocboost)

## ----load-mixed-data----------------------------------------------------------
# Load example data
data(Ind_5traits)
data(Sumstat_5traits) 

# Create a mixed dataset
X <- Ind_5traits$X[1:4]
Y <- Ind_5traits$Y[1:4]
sumstat <- Sumstat_5traits$sumstat[5]
LD <- get_cormat(Ind_5traits$X[[1]])

## ----mixd-basic---------------------------------------------------------------
# Run colocboost
res <- colocboost(X = X, Y = Y, sumstat = sumstat, LD = LD)

# Identified CoS
res$cos_details$cos$cos_index

## ----disease-basic------------------------------------------------------------
# Run colocboost
res <- colocboost(X = X, Y = Y, 
                  sumstat = sumstat, LD = LD, 
                  focal_outcome_idx = 5)

# Plotting the focal only results colocalization results
colocboost_plot(res, plot_focal_only = TRUE)

## ----all-basic----------------------------------------------------------------
# Identified CoS
res$cos_details$cos$cos_index

# Plotting all results
colocboost_plot(res)

