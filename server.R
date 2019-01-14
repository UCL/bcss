
library(shiny)
library(ggplot2)
library(plotly)
library(shinyjs)

server <- function(input,output){
  
  
  eq9<-function(x){ 1 - ((input$WCC*input$WCC*input$rho*input$rho*input$n*input$n*x)/((1+((input$n-1)*input$rho))*(1+((((input$n*x))-1)*input$rho)))) } 
  eq <-function(x){ 1 - ((0.5*0.5*input$rho*input$rho*input$n*input$n*x)/((1+((input$n-1)*input$rho))*(1+((((input$n*x))-1)*input$rho)))) }
  #try this for proportion it works!
  eqprop9<-function(x){ (1-input$rho+(input$n*input$rho*(1-x)))*(1/(1-x))*(1-((input$WCC*input$WCC*input$rho*input$rho*input$n*input$n*x*(1-x))/((1+(((input$n*(1-x))-1)*input$rho))*(1+(((input$n*x)-1)*input$rho)))))/(1+((input$n-1)*input$rho)) }
  eqprop<-function(x){ (1-input$rho+(input$n*input$rho*(1-x)))*(1/(1-x))*(1-((0.5*0.5*input$rho*input$rho*input$n*input$n*x*(1-x))/((1+(((input$n*(1-x))-1)*input$rho))*(1+(((input$n*x)-1)*input$rho)))))/(1+((input$n-1)*input$rho)) }
  
  # Rat fun as baseline in paper
  
  #  eqRat9<-function(x){( 1 - input$rho+(input$n*input$rho*(1-x)))*(1/(1-x))*(1-input$WCC*input$WCC*input$rho*input$rho*input$n*input$n*x*(1-x))/((1+(((input$n*(1-x))-1)*input$rho))*(1+(((input$n*x)-1)*input$rho)))))/(1+((input$n-1)*input$rho)) }
  
  
  # wrongeqRat <-function(x){ 1 - ((0.5*0.5*input$rho*input$rho*input$n*input$n*x)/((1+((input$n-1)*input$rho))*(1+((((input$n*x))-1)*input$rho)))) }   
  
  #sizearg <- paste("size= ",input$n)
  output$plot2 <- renderPlot({ if ( input$select=="1") { 
    ggplot(data.frame(x=c(0,2)),aes(x=x))+ggtitle(paste("size=",input$n," ICC=",input$rho," WCC=",input$WCC))+
      theme(plot.title = element_text(face="plain",size=12),legend.position = "top") +xlab("Baseline data - proportion of total") + ylab("Proportionate change in clusters required") + #stat_function(fun=eq,geom="line",colour="red"  )+stat_function(fun=eq9,geom="line",colour="blue")+
      stat_function(fun=eqprop,geom="line",aes(colour="0.5"))+stat_function(fun=eqprop9,geom="line",aes(colour=" "))  +
      coord_cartesian(ylim=c(0,input$ytop)) + scale_colour_manual("WCC",values=c("green","orange")) }                       
    #ggplotly(p_eq) }
    else if (input$select=="2") { 
      ggplot(data.frame(x=c(0,2)),aes(x=x))+ggtitle(paste("size =",input$n,"ICC = ",input$rho))+
        theme(plot.title = element_text(face="bold"))+ xlab("Baseline data - ratio to main trial data") + ylab("Proportionate change in clusters required") + stat_function(fun=eq,geom="line",colour="red"  )+stat_function(fun=eq9,geom="line",colour="blue")+
        # stat_function(fun=eqprop,geom="line",colour="green")+stat_function(fun=eqprop9,geom="line",colour="orange")  +
        coord_cartesian(ylim=c(0,input$ytop))
    } 
    
    #  coord_cartesian(ylim=c(0,input$ytop)) scale_colour_manual("WCC",values=c("green","orange")) }
    
    # output$plot2 <- renderPlot({
    #    ggplot(data.frame(x=c(0,12)),aes(x=x))+ggtitle("Proportionate change #clusters required by ratio additional baseline to endline data")+ xlab("Baseline data - ratio to main trial data") + ylab("Proportionate change in clusters required") + stat_function(fun=eq,geom="line",colour="red"  )+stat_function(fun=eq9,geom="line",colour="blue")+
    #      stat_function(fun=eqprop,geom="line",colour="green")+stat_function(fun=eqprop9,geom="line",colour="orange")  +
    #      coord_cartesian(ylim=c(0,input$ytop))
    
    
  })
  
}