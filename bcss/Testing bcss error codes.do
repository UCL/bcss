* Testing error messages in the program bcss
* Ella Marley-Zagar 
* Last updated : 02/04/2019

log using C:\Users\rmjlem1\Desktop\My_files\Andrew_Copas_baseline_data_for_CRT\testing\bcss_error_msg.log, replace

bcss, pi(0.5 0.6 0.7) rho(0.01)
bcss, pi(0.5 0.6 0.7) rho(0.01) pr
bcss, pi(0.5 0.6 0.7) rho(0.01) re
bcss, pi(0.5 0.6 0.7) rho(0.01) ret
bcss, pi(0.5 0.6 0.7) rho(0.01) ret total(200)
bcss, pi(0.5 0.6 0.7) rho(0.01) ret total(200) endline(200)
bcss, pi(0.5 0.6 0.7) rho(0.01) ret endline(200) total(200)
bcss, pi(0.5 0.6 0.7) rho(0.01) ret endline(200) pxmin

bcss, pi(0.5 0.6 0.7) rho(0.01) pro
bcss, pi(0.5 0.6 0.7) rho(0.01) pro endline(200)
bcss, pi(0.5 0.6 0.7) rho(0.01) pro total(200) endline(200)
bcss, pi(0.5 0.6 0.7) rho(0.01) pro endline(200) total(200)

* Out of range values of pi
bcss, rho(0.01) pro total(200)
bcss, pi(-0.1) rho(0.01) pro total(200)
bcss, pi(1.1) rho(0.01) pro total(200)
bcss, pi(1000) rho(0.01) pro total(200)
bcss, pi(-0.1 0.1) rho(0.01) pro total(200)
bcss, pi(0.5 100000) rho(0.01) pro total(200)
bcss, pi(-0.1 1.1) rho(0.01) pro total(200)

bcss, rho(0.01) ret endline(200)
bcss, pi(-0.1) rho(0.01) ret endline(200)
bcss, pi(1.1) rho(0.01) ret endline(200)
bcss, pi(1000) rho(0.01) ret endline(200)
bcss, pi(-0.1 0.1) rho(0.01) ret endline(200)
bcss, pi(0.5 100000) rho(0.01) ret endline(200)
bcss, pi(-0.1 1.1) rho(0.01) ret endline(200)

* Out of range values of rho
bcss, pi(0.5 0.7 0.9) pro total(200)
bcss, pi(0.5 0.7 0.9) rho(-0.1) pro total(200)
bcss, pi(0.5 0.7 0.9) rho(1.1) pro total(200)
bcss, pi(0.5 0.7 0.9) rho(10000) pro total(200)
bcss, pi(0.5 0.7 0.9) rho(0.01 0.05) pro total(200)

bcss, pi(0.5 0.7 0.9) ret endline(200)
bcss, pi(0.5 0.7 0.9) rho(-0.1) ret endline(200)
bcss, pi(0.5 0.7 0.9) rho(1.1) ret endline(200)
bcss, pi(0.5 0.7 0.9) rho(10000) ret endline(200)
bcss, pi(0.5 0.7 0.9) rho(0.01 0.05) ret endline(200)

* Out of range values of endline/total
bcss, pi(0.5 0.7 0.9) rho(0.01) pro 
bcss, pi(0.5 0.7 0.9) rho(0.01) pro total(-100)
bcss, pi(0.5 0.7 0.9) rho(0.01) pro total(0)
bcss, pi(0.5 0.7 0.9) rho(0.01) pro total(1000001) propxaxis(0 0.5) propyaxis(0 1) propystep(0.2)
bcss, pi(0.5 0.7 0.9) rho(0.01) pro total(200 300)

bcss, pi(0.5 0.7 0.9) rho(0.01) ret 
bcss, pi(0.5 0.7 0.9) rho(0.01) ret endline(-100)
bcss, pi(0.5 0.7 0.9) rho(0.01) ret endline(0)
bcss, pi(0.5 0.7 0.9) rho(0.01) ret endline(1000001) propxaxis(0 0.5) propyaxis(0 1) propystep(0.2)
bcss, pi(0.5 0.7 0.9) rho(0.01) ret endline(200 300)

* Axes: if one is specified then all must be
bcss, pi(0.5 0.6 0.7) rho(0.01) pro total(200) propxaxis(0 0.5)
bcss, pi(0.5 0.6 0.7) rho(0.01) pro total(200) propxaxis(0 0.5) propyaxis(1 1.25)
*bcss, pi(0.5 0.6 0.7) rho(0.01) pro total(200) propxaxis(0 0.5) propyaxis(1 1.25) propystep(0.05) // how it should be 
bcss, pi(0.5 0.6 0.7) rho(0.01) ret endline(200) retxaxis(0 2)
bcss, pi(0.5 0.6 0.7) rho(0.01) ret endline(200) retxaxis(0 2) retyaxis(0 1)
*bcss, pi(0.5 0.6 0.7) rho(0.01) ret endline(200) retxaxis(0 2) retyaxis(0 1) retystep(0.1) // how it should be

* Axes: user putting incorrect number of arguments in to each axis option
bcss, pi(0.5 0.6 0.7) rho(0.01) pro total(200) propxaxis(0.5)
bcss, pi(0.5 0.6 0.7) rho(0.01) pro total(200) propxaxis(0 0.5 1)
bcss, pi(0.5 0.6 0.7) rho(0.01) pro total(200) propyaxis(1)
bcss, pi(0.5 0.6 0.7) rho(0.01) pro total(200) propyaxis(1 1.25 1.5)
bcss, pi(0.5 0.6 0.7) rho(0.01) pro total(200) propystep(0.05 1)

bcss, pi(0.5 0.6 0.7) rho(0.01) ret endline(200) retxaxis(2)
bcss, pi(0.5 0.6 0.7) rho(0.01) ret endline(200) retxaxis(0 2 3)
bcss, pi(0.5 0.6 0.7) rho(0.01) ret endline(200) retyaxis(1)
bcss, pi(0.5 0.6 0.7) rho(0.01) ret endline(200) retyaxis(0 1 2)
bcss, pi(0.5 0.6 0.7) rho(0.01) ret endline(200) retystep(0.1 0.2)

* Axes: incorrect values for x axis
bcss, pi(0.5 0.6 0.7) rho(0.01) pro total(200) propxaxis(-0.5 0.5) propyaxis(1 1.25) propystep(0.05)
bcss, pi(0.5 0.6 0.7) rho(0.01) pro total(200) propxaxis(0 1.5) propyaxis(1 1.25) propystep(0.05)
bcss, pi(0.5 0.6 0.7) rho(0.01) pro total(200) propxaxis(-0.5 1.5) propyaxis(1 1.25) propystep(0.05)
bcss, pi(0.5 0.6 0.7) rho(0.01) pro total(200) propxaxis(1.5 -0.5) propyaxis(1 1.25) propystep(0.05)
bcss, pi(0.5 0.6 0.7) rho(0.01) pro total(200) propxaxis(0.5 0) propyaxis(1 1.25) propystep(0.05) // swops them round as required
bcss, pi(0.5 0.6 0.7) rho(0.01) pro total(200) propxaxis(0 0) propyaxis(1 1.25) propystep(0.05)  

bcss, pi(0.5 0.6 0.7) rho(0.01) ret endline(200) retxaxis(-0.5 2) retyaxis(0 1) retystep(0.1)
bcss, pi(0.5 0.6 0.7) rho(0.01) ret endline(200) retxaxis(2 -0.5) retyaxis(0 1) retystep(0.1)
bcss, pi(0.5 0.6 0.7) rho(0.01) ret endline(200) retxaxis(-0.5 -1) retyaxis(0 1) retystep(0.1)
bcss, pi(0.5 0.6 0.7) rho(0.01) ret endline(200) retxaxis(2 0) retyaxis(0 1) retystep(0.1)  // swops them round as required
bcss, pi(0.5 0.6 0.7) rho(0.01) ret endline(200) retxaxis(0 0) retyaxis(0 1) retystep(0.1) 

* Incorrect legend options specified
bcss, pi(0.5 0.6 0.7) rho(0.01) pro total(200) propxaxis(0 0.5) propyaxis(1 1.25) propystep(0.05) leg(rubbish)
bcss, pi(0.5 0.6 0.7) rho(0.01) ret endline(200) retxaxis(0 2) retyaxis(0 1) retystep(0.1) leg(rubbish)
* Error messages as required

log close
