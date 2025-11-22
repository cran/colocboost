## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  dpi = 70
)

## ----setup--------------------------------------------------------------------
library(colocboost)

## ----LD-mismatch--------------------------------------------------------------
# Create a simulated dataset with LD mismatch
data("Sumstat_5traits")
data("Ind_5traits")
LD <- get_cormat(Ind_5traits$X[[1]])

# Change sign of Z-score for 1% of variants for each trait by including mismatched LD
set.seed(123)
miss_prop <- 0.005 
sumstat <- lapply(Sumstat_5traits$sumstat, function(ss){
  p <- nrow(ss)
  pos_miss <- sample(1:p, ceiling(miss_prop * p))
  ss$z[pos_miss] <- -ss$z[pos_miss]
  return(ss)
})

## ----LD-mismatch-runcode------------------------------------------------------
res <- colocboost(sumstat = sumstat, LD = LD)
res$cos_details$cos$cos_index

## ----LD-mismatch-mpc_0--------------------------------------------------------
res$cos_details$cos_outcomes_npc

## ----LD-mismatch-one-iter-----------------------------------------------------
# Perform only 1 iteration of gradient boosting with LD matrix
res_mismatch <- colocboost(sumstat = sumstat, LD = LD, M = 1)

## ----LD-free------------------------------------------------------------------
res_free <- colocboost(sumstat = sumstat)

## ----hyprcoloc-compatible-----------------------------------------------------
# Loading the Dataset
data(Ind_5traits)
X <- Ind_5traits$X
Y <- Ind_5traits$Y

# Coverting to HyPrColoc compatible format
effect_est <- effect_se <- effect_n <- c()
for (i in 1:length(X)){
  x <- X[[i]]
  y <- Y[[i]]
  effect_n[i] <- length(y)
  output <- susieR::univariate_regression(X = x, y = y)
  effect_est <- cbind(effect_est, output$beta)
  effect_se <- cbind(effect_se, output$sebeta)
}
colnames(effect_est) <- colnames(effect_se) <- c("Y1", "Y2", "Y3", "Y4", "Y5")
rownames(effect_est) <- rownames(effect_se) <- colnames(X[[1]])


# Run colocboost
res <- colocboost(effect_est = effect_est, effect_se = effect_se, effect_n = effect_n)

# Identified CoS
res$cos_details$cos$cos_index

