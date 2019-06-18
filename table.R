tab_table <- tabPanel(
  'Table'
  , tableOutput('out_avengers_table')
)

expr_table <- quote({
  
  output$out_avengers_table <-  renderTable({
      
      tbl_avengers
    
    }
    , striped = TRUE
  )
  
  
})