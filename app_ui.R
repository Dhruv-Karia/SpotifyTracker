

source("scripts/chart1.R")
page_one <- tabPanel(
  "Personality",
  tags$div(id = "adjectives",
           h1(words[[1]]),
           h1(words[[2]]),
           h1(words[[3]])),
  h2("Your favorite artists and tracks at the moment!"),
  DT::dataTableOutput("get_top_artists"),
  DT::dataTableOutput("get_top_tracks")
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
      ),
      htmlOutput("frame"),
      textOutput("click_selected")
    ), 
    mainPanel(
      scatterD3Output(
        outputId = "scatter"
      )
    )
  )
)


ui <- fluidPage(
  includeCSS("www/style.css"),
  navbarPage(
    "Spotify Tracker",
    page_one,
    page_two
  )
)