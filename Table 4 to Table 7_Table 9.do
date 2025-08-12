
********************************Table 4 - Panel Regressions of Monthly Bond Performance ***********************************************

// Panel A
use C:\Users\yifeil\Dropbox\bondag\Replication\Stata_data\retreg.dta,replace
set more off

egen permno_year=group(permno year)

global mainvar ag
global control blev blevchge logat amihud lagduration coupon logsize call put
reghdfe eret1 $mainvar $control, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, replace stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

global mainvar tg
reghdfe eret1 $mainvar $control, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

global mainvar ig
reghdfe eret1 $mainvar $control, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

global mainvar ag tg ig
reghdfe eret1 $mainvar $control, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

// By Rating groups
global mainvar ag
reghdfe eret1 $mainvar $control if ing==1, absorb(permno year) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

reghdfe eret1 $mainvar $control if ing==0, absorb(permno year) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

****to get the significance of the difference between investment grade and junk bonds
// reghdfe ret1 c.$mainvar##i.investment_grade $control , absorb(permno year) vce(cluster permno_year)

// By Maturity groups
reghdfe eret1 $mainvar $control if short_term==1, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

reghdfe eret1 $mainvar $control if short_term==0, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

****to get the significance of the difference between investment grade and junk bonds
// reghdfe ret1 c.$mainvar##i.short_term $control , absorb(permno year) vce(cluster permno_year)

************************

// Panel B
// Estimate Betas on risk factors
bys mbondcusip: asreg eret1 mktb def term lrf, wind(mno 36) newey(3)

// Control for bond risk factors
global control blev blevchge logat amihud lagduration coupon logsize call put _b_mktb _b_def _b_term _b_lrf

global mainvar ag 
reghdfe eret1 $mainvar $control, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, replace stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

global mainvar tg 
reghdfe eret1 $mainvar $control, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

global mainvar ig 
reghdfe eret1 $mainvar $control, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

global mainvar ag tg ig
reghdfe eret1 $mainvar $control, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

// By Rating groups
global mainvar ag 
reghdfe eret1 $mainvar $control if ing ==1, absorb(permno year ) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

reghdfe eret1 $mainvar $control if ing ==0, absorb(permno year ) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

// By Maturity groups
reghdfe eret1 $mainvar $control if short_term==1, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

reghdfe eret1 $mainvar $control if short_term==0, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)


// Table 5 - By Secured groups
global mainvar ag
global control blev blevchge logat amihud lagduration coupon logsize call put
reghdfe eret1 $mainvar $control if secured ==1, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, replace stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

reghdfe eret1 $mainvar $control if secured ==0, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

************************

// Table 6 EDF Test
use C:\Users\yifeil\Dropbox\bondag\Replication\Stata_data\t6edf.dta,replace
egen permno_year=group(mpermno year)

global mainvar ag
global control blev blevchge 
reghdfe edf_chge $mainvar $control, absorb(mpermno year) vce(cluster permno_year)
outreg2 using reg.xls, replace stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

global mainvar ag tg ig
reghdfe edf_chge $mainvar $control, absorb(mpermno year) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

global mainvar ag
reghdfe lead_edf_chge $mainvar $control, absorb(mpermno year) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

global mainvar ag tg ig
reghdfe lead_edf_chge $mainvar $control, absorb(mpermno year) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar $control)

***********************************
// Table 7

use C:\Users\yifeil\Dropbox\bondag\Replication\Stata_data\t7ys.dta,replace

egen permno_year=group(permno year)
global control blev blevchge logat amihud lagduration coupon logsize call put

global mainvar ag 
reghdfe iys $mainvar $control, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, replace stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar)

global mainvar c.ag##i.junk
reghdfe iys $mainvar $control, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar)

global mainvar ag edf junk
reghdfe iys $mainvar $control, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar)

global mainvar c.ag##i.junk  c.edf##i.junk
reghdfe iys $mainvar $control, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar)

***********************************
use C:\Users\yifeil\Dropbox\bondag\Replication\Stata_data\yschge.dta,replace

egen permno_year=group(permno year)
global control blev blevchge logat amihud lagduration coupon logsize call put

global mainvar ag iys
reghdfe yschge $mainvar  $control, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar)

global mainvar c.ag##i.junk iys
reghdfe yschge $mainvar $control, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar)

global mainvar ag edf i.junk iys
reghdfe yschge $mainvar $control, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar)

global mainvar c.ag##i.junk  c.edf##i.junk iys
reghdfe yschge $mainvar $control, absorb(permno year lagrating) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep($mainvar)

***********************************
// Table 9
use C:\Users\yifeil\Dropbox\bondag\Replication\Stata_data\tworet.dta,replace

egen permno_year=group(mpermno year)

global mainvar ag
reghdfe stkret ag, absorb(mpermno year) vce(cluster permno_year)
outreg2 using reg.xls, replace stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep(ag)

reghdfe  stkret ag blev roa size bm beta, absorb(mpermno year) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep(ag blev roa size bm beta)

reghdfe  stkret ag bondret blev roa size bm beta, absorb(mpermno year) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep(ag bondret blev roa size bm beta)

reghdfe  stkret ag bondret lagbret blev roa size bm beta, absorb(mpermno year) vce(cluster permno_year)
outreg2 using reg.xls, append stats(coef tstat) bdec(4) tdec(2) adjr2  ///
keep(ag bondret lagbret blev roa size bm beta)

***********************************

