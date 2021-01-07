# goodreads-rip
Pull book metadata from goodreads

## Use
  - Update the goodreads IDs for books of interest in **src/input.csv**.
    - IDs are accessible in goodreads URLs: **https://www.goodreads.com/book/show/[ID]...**.
  - Run **driver.R** to return a data frame with:
    - ID
    - Title
    - Number of pages
    - Number of ratings
    - Star rating
