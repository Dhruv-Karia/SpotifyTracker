# Load libraries
library(shiny)
library(dplyr)
library(ggplot2)
library(tidyr)
library(scatterD3)
library(stringr)

# Source UI and server
source("app_ui.R")
source("app_server.R")

# Run shiny app
shinyApp(ui = ui, server = server)