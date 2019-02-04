# R program converted from Shiny to output static report from the basreline data Shiny app
# K McGrath Jan 2019

library(ggplot2)
# input variables
 
# hard code input values here,  select=1 for prospective, 2 for retrospective plots
input <- data.frame(rho=0.1, WCC1=0.5,WCC2=0.9,n=200, n_retro=200,select=2,ytop=1.25)


# eq,eq9 for retrospective 
eq9<-function(x){ 1 - ((input$WCC1*input$WCC1*input$rho*input$rho*input$n_retro*input$n_retro*x)/((1+((input$n_retro-1)*input$rho))*(1+((((input$n_retro*x))-1)*input$rho)))) } 
eq <-function(x){ 1 - ((input$WCC2*input$WCC2*input$rho*input$rho*input$n_retro*input$n_retro*x)/((1+((input$n_retro-1)*input$rho))*(1+((((input$n_retro*x))-1)*input$rho)))) }
#try this for proportion it works!
eqprop9<-function(x){ (1-input$rho+(input$n*input$rho*(1-x)))*(1/(1-x))*(1-((input$WCC1*input$WCC1*input$rho*input$rho*input$n*input$n*x*(1-x))/((1+(((input$n*(1-x))-1)*input$rho))*(1+(((input$n*x)-1)*input$rho)))))/(1+((input$n-1)*input$rho)) }
eqprop<-function(x){ (1-input$rho+(input$n*input$rho*(1-x)))*(1/(1-x))*(1-((input$WCC2*input$WCC2*input$rho*input$rho*input$n*input$n*x*(1-x))/((1+(((input$n*(1-x))-1)*input$rho))*(1+(((input$n*x)-1)*input$rho)))))/(1+((input$n-1)*input$rho)) }


# access the values of the sliders
#output$value <-renderPrint({input$rho1}) 
#output$range <- renderPrint({ input$WCC })

#sizearg <- paste("size= ",input$n)
plot2 <- ({ if ( (input$select=="1") ) { 
  ggplot(data.frame(x=c(0,1)),aes(x=x))+ggtitle(paste("size=",input$n," ICC=",input$rho," WCC=",input$WCC1," ",input$WCC2))+
    theme(plot.title = element_text(face="plain",size=12),legend.position = "top",panel.background=element_blank(),axis.line = element_line(colour="black")) +xlab("Baseline data - proportion of total") + ylab("Proportionate change in clusters required") + #stat_function(fun=eq,geom="line",colour="red"  )+stat_function(fun=eq9,geom="line",colour="blue")+
    stat_function(fun=eqprop,geom="line",aes(colour="high WCC") )+stat_function(fun=eqprop9,geom="line",aes(colour="low WCC") )  +
    coord_cartesian(ylim=c(0.8,input$ytop)) + scale_colour_manual("", values = c("red", "blue"))  }                      
  else if ((input$select=="2") ) { 
    ggplot(data.frame(x=c(0,1)),aes(x=x))+ggtitle(paste("size =",input$n_retro,"ICC = ",input$rho,"WCC=",input$WCC1," ",input$WCC2))+
      theme(plot.title = element_text(face="plain"),panel.background=element_blank(),axis.line = element_line(colour="black"))+ xlab("Baseline data - ratio to main trial data") + ylab("Proportionate change in clusters required") + stat_function(fun=eq,geom="line",aes(colour="high WCC")  )+stat_function(fun=eq9,geom="line",aes(colour="low WCC"))+
      # stat_function(fun=eqprop,geom="line",colour="low WCC")+stat_function(fun=eqprop9,geom="line",colour="high WCC")  +
      coord_cartesian(ylim=c(0,input$ytop)) + scale_colour_manual("", values = c("green", "orange")) }
 }
) 

print(plot2)

#output the optimal point for prospective data , select = 1
outputtext_calc <- (  if (( input$select=="1")  )  {
  n <-input$n
  rho <-input$rho
  WCC1 <- input$WCC1
  WCC2 <- input$WCC2
 print( paste("Low WCC,Optimal (x,y) = (", round((n*rho*WCC1+rho-1)/(rho*n*(1+WCC1)),digits=4),",", round(eqprop(n*rho*WCC1+rho-1)/(rho*n*(1+WCC1)),digits=4),")  "))
 print( paste("High WCC,Optimal (x,y) = (", round((n*rho*WCC2+rho-1)/(rho*n*(1+WCC2)),digits=4),",", round(eqprop(n*rho*WCC2+rho-1)/(rho*n*(1+WCC2)),digits=4),")  "))} 
  ) 
outputtext_calc
