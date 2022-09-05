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


# source data frame
src <-
  readr::read_csv("src/input.csv") %>%
  mutate(gr_id = as.character(gr_id)) %>%
  assertr::assert(is_uniq, gr_id)

ids <- src %>% pull(gr_id)


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

df %<>%
  inner_join(
    .,
    src,
    by = "gr_id"
  ) %>%
  select(
    gr_id,
    gr_title,
    gr_author,
    publication,
    language,
    gender,
    nationality,
    gr_pages,
    gr_ratings,
    gr_stars
  )


# write out results
write.csv(df, file = "results.csv", row.names = F)

