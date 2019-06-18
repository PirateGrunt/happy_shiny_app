library(shiny)
library(tidyverse)

tbl_avengers <- readr::read_csv('avengers.csv')

ui <- navbarPage(
  title = "Happy Shiny"
  , tabPanel(
    'Table'
    , tableOutput('out_avengers_table')
  )
  , tabPanel(
    'Plot'
    , plotOutput('out_avengers_plot')
  )
)

server <- function(input, output, session) {
  
  output$out_avengers_table <-  renderTable({
      tbl_avengers
    }
    , striped = TRUE
  )
  
  output$out_avengers_plot <- renderPlot({
    
    tbl_avengers %>% 
      ggplot(aes(Appearances, color = Gender)) +
      geom_density() +
      scale_x_log10()
    
  })
  
}

shinyApp(ui, server)
