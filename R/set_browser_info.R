#' Set the Shiny input value with browser info
#'@param id A list with browser info is assigned to input$id
#' @description Sets input$navigatorInfo
#'@export
set_browser_info <- function(id = "navigatorInfo", session =  getDefaultReactiveDomain()){
  
  session$sendCustomMessage("navigatorInfo", list(data = id))
  
}
