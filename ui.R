library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Miles Per Gallon Predictor"),
  
  sidebarPanel(
    
    p('Enter Values Here'),
    uiOutput("ui_cyl"),
    uiOutput("ui_disp"),
    uiOutput("ui_hp"),
    uiOutput("ui_drat"),
    uiOutput("ui_wt"),
    uiOutput("ui_qsec"),
    uiOutput("ui_vs"),
    uiOutput("ui_am"),
    uiOutput("ui_gear"),
    uiOutput("ui_carb"),
    br(),
    actionButton("predict", "Predict")
  ),
  
  mainPanel(
    
    tabsetPanel(
      tabPanel("Help", 
               h3("How to use this application"), 
               p("Select which variables to use in the 'Settings'-tab"),
               p("Make a decision on variable by using the 'View 
                 Correlations'-tab to determine which parameters correlate 
                 the most with mpg prediction."),
               p("Or de-select the variables that you do not have information for"),
               br(),
               p("Once you have selected the parameters to use, enter your values 
                  into the sidebar and press 'Predict' to have the predicted mpg 
                  displayed on the 'Predicted MPG'-tab.")
      ),
      tabPanel("View Correlations",
               p("Correlation plots between mpg and other parameters. Use this is help 
                  decide which parameters to use in predicting the mpg."),
               selectInput("cor_plot_select", "Parameter:", 
                           c("Number of cylinders" = "cyl", 
                             "Displacement (cu.in)" = "disp", 
                             "Gross horsepower" = "hp", 
                             "Rear axle ratio" = "drat", 
                             "Weight (lb/1000)" = "wt", 
                             "1/4 mile time" = "qsec", 
                             "Engine Type" = "vs", 
                             "Transmission (0 = automatic, 1 = manual)" = "am",
                             "Number of forward gears" = "gear",
                             "Number of carburetors" = "carb")),
               plotOutput("cor_plot")
      ),
      tabPanel("Predicted MPG", 
               p("Based on your entered values your predicted MPG is:"), 
               verbatimTextOutput("prediction"),
               br(),
               p("This was calculated by creating the following linear model,"),
               verbatimTextOutput("linear_model"),
               p(", and using the following values to predict the mpg:"),
               tableOutput("values")
      ),
      tabPanel("Settings", 
               checkboxInput("use_cyl", "Use number of cylinders", TRUE), 
               checkboxInput("use_disp", "Use displacement (cu.in)", TRUE),
               checkboxInput("use_hp", "Use gross horsepower ", TRUE),
               checkboxInput("use_drat", "Use rear axle ratio", TRUE),
               checkboxInput("use_wt", "Use Weight (lb/1000)", TRUE),
               checkboxInput("use_qsec", "Use 1/4 mile time", TRUE),
               checkboxInput("use_vs", "Use engine type", TRUE),
               checkboxInput("use_am", "Use transmission type", TRUE),
               checkboxInput("use_gear", "Use number of forward gears", TRUE),
               checkboxInput("use_carb", "Use number of carburetors ", TRUE)
      )
    )
  )
))