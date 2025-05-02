## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----data-loader-individual---------------------------------------------------
# Example of loading individual-level data
region = "chr1:1000000-2000000"
genotype_list = c("plink_cohort1.1.bed", "plink_cohort1.2.bed")
phenotype_list = c("phenotype1_cohort1.bed.gz", "phenotype2_cohort1.bed.gz", "phenotype1_cohort2.bed.gz")
covariate_list = c("covariate1_cohort1.bed.gz", "covariate2_cohort1.bed.gz", "covariate1_cohort2.bed.gz")
conditions_list_individual = c("phenotype1_cohort1", "phenotype2_cohort1", "phenotype1_cohort2")
match_geno_pheno = c(1,1,2) # indices of phenotypes matched to genotype
association_window = "chr1:1000000-2000000" # same as region for cis-analysis

# Following parameters need to be set according to your data
maf_cutoff = 0.01
mac_cutoff = 10
xvar_cutoff = 0
imiss_cutoff = 0.9

# More advanced parameters see pecotmr::load_multitask_regional_data()

## ----data-loader-sumstat------------------------------------------------------
# Example of loading summary statistics
sumstat_path_list = c("sumstat1.tsv.gz", "sumstat2.tsv.gz")
column_file_path_list = c("mapping_columns_1.yml", "mapping_columns_2.yml")
LD_meta_file_path_list = "ld_meta_file.tsv"
covariate_list = c("covariate1_cohort1.bed.gz", "covariate2_cohort1.bed.gz", "covariate1_cohort2.bed.gz")
conditions_list_sumstat = c("sumstat_1", "sumstat_2")

# Following parameters need to be set according to your data
n_samples = c(0, 0)
n_cases = c(10000, 20000)
n_controls = c(20000, 40000)

# More advanced parameters see pecotmr::load_multitask_regional_data()

## ----colocboost-analysis------------------------------------------------------
# region_data <- load_multitask_regional_data(...)
# res <- colocboost_analysis_pipeline(region_data)

