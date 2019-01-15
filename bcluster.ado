*! version 1.0.0 EMZ 08jan2019
* m: cluster size, m=n_b+n_e (page 5), m=n_b+n_m, (pg 14)
* n: cluster size (n_b+n_e) Appendix D
* Rho is the intra-cluster correlation (ICC)
* pi: cluster autocorrelation, the correlation between the underlying cluster population means at baseline and endline (Appendix D)
* Note from paper: "small cluster size (n_e) of 50 and large of 200, and low ICC ρ=0.01 and high ρ=0.05"
* θ_opt=(mρπ+ρ-1)/[ρm(1+π)]   (x value on graph)
* generate plots to examine the impact of varying amount of prospective/retrospective baseline data collection. 

capture program drop bcluster
program define bcluster, rclass
version 15
syntax , N(integer) Rho(real) M(integer) Pilist(numlist) [PROspective RETrospective]
* Kevin test edit

* Range checks
****************

* pi
numlist "`pilist'", sort
local n_pi : word count `pilist'
local minpi : word 1 of `r(numlist)'
local maxpi : word `n_pi' of `r(numlist)'

if `minpi'<0 | `maxpi'>1 & `maxpi'!=. { 
	di as err "pi is out of range"
	exit 198
}


* n
//if `n'<0 | `n'>1000 & `n'!=. { 
if `n'<0 | `n'>1000000 & `n'!=. { 
	di as err "n is out of range"
	exit 198
}

* rho
if `rho'<0 | `rho'>0.1 & `rho'!=. { 
	di as err "rho is out of range"
	exit 198
}

*m
//if `m'<0 | `m'>1000 & `m'!=. { 
if `m'<0 | `m'>1000000 & `m'!=. { 
	di as err "m is out of range"
	exit 198
}


//determine what type of graph the user is wanting to compute
		
	local type = 0 			// type identifies whether prospective (1) or retrospective (2) or nothing (0) was selected
	if  "`prospective'" ~= "" & "`retrospective'" ~= "" {
	
         di as error "Either pro *or* ret must be specified, for prospective or retrospective baseine data respectively."
	     exit 198
}
	else if "`prospective'" ~= "" {
		local type = 1
	}
	else if "`retrospective'" ~= "" {
		local type = 2
	}
	
	
if `type' == 0 {

di as error "Either pro or ret must be specified, for prospective or retrospective baseine data respectively."
exit 198
}
	
else if `type' == 1 {					// prospective
	
clear all
set more off
set scheme s1color 

****************
* FIRST GRAPH
****************


local graph_n 1
	
     foreach pi of local pilist {
	 
        local graph_nplus1 = `graph_n'+1
		local graph_colour = `graph_n'+11
	 
	 // make theta opt and corresponding y-value
		local theta_opt`graph_n' = ((`m' * `rho' * `pi') + `rho' -1)/((`rho' * `m')*(1 + `pi'))
		local ytheta_opt`graph_n' = (1-`rho'+(`n'*`rho'*(1-`theta_opt`graph_n'')))*(1/(1-`theta_opt`graph_n''))*(1-((`pi'*`pi'*`rho'*`rho'*`n'*`n'*`theta_opt`graph_n''*(1-`theta_opt`graph_n''))/((1+(((`n'*(1-`theta_opt`graph_n''))-1)*`rho'))*(1+(((`n'*`theta_opt`graph_n'')-1)*`rho')))))/(1+((`n'-1)*`rho'))
		local roundtheta_opt`graph_n': di %5.3f `theta_opt`graph_n''
		local roundytheta_opt`graph_n': di %5.3f `ytheta_opt`graph_n''
		
		// Define graph
        local call "y = (1-`rho'+(`n'*`rho'*(1-x)))*(1/(1-x))*(1-((`pi'*`pi'*`rho'*`rho'*`n'*`n'*x*(1-x))/((1+(((`n'*(1-x))-1)*`rho'))*(1+(((`n'*x)-1)*`rho')))))/(1+((`n'-1)*`rho'))"
        
		
        // Make graph
        local graphcommand "function `call', range(0 0.5) ylabel(1(0.05)1.25) color("scheme p`graph_colour'") || (scatteri `roundytheta_opt`graph_n'' `roundtheta_opt`graph_n'', mcolor("scheme p`graph_colour'") msymbol(d)), legend(on label(`graph_n' "pi =`pi'") label(`graph_nplus1' "θ_opt = (`roundtheta_opt`graph_n'' , `roundytheta_opt`graph_n'')") pos(10) ring(0) forcesize symxsize(8) symysize(1) rowgap(1) size(small) colgap(1) symplacement(left) textfirst cols(1) colfirst)"
       
		// overlay graphs 
		local aggregate_graphcommand `aggregate_graphcommand' `graphcommand' ||

        // Make graph for next value of pi
        * local ++graph_n
		local graph_n = `graph_n'+2
		
		}
		   
graph twoway `aggregate_graphcommand' , ytitle("Proportionate change in clusters required") xtitle("Baseline data - proportion of total") 

}
			
			else if `type' == 2 {					// retrospective
			
clear all
set more off
set scheme s1color

****************
* SECOND GRAPH
****************


local graph_n 1
	
     foreach pi of local pilist {
	 
	    local graph_nplus1 = `graph_n'+1
		local graph_colour = `graph_n'+2
	 
	 // make theta opt and corresponding y-value
		local theta_opt`graph_n' = ((`m' * `rho' * `pi') + `rho' -1)/((`rho' * `m')*(1 + `pi'))
        local ytheta_opt`graph_n' = (1 - ((`pi'*`pi'*`rho'*`rho'*`n'*`n'*`theta_opt`graph_n'')/((1+((`n'-1)*`rho'))*(1+((((`n'*`theta_opt`graph_n''))-1)*`rho')))))
		local roundtheta_opt`graph_n': di %5.3f `theta_opt`graph_n''
		local roundytheta_opt`graph_n': di %5.3f `ytheta_opt`graph_n''

		
		// Define graph
        local call "y = (1 - ((`pi'*`pi'*`rho'*`rho'*`n'*`n'*x)/((1+((`n'-1)*`rho'))*(1+((((`n'*x))-1)*`rho')))))"
        
		
        // Make graph
        local graphcommand2 "function `call', range(0 2) yscale(range(0)) ylabel(0(0.1)1) color("scheme p`graph_colour'") || (scatteri `roundytheta_opt`graph_n'' `roundtheta_opt`graph_n'', mcolor("scheme p`graph_colour'") msymbol(d)), legend(on label(`graph_n' "pi =`pi'") label(`graph_nplus1' "θ_opt = (`roundtheta_opt`graph_n'' , `roundytheta_opt`graph_n'')") pos(7) ring(0) forcesize symxsize(8) symysize(1) rowgap(1) size(small) colgap(1) symplacement(left) textfirst cols(1) colfirst)"
       
		// overlay graphs 
		local aggregate_graphcommand2 `aggregate_graphcommand2' `graphcommand2' ||

        // Make graph for next value of pi
		local graph_n = `graph_n'+2
		
		}
		   
graph twoway `aggregate_graphcommand2' , title("size=`n', ICC=`rho'") ytitle("Proportionate change in clusters required") xtitle("Baseline data - ratio to endline data")  			
			
}			
			
			

end


* bcluster, n(200) rho(0.01) m(200) pi(0.5 0.6 0.7) pro
* bcluster, n(200) rho(0.01) m(200) pi(0.5 0.6 0.7) ret
