library(shiny) #liberando o pacote shiby

ui <- fluidPage( #Responsável pela a parte visivel do arquivo
  titlePanel("Gráfico de números aleatórios"), #titulo
  sidebarLayout( #Estrutura de grid
    sidebarPanel( #Menu
      selectInput("inicio", "Selecione um modelo de destribuição",
                  choices = c ("Normal", "Uniforme", "Exponencial")),
      numericInput("num", "Defina a validação dos numeros",
                   min = 10, max = 10000, value = 20),
      textInput("text", "Defina o título do Histogrma"),
      sliderInput("totalNum", "Quantos números devem ser exibidos?", 
                  min = 10, max = 1000, value = 20, step = 20)
    ),
    mainPanel( #Gráfico e números
      plotOutput("hist"),
      verbatimTextOutput("numeros")
    )
  ),
  
)

server <- function(input, output) { #Responsável pela lógica

  x <-  reactive({ #Garantia de gerar numeros aleatorios
    switch (input$inicio, 
            "Normal" = rnorm(input$num),
            "Uniforme" = runif(input$num),
            "Exponencial" = rexp(input$num))
    
  })
  
  #Histograma:
  output$hist <- renderPlot({
    hist(x(), main= input$text)
  })
  
  #Números:
  output$numeros <- renderPrint({
    head(x(), input$totalNum)
  })
}

shinyApp(ui = ui, server = server) #Responsável por fazer o UI e o SERVE funcionar
