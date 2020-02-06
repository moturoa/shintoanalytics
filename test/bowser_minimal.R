library(shiny)

ui <- fluidPage(
  
  includeScript("https://cdnjs.cloudflare.com/ajax/libs/bowser/1.9.4/bowser.min.js"),
  
  actionButton("btn_test", "test", 
               onclick = "alert(JSON.stringify(bowser));")
  
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)
