if (interactive()) {
  # testing
  options(shiny.port = 8100)
  REDIRECT_URI <- 'http://localhost:8100/'
} else {
  # deployed URL
  REDIRECT_URI <- 'https://dhruvkaria.shinyapps.io/SpotifyTracker/'
}

auth_url <- GET('https://accounts.spotify.com/authorize',
                query = list(
                  client_id = Sys.getenv('99da33047a40447f85919d30b0dc3040'),
                  response_type = 'token',
                  redirect_uri = REDIRECT_URI,
                  scope = 'user-top-read'
                )) %>% .$url

login_js <- str_glue("shinyjs.login = function(callback) {
                    var url = '{{auth_url}}';
                     var parseResult = new DOMParser().parseFromString(url, 'text/html');
                     var parsedUrl = parseResult.documentElement.textContent;
                     window.location = parsedUrl;
                     };", .open = '{{', .close = '}}'
)

