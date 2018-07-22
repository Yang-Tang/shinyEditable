library(shiny)
library(shinyEditable)

ui <- fluidPage(
  editableInput("foo", "text", ""),
  actionButton("update", "Update"),
  verbatimTextOutput("bar")
)

server <- function(input, output, session) {
  output$bar <- renderPrint(input$foo)
  observeEvent(input$update, {
    updateEditableInput(session, "foo", sample(month.abb, 1))
  })
}

shinyApp(ui, server)
