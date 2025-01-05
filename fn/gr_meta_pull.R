gr_meta_pull <- function(id) {

  # target
  target <- paste0("https://www.goodreads.com/book/show/", id)
  
  
  # pull target
  html <- xml2::read_html(target)
          
  
  # data frame
  df <-
    tibble(
      gr_id      = id,
      gr_pages   = html %>% rvest::html_node("[class='FeaturedDetails']") %>% html_node("p:nth-child(1)") %>% html_text(.),
      gr_ratings = html %>% rvest::html_node("[class='RatingStatistics__meta']") %>% html_node("span:nth-child(1)") %>% html_text(.),
      gr_stars   = html %>% rvest::html_node("[class='RatingStatistics__rating']") %>% html_text(.)
    )
  
  df <-
    df %>%
    mutate_all(~ stringr::str_trim(.)) %>%
    mutate_at(c("gr_pages", "gr_ratings", "gr_stars"), ~ gsub("[^0-9.]", "", .)) %>%
    mutate_at(c("gr_pages", "gr_ratings", "gr_stars"), ~ as.numeric(.))
  
  
  # return
  return(df)

}
