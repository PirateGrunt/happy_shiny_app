str_db_filename <- 'votes.csv'

db_updated <- function() {
  if (file.exists(str_db_filename))
    file.info(str_db_filename)$mtime[1]
  else
    ""
}

avengers <- tbl_avengers$`Name/Alias` %>% unique() %>% sort()

tab_vote <- tabPanel(
    'Vote'
  , selectInput('in_vote', 'Select your favorite Avenger!', avengers)
  , actionButton('btn_vote', 'Vote!')
  , tableOutput('out_vote_table')
  , plotOutput('out_vote_plot')
  
)

expr_vote <- quote({
  
  observeEvent(input$btn_vote, {
    
    tibble(
      avenger = input$in_vote
      , voted = Sys.time()
    ) %>% 
      write_csv(str_db_filename, append = file.exists(str_db_filename))

  })
  
  tbl_votes <- reactivePoll(
    100
    , session
    , checkFunc = db_updated
    , valueFunc = function() {
      
        if (file.exists(str_db_filename)) {
          read_csv(str_db_filename)
        } else {
          NULL
        }
    
      }
  )
  
  output$out_vote_table <- renderTable({
    validate(
      need(!is.null(tbl_votes()), 'No one has voted yet')
    )
    
    tbl_votes() %>% 
      count(avenger)
  })
  
  output$out_vote_plot <- renderPlot({
    
    validate(
      need(!is.null(tbl_votes()), 'No one has voted yet')
    )
    
    tbl_votes() %>% 
      ggplot(aes(avenger)) + 
      geom_bar()
  })
  
})