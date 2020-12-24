

page_one <- 
  tabPanel(
    "Spotify Wrapped"
    # Top 5 genres
    # Top 5 songs
    # Minutes listened in last 12 months
  )

source("scripts/chart2.R")
page_two <- tabPanel(
  "ScatterD3 Graph",
  sidebarLayout(
    sidebarPanel(
      h2("Customize graph:"),
      selectInput(
        inputId = "selectX",
        "X Axis Variable:",
        choices = droplist
      ),
      selectInput(
        inputId = "selectY",
        "Y Axis Variable:",
        choices = droplist,
        selected = "Energy"
      )
    ), 
    mainPanel(
      scatterD3Output(
        outputId = "scatter"
      )
    )
  )
)

ui <- fluidPage(
  source("style.css"),
  navbarPage(
    "Spotify Tracker",
    page_one,
    page_two
  )
)