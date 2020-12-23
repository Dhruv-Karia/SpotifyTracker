library(spotifyr)
library(tidyverse)
library(knitr)
library(lubridate)

source("secret.R")
access_token <- get_spotify_access_token()

recents <- get_my_recently_played(limit = 50) %>% 
  mutate(artist.name = map_chr(track.artists, function(x) x$name[1]),
         played_at = as_datetime(played_at)) %>%
  select(track.name, artist.name, track.album.name, played_at)


playlists <- get_my_playlists(limit = 50, offset = 0,
                 authorization = get_spotify_authorization_code(),
                 include_meta_info = FALSE)

get_track <- function(id)
{
  tracks <- get_playlist_tracks(id, fields = NULL, limit = 100,
                    offset = 0, market = NULL,
                    authorization = get_spotify_access_token(),
                    include_meta_info = FALSE)
}

all_tracks_list <- lapply(playlists$id, get_track)
all_tracks <- as.data.frame(do.call(rbind, all_tracks_list))

get_analysis <- function(track_id)
{
  analysis <- get_track_audio_features(track_id, 
                                       authorization = get_spotify_access_token())  
}

tracks_list <- lapply(all_tracks$track.id, get_analysis)
track_features <- as.data.frame(do.call(rbind, tracks_list))

total_tracks <- cbind(all_tracks, track_features)