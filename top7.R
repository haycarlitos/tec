dplyr::starwars

library(dplyr)

starwars %>% 
  filter(species == "Droid")

starwars %>% 
  select(name, ends_with("color"))

starwars %>% 
  mutate(name, bmi = mass / ((height / 100)  ^ 2)) %>%
  select(name:mass, bmi)

starwars %>% 
  arrange(desc(mass))

starwars %>%
  group_by(species) %>%
  summarise(
    n = n(),
    mass = mean(mass, na.rm = TRUE)
  ) %>%
  filter(
    n > 1,
    mass > 50
  )


library(plotly)



dist <- runif(50)

hist(dist)

plot_ly(x = ~dist, type = "histogram")




library(forecast)

qxts <- structure(list(y = ceiling(runif(n=100, min = 0, max = 9)),
                      date = seq(as.Date("2020/7/1"), as.Date("2021/1/1"), "day")[0:100]))

fit.xts <- splinef(qxts$y)
forecast_length <- 10
fore.xts <- forecast(fit.xts, h=forecast_length)


fore.dates <- seq(as.Date("2020/7/1"), as.Date("2021/1/1"), "day")[101:110]

p <- plot_ly() %>%
  add_lines(x = as.POSIXct(qxts$date, origin='2020-07-01'), y = qxts$y,
            color = I("black"), 
            name = "Real", 
            marker=list(mode='lines')) %>% 
  add_lines(x = fore.dates, y = ceiling(fore.xts$mean), color = I("blue"), name = "Predicción",) %>%
  add_lines(x = as.POSIXct(qxts$date, origin='2020-07-01'), y = fore.xts$fitted, line = list(color = I('blue'), width = 2, dash = 'dot'), name = "Ajuste") %>%
  add_ribbons(x = fore.dates, 
              ymin = ceiling(fore.xts$lower[, 2]), 
              ymax = ceiling(fore.xts$upper[, 2]),
              color = I("gray95"), 
              name = "95% confidence") %>%
  add_ribbons(p, 
              x = fore.dates, 
              ymin = ceiling(fore.xts$lower[, 1]), 
              ymax = ceiling(fore.xts$upper[, 1]),
              color = I("gray80"), name = "80% confidence")%>%
  layout(title = "Forecast Splines Cúbicos",
         showlegend = T,
         yaxis = list(showticklabels = T),
         xaxis = list(showticklabels = T, title = '', 
                      rangeslider = list(type = "date")))


p

fit.xts <- rwf(qxts$y)
forecast_length <- 10
fore.xts <- forecast(fit.xts, h=forecast_length)


fore.dates <- seq(as.Date("2020/7/1"), as.Date("2021/1/1"), "day")[101:110]

rw <- plot_ly() %>%
  add_lines(x = as.POSIXct(qxts$date, origin='2020-07-01'), y = qxts$y,
            color = I("black"), 
            name = "Real", 
            marker=list(mode='lines')) %>% 
  add_lines(x = fore.dates, y = ceiling(fore.xts$mean), color = I("blue"), name = "Predicción",) %>%
  add_lines(x = as.POSIXct(qxts$date, origin='2020-07-01'), y = fore.xts$fitted, line = list(color = I('blue'), width = 2, dash = 'dot'), name = "Ajuste") %>%
  add_ribbons(x = fore.dates, 
              ymin = ceiling(fore.xts$lower[, 2]), 
              ymax = ceiling(fore.xts$upper[, 2]),
              color = I("gray95"), 
              name = "95% confidence") %>%
  add_ribbons(p, 
              x = fore.dates, 
              ymin = ceiling(fore.xts$lower[, 1]), 
              ymax = ceiling(fore.xts$upper[, 1]),
              color = I("gray80"), name = "80% confidence")%>%
  layout(title = "Forecast RandomWalk",
         showlegend = T,
         yaxis = list(showticklabels = T),
         xaxis = list(showticklabels = T, title = '', 
                      rangeslider = list(type = "date")))


rw


library(shiny)

# Global variables can go here
n <- 200


# Define the UI
ui <- bootstrapPage(
  numericInput('n', 'Number of obs', n),
  plotOutput('plot')
)


# Define the server code
server <- function(input, output) {
  output$plot <- renderPlot(hist(runif(input$n)))
}

# Return a Shiny app object
shinyApp(ui = ui, server = server)



library(shinydashboard)

## app.R ##
library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody()
)

server <- function(input, output) { }

shinyApp(ui, server)




library(leaflet)

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")
m  # Print the map



# RMySQL
library(RMySQL)

db <- dbConnect(MySQL(),
                dbname = "apprecio",
                user = "root",
                host = "127.0.0.1",  
                port= 3306,
                password = "P4s.word")

res <- dbSendQuery(db, "SELECT * from comparador_brand;")
brands <- dbFetch(res, n = -1)

dbDisconnect(db)
