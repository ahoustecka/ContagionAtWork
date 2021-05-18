*****************************************************************
* Contagion at Work: Occupations, Industries and Human Contact *

  * Anna Houstecka, Dongya Koh and Raul Santaeulalia-Llopis *

            * Replication File *
			
*****************************************************************
/* This file replicates Figures 4 and 6 using data obtained from
regressions using the MEPS 2002-2016 and Human Contact Score 
obtained from O'NET and OES 
(Occupational Employment Statistics)
*/

*****************************************************************
use MEPS_Industry_Occupation_Flu_HumanContact, clear

*****************************************************************


* Figure 4

gen ind_n = meps_ind
gen occ_n = meps_occ

gen sig = 0
replace sig = 1 if (CIup_indXocc_con>0 & CIlow_indXocc_con>0) | ( CIup_indXocc_con<0 & CIlow_indXocc_con< 0)

sort beta_occ_con
gen order = _n
by beta_occ_con (order), sort: generate meps_occ_order = _n == 1
replace meps_occ_order = sum(meps_occ_order) 

cap drop var1b
gen var1b = meps_occ_order
replace var1b = meps_occ_order-0.42 if meps_ind==1
replace var1b = meps_occ_order-0.35 if meps_ind==2
replace var1b = meps_occ_order-0.28 if meps_ind==3
replace var1b = meps_occ_order-0.21 if meps_ind==4
replace var1b = meps_occ_order-0.14 if meps_ind==5
replace var1b = meps_occ_order-0.07 if meps_ind==6
replace var1b = meps_occ_order if meps_ind==7
replace var1b = meps_occ_order+0.07 if meps_ind==8
replace var1b = meps_occ_order+0.14 if meps_ind==9
replace var1b = meps_occ_order+0.21 if meps_ind==10
replace var1b = meps_occ_order+0.28 if meps_ind==11
replace var1b = meps_occ_order+0.35 if meps_ind==12
replace var1b = meps_occ_order+0.42 if meps_ind==13


cap drop max_val
gen max_val = 0.04
replace max_val = -0.02 if meps_occ==1


cap drop max_val2
gen max_val2 = 0.04
replace max_val2 = -0.02 if meps_ind==1


replace CIup_indXocc_con = 0.04 if CIup_indXocc_con>.04
replace CIlow_indXocc_con = -0.02 if CIlow_indXocc_con<-0.02


cap drop var4
gen var4 = meps_occ_order-0.47


cap drop label_pos2
gen label_pos2 = 12

replace label_pos2 = 6 if (meps_ind==8 | meps_ind==11 ) & meps_occ==1
replace label_pos2 = 11 if meps_ind==12 & meps_occ==1

replace label_pos2 = 6 if (meps_ind==8 | meps_ind==9 ) & meps_occ==2
replace label_pos2 = 11 if meps_ind==13 & meps_occ==2
replace label_pos2 = 3 if meps_ind==11 & meps_occ==2

replace label_pos2 = 6 if  (meps_ind==9 | meps_ind==11 | meps_ind==13 ) & meps_occ==3

replace label_pos2 = 6 if meps_ind==1 & meps_occ==4
replace label_pos2 = 11 if meps_ind==12 & meps_occ==4

replace label_pos2 = 6 if (meps_ind==11 | meps_ind==12 ) & meps_occ==5
replace label_pos2 = 1 if meps_ind==10 & meps_occ==5
replace label_pos2 = 11 if meps_ind==13 & meps_occ==5

replace label_pos2 = 6 if (meps_ind==1 | meps_ind==3 ) & meps_occ==7
replace label_pos2 = 11 if meps_ind==2 & meps_occ==7

replace label_pos2 = 6 if (meps_ind==10 | meps_ind==11 ) & meps_occ==8
replace label_pos2 = 11 if meps_ind==4 & meps_occ==8


label define occ_label 1 "Farming" 2 "Production" 3 "Construction" 4 "Services" 5 "Office Support" 6 "Management" 7 "Professional" 8 "Sales"
label values meps_occ_order occ_label

 
graph twoway (bar max_val2 meps_occ_order, scheme(s1color) fcolor(none) lcolor(black)) ///
(rcap CIlow_indXocc_con CIup_indXocc_con  var1b,  lcolor(gs13)) (rcap CIlow_indXocc_con CIup_indXocc_con var1b if sig==1,  lcolor(red*0.75)) ///
(scatter beta_indXocc_con var1b, mcolor(blue) mlabel(ind_n) mlabcolor(black) mlabgap(0.1) mlabv(label_pos2) ) ///
(rcap CIlow_occ_con CIup_occ_con var4,  msize(normal) lwidth(medthick)  lcolor(green)) (scatter beta_occ_con var4,  msize(normal) mcolor(green) mlabcolor(black) mlabposition(3) ) ///
, xlabel(1(1)8,valuelabel angle(45) labsize(small)) ysc(r(-0.001 0.002)) xtitle("") ytitle("Coefficient") legend(off)
graph export Scatter_occupation_new.png, replace


*************************************************************
* INDUSTRY 

sort beta_ind_con
gen order_ind = _n
by beta_ind_con (order_ind), sort: generate meps_ind_order = _n == 1
replace meps_ind_order = sum(meps_ind_order) 

gen var2 = meps_ind_order
replace var2 = meps_ind_order-0.15 if meps_occ==1
replace var2 = meps_ind_order-0.1 if meps_occ==2
replace var2 = meps_ind_order-0.05 if meps_occ==3
replace var2 = meps_ind_order if meps_occ==4
replace var2 = meps_ind_order+0.05 if meps_occ==5
replace var2 = meps_ind_order+0.1 if meps_occ==6
replace var2 = meps_ind_order+0.15 if meps_occ==7
replace var2 = meps_ind_order+0.2 if meps_occ==8

cap drop var2b
gen var2b = meps_ind_order
replace var2b = meps_ind_order-0.3 if meps_occ==1
replace var2b = meps_ind_order-0.2 if meps_occ==2
replace var2b = meps_ind_order-0.1 if meps_occ==3
replace var2b = meps_ind_order if meps_occ==4
replace var2b = meps_ind_order+0.1 if meps_occ==5
replace var2b = meps_ind_order+0.2 if meps_occ==6
replace var2b = meps_ind_order+0.3 if meps_occ==7
replace var2b = meps_ind_order+0.4 if meps_occ==8

cap drop var3
gen var3 = meps_ind_order-0.4

cap drop label_pos
gen label_pos = 12
replace label_pos = 6 if meps_ind==1 & meps_occ==7
replace label_pos = 11 if meps_ind==1 & (meps_occ==2 | meps_occ==1)
replace label_pos = 2 if meps_ind==1 & (meps_occ==6 | meps_occ==5)

replace label_pos = 3 if meps_ind==2 & (meps_occ==3 | meps_occ==4)
replace label_pos = 11 if meps_ind==2 & (meps_occ==8)

replace label_pos = 11 if meps_ind==3 & (meps_occ==1 | meps_occ==2 | meps_occ==7)
replace label_pos = 3 if meps_ind==3 & (meps_occ==6 | meps_occ==5)
replace label_pos = 6 if meps_ind==3 & (meps_occ==8)

replace label_pos = 11 if meps_ind==4 & (meps_occ==1 | meps_occ==4 | meps_occ==7 | meps_occ==2)
replace label_pos = 5 if meps_ind==4 & (meps_occ==2)
replace label_pos = 1 if meps_ind==4 & (meps_occ==5)

replace label_pos = 11 if meps_ind==5 & (meps_occ==1)
replace label_pos = 7 if meps_ind==5 & (meps_occ==5)
replace label_pos = 6 if meps_ind==5 & (meps_occ==6)

replace label_pos = 11 if meps_ind==6 & (meps_occ==3)
replace label_pos = 3 if meps_ind==6 & (meps_occ==1)

replace label_pos = 11 if meps_ind==7 & (meps_occ==1)
replace label_pos = 1 if meps_ind==7 & (meps_occ==2 | meps_occ==7)
replace label_pos = 9 if meps_ind==7 & (meps_occ==4)

replace label_pos = 6 if meps_ind==8 & (meps_occ==2)
replace label_pos = 1 if meps_ind==8 & (meps_occ==5)
replace label_pos = 11 if meps_ind==8 & (meps_occ==1)

replace label_pos = 11 if meps_ind==9 & (meps_occ==1 | meps_occ==4 | meps_occ==7)
replace label_pos = 1 if meps_ind==9 & (meps_occ==5)
replace label_pos = 6 if meps_ind==9 & (meps_occ==3)

replace label_pos = 11 if meps_ind==10 & (meps_occ==1 | meps_occ==7)
replace label_pos = 6 if meps_ind==10 & (meps_occ==3)
replace label_pos = 1 if meps_ind==10 & (meps_occ==5)

replace label_pos = 11 if meps_ind==11 & (meps_occ==1 | meps_occ==6)
replace label_pos = 6 if meps_ind==11 & (meps_occ==3 |meps_occ==5)

replace label_pos = 11 if meps_ind==12 & (meps_occ==1 | meps_occ==2)
replace label_pos = 1 if meps_ind==12 & (meps_occ==4)

replace label_pos = 11 if meps_ind==13 & (meps_occ==1)


label define ind_label 1 "Mining" 2 "Natural Resources" 3 "Transportation" 4 "Construction" 5 "Manufacturing" 6 "Leisure" 7  "Information" 8 "Wholesale/Retail" 9 "Financial" 10 "Other Services" 11 "Public Administration" 12 "Professional/Business" 13 "Health, Education, Social"

label values meps_ind_order ind_label
 
 
graph twoway (bar max_val meps_ind_order, scheme(s1color) fcolor(none) lcolor(black)) ///
(rcap CIlow_indXocc_con CIup_indXocc_con  var2b,  lcolor(gs13)) (rcap CIlow_indXocc_con CIup_indXocc_con  var2b if sig==1,  lcolor(red*0.75)) /// 
(scatter beta_indXocc_con  var2b, mcolor(blue) mlabel(occ_n) mlabcolor(black) mlabgap(0.1) mlabv(label_pos)) ///
(rcap CIlow_ind_con CIup_ind_con var3,  msize(normal) lwidth(medthick)  lcolor(green)) (scatter beta_ind_con var3,  msize(normal) mcolor(green) mlabcolor(black) mlabposition(3) ) ///
, xlabel(1(1)13,valuelabel angle(45) labsize(small)) ysc(r(-0.001 0.002)) xtitle("") ytitle("Coefficient") legend(off)
graph export Scatter_industry_new.png, replace



* Figure 6

corr beta_indXocc_con lnhcs [w=pop]
local corr : di %5.3g r(rho)
graph twoway (lfit beta_indXocc_con lnhcs [w=pop] if inrange(lnhcs, -1.2, -0.2), lcolor(red*.75) lpattern(dash) ) ///
             (scatter beta_indXocc_con lnhcs [w=pop] if beta_indXocc_con<0.02 & beta_indXocc_con>0 & inrange(lnhcs, -1.2, -0.2),  ///
xtitle("Human Contact Score, ln({it:HCS(o,m)})") xscale(range(-1.2(.2)-0.2)) ytitle("Coefficient") ///
scheme(s1color) fcolor(none) lcolor(blue*.45) msymbol(circle_hollow) legend(off) mcolor(blue) text(0.002 -0.45 "Correlation=`corr'", place(se))) ///
(scatter beta_indXocc_con lnhcs if beta_indXocc_con<0.02 & beta_indXocc_con>0 & inrange(lnhcs, -1.2, -0.2), xscale(range(-1.2(.2)-0.2)) msymbol(none) mlabposition(3) mlabcolor(black) mcolor(black))
graph export Scatter_HC_final.png, replace

