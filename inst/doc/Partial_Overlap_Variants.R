## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  dpi = 70
)

## ----setup--------------------------------------------------------------------
library(colocboost)

## ----make-data----------------------------------------------------------------
# Load example data
data(Ind_5traits)
X <- Ind_5traits$X
Y <- Ind_5traits$Y

# Create causal variants with potentially LD proxies
causal_1 <- c(100:350)
causal_2 <- c(450:650)

# Create missing data
X[[2]] <- X[[2]][, -causal_1, drop = FALSE]
X[[3]] <- X[[3]][, -causal_2, drop = FALSE]

# Show format
X[[2]][1:2, 1:6]
X[[3]][1:2, 1:6]

## ----run-code-----------------------------------------------------------------
# Run colocboost
res <- colocboost(X = X, Y = Y)

# The number of variants in the analysis
res$data_info$n_variables

# Plotting the results
colocboost_plot(res)

## ----run-code-overlap---------------------------------------------------------
# Run colocboost with only overlapping variables
res <- colocboost(X = X, Y = Y, overlap_variables = TRUE)

# The number of variants in the analysis
res$data_info$n_variables

# Plotting the results
colocboost_plot(res)

## ----run-code-focal-----------------------------------------------------------
# Run colocboost
res <- colocboost(X = X, Y = Y, focal_outcome_idx = 3)

# The number of variants in the analysis
res$data_info$n_variables

# Plotting the results
colocboost_plot(res)

