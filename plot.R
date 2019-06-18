tab_plot <- tabPanel(
  
  'Plot'
  
  , radioButtons(
    'in_filter_current'
    , 'Current?'
    , c('All', 'Current', 'Former'))
  
  , tableOutput('out_agg_table')
  , plotOutput('out_avengers_plot')
)

expr_plot <- quote({

  if (input$in_filter_current == 'All') {
    tbl_filtered <- tbl_avengers
  } else {
    tbl_filtered <- tbl_avengers %>% 
      filter(`Current?` == ifelse(input$in_filter_current == 'Current', 'YES', 'NO'))
  }
  
  output$out_agg_table <- renderText({
    
    tbl_filtered %>% 
      count(Gender)
    
  })
  
  output$out_avengers_plot <- renderPlot({
    
    tbl_filtered %>% 
      ggplot(aes(Appearances, color = Gender)) +
      geom_density() +
      scale_x_log10()
    
  })
  
})
