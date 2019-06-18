library(shiny)
library(tidyverse)

source('table.R')
source('plot.R')

options(shiny.reactlog = TRUE) 

tbl_avengers <- readr::read_csv('avengers.csv')

ui <- navbarPage(
  title = "Happy Shiny"
  , tab_table
  , tab_plot
)

server <- function(input, output, session) {

  eval(expr_table)
  eval(expr_plot)
  
}

shinyApp(ui, server)
