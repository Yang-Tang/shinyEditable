
buildDependency <- function() {

  jquery_dep <- htmltools::htmlDependency(
    name       = "jquery",
    version    = "1.12.4",
    src        = c(href = "shared"),
    script     = "jquery.min.js"
  )

  bs_dep <- htmltools::htmlDependency(
    name       = "bootstrap",
    version    = "3.3.7",
    src        = c(href = "shared/bootstrap"),
    script     = "js/bootstrap.min.js",
    stylesheet = "css/bootstrap.min.css"
  )

  editable_dep <- htmltools::htmlDependency(
    name       = "bootstrap-editable",
    version    = "1.5.0",
    src        = c(href = "//cdnjs.cloudflare.com/ajax/libs/x-editable/1.5.0/bootstrap3-editable"),
    script     = "js/bootstrap-editable.min.js",
    stylesheet = "css/bootstrap-editable.css"
  )

  shiny::addResourcePath(
    prefix = "shinyEditable",
    directoryPath = system.file("www", package = "shinyEditable")
  )
  editableInput_dep <- htmltools::htmlDependency(
    name       = "editableInput",
    version    = "0.1.0",
    src        = c(href = "shinyEditable"),
    script     = "editableInput.js"
  )

  htmltools::tagList(
    jquery_dep,
    bs_dep,
    editable_dep,
    editableInput_dep
  )
}

buildScript <- function(inputId, type, options) {
  options <- c(options, list(type = type, placement = "auto"))
  options <- jsonlite::toJSON(options, auto_unbox = TRUE, force = TRUE)
  selector <- sprintf("[id='%s']", inputId)
  js <- sprintf("$(\"%s\").editable(%s);", selector, options)
  htmltools::tags$script(js)
}

buildElement <- function(inputId, value) {
  htmltools::tags$a(
    id    = inputId,
    class = "shinyEditable-bound-input",
    value
  )
}

# Given a vector or list, drop all the NULL items in it
dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE=logical(1))]
}
