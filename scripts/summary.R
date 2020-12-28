library(spotifyr)
library(tidyverse)
library(knitr)
library(lubridate)
library(data.table)
library(forestmangr)

source("scripts/secret.R")
access_token <- get_spotify_access_token()

get_my_top_artists_or_tracks(type = 'artists', time_range = 'short_term', limit = 15) %>%
  select(name, genres) %>%
  rowwise %>%
  mutate(genres = paste(genres, collapse = ', ')) %>%
  ungroup %>%
  kable()


get_my_top_artists_or_tracks(type = 'tracks', time_range = 'short_term', limit = 5) %>%
  mutate(artist.name = map_chr(artists, function(x) x$name[1])) %>%
  select(name, artist.name, album.name) %>%
  kable()
