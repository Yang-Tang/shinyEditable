
#' Create an in-place editable input control
#'
#' @param inputId The `input` slot that will be used to access the value.
#' @param type Type of input. One of "text", "textarea", "select", "date",
#'   "checklist"
#' @param value Initial value.
#' @param options A list of general and input-type-dependent options for
#'   [X-editable](http://github.com/vitalets/x-editable). Details
#'   [here](http://vitalets.github.io/x-editable/docs.html#editable).
#'
#' @return An in-place editable input control that can be added to a UI definition.
#' @export
#'
#' @examples
#' editableInput("foo", "text", "bar")
#'
editableInput <- function(inputId, type, value = "", options = list()) {
  type <- match.arg(
    type,
    c("text",
      "textarea",
      "select",
      "date",
      "checklist")
  )

  element    <- buildElement(inputId, value)
  script     <- buildScript(inputId, type, options)
  dependency <- buildDependency()

  htmltools::tagList(element, script, dependency)

}


#' Change the value of an in-place editable  input on the client
#'
#' @param session The `session` object passed to function given to shinyServer.
#' @param inputId The id of the input object.
#' @param value The value to set for the input object.
#'
#' @export
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' ui <- fluidPage(
#'   editableInput("foo", "text", ""),
#'   actionButton("update", "Update"),
#'   verbatimTextOutput("bar")
#' )
#'
#' server <- function(input, output, session) {
#'   output$bar <- renderPrint(input$foo)
#'   observeEvent(input$update, {
#'     updateEditableInput(session, "foo", sample(month.abb, 1))
#'   })
#' }
#'
#' shinyApp(ui, server)
#'
#' }
updateEditableInput <- function(session, inputId, value = NULL) {
  message <- dropNulls(list(value = value))
  session$sendInputMessage(inputId, message)
}


