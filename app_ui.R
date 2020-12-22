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
    "temp1"
  )

page_two <- 
  tabPanel(
    "temp2"
  )