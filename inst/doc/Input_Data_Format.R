## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(colocboost)

## ----summary-stats-example----------------------------------------------------
data(Sumstat_5traits)
head(Sumstat_5traits$sumstat[[1]])

## ----dict_YX------------------------------------------------------------------
dict_YX <- cbind(c(1,2,3,4,5,6), c(1,1,1,2,2,3))
dict_YX

