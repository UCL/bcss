![mrcctu logo](mrcctu.png)
# Sample size for cluster randomised trials with baseline data

This repository contains software to support the paper "Cluster randomised trials with baseline data: sample size and optimal designs" by Andrew Copas and Richard Hooper. 

The paper shows how to choose the extent of baseline data collection (as a proportion of the whole) under retrospective and prospective data collection.

The software provides interactive plots of relative efficiency against the extent of baseline data collection. The user may vary the sample size, cluster autocorrelation and intra-cluster correlation.

The software is provided in 
1. Stata, as program bcss (see folder "bcss")
2. an R Shiny app available at 
[Interactive charts](https://kmcgrath.shinyapps.io/Rprograms) (with source code in folder "R programs")

## Installation

the latest version of the package can be installed directly from github.com  using the Stata github command   

.github  install UCL/bcss

note: to install the github package within Stata need to run 

net install github, from("https://haghish.github.io/github/")

Alternatively 
From the Statistical Software Components (SSC) archive

.ssc install bcss


## Contact 

Dr Andrew J Copas1

London Hub for Trials Methodology Research

MRC Clinical Trials Unit at University College London

Dr Richard Hooper

Centre for Primary Care and Public Health,

Queen Mary University of London

1Address for correspondence:

90 High Holborn

London

WC1V 6LJ

a.copas@ucl.ac.uk

+44 20 7670 4888
