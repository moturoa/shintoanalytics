#' Load dependencies in the UI
#'@export
browserInfoDependencies <- function() {
  
  list(
    htmlDependency(name = "browserInfo-assets", version = "0.1",
                 package = "shintoanalytics",
                 src = "assets",
                 script = "navigatorInfo/navigatorInfo.js"
    ),
    htmlDependency(name = "bowser", version = "0.1",
                   package = "shintoanalytics",
                   src = "assets",
                   script = "bowser/bowser.min.js"
    )
  )
}

