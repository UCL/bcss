
<a href="https://www.ctu.mrc.ac.uk"><img src="mrcctu.png" width="400"/> <a href="https://www.ucl.ac.uk"><img src="ucl.png" width="355"/>


# Sample size for cluster randomised trials with baseline data
## bcss: Baseline data Cluster Sample Size
This repository contains software to support the paper "Cluster randomised trials with baseline data: sample size and optimal designs" by Andrew Copas and Richard Hooper  - currently pending publication in 'Statistics in Medicine'. 

The paper shows how to choose the extent of baseline data collection (as a proportion of the whole) under retrospective and prospective data collection.

The software provides interactive plots of relative efficiency against the extent of baseline data collection. The user may vary the sample size, cluster autocorrelation and intra-cluster correlation.

The software is provided as 
<ul>
<li><p>Stata ado program, bcss</p></li>    
<li><p>an R Shiny app available at [Interactive charts](https://kmcgrath.shinyapps.io/Rprograms) with source code in folder "R programs"</p></li>
</ul>  

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
