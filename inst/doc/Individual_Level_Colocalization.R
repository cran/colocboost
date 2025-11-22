## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  dpi = 70
)

## ----setup--------------------------------------------------------------------
library(colocboost)

## ----load-example-data--------------------------------------------------------
# Loading the Dataset
data(Ind_5traits)
names(Ind_5traits)
Ind_5traits$true_effect_variants

## ----multiple-matched---------------------------------------------------------
# Extract genotype (X) and phenotype (Y) data
X <- Ind_5traits$X
Y <- Ind_5traits$Y

# Run colocboost with matched data
res <- colocboost(X = X, Y = Y)

# Identified CoS
res$cos_details$cos$cos_index

# Plotting the results
colocboost_plot(res)

## ----single-x-----------------------------------------------------------------
# Extract a single SNP (as a vector)
X_single <- X[[1]]  # First SNP for all individuals

# Run colocboost
res <- colocboost(X = X_single, Y = Y)

# Identified CoS
res$cos_details$cos$cos_index

## ----superset-X---------------------------------------------------------------
# Create phenotype with different samples - remove 50 samples trait 1 and trait 3.
X_superset <- X[[1]] 
Y_remove <- Y
Y_remove[[1]] <- Y[[1]][-sample(1:length(Y[[1]]),50), , drop=F]
Y_remove[[3]] <- Y[[3]][-sample(1:length(Y[[3]]),50), , drop=F]

# Run colocboost
res <- colocboost(X = X_superset, Y = Y_remove)

# Identified CoS
res$cos_details$cos$cos_index

## ----dictionary-mapped--------------------------------------------------------
# Create a simple dictionary for demonstration purposes
X_arbitrary <- X[c(1,3)] 
dict_YX = cbind(c(1:5), c(1,1,2,2,2))

# Display the dictionary
dict_YX

# Run colocboost
res <- colocboost(X = X_arbitrary, Y = Y, dict_YX = dict_YX)

# Identified CoS
res$cos_details$cos$cos_index

