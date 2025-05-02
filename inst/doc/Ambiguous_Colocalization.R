## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  dpi = 80
)

## ----setup--------------------------------------------------------------------
library(colocboost)
# Run colocboost with diagnostic details
data(Ambiguous_Colocalization)
names(Ambiguous_Colocalization)

## ----colocboost-results-------------------------------------------------------
# Trait-specific effects for both eQTL and GWAS
Ambiguous_Colocalization$ColocBoost_Results$ucos_details$ucos$ucos_index

# Intersection of eQTL and GWAS variants
Reduce(intersect, Ambiguous_Colocalization$ColocBoost_Results$ucos_details$ucos$ucos_index)

## ----colocboost-purity--------------------------------------------------------
# With-in and between purity
Ambiguous_Colocalization$ColocBoost_Results$ucos_details$ucos_purity

## ----plot-ambiguous-----------------------------------------------------------
n_variables <- Ambiguous_Colocalization$ColocBoost_Results$data_info$n_variables
colocboost_plot(
  Ambiguous_Colocalization$ColocBoost_Results, 
  plot_cols = 1,
  grange = c(2000:n_variables),
  plot_ucos = TRUE,
  show_cos_to_uncoloc = TRUE
)

## ----susie-results------------------------------------------------------------
susie_eQTL <- Ambiguous_Colocalization$SuSiE_Results$eQTL
susie_GWAS <- Ambiguous_Colocalization$SuSiE_Results$GWAS

# Fine-mapped eQTL
susie_eQTL$sets$cs$L1

# Fine-mapped GWAS variants
susie_GWAS$sets$cs$L1

# Intersection of fine-mapped eQTL and GWAS variants
intersect(susie_eQTL$sets$cs$L1, susie_GWAS$sets$cs$L1)

## ----plot-susie---------------------------------------------------------------
susieR::susie_plot(susie_eQTL, y = "PIP", pos = 2000:n_variables)
susieR::susie_plot(susie_GWAS, y = "PIP", pos = 2000:n_variables)

## ----coloc-results------------------------------------------------------------
# To run COLOC, please use the following command:
# res <- coloc::coloc.susie(susie_eQTL, susie_GWAS)
res <- Ambiguous_Colocalization$COLOC_V5_Results
res$summary

## ----ambiguous-results--------------------------------------------------------
colocboost_results <- Ambiguous_Colocalization$ColocBoost_Results
res <- get_ambiguous_colocalization(
  colocboost_results, 
  min_abs_corr_between_ucos = 0.5, 
  median_abs_corr_between_ucos = 0.8
)
names(res)
names(res$ambiguous_cos)
names(res$ambiguous_cos[[1]])

## ----ambiguous-summary--------------------------------------------------------
# Get the full summary results from colocboost
full_summary <- get_colocboost_summary(colocboost_results, summary_level = 3)
names(full_summary)

# Get the summary of ambiguous colocalization results
summary_ambiguous <- full_summary$ambiguous_cos_summary
colnames(summary_ambiguous)

