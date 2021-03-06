% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/actionbuttonUI.R
\name{actionButtonUI}
\alias{actionButtonUI}
\title{actionButtonUI}
\usage{
actionButtonUI(id,
  label = paste("Please provide a label argument to the actionButton",
  " with id = ", id, ".", sep = ""), icon = NULL, width = NULL,
  custom_css = NULL)
}
\arguments{
\item{id}{A unique string id for the action button. If your code is modularised,
remember to wrap the id with the relevant session namespace function, e.g.
numericValueUI(id = session$ns("someinput")).}

\item{icon}{An icon for the action button (see shiny::icon).}

\item{width}{The width of the shiny::numericValue UI element. Must be valid
css (i.e. '10\%' or '150px' will work).}

\item{custom_css}{If provided, the action button is wrapped in a div styled 
by the custom_css input. For example, one could provide 
custom_css = "display: inline-block;" to display the action button inline.}

\item{width}{The widths of the action buttons. Must be valid css.}
}
\description{
Wrapper around shiny::actionButton.
}
\examples{
if (interactive()) {
####################################################################
# Suppose we want an action button that increments a counter. We first 
# need to define UI and server-side logic for the button.
####################################################################
pacman::p_load_current_gh(c("kahaaga/shinymodules", "rstudio/shiny"))

# Function that displays the UI created server-side.
actionButtonTestUI <- function(id) {
  ns <- NS(id)
  uiOutput(ns("increment_btn")
}
# Server-side module that generates the action button.
actionButtonTest <- function(input, output, session) {
  output$increment_btn <- renderUI({
    shinymodules::actionButtonUI(
      id = session$ns("increment"),
      label = "Push me to increment counter"
    )
  })
}

ui <- fluidPage(
  # Let's suppose we have a page where we want the action button
  # to appear. Here we call the UI logic. We'll also add a textOutput 
  # showing the number of times the button has been clicked.
  fluidRow(actionButtonTestUI(id = "helppage"), textOutput("numclicks"))
)

server <- function(input, output, session) {
  # Call the module that generates the action button.
  callModule(module = actionButtonTest, id = "helppage")
  
  # The number of times the button has been clicked
  output$numclicks <- renderText({input[["helppage-increment-actionbutton"]]})
}

shinyApp(ui = ui, server = server)
}
}
