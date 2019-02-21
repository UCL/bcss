{smcl}
{* *! version 1.0 19 Feb 2019}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "Install command2" "ssc install command2"}{...}
{vieweralsosee "Help command2 (if installed)" "help command2"}{...}
{viewerjumpto "Syntax" "C:\ado\personal\b\bcss##syntax"}{...}
{viewerjumpto "Description" "C:\ado\personal\b\bcss##description"}{...}
{viewerjumpto "Options" "C:\ado\personal\b\bcss##options"}{...}
{viewerjumpto "Remarks" "C:\ado\personal\b\bcss##remarks"}{...}
{viewerjumpto "Examples" "C:\ado\personal\b\bcss##examples"}{...}
{title:Title}
{phang}
{bf:C:\ado\personal\b\bcss} {hline 2} a command to create graphs for baseline data cluster sample size (prospective or retrospective data collection)

{marker syntax}{...}
{title:Syntax}
{p 8 17 2}
{cmdab:C:\ado\personal\b\bcss}
[{cmd:,}
{it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt pi:list(numlist)}}  specifies the ranges of pi (cluster autocorrelation): the correlation between the underlying cluster population means at baseline and endline.

{pstd}
{p_end}
{synopt:{opt r:ho(#)}}  the the intra-cluster correlation (ICC).

{pstd}
{p_end}
{synopt:{opt pro:spective}}  specified when prospective baseline data collection is required.

{pstd}
{p_end}
{synopt:{opt t:otal(#)}}  the cluster size (n_b+n_e) when prospective data collection is selected, where n_b is the number of baseline measurements and n_e is the number of endline measurements from each cluster.

{pstd}
{p_end}
{synopt:{opt propx:axis(numlist min=2  max=2)}}  the min and max ranges of the x axis for prospecitve baseline data graphs (proportions).

{pstd}
{p_end}
{synopt:{opt propy:axis(numlist min=2  max=2)}}  the min and max ranges of the y axis for prospecitve baseline data graphs.

{pstd}
{p_end}
{synopt:{opt propys:tep(numlist max=1)}}  the step on the y axis for prospecitve baseline data graphs.

{pstd}
{p_end}
{synopt:{opt ret:rospective}}  specified when retrospective baseline data collection is required.

{pstd}
{p_end}
{synopt:{opt e:ndline(#)}}  the cluster size (n_e) when retrospective data collection is selected (i.e. the baseline data of size n_b is retrospective).

{pstd}
{p_end}
{synopt:{opt retx:axis(numlist min=2  max=2)}}  the min and max ranges of the x axis for retrospective baseline data graphs (ratios).

{pstd}
{p_end}
{synopt:{opt rety:axis(numlist min=2  max=2)}}  the min and max ranges of the y axis for retrospective baseline data graphs.

{pstd}
{p_end}
{synopt:{opt retys:tep(numlist max=1)}}  the step on the y axis for retrospective baseline data graphs.

{pstd}
{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}

{marker description}{...}
{title:Description}
{pstd}

{pstd}
 {cmd:bcss} displays graphs examining the impact of varying amount of prospective/retrospective baseline data collection on cluster sample size with
 different cluster autocorrelation and intra-cluster correlation values.

{pstd}
 The user must specify either prospective (and total) or retrospective (and endline) in the syntax for prospective or retrospective baseline data collection respectively.

{pstd}
 The x axes values on the prospective data graphs are proportions.

{pstd}
 The x axes values on the retrospective data graphs are ratios.

{pstd}
 The user can choose to change the graph axes, however if one axis range is specified then the corresponding axis must also be specified (e.g. if the user selects certain x axis values, then they must also select the corresponding y axis values).

{pstd}
 Theta opt is the optimum proportion of baseline measurements to maximise power, shown on the prospective data graphs as θ_opt=(mρπ+ρ-1)/[ρm(1+π) where m = "total" = n_b+n_e
 
{pstd}
 Please note that it is not advisable to set pi or rho at the boundary values (e.g. 1) for these graphical representations.



{marker examples}{...}
{title:Examples}
{pstd}

{pstd}
  bcss, pi(0.5 0.6 0.7) rho(0.01) pro total(200) propxaxis(0 0.5) propyaxis(1 1.25) propystep(0.05)

{pstd}
   bcss, pi(0.5 0.6 0.7) rho(0.01) ret endline(200) retxaxis(0 2) retyaxis(0 1) retystep(0.1)


{title:References}
{pstd}

{pstd}
Copas, A. and Hooper, H.  Cluster randomised trials with baseline data: sample size and optimal designs (ref)


{title:Author}
{p}

Ella Marley-Zagar, MRC Clinical Trials Unit, University College London.

Email {browse "mailto:e.marley-zagar@ucl.ac.uk":e.marley-zagar@ucl.ac.uk}


