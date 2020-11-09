
#' Main function to log user data and return browser/navigator/os info
#' @description Use in server function
#' @export 
log_user_data <- function(user, application, version, write_db = TRUE, 
                          write_db_local = FALSE, file_config = "conf/config.yml"){
  
  navinfo <- callModule(log_user_data_module, 
                        id = "shintolabs", 
                        user = user,
                        application = application, 
                        version = version, 
                        write_db = write_db,
                        write_db_local = write_db_local,
                        file_config = file_config)
  return(navinfo)
}

#' Read navigator information and make available as a Shiny input
#' @description When run, input$navigatorInfo is created, a list with lots of info on your system, including
#' Shiny session clientdata (user, url, port, etc.), navigator info (window size, screen size, resolution), and browser
#' info (using bowser.js), version, and platform (win/mac/mobile etc.).
#' @param session The session object.
#' @export
get_navigator_info <- function(session = getDefaultReactiveDomain()){
  session$sendCustomMessage("navigatorInfo", list(id = session$ns("navigatorInfo")))
}


# Module. Used by log_user_data(), not by user.
log_user_data_module <- function(input, output, session, user, application, 
                                 version, write_db = TRUE, file_config = "conf/config.yml",
                                 write_db_local = FALSE){
  

  get_navigator_info(session)
  
  out <- reactiveVal()
  
  observeEvent(input$navigatorInfo, once = TRUE, {
    nav <- input$navigatorInfo
    req(nav)
    
    if(write_db){
      
      db <- shintoanalytics::shinto_db_connection("shintoanalytics", 
                                                  file = file_config)
      on.exit(dbDisconnect(db))
      
      # Niet schrijven als we in / bezig zijn (local)
      if(write_db_local || session$clientData$url_pathname != "/"){
        flog.info("Login data naar shintoanalytics gestuurd.", name = "shintoanalytics")
        out(
          shinto_write_user_login(user = user,
                                  application = application,
                                  version = version,
                                  db =  db,
                                  nav = nav )
        )
      } else {
        #flog.info("Lokale app  - Login data *niet* naar shintoanalytics gestuurd.", 
        #          name = "shintoanalytics")
      }
      
    }
    
    
  })
  
  
  
  return(list(nav = reactive(input$navigatorInfo), db_response = out))
  
}