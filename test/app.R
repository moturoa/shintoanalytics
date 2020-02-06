library(shiny)
library(shintoanalytics)



# na executie checK
if(FALSE){
  
  
  db <- shinto_db_connection("shintoanalytics", file = "test/conf/config.yml")
  
  dbReadTable(db, "logins")
  dbDisconnect(db)
  
}

ui <- fluidPage(
  browserInfoDependencies(),
  
  tags$h4("Output"),
  verbatimTextOutput("txt_out")  ,
  actionButton("btn_test","browser()")
)

server <- function(input, output, session) {
  
  

  
  observeEvent(input$btn_test, browser())
  
  
  
  out <- reactiveVal()
  
  observe({
    set_browser_info()
    nav <- input$navigatorInfo
    req(nav)
    user <- "Remko"
    resp <- shinto_write_user_login(user = "Remko", 
                            application = "package_test", 
                            nav = nav)
    print("written")
    out(resp)
  })
  
  output$txt_out <- renderPrint(out())
  
}

shinyApp(ui, server)
