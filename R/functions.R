#' Connect to shinto devpostgres02
#'@export
shinto_db_connection <- function(what = c("CBS","BRKdata","BAGdata","shintoanalytics"), file = "conf/config.yml"){
  
  what <- match.arg(what)
  conf <- config::get(what, file = file)
  
  dbConnect(RPostgres::Postgres(),
            dbname = conf$dbname,
            host = conf$dbhost,
            port = 5432,
            user = conf$dbuser,
            password = conf$dbpassword)  
}


#' Schema for logins table in shintoanalytics db
#'@export
logins_schema <- function(){
  tibble(
    id = character(),
    timestamp = integer(),
    application = character(),
    application_version = character(),
    user = character(),
    url_protocol = character(), 
    url_hostname = character(), 
    url_port = character(), 
    url_pathname = character(), 
    url_search = character(), 
    url_hash_initial = character(),
    url_hash = character(),
    pixelratio = character(),
    appCodeName = character(),
    appName = character(),
    appVersion = character(),
    cookieEnabled = character(),
    language = character(),
    onLine = character(),
    platform = character(),
    userAgent = character()
  )
}

#' WATCH OUT
clear_login_database <- function(){
  
  db <- shinto_db_connection("shintoanalytics")
  on.exit(dbDisconnect(db))
  
  so_schema <- logins_schema()
  
  # manual override :)
  if(FALSE){
    dbWriteTable(db, "logins", so_schema, overwrite = TRUE)  
  }
  
}


# geen export
add_logins_row <- function(object, db = NULL){
  
  if(is.null(db)){
    db <- shinto_db_connection("shintoanalytics")
    on.exit(dbDisconnect(db))
  }
  
  
  # Type convert: precies zoals logins_schema.
  scheme <- logins_schema()
  cls <- sapply(scheme, class)
  
  for(nm in names(object)){
    clas <- cls[nm]
    fun <- base::get(paste0("as.", clas))
    object[[nm]] <- fun(object[[nm]])
  }
  
  
  row <- as_tibble(object)
  response <- dbWriteTable(db, "logins", row, append = TRUE)
  
  return(response)
}


#' Schrijf user login data
#' Voor gebruik in een shiny app. Zet eerst 'nav' met shintobrowserinfo, vind user (via lokale get_user, bv.),
#' en geef naam van applicatie door.
#' @export
shinto_write_user_login <- function(user = "unknown", 
                                    application = "package_test", 
                                    version = "",
                                    db = NULL, 
                                    nav = NULL,
                                    session = getDefaultReactiveDomain()){
  
  obj <- list(
    id = uuid::UUIDgenerate(),
    timestamp = as.integer(Sys.time()),
    application = application,
    application_version = version,
    user = user  
  )
  
  clientdat <- shiny::reactiveValuesToList(session$clientData)
  if(!is.null(clientdat)){
    
    sessiondat <- clientdat[c("url_protocol",
                              "url_hostname",
                              "url_port",
                              "url_pathname",
                              "url_search",
                              "url_hash_initial",
                              "url_hash",
                              "pixelratio")]
    
    obj <- c(obj, sessiondat)
  }
  
  if(is.null(nav)){
    
    nav <- list(
      appCodeName = NA_character_,
      appName = NA_character_,
      appVersion = NA_character_,
      cookieEnabled = NA_character_,
      language = NA_character_,
      onLine = NA_character_,
      platform = NA_character_,
      userAgent = NA_character_
    )
    
  }
  
  object <- c(obj, nav)
  response <- add_logins_row(object, db)
  
  return(response)
}

#' Read (n) last login(s)
#'@export
last_logins <- function(n = 1, db = NULL){
  
  if(is.null(db)){
    db <- shinto_db_connection("shintoanalytics")
    on.exit(dbDisconnect(db))
  }
  
  tbl(db, "logins") %>%
    arrange(desc(timestamp)) %>%
    head(n) %>%
    collect
  
}


