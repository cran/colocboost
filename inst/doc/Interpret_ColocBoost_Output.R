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
cos_summary <- res$cos_summary
names(cos_summary)

## ----summary-colocboost-------------------------------------------------------
# Get summary table of colocalization
cos_interest_outcome <- get_cos_summary(res, interest_outcome = c("Y1", "Y2"))

## ----run-strong-colocalization------------------------------------------------
filter_res <- get_robust_colocalization(res, cos_npc_cutoff = 0.5, npc_outcome_cutoff = 0.2)

## ----load-mixed-data----------------------------------------------------------
# Load example data
data(Ind_5traits)
data(Sumstat_5traits) 
# Create a mixed dataset
X <- Ind_5traits$X[1:4]
Y <- Ind_5traits$Y[1:4]
sumstat <- Sumstat_5traits$sumstat[5]
LD <- get_cormat(Ind_5traits$X[[1]])
# Run colocboost
res <- colocboost(X = X, Y = Y, sumstat = sumstat, LD = LD)

## ----vcp-plot-----------------------------------------------------------------
colocboost_plot(res, y = "vcp")

## ----analyzed-data-info-------------------------------------------------------
res$data_info$outcome_info

## ----cos-details--------------------------------------------------------------
names(res$cos_details)

## ----cos----------------------------------------------------------------------
res$cos_details$cos

## ----cos-outcome--------------------------------------------------------------
res$cos_details$cos_outcomes

## ----cos-npc------------------------------------------------------------------
res$cos_details$cos_npc
res$cos_details$cos_outcomes_npc

## ----cos-purity---------------------------------------------------------------
res$cos_details$cos_purity

## ----cos-top------------------------------------------------------------------
res$cos_details$cos_top_variables

## ----jk_update----------------------------------------------------------------
# Pick arbitrary SEC updates, see entire update in advance
res$model_info$jk_star[c(5:10,36:38), ]

## ----profile_loglik-----------------------------------------------------------
# Plotting joint profile log-likelihood (blue) and trait-specific profile log-likelihood (red).
par(mfrow=c(2,3),mar=c(4,4,2,1))
plot(res$model_info$profile_loglik, type="p", col="#3366CC", lwd=2, xlab="", ylab="Joint Profile")
for(i in 1:5){
plot(res$model_info$outcome_profile_loglik[[i]], type="p", col="#CC3333", lwd=2, xlab="", ylab=paste0("Profile (Trait ", i, ")"))
}

## ----objective-proximity------------------------------------------------------
# Save to restore default options
oldpar <- par(no.readonly = TRUE)
# Plotting trait-specific proximity objective
par(mfrow=c(2,3), mar=c(4,4,2,1))
for(i in 1:5){
plot(res$model_info$outcome_proximity_obj[[i]], type="p", col="#3366CC", lwd=2, xlab="", ylab="Trait-specific Objective", main = paste0("Trait ", i))
}
par(oldpar)

## ----objective-best-----------------------------------------------------------
# Save to restore default options
oldpar <- par(no.readonly = TRUE)
# Plotting trait-specific objective at the best update variant
par(mfrow=c(2,3), mar=c(4,4,2,1))
for(i in 1:5){ 
  plot(res$model_info$outcome_coupled_best_update_obj[[i]], type="p", col="#CC3333", lwd=2, xlab="", ylab=paste0("Objective at best update variant"), main = paste0("Trait ", i)) 
}
par(oldpar)

## ----ucos-details-------------------------------------------------------------
# Create a mixed dataset
data(Ind_5traits)
data(Heterogeneous_Effect)
X <- Ind_5traits$X[1:3]
Y <- Ind_5traits$Y[1:3]
X1 <- Heterogeneous_Effect$X
Y1 <- Heterogeneous_Effect$Y[,1,drop=F]
res <- colocboost(X = c(X, list(X1)), Y = c(Y, list(Y1)), output_level = 2)
names(res$ucos_details)

## ----ucos---------------------------------------------------------------------
res$ucos_details$ucos

## ----ucos-outcomes------------------------------------------------------------
res$ucos_details$ucos_outcomes

## ----cos-ucos-purity----------------------------------------------------------
res$ucos_details$cos_ucos_purity

## ----diagnostic-details-------------------------------------------------------
# Loading the dataset
data(Ind_5traits)
X <- Ind_5traits$X
Y <- Ind_5traits$Y
res <- colocboost(X = X, Y = Y, output_level = 3)

## ----cb-model-----------------------------------------------------------------
names(res$diagnostic_details$cb_model)
names(res$diagnostic_details$cb_model$ind_outcome_1)

## ----cb-model-para------------------------------------------------------------
names(res$diagnostic_details$cb_model_para)

