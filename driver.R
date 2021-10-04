rm(list = ls())

# package declarations
library(assertr)
library(dplyr)
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
df <- NULL

for (id in c(ids)) {
  
  Sys.sleep(base::sample(c(1:3), size = 1))
  
  df <- rbind(df, gr_meta_pull(id))
  
}

df

