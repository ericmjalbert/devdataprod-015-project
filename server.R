library(shiny)
data(mtcars)

shinyServer(
  
  function(input, output) {

    
    # Predict MPG based on the event of the "predict" button being pressed
    predictText <- eventReactive(input$predict, {
      # Create linear model based on selected parameters from settings
      params <- vector()
      if (input$use_cyl == TRUE) params <- c(params, "cyl")
      if (input$use_disp == TRUE) params <- c(params, "disp")
      if (input$use_hp == TRUE) params <- c(params, "hp")
      if (input$use_drat == TRUE) params <- c(params, "drat")
      if (input$use_wt == TRUE) params <- c(params, "wt")
      if (input$use_qsec == TRUE) params <- c(params, "qsec")
      if (input$use_vs == TRUE) params <- c(params, "vs")
      if (input$use_am == TRUE) params <- c(params, "am")
      if (input$use_gear == TRUE) params <- c(params, "gear")
      if (input$use_carb == TRUE) params <- c(params, "carb")
      mpg_formula <- as.formula(paste( "mpg ~ ", paste(params, collapse = "+")))
      
      # Grab inputted parameter values to use for prediction
      input_vals <- data.frame(NA) # going to ignore this first point later....
      if (input$use_cyl == TRUE) input_vals$cyl <- input$cyl
      if (input$use_disp == TRUE) input_vals$disp <- input$disp
      if (input$use_hp == TRUE) input_vals$hp <- input$hp
      if (input$use_drat == TRUE) input_vals$drat <- input$drat
      if (input$use_wt == TRUE) input_vals$wt <- input$wt
      if (input$use_qsec == TRUE) input_vals$qsec <- input$qsec
      if (input$use_vs == TRUE) input_vals$vs <- as.numeric(input$vs)
      if (input$use_am == TRUE) input_vals$am <- as.numeric(input$am)
      if (input$use_gear == TRUE) input_vals$gear <- as.numeric(input$gear)
      if (input$use_carb == TRUE) input_vals$carb <- input$carb
      
      # Predict value using linear regression
      predict.lm( lm(mpg_formula, data = mtcars), input_vals[-1])
    })
    
    # linear model based on selected parameters
    linearModel <- eventReactive(input$predict, {
      params <- vector()
      if (input$use_cyl == TRUE) params <- c(params, "cyl")
      if (input$use_disp == TRUE) params <- c(params, "disp")
      if (input$use_hp == TRUE) params <- c(params, "hp")
      if (input$use_drat == TRUE) params <- c(params, "drat")
      if (input$use_wt == TRUE) params <- c(params, "wt")
      if (input$use_qsec == TRUE) params <- c(params, "qsec")
      if (input$use_vs == TRUE) params <- c(params, "vs")
      if (input$use_am == TRUE) params <- c(params, "am")
      if (input$use_gear == TRUE) params <- c(params, "gear")
      if (input$use_carb == TRUE) params <- c(params, "carb")
      as.formula(paste( "mpg ~ ", paste(params, collapse = "+")))
    })
    
    values_used <- eventReactive(input$predict, {
      input_vals <- data.frame(NA) # going to ignore this first point later....
      if (input$use_cyl == TRUE) input_vals$cyl <- input$cyl
      if (input$use_disp == TRUE) input_vals$disp <- input$disp
      if (input$use_hp == TRUE) input_vals$hp <- input$hp
      if (input$use_drat == TRUE) input_vals$drat <- input$drat
      if (input$use_wt == TRUE) input_vals$wt <- input$wt
      if (input$use_qsec == TRUE) input_vals$qsec <- input$qsec
      if (input$use_vs == TRUE) input_vals$vs <- as.numeric(input$vs)
      if (input$use_am == TRUE) input_vals$am <- as.numeric(input$am)
      if (input$use_gear == TRUE) input_vals$gear <- as.numeric(input$gear)
      if (input$use_carb == TRUE) input_vals$carb <- input$carb
      input_vals[-1]
    })
      

    # Print the output when the predictText value changes
    output$prediction <- renderPrint({ predictText() })
    output$linear_model <- renderPrint({ linearModel() })
    output$values <- renderTable({ values_used() })
    
    # Correlation plots
    output$cor_plot <- renderPlot({
      if(input$cor_plot_select == "cyl")
        plot(mtcars$cyl, mtcars$mpg, xlab = "Number of Cylinders", ylab = "MPG")
      if(input$cor_plot_select == "disp")
        plot(mtcars$disp, mtcars$mpg, xlab = "Displacement (cu.in)", ylab = "MPG")
      if(input$cor_plot_select == "hp")
        plot(mtcars$hp, mtcars$mpg, xlab = "Gross Horsepower", ylab = "MPG")
      if(input$cor_plot_select == "drat")
        plot(mtcars$drat, mtcars$mpg, xlab = "Rear Axle Ratio", ylab = "MPG")
      if(input$cor_plot_select == "wt")
        plot(mtcars$wt, mtcars$mpg, xlab = "Weight (lb/1000)", ylab = "MPG")
      if(input$cor_plot_select == "qsec")
        plot(mtcars$qsec, mtcars$mpg, xlab = "1/4 Mile Time", ylab = "MPG")
      if(input$cor_plot_select == "vs")
        plot(mtcars$vs, mtcars$mpg, xlab = "Engine Type (0 = V Engine, 1 = Straight Engine)", ylab = "MPG")
      if(input$cor_plot_select == "am")
        plot(mtcars$am, mtcars$mpg, xlab = "Transmission (0 = auto, 1 = manual)", ylab = "MPG")
      if(input$cor_plot_select == "gear")
        plot(mtcars$gear, mtcars$mpg, xlab = "Number of forward gears", ylab = "MPG")
      if(input$cor_plot_select == "carb")
        plot(mtcars$carb, mtcars$mpg, xlab = "Number of carburetors", ylab = "MPG")
    })
      
    
    # Sidebar UI based on setting selections
    
      output$ui_cyl <- renderUI({
        if(input$use_cyl == TRUE) {
          sliderInput("cyl", "Number of Cylinders", min = 4, max = 8, value = 6, step=1)
        }
      })
      output$ui_disp <- renderUI({
        if(input$use_disp == TRUE) {
          sliderInput("disp", "Displacement (cu.in.)", min = 50, max = 500, value = 200, step = 0.1)
        }
      })
      output$ui_hp <- renderUI({
        if(input$use_hp == TRUE) {
          sliderInput("hp", "Gross horsepower", min = 40, max = 400, value = 125, step = 0.1)
        }
      })
      output$ui_drat <- renderUI({
        if(input$use_drat == TRUE) {
          sliderInput("drat", "Rear axle ratio", min = 2, max = 5, value = 3.5, step = 0.05)
        }
      })
      output$ui_wt <- renderUI({
        if(input$use_wt == TRUE) {
          sliderInput("wt", "Weight (1000 lbs)", min = 0.5, max = 7, value = 3, step = 0.05)
        }
      })
      output$ui_qsec <- renderUI({
        if(input$use_qsec == TRUE) {
          sliderInput("qsec", "1/4 mile time", min = 10, max = 30, value = 17, step = 0.1)
        }
      })
      output$ui_vs <- renderUI({
        if(input$use_vs == TRUE) {
          radioButtons("vs", label = "Engine Type", 
                       choices = list("V Engine" = 0, "Straight Engine" = 1),
                       selected = 0)
        }
      })
      output$ui_am <- renderUI({
        if(input$use_am == TRUE) {
          radioButtons("am", label = "Transmission",
                       choices = list("Automatic" = 0, "Manual" = 1), 
                       selected = 1)
        }
      })
      output$ui_gear <- renderUI({
        if(input$use_gear == TRUE) {
          selectInput("gear", label = "Number of forward gears", 
                      choices = list("3-gears" = 3, "4-gears" = 4, "5-gears" = 5), 
                      selected = 4)
        }
      })
      output$ui_carb <- renderUI({
        if(input$use_carb == TRUE) {
          sliderInput("carb", "Number of carburetors", min = 1, max = 8, value = 2, step = 1)
        }
      })
  }
  
)