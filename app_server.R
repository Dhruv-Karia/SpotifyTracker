# Define server
server <- function(input, output) {
  
  # Create a scatter plot of Spotify data
  output$scatter <- renderScatterD3({
    source("scripts/chart2.R")
    varX <- eval(parse(text=paste0("tracks$", tolower(input$selectX))))
    varY <- eval(parse(text=paste0("tracks$", tolower(input$selectY))))
    plot <- scatterD3(
      x = varX, y = varY, point_opacity = 0.5, colors = c("1DB954", "#191414"),
      col_var = str_to_title(tracks$Explicit),
      xlab = str_to_title(input$selectX), ylab = str_to_title(input$selectY),
      axes_font_size = "160%", col_lab = "Explicit",
      tooltip_text = paste0("Track: ",
                            str_to_title(tracks$Track), "<br>",
                            input$selectX, ": ", varX, "<br>",
                            input$selectY, ": ", varY),
      click_callback = "function(id, index) {
                          if(id && typeof(Shiny) != 'undefined') {
                            Shiny.setInputValue('selected_point', index);
                          }
                        }"
    )
    return(plot)
  })
  
  output$click_selected <- renderText(
    paste0(
      "Clicked point: ",
      input$selected_point
      )
    )
  
  output$frame <- renderUI({
    song <- tags$iframe(src="https://open.spotify.com/embed/track/6Im9k8u9iIzKMrmV7BWtlF",
                           height=80, width=300, frameborder="0",
                           allowtransparency="true", allow="encrypted-media")
    return(song)
  })
  
  output$get_top_artists <- renderDataTable({
    source("scripts/summary.R")
    top1 <- datatable(top1)
    return(top1)
  })
  
  output$get_top_tracks <- renderDataTable({
    source("scripts/summary.R")
    return(top2)
  })
  
}