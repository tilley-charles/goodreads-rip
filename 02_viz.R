rm(list = ls())

# package declarations
library(assertr)
library(dplyr)
library(ggplot2)
library(magrittr)
library(readr)


# load data
df <- 
  inner_join(
    readr::read_csv("results.csv") %>%
      assertr::assert(is_uniq, gr_id),
    readr::read_csv("src/selection.csv") %>%
      assertr::assert(is_uniq, gr_id),
    by = "gr_id"
  ) %>%
  mutate(
    selection = as.factor(selection)
  )
  

# plot
gg <-
  df %>%
  ggplot(
    aes(
      x     = publication,
      y     = gr_ratings,
      color = selection
    )
  ) +
  geom_point(
    size = 4  
  ) +
  scale_y_continuous(
    trans  = "log10",
    labels = scales::label_comma()
  ) +
  scale_color_manual(
    values = c("#ff7f00", "#984ea3", "#4daf4a", "#377eb8", "#e41a1c")
  ) +
  labs(
    x     = "Publication year",
    y     = "Number of ratings",
    color = "Selection"
  ) +
  theme_bw() +
  theme(
    axis.title         = element_text(size = 11, colour = "black"),
    axis.text          = element_text(size = 11, colour = "black"),
    axis.line          = element_line(colour = "black"),
    legend.title       = element_text(size = 11, colour = "black"),
    legend.key.height  = unit(0.5, "cm"),
    legend.key.width   = unit(0.5, "cm"),
    legend.position    = "right",
    legend.text        = element_text(size = 10, colour = "black"),
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_line(size = 0.1, color = "gray88"),
    panel.grid.minor   = element_blank(),
    panel.border       = element_blank(),
    panel.background   = element_blank()
  )
  
