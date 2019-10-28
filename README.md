<a href ="https://www.ctu.mrc.ac.uk/"><img src="MRCCTU_at_UCL_Logo.png" width="50%" /></a>

# Sample size for cluster randomised trials with baseline data
## bcss: Baseline data Cluster Sample Size
This repository contains software to support the paper Copas AJ and Hooper R "Cluster randomised trials with different numbers of measurements at baseline and endline: Sample size and optimal allocation". *Clinical Trials* https://journals.sagepub.com/doi/full/10.1177/1740774519873888. 

The paper shows how to choose the extent of baseline data collection (as a proportion of the whole) under retrospective and prospective data collection.

The software provides interactive plots of relative efficiency against the extent of baseline data collection. The user may vary the sample size, cluster autocorrelation and intra-cluster correlation.

The software is provided as 

1. Stata ado program, bcss   
2. an R Shiny app available at [interactive charts](https://kmcgrath.shinyapps.io/Rprograms) with source code in folder "R programs"  

## Installation

the latest version of the package can be installed directly from github.com  using the Stata github command   

.github  install UCL/bcss

(note: to install the github package within Stata need to run
'net install github, from("https://haghish.github.io/github/")' )

Alternatively to install bcss 
from the Statistical Software Components (SSC) archive using the Stata command ssc

.ssc install bcss


## Contact 

Dr Andrew J Copas<sup>1</sup>

London Hub for Trials Methodology Research

MRC Clinical Trials Unit at University College London

Dr Richard Hooper

Centre for Primary Care and Public Health,

Queen Mary University of London

<sup>1</sup>Address for correspondence:

90 High Holborn

London

WC1V 6LJ

a.copas@ucl.ac.uk

+44 20 7670 4888
