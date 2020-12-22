ui <- fluidPage(
  source("style.css"),
  navbarPage(
    "Spotify Tracker",
    page_one,
    page_two
  )
)

page_one <- 
  tabPanel(
    "Spotify Wrapped"
    # Top 5 genres
    # Top 5 songs
    # Minutes listened in last 12 months
  )

page_two <- 
  tabPanel(
    "TempGraph"
    # scatterD3
  )