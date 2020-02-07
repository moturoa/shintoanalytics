library(shiny)
library(shintoanalytics)


db <- shinto_db_connection("shintoanalytics")


ui <- fluidPage(
  browserInfoDependencies(),
  
  
  
  fluidRow(
    column(6,
      tags$h4("navigatorInfo"),
      verbatimTextOutput("nav_out")  
    ),
    column(6,
           
        tags$h4("Log"),
        actionButton("btn_log", "Write log"),
        
        tags$h4("Response"),
        verbatimTextOutput("txt_out")
           
    )
    
  )
  
)

server <- function(input, output, session) {
  

  set_browser_info()
  
  onStop(function() {
    
    dbDisconnect(db)
    
  })  

  output$nav_out <- renderPrint({
    input$navigatorInfo
  })
  
  
  observeEvent(input$btn_log, {
    nav <- input$navigatorInfo
    req(nav)
    
    out <- shinto_write_user_login(user = "Remko",
                            application = "package_test",
                            version = "0.1",
                            db =  db,
                            nav = nav )
    output$txt_out <- renderPrint(out)
  })
  
  
}

shinyApp(ui, server)
