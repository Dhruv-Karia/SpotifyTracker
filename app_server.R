# Define server
server <- function(input, output) {
  
  # Create a scatter plot of Spotify data
  output$scatter <- renderScatterD3({
    source("scripts/chart2.R")
    varX <- eval(parse(text=paste0("tracks$", tolower(input$selectX))))
    varY <- eval(parse(text=paste0("tracks$", tolower(input$selectY))))
    plot <- scatterD3(
      x = varX, y = varY, point_opacity = 0.5, colors = c("#191414", "1DB954"),
      col_var = str_to_title(tracks$Explicit),
      xlab = str_to_title(input$selectX), ylab = str_to_title(input$selectY),
      axes_font_size = "160%", col_lab = "Explicit",
      tooltip_text = paste0("Track: ",
                           str_to_title(tracks$Track), "<br>",
                           input$selectX, ": ", varX, "<br>",
                           input$selectY, ": ", varY)
    )
    return(plot)
  })
  
  output$topwords <- renderText({
    source("scripts/chart1.R")
    return(paste0(words[[1]], ", ", words[[2]], ", ", words[[3]]))
  })
  
  output$get_top_artists<-renderDataTable({
    source("scripts/summary.R")
    return(top1)
  })
  
  output$get_top_tracks<-renderDataTable({
    source("scripts/summary.R")
    return(top2)
  })
  
}