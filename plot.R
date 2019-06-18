tab_plot <- tabPanel(
  
  'Plot'
  
  , radioButtons(
    'in_filter_current'
    , 'Current?'
    , c('All', 'Current', 'Former'))
  
  , plotOutput('out_avengers_plot')
)

expr_plot <- quote({

  output$out_avengers_plot <- renderPlot({
    
    if (input$in_filter_current == 'All') {
      tbl_plot <- tbl_avengers
    } else {
      tbl_plot <- tbl_avengers %>% 
        filter(`Current?` == ifelse(input$in_filter_current == 'Current', 'YES', 'NO'))
    }
    
    tbl_plot %>% 
      ggplot(aes(Appearances, color = Gender)) +
      geom_density() +
      scale_x_log10()
    
  })
  
})
