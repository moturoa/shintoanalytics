library(shiny)
library(shintoanalytics)


ui <- fluidPage(
  browserInfoDependencies(),
  
  
  tags$h4("navigatorInfo"),
  verbatimTextOutput("nav_out"),
  
  tags$h4("bowser"),
  verbatimTextOutput("bowserInfo")

)

server <- function(input, output, session) {
  

  set_browser_info()
  

  output$nav_out <- renderPrint({
    input$navigatorInfo
  })
  
  output$bowserInfo <- renderPrint({
    input$bowserInfo
  })
  
  
}

shinyApp(ui, server)
