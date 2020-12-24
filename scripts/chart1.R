library(spotifyr)
library(tidyverse)
library(knitr)
library(lubridate)


source("scripts/secret.R")
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


summary <- summarize(total_tracks, danceability = mean(danceability),
                     energy = mean(energy),
                     speechiness = mean(speechiness), acousticness = mean(acousticness),
                     instrumentalness = mean(instrumentalness),
                     valence = mean(valence)) 

top3 <- abs(t(apply(summary[-1], 1, function(x) head(sort(-x), 3))))
top3_names <- colnames(top3)

words <- list()

for(i in 1:length(top3_names)){
  
  if("danceability" == top3_names[i])
  {
    words[[i]] <- "Dougie"
  }
  
  if("energy" == top3_names[i])
  {
    words[[i]] <- "Bubbly"
  }
  
  if("speechiness" == top3_names[i])
  {
    words[[i]] <- "Gangster"
  }
  
  if("acousticness" == top3_names[i])
  {
    words[[i]] <- "Natural"
  }
  
  if("instrumentalness" == top3_names[i])
  {
    words[[i]] <- "Word-Girl"
  }
  
  if("valence" == top3_names[i])
  {
    words[[i]] <- "On Cloud Nine"
  }
    
}