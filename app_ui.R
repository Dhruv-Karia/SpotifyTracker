
#source("scripts/chart1.R")
page_one <- tabPanel(
  "Personality",
    mainPanel(
    textOutput(
        outputId = "topwords"
      )
    )
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

page_three <- tabPanel(
  "Top",
  mainPanel(
    textOutput(
      outputId = "get_top_artists"
    )
  )
)

ui <- fluidPage(
  useShinyjs(),
  extendShinyjs(text = login_js, functions = c("login")),
  material_card(id = 'login_button', depth = 5, align = 'center',
                actionButton('go', 'Log in with Spotify')),
  
  includeCSS("style.css"),
  navbarPage(
    "Spotify Tracker",
    page_one,
    page_two,
    page_three
  )
)