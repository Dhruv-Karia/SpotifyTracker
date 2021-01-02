# Load libraries
library(shiny)
library(scatterD3)
library(stringr)
library(spotifyr)
library(devtools)
library(tidyverse)
library(data.table)
library(httr)
library(shinyjs)
library(shinymaterial)
library(curl)
library(DT)

# Source UI and server
source("app_ui.R")
source("app_server.R")

# Run shiny app
shinyApp(ui = ui, server = server)
