rm(list = ls())

# package declarations
library(assertr)
library(dplyr)
library(purrr)
library(rvest)
library(stringr)
library(tibble)
library(xml2)

source("fn/gr_meta_pull.R")


# load IDs
ids <-
  readr::read_csv("src/input.csv") %>%
  assertr::verify(length(unique(id))==nrow(.)) %>%
  pull(id)


# pull down metadata
gr_trycatch <- function(id) {
  
  Sys.sleep(base::sample(c(1:3), size = 1))
  
  res <- NA
  while (is.na(res[1])) {
    res <- tryCatch(gr_meta_pull(id), error = function(e) { NA })
  }
  
  return(res)
  
}

df <- purrr::map_dfr(c(ids), ~ gr_trycatch(.x))


# write out results
write.csv(df, file = "results.csv", row.names = F)

