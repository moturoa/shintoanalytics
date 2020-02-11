library(shiny)
library(shintoanalytics)






log_user_data_module <- function(input, output, session, user, application, version, write_db = TRUE){
  
  db <- shintoanalytics::shinto_db_connection("shintoanalytics")
  on.exit(dbDisconnect(db))
  
  session$sendCustomMessage("navigatorInfo", list(id = session$ns("navigatorInfo")))
  
  out <- reactiveVal()
  
  observe({
    nav <- input$navigatorInfo
    req(nav)
    
    if(write_db){
      
      if(!dbIsValid(db)){
        db <- shintoanalytics::shinto_db_connection("shintoanalytics")
      }
      
      out(
        shinto_write_user_login(user = user,
                                application = application,
                                version = version,
                                db =  db,
                                nav = nav )
      )
    }
    
    
  })
  
  
  
  return(list(nav = reactive(input$navigatorInfo), db_response = out))
  
}


log_user_data <- function(user, application, version, write_db = TRUE){
  
  navinfo <- callModule(log_user_data_module, 
                        id = "shintolabs", 
                        user = user,
                        application = application, 
                        version = version, 
                        write_db = write_db)
  return(navinfo)
}



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
  

  log_out <- log_user_data(user = "Remko", 
                           application = "testpackage", 
                           version = "0.0",
                           write_db = TRUE)
  
  output$nav_out <- renderPrint({
    log_out$nav()
  })
  
  output$txt_out <- renderPrint({
    log_out$db_response()
  })
  
 
   
}

shinyApp(ui, server)


