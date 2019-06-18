library(shiny)
library(tidyverse)

source('table.R')
source('plot.R')
source('vote.R')

options(shiny.reactlog = TRUE) 

tbl_avengers <- readr::read_csv('avengers.csv')

ui <- navbarPage(
  title = "Happy Shiny"
  , tab_table
  , tab_plot
  , tab_vote
)

server <- function(input, output, session) {

  eval(expr_table)
  eval(expr_plot)
  eval(expr_vote)
  
}

shinyApp(ui, server)
