## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  dpi = 70
)

## ----setup--------------------------------------------------------------------
library(colocboost)

## ----run-colocboost-----------------------------------------------------------
# Loading the Dataset
data(Ind_5traits)
# Run colocboost 
res <- colocboost(X = Ind_5traits$X, Y = Ind_5traits$Y)

## ----basic-plot---------------------------------------------------------------
colocboost_plot(res)

## ----zoomin-plot--------------------------------------------------------------
colocboost_plot(res, grange = c(1:400), outcome_idx = c(1:4))

## ----top-plot-----------------------------------------------------------------
colocboost_plot(res, show_top_variables = TRUE)

## ----ucos-plot----------------------------------------------------------------
colocboost_plot(res, show_cos_to_uncoloc = TRUE)

## ----vertical-plot------------------------------------------------------------
colocboost_plot(
  res, show_top_variables = TRUE, 
  add_highlight = TRUE, 
  add_highlight_idx = unique(unlist(Ind_5traits$true_effect_variants)),
  add_highlight_style = "star"
)

## ----trait-specific-----------------------------------------------------------
# Create a mixed dataset
data(Ind_5traits)
data(Heterogeneous_Effect)
X <- Ind_5traits$X[1:3]
Y <- Ind_5traits$Y[1:3]
X1 <- Heterogeneous_Effect$X
Y1 <- Heterogeneous_Effect$Y[,1,drop=F]

# Run colocboost
res <- colocboost(X = c(X, list(X1)), Y = c(Y, list(Y1)), output_level = 2)
colocboost_plot(res, plot_ucos = TRUE)

## ----focal-colocalization-----------------------------------------------------
# Create a mixed dataset
data(Ind_5traits)
data(Sumstat_5traits) 
X <- Ind_5traits$X[1:3]
Y <- Ind_5traits$Y[1:3]
sumstat <- Sumstat_5traits$sumstat[4]
LD <- get_cormat(Ind_5traits$X[[1]])

# Run colocboost
res <- colocboost(X = X, Y = Y, 
                  sumstat = sumstat, LD = LD, 
                  focal_outcome_idx = 4)

# Only plot CoS with focal trait
colocboost_plot(res, plot_focal_only = TRUE)
# Plot all CoS including at least one traits colocalized with focal trait
colocboost_plot(res, plot_focal_cos_outcome_only = TRUE)

