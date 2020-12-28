# ScatterD3 Plot
source("scripts/chart1.R")

tracks <- total_tracks %>%
  select(track.name, track.artists, added_at, track.duration_ms, track.explicit,
         track.id, track.popularity, track.album.name, track.album.release_date,
         danceability, energy, key, loudness, mode, speechiness, acousticness,
         instrumentalness, valence, tempo, track.uri) %>%
  rename("Track" = track.name,"Artist(s)" = track.artists,
         "Date Added" = added_at, "Track Length" = track.duration_ms,
         "Explicit" = track.explicit, "ID" = track.id,
         "Popularity" = track.popularity, "Album" = track.album.name,
         "Release Date" = track.album.release_date) %>%
  distinct(Track, .keep_all = T)

droplist <- list("Danceability", "Energy", "Key", "Loudness", "Mode",
  "Speechiness", "Acousticness", "Instrumentalness", "Valence", "Tempo")
