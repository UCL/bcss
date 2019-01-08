####################################################################################
# R (Shiny) prog to plot interactive chart for cRCTs with varying baseline data
# R shiny app to accompany \"Cluster randomised trials with baseline data:sample size and optimal designs\" ,Copas and Hooper
# Author: Kevin McGrath
####################################################################################

#NO tabs
#x axis proportion

#https://stackoverflow.com/questions/32969659/shiny-reactive-ggplot-output
#for ggplot
#http://zevross.com/blog/2014/08/04/beautiful-plotting-in-r-a-ggplot2-cheatsheet-3/


library(shiny)
library(ggplot2)
library(plotly)
library(shinyjs)
kmui <- fluidPage(
  titlePanel(title = h4("R shiny app to accompany \"Cluster randomised trials with baseline data:sample size and optimal designs\" ,Copas and Hooper")),
  sidebarPanel(
    sliderInput("WCC","autocorrelation:", min=0,max=1,step=0.005,value=0.9) ,
    
    
    sliderInput("rho","intra-correlation:", min=0,max=0.1,step=0.005,value=0.01) ) ,
  
  actionButton('reset', 'Clear file'),
  numericInput("n",
               "Number of subjects in each cluster-period, n:",
               min = 10,
               max=1000,
               step = 10,
               value = 200),
  
  numericInput("ytop",
               "Size of y-axis:",
               min = 0,
               max=10,
               step = 1,
               value = 2),
  
## adding select option
######################
  #conditionalPanel(condition="input.conditionedPanels==1",
               selectInput("select", label = ("What would you like to calculate?"), 
                         choices = list("prospective baseline data collection" = 1, 
                                      "retrospective baseline data collection" = 2), selected = 1),
  
  mainPanel(plotOutput("plot2"))
)

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
kmapp <- shinyApp(kmui, server) 

# below only for R standalone version (ie not Shiny)
#runApp(kmapp,host="0.0.0.0",port=5050)

