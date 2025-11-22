## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----data-loader-individual, eval = FALSE-------------------------------------
# # Example of loading individual-level data
# region = "chr1:1000000-2000000"
# genotype_list = c("plink_cohort1.1", "plink_cohort1.2")
# phenotype_list = c("phenotype1_cohort1.bed.gz", "phenotype2_cohort1.bed.gz", "phenotype1_cohort2.bed.gz")
# covariate_list = c("covariate1_cohort1.bed.gz", "covariate2_cohort1.bed.gz", "covariate1_cohort2.bed.gz")
# conditions_list_individual = c("phenotype1_cohort1", "phenotype2_cohort1", "phenotype1_cohort2")
# match_geno_pheno = c(1,1,2)
# association_window = "chr1:1000000-2000000" # set to be the same as region for cis-analysis
# extract_region_name = list(c("ENSG00000269699, ENSG00000789633"), c("ENSG00000269699"), c("ENSG00000269699", "ENSG00000789633"))
# region_name_col = 4
# keep_indel = TRUE
# keep_samples = c("SAMPLE1", "SAMPLE2", "SAMPLE3")
# 
# # Following parameters need to be set according to your data
# maf_cutoff = 0.01
# mac_cutoff = 10
# xvar_cutoff = 0
# imiss_cutoff = 0.9
# 
# # More advanced parameters see pecotmr::load_multitask_regional_data()
# region_data_individual <- load_multitask_regional_data(
#     region = region,
#     genotype_list = genotype_list,
#     phenotype_list = phenotype_list,
#     covariate_list = covariate_list,
#     conditions_list_individual = conditions_list_individual,
#     match_geno_pheno = match_geno_pheno,
#     association_window = association_window,
#     region_name_col = region_name_col,
#     extract_region_name = extract_region_name,
#     keep_indel = keep_indel,
#     keep_samples = keep_samples,
#     maf_cutoff = maf_cutoff,
#     mac_cutoff = mac_cutoff,
#     xvar_cutoff = xvar_cutoff,
#     imiss_cutoff = imiss_cutoff
# )
# 

## ----data-loader-sumstat, eval = FALSE----------------------------------------
# # Example of loading summary statistics
# sumstat_path_list = c("sumstat1.tsv.gz", "sumstat2.tsv.gz")
# column_file_path_list = c("column_mapping_sumstat1.yml", "column_mapping_sumstat2.yml")
# LD_meta_file_path_list = c("ld_meta_file.tsv")
# conditions_list_sumstat = c("sumstat_1", "sumstat_2")
# match_LD_sumstat = c("sumstat_1", "sumstat_2")
# association_window = "chr1:1000000-2000000"
# 
# # Following parameters need to be set according to your data
# n_samples = c(300000, 0)
# n_cases = c(0, 20000)
# n_controls = c(0, 40000)
# 
# 
# # More advanced parameters see pecotmr::load_multitask_regional_data()
# region_data_sumstat <- load_multitask_regional_data(
#     sumstat_path_list = sumstat_path_list,
#     column_file_path_list = column_file_path_list,
#     LD_meta_file_path_list = LD_meta_file_path_list,
#     conditions_list_sumstat = conditions_list_sumstat,
#     match_LD_sumstat = match_LD_sumstat,
#     association_window = association_window,
#     n_samples = n_samples,
#     n_cases = n_cases,
#     n_controls = n_controls
# )

## ----colocboost-analysis, eval = FALSE----------------------------------------
# #### Please check the example code below ####
# # # load in individual-level and sumstat data
# region_data_combined <- load_multitask_regional_data(
#     region = region,
#     genotype_list = genotype_list,
#     phenotype_list = phenotype_list,
#     covariate_list = covariate_list,
#     conditions_list_individual = conditions_list_individual,
#     match_geno_pheno = match_geno_pheno,
#     association_window = association_window,
#     region_name_col = region_name_col,
#     extract_region_name = extract_region_name,
#     keep_indel = keep_indel,
#     keep_samples = keep_samples,
#     maf_cutoff = maf_cutoff,
#     mac_cutoff = mac_cutoff,
#     xvar_cutoff = xvar_cutoff,
#     imiss_cutoff = imiss_cutoff,
#     sumstat_path_list = sumstat_path_list,
#     column_file_path_list = column_file_path_list,
#     LD_meta_file_path_list = LD_meta_file_path_list,
#     conditions_list_sumstat = conditions_list_sumstat,
#     match_LD_sumstat = match_LD_sumstat,
#     n_samples = n_samples,
#     n_cases = n_cases,
#     n_controls = n_controls
# )
# 
# maf_cutoff = 0.01
# pip_cutoff_to_skip_ind = rep(0, length(phenotype_list))
# pip_cutoff_to_skip_sumstat = rep(0, length(sumstat_path_list))
# qc_method = "rss_qc"
# 
# # run colocboost analysis
# colocboost_results <- colocboost_analysis_pipeline(
#     region_data_combined,
#     maf_cutoff = maf_cutoff,
#     pip_cutoff_to_skip_ind = pip_cutoff_to_skip_ind,
#     pip_cutoff_to_skip_sumstat = pip_cutoff_to_skip_sumstat,
#     qc_method = qc_method,
#     xqtl_coloc = TRUE,
#     joint_gwas = TRUE,
#     separate_gwas = TRUE
# )
# 
# # visualize results for xQTL-only mode
# colocboost_plot(colocboost_results$xqtl_coloc)
# 
# # visualize results for joint GWAS mode
# colocboost_plot(colocboost_results$joint_gwas)
# 
# # visualize results for separate GWAS mode
# for (i in 1:length(colocboost_results$separate_gwas)) {
#     colocboost_plot(colocboost_results$separate_gwas[[i]])
# }

