############################################################################################
# R program converted from Shiny to output static report from the baseline data Shiny app
# K McGrath Jan 2019
# updated  10 Jul 2019
# Note may be necessary to rerun the program if optimal data points do not appear on the lines    
############################################################################################


library(ggplot2)
# input variables



# in order to select prospective or retrospective
# hard code input values here,  select=1 for prospective, 2 for retrospective plots

# comment out respective line

#select=1 for prospective
#input <- data.frame(rho=0.05, WCC1=0.5,WCC2=0.9,n=200, select=1,ytop=1.25,ybot=0.4)
#select=2 for retrospective

for (select in c(1,2)) {
input <- data.frame(rho=0.05, WCC1=0.5,WCC2=0.9,n=200,select,ytop=1.25,ybot=0)


# eq,eq9 for retrospective 
eq9<-function(x){ 1 - ((input$WCC1*input$WCC1*input$rho*input$rho*input$n*input$n*x)/((1+((input$n-1)*input$rho))*(1+((((input$n*x))-1)*input$rho)))) } 
eq <-function(x){ 1 - ((input$WCC2*input$WCC2*input$rho*input$rho*input$n*input$n*x)/((1+((input$n-1)*input$rho))*(1+((((input$n*x))-1)*input$rho)))) }
#try this for proportion it works!
eqprop9<-function(x){ (1-input$rho+(input$n*input$rho*(1-x)))*(1/(1-x))*(1-((input$WCC1*input$WCC1*input$rho*input$rho*input$n*input$n*x*(1-x))/((1+(((input$n*(1-x))-1)*input$rho))*(1+(((input$n*x)-1)*input$rho)))))/(1+((input$n-1)*input$rho)) }
eqprop<-function(x){ (1-input$rho+(input$n*input$rho*(1-x)))*(1/(1-x))*(1-((input$WCC2*input$WCC2*input$rho*input$rho*input$n*input$n*x*(1-x))/((1+(((input$n*(1-x))-1)*input$rho))*(1+(((input$n*x)-1)*input$rho)))))/(1+((input$n-1)*input$rho)) }

#eqf <-function(x,pi){ 1 - ((pi*pi*input$rho*input$rho*input$n*input$n*x)/((1+((input$n-1)*input$rho))*(1+((((input$n*x))-1)*input$rho))))  } 
eqpropf<-function(x,pi){ (1-input$rho+(input$n*input$rho*(1-x)))*(1/(1-x))*(1-((pi*pi*input$rho*input$rho*input$n*input$n*x*(1-x))/((1+(((input$n*(1-x))-1)*input$rho))*(1+(((input$n*x)-1)*input$rho)))))/(1+((input$n-1)*input$rho)) }

#try titles
#labs(title=paste("size=",input$n," ICC=",input$rho," WCC=",input$WCC12)),
#     subtitle =paste("size=",input$n," ICC=",input$rho," WCC="," ",input$WCC2))"
#ggtitle(paste("size=",input$n," ICC=",input$rho," WCC=",input$WCC1," ",input$WCC2),subtitle=  )


#fromstackoverflow 44033011 , not work!
pi=c(input$WCC1,input$WCC2)
legends=paste0("pi= ",pi)
# prospective select =1 
plot2 <- ({ if ( (input$select=="1") ) { 
  ggplot(data.frame(x=c(0,0.5)),aes(x=x,colour=legends))+ggtitle(label=paste("total cluster size=",input$n," ICC=",input$rho))+ 
    theme(plot.title = element_text(face="plain",size=12,colour = "black"),plot.subtitle = element_text(colour = "red"),legend.position = "top",panel.background=element_blank(),axis.line = element_line(colour="black")) +xlab("Baseline data as proportion of total") + ylab("Proportionate change in clusters required") + #stat_function(fun=eq,geom="line",colour="red"  )+stat_function(fun=eq9,geom="line",colour="blue")+
    stat_function(fun=eqprop,geom="line",aes(colour=legends) )+stat_function(fun=eqprop9,geom="line",aes(colour=legends),colour="red" )  +
    coord_cartesian(ylim=c(input$ybot,input$ytop)) + scale_colour_manual("", values = c("red", "blue")) +geom_point(data=nedf,aes(x,y)) 
    }                      
# retrospective select = 2
   else if ((input$select=="2") ) { 
    ggplot(data.frame(x=c(0,1)),aes(x=x,colour=legends))+ggtitle(label=paste("endline cluster size =",input$n,"ICC = ",input$rho,"pi=",input$WCC1," ",input$WCC2))+
      theme(plot.title = element_text(face="plain",size=12,colour="black"),plot.subtitle = element_text(colour = "red"),legend.position = "top",panel.background=element_blank(),axis.line = element_line(colour="black"))+ xlab("Baseline data as a ratio to endline") + ylab("Proportionate change in clusters required") + 
       stat_function(fun=eq,geom="line",aes(colour=legends) )+stat_function(fun=eq9,geom="line",aes(colour=legends),colour="green")+
      # stat_function(fun=eqprop,geom="line",colour="low WCC")+stat_function(fun=eqprop9,geom="line",aes(colour="high WCC"))  +
      coord_cartesian(ylim=c(input$ybot,input$ytop)) + scale_colour_manual("", values = c("green", "orange")) }
 }
) 

print(plot2)

#output the optimal point for prospective data only  , select = 1
outputtext_calc <- (  if (( input$select=="1")  )  {
  n <-input$n
  rho <-input$rho
  WCC1 <- input$WCC1
  WCC2 <- input$WCC2
 print( paste("Low WCC,Optimal (x,y) = (", round((n*rho*WCC1+rho-1)/(rho*n*(1+WCC1)),digits=4),",", round(eqprop(n*rho*WCC1+rho-1)/(rho*n*(1+WCC1)),digits=4),")  "))
 print( paste("High WCC,Optimal (x,y) = (", round((n*rho*WCC2+rho-1)/(rho*n*(1+WCC2)),digits=4),",", round(eqprop(n*rho*WCC2+rho-1)/(rho*n*(1+WCC2)),digits=4),")  "))} 
  ) 
print(outputtext_calc)

# to use geom_point() need put optimal values into a data frame


if (( input$select=="1")  )  {
  Lopt_x = round((n*rho*WCC1+rho-1)/(rho*n*(1+WCC1)),digits=4)
  Lopt_y<- round(eqpropf(Lopt_x,input$WCC1),digits=4) 
  Hopt_x <-round((n*rho*WCC2+rho-1)/(rho*n*(1+WCC2)),digits=4)
  Hopt_y<-round(eqpropf(Hopt_x,input$WCC2),digits=4)   

 #If any of the x values are negative in order to prevent the plots showing negative x scale assign all the optimal x's and y's to zero.
  if ( Lopt_x<0  ) { 
    Lopt_x <-0
    Lopt_y=1}
  if (Hopt_x<0) {
    Hopt_x=0
    Hopt_y=1 }
  
#need to create data set to plot opt points on ggplot,as parameter to geom_point 
nedf <- data.frame("x"=c(Lopt_x,Hopt_x),"y"=c(Lopt_y,Hopt_y))
}

#end select
} 



