library(spotifyr)
library(tidyverse)
library(lubridate)
library(knitr)

source("secret.R")
access_token <- get_spotify_access_token()

get_my_recently_played(limit = 25) %>% 
  mutate(artist.name = map_chr(track.artists, function(x) x$name[1]),
         played_at = as_datetime(played_at)) %>% 
  select(track.name, artist.name, track.album.name, played_at) %>% 
  kable()
