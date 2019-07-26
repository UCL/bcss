# Shiny UI that contains header,sidebar for input controls and main area for output  
####################################################################################
# R (Shiny) prog to plot interactive chart for cRCTs with varying baseline data
# R shiny app to accompany \"Cluster randomised trials with baseline data:sample size and optimal designs\" ,Copas and Hooper
# Author: Kevin McGrath  
# this version 10 July 2019 
####################################################################################


#https://stackoverflow.com/questions/32969659/shiny-reactive-ggplot-output
#for ggplot
#http://zevross.com/blog/2014/08/04/beautiful-plotting-in-r-a-ggplot2-cheatsheet-3/


library(shiny)
library(ggplot2)

ui <- fluidPage(
 
  titlePanel(title = h4("R shiny app to accompany \"Cluster randomised trials with different numbers of measurements at baseline and endline:sample size and optimal designs\"   Copas and Hooper),
  ")) ,
  # https://shiny.rstudio.com/articles/html-tags.html
  # adding subtitle by using HTML - htmlnew div tag to the titlepanel as in above            
  tags$div(class="header", checked=NA,
       tags$em("The app displays the proportionate change in the number of clusters required for the trial due to collection of baseline data, which is either prospective (within the trial) or retrospective (collected before the trial and so not considered part of the trial sample size).")
       ),
  
  
  sidebarPanel(
    
    sliderInput("WCC","Range of autocorrelation, pi:", min=0,max=1,step=0.005,value=c(0.5,0.7)) ,
    
    selectInput("whichscale", label = ("Which scale would you like to use for ICC?"), 
                choices = list("0-0.1" = 1,"0.1-1" = 2), selected = 1),
    
    #only show this scale if scale1 chosen
    conditionalPanel(
      condition = "input.whichscale == '1'",
      sliderInput("rho1","Value of intra-cluster correlation, rho:", min=0,max=0.1,step=0.001,value=0.01)
    ),
    #only show this scale if scale2 chosen
    conditionalPanel(
      condition = "input.whichscale == '2'",
      sliderInput("rho2","Value of intra-cluster correlation, rho:", min=0.1,max=1,step=0.01,value=0.1)
    ),
    
    
    # Create table output
    #https://stackoverflow.com/questions/38372906/constrain-two-sliderinput-in-shiny-to-sum-to-100
    #mainPanel(tableOutput("restable")),
    
    #actionButton('reset', 'Clear file'),
    
    
    ## adding select option
    ######################
    #conditionalPanel(condition="input.conditionedPanels==1",
    selectInput("select", label = ("Is the baseline data collected prospectively or retrospectively?"), 
                choices = list("prospective baseline data collection" = 1, 
                               "retrospective baseline data collection" = 2), selected = 1),
    
    
    #only show this scale if prospective data chosen
    conditionalPanel(
      condition = "input.select == '1'",
      numericInput("n",
                   "total cluster size (baseline plus endline)",
                   min = 10,
                   max=1000,
                   step = 10,
                   value = 200),
      numericInput("ytop",
                   "Size of y-axis:",
                   min = 0,
                   max=10,
                   step = 0.1,
                   value = 2)),
       #only show this scale if retrospective data chosen
    conditionalPanel(
      condition = "input.select == '2'",
      numericInput("n_retro",
                   "cluster size - endline data",
                   min = 10,
                   max=1000,
                   step = 10,
                   value=200)  ),
   # radioButtons('format', 'Document format', c('PDF', 'HTML', 'Word'),
   #              inline = TRUE),
    downloadButton("report","download shiny Generate report") 
    ),
  #only show this scale if prospective data chosen
  
  #for debugging
  #  verbatimTextOutput("value"),
  # verbatimTextOutput("range"),
  
  #show the plot of the curves 
  mainPanel(plotOutput("plot2"), textOutput("text_calc"))
  
  ##mainPanel(tableOutput("restable"))
)
