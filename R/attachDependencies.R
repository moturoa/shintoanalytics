#' Load dependencies in the UI
#'@export
browserInfoDependencies <- function() {
  htmlDependency(name = "browserInfo-assets", version = "0.1",
                 package = "shintoanalytics",
                 src = "assets",
                 script = "navigatorInfo/navigatorInfo.js"
  )
}


