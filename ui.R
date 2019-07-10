####################################################################################
# R (Shiny)   user-interface program
# prog to plot interactive chart for cRCTs with varying baseline data
# R shiny app to accompany \"Cluster randomised trials with baseline data:sample size and optimal designs\" ,Copas and Hooper
# Author: Kevin McGrath
####################################################################################


#https://stackoverflow.com/questions/32969659/shiny-reactive-ggplot-output
#for ggplot
#http://zevross.com/blog/2014/08/04/beautiful-plotting-in-r-a-ggplot2-cheatsheet-3/


library(shiny)
library(ggplot2)
library(plotly)
library(shinyjs)
ui <- fluidPage(
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