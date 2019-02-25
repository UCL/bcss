################################################################################### 
#server side  (ie the logic) program for Shiny 
# R (Shiny) prog to plot interactive chart for cRCTs with varying baseline data
# R shiny app to accompany \"Cluster randomised trials with baseline data:sample size and optimal designs\" ,Copas and Hooper
# Author: Kevin McGrath
####################################################################################

# https://stackoverflow.com/questions/38372906/constrain-two-sliderinput-in-shiny-to-sum-to-100


library(shiny)
library(ggplot2)
#library(plotly)
#library(shinyjs)

server <- function(input,output,session){
  
  
  # eq,eq9 for retrospective 
  eq9<-function(x){ 1 - ((input$WCC[1]*input$WCC[1]*input$rho1*input$rho1*input$n_retro*input$n_retro*x)/((1+((input$n_retro-1)*input$rho1))*(1+((((input$n_retro*x))-1)*input$rho1)))) } 
  eq <-function(x){ 1 - ((input$WCC[2]*input$WCC[2]*input$rho1*input$rho1*input$n_retro*input$n_retro*x)/((1+((input$n_retro-1)*input$rho1))*(1+((((input$n_retro*x))-1)*input$rho1)))) }
  #try this for proportion it works!
  eqprop9<-function(x){ (1-input$rho1+(input$n*input$rho1*(1-x)))*(1/(1-x))*(1-((input$WCC[1]*input$WCC[1]*input$rho1*input$rho1*input$n*input$n*x*(1-x))/((1+(((input$n*(1-x))-1)*input$rho1))*(1+(((input$n*x)-1)*input$rho1)))))/(1+((input$n-1)*input$rho1)) }
  eqprop<-function(x){ (1-input$rho1+(input$n*input$rho1*(1-x)))*(1/(1-x))*(1-((input$WCC[2]*input$WCC[2]*input$rho1*input$rho1*input$n*input$n*x*(1-x))/((1+(((input$n*(1-x))-1)*input$rho1))*(1+(((input$n*x)-1)*input$rho1)))))/(1+((input$n-1)*input$rho1)) }
  
# forscale 0.1 to 1  need to use rho2
  # eq,eq9 for retrospective 
  R2eq9<-function(x){ 1 - ((input$WCC[1]*input$WCC[1]*input$rho2*input$rho2*input$n_retro*input$n_retro*x)/((1+((input$n_retro-1)*input$rho2))*(1+((((input$n_retro*x))-1)*input$rho2)))) } 
  R2eq <-function(x){ 1 - ((input$WCC[2]*input$WCC[2]*input$rho2*input$rho2*input$n_retro*input$n_retro*x)/((1+((input$n_retro-1)*input$rho2))*(1+((((input$n_retro*x))-1)*input$rho2)))) }
  #try this for proportion it works!
  R2eqprop9<-function(x){ (1-input$rho2+(input$n*input$rho2*(1-x)))*(1/(1-x))*(1-((input$WCC[1]*input$WCC[1]*input$rho2*input$rho2*input$n*input$n*x*(1-x))/((1+(((input$n*(1-x))-1)*input$rho2))*(1+(((input$n*x)-1)*input$rho2)))))/(1+((input$n-1)*input$rho2)) }
  R2eqprop<-function(x){ (1-input$rho2+(input$n*input$rho2*(1-x)))*(1/(1-x))*(1-((input$WCC[2]*input$WCC[2]*input$rho2*input$rho2*input$n*input$n*x*(1-x))/((1+(((input$n*(1-x))-1)*input$rho2))*(1+(((input$n*x)-1)*input$rho2)))))/(1+((input$n-1)*input$rho2)) }
 
   
  
  
  #output$value <-renderPrint({input$rho1}) 
  output$range <- renderPrint({ input$WCC })
  
  # prospective is select==1
  output$plot2 <- renderPlot(
   { legends=paste0("pi= ",input$WCC)
   if ( (input$select=="1")   & (input$whichscale=="1") ) {  
      ggplot(data.frame(x=c(0,1)),aes(x=x,colour=legends))+ggtitle(paste("size=",input$n," ICC=",input$rho1," pi=",input$WCC[1]," ",input$WCC[2]))+
      theme(plot.title = element_text(face="plain",size=12),panel.background=element_blank(),axis.line = element_line(colour="black")) +xlab("Baseline data - proportion of total") + ylab("Proportionate change in clusters required") + 
      stat_function(fun=eqprop,geom="line",aes(colour=legends) )+stat_function(fun=eqprop9,geom="line",aes(colour=legends),colour="red" )  +
      coord_cartesian(ylim=c(0.5,input$ytop))  + scale_colour_manual("", values = c("red", "blue")) } #+geom_point(data=opt_dat,size=4 ) }                       
    else if (( input$select=="1") & (input$whichscale=="2") ) { 
    ggplot(data.frame(x=c(0,1)),aes(x=x,colour=legends))+ggtitle(paste("size=",input$n," ICC=",input$rho2," pi=",input$WCC[1]," ",input$WCC[2]))+
      theme(plot.title = element_text(face="plain",size=12),panel.background=element_blank(),axis.line = element_line(colour="black")) +xlab("Baseline data - proportion of total") + ylab("Proportionate change in clusters required") + 
      stat_function(fun=R2eqprop,geom="line",aes(colour=legends ))+stat_function(fun=R2eqprop9,geom="line",colour="red",aes(colour=legends) )  +
      coord_cartesian(ylim=c(0,input$ytop)) + scale_colour_manual("", values = c("red", "blue")) }                       
    else if ((input$select=="2") & (input$whichscale=="1")) { 
      ggplot(data.frame(x=c(0,1)),aes(x=x,colour=legends))+ggtitle(paste("size =",input$n_retro,"ICC = ",input$rho1,"pi=",input$WCC[1]," ",input$WCC[2]))+
        theme(plot.title = element_text(face="plain"),panel.background=element_blank(),axis.line = element_line(colour="black"))+ xlab("Baseline data - ratio to main trial data") + ylab("Proportionate change in clusters required") + stat_function(fun=eq,geom="line",aes(colour=legends)  )+stat_function(fun=eq9,geom="line",colour="green",aes(colour=legends))+
        coord_cartesian(ylim=c(0,input$ytop)) + scale_colour_manual("", values = c("green", "orange")) }
    else if ((input$select=="2") & (input$whichscale=="2")) {
      ggplot(data.frame(x=c(0,1)),aes(x=x,colour=legends))+ggtitle(paste("size =",input$n_retro,"ICC = ",input$rho2,"pi=",input$WCC[1]," ",input$WCC[2]))+
        theme(plot.title = element_text(face="plain"),panel.background=element_blank(),axis.line = element_line(colour="black"))+ xlab("Baseline data - ratio to main trial data") + ylab("Proportionate change in clusters required") + stat_function(fun=R2eq,geom="line",aes(colour=legends) )+stat_function(fun=R2eq9,geom="line",colour="green",aes(colour=legends))+
        coord_cartesian(ylim=c(0,input$ytop)) + scale_colour_manual("", values = c("green", "orange")) }
    }
    ) 


  
  
# for prospective, calculate optimal value of x, try 
# https://stackoverflow.com/questions/40997817/reactive-variables-in-shiny-for-later-calculations

  #output the optimal point for pospective data , select = 1
  output$text_calc <- renderText({  if (( input$select=="1") & ( input$whichscale=="1") )  {
     n <-input$n
     rho1 <-input$rho1
     WCC1 <- input$WCC[1]
     WCC2 <- input$WCC[2]
     opt_x <- round((n*rho1*WCC1+rho1-1)/(rho1*n*(1+WCC1)),digits=4)
     opt_y <- round(eqprop9(opt_x),digits=4)
     opt_x2 <- round((n*rho1*WCC2+rho1-1)/(rho1*n*(1+WCC2)),digits=4)
     opt_y2 <- round(eqprop(opt_x2),digits=4)
     paste("Optimal (x,y) = (", opt_x,",",opt_y," ), (", opt_x2,",",opt_y2," )")}   
     #paste("Optimal (x,y) = (", opt_x2,",",opt_y2," ),")  }
     #paste("Optimal (x,y) = (", round((n*rho1*WCC1+rho1-1)/(rho1*n*(1+WCC1)),digits=4),",", round(eqprop(n*rho1*WCC1+rho1-1)/(rho1*n*(1+WCC1)),digits=4),")  ")  
    #paste("Optimal (x,y) = (", round((n*rho1*WCC2+rho1-1)/(rho1*n*(1+WCC2)),digits=4),",", round(eqprop9(n*rho1*WCC2+rho1-1)/(rho1*n*(1+WCC2)),digits=4),")  ") } 
     else if (( input$select=="1") & ( input$whichscale=="2") ) {
      n <-input$n
      rho2 <-input$rho2
      WCC1 <- input$WCC[1]
      WCC2 <- input$WCC[2]
      opt_x <- round((n*rho2*WCC1+rho2-1)/(rho2*n*(1+WCC1)),digits=4)
      opt_y <- round(R2eqprop9(opt_x),digits=4)
      opt_x2 <- round((n*rho2*WCC2+rho2-1)/(rho2*n*(1+WCC2)),digits=4)
      opt_y2 <- round(R2eqprop(opt_x2),digits=4)
      paste("Optimal (x,y) = (", opt_x,",",opt_y," ), (", opt_x2,",",opt_y2," )")} 
      #paste("Optimal (x,y) = (", round((n*rho2*WCC+rho2-1)/(rho2*n*(1+WCC)),digits=4),",", round(eqprop(n*rho2*WCC+rho2-1)/(rho2*n*(1+WCC)),digits=4),")  ")  }
  }
  #render end below
 
   ) 
  
 }
        
  
#https://stackoverflow.com/questions/38917101/how-do-i-show-the-y-value-on-tooltip-while-hover-in-ggplot2
  #output$vals <- renderPrint({
   # hover <- input$plot_hover 
    ## print(str(hover)) # list
    #y <- nearPoints(iris, input$plot_hover)[input$var_y]
    #req(nrow(y) != 0)
    #y
    #})
  
#https://gitlab.com/snippets/16220
  

