library(quantmod, verbose = F)
load('cs.Rdata')

ui <- fluidPage(
    
    titlePanel("Case-Shiller Home Price Indices"),
    
    sidebarLayout(
        
        sidebarPanel(
            
            selectInput(inputId = 'city', label = 'Select a city:', choices = cities,
                        selected = 'Seattle')
            
        ),
        
        mainPanel(
            
            plotOutput(outputId = "tsPlot")
            
        )
    )
)

server <- function(input, output) {
    
    output$tsPlot <- renderPlot({
        
        plot(cs[[input$city]], main = paste('Seasonally Adjusted Case-Shiller Index for',
                                            input$city), ylim = c(0, 300))
        
    })
    
}

shinyApp(ui = ui, server = server)
