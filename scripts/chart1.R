library(spotifyr)
library(tidyverse)
library(knitr)
library(lubridate)
library(data.table)
library(forestmangr)

source("scripts/secret.R")
access_token <- get_spotify_access_token()

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

if(nrow(all_tracks) > 500){
  all_tracks <- all_tracks[sample(nrow(all_tracks), 500), ]
}


get_analysis <- function(track_id)
{
  analysis <- get_track_audio_features(track_id, 
                                       authorization = get_spotify_access_token())  
}

tracks_list <- lapply(all_tracks$track.id, get_analysis)
#track_features <- as.data.frame(do.call(rbind, tracks_list))
track_features <- rbindlist(tracks_list, fill = TRUE, idcol = T)


total_tracks <- cbind(all_tracks, track_features)


summary <- summarize(total_tracks, danceability = mean(danceability, na.rm=TRUE),
                     energy = mean(energy, na.rm=TRUE),
                     speechiness = mean(speechiness, na.rm=TRUE), acousticness = mean(acousticness, na.rm=TRUE),
                     instrumentalness = mean(instrumentalness, na.rm=TRUE),
                     valence = mean(valence, na.rm=TRUE)) 

top3 <- (summary[,order(-summary[nrow(summary),])])[1:3]
top3_names <- colnames(top3)
top3_rounded <- round_df(top3, 1, rf = "round")

words_df <- read.csv(file = 'scripts/data/words_df.csv')

words <- list()
for(i in 1:length(top3_names))
{
  totalwords <- words_df %>%
    select(X, top3_names[i]) %>%
    filter(X == top3_rounded[1,i])
  
  words[[i]] <- totalwords[1,2]
}