## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  dpi = 70
)

## ----setup--------------------------------------------------------------------
library(colocboost)

## ----load-summary-data--------------------------------------------------------
# Loading the Dataset
data("Sumstat_5traits")
names(Sumstat_5traits)
Sumstat_5traits$true_effect_variants

## ----summary-data-format------------------------------------------------------
class(Sumstat_5traits$sumstat[[1]])
head(Sumstat_5traits$sumstat[[1]])

## ----one-LD-------------------------------------------------------------------
# Extract genotype (X) and calculate LD matrix
data("Ind_5traits")
LD <- get_cormat(Ind_5traits$X[[1]])

# Run colocboost
res <- colocboost(sumstat = Sumstat_5traits$sumstat, LD = LD)

# Identified CoS
res$cos_details$cos$cos_index

# Plotting the results
colocboost_plot(res)

## ----matched-LD---------------------------------------------------------------
# Duplicate LD with matched summary statistics
LD_multiple <- lapply(1:length(Sumstat_5traits$sumstat), function(i) LD )

# Run colocboost
res <- colocboost(sumstat = Sumstat_5traits$sumstat, LD = LD_multiple)

# Identified CoS
res$cos_details$cos$cos_index

## ----superset-LD--------------------------------------------------------------
# Create sumstat with different number of variants - remove 100 variants in each sumstat
LD_superset <- LD
sumstat <- lapply(Sumstat_5traits$sumstat, function(x) x[-sample(1:nrow(x), 20), , drop = FALSE])

# Run colocboost
res <- colocboost(sumstat = sumstat, LD = LD_superset)

# Identified CoS
res$cos_details$cos$cos_index

## ----dictionary-mapped--------------------------------------------------------
# Create a simple dictionary for demonstration purposes
LD_arbitrary <- list(LD, LD) # traits 1 and 2 matched to the first genotype matrix; traits 3,4,5 matched to the third genotype matrix.
dict_sumstatLD = cbind(c(1:5), c(1,1,2,2,2))

# Display the dictionary
dict_sumstatLD

# Run colocboost
res <- colocboost(sumstat = Sumstat_5traits$sumstat, LD = LD_arbitrary, dict_sumstatLD = dict_sumstatLD)

# Identified CoS
res$cos_details$cos$cos_index

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
LD <- get_cormat(Ind_5traits$X[[1]])
res <- colocboost(effect_est = effect_est, effect_se = effect_se, effect_n = effect_n, LD = LD)

# Identified CoS
res$cos_details$cos$cos_index

