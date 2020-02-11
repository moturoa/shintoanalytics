
#' Main function to log user data and return browser/navigator/os info
#' @description Use in server function
#' @export 
log_user_data <- function(user, application, version, write_db = TRUE){
  
  navinfo <- callModule(log_user_data_module, 
                        id = "shintolabs", 
                        user = user,
                        application = application, 
                        version = version, 
                        write_db = write_db)
  return(navinfo)
}



# Module. Used by log_user_data(), not by user.
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