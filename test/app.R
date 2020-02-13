library(shiny)
library(shintoanalytics)




ui <- fluidPage(
  
  shintoanalyticsDependencies(),
  
  fluidRow(
    column(6,
           tags$h4("navigatorInfo"),
           verbatimTextOutput("nav_out")  
    ),
    column(6,
           
           tags$h4("Response"),
           verbatimTextOutput("txt_out")
           
    )
    
  )
  
)

server <- function(input, output, session) {
  

  log_out <- shintoanalytics::log_user_data(user = "Remko", 
                           application = "testpackage", 
                           version = "0.0",
                           write_db = TRUE,
                           write_db_local = TRUE
                           )
  
  output$nav_out <- renderPrint({
    log_out$nav()
  })
  
  output$txt_out <- renderPrint({
    log_out$db_response()
  })
  
 
   
}

shinyApp(ui, server)


