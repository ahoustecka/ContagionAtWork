*****************************************************************
* Contagion at Work: Occupations, Industries and Human Contact *

  * Anna Houstecka, Dongya Koh and Raul Santaeulalia-Llopis *

            * Replication File *
			
*****************************************************************
/* This file replicates Tables 2, 3, 4 and 5 and Figures 2 and 3 
of the paper, using MEPS data from 1996-2016 for Tables 2, 3, 4 
and 2002-2016 for Figures 2 and 3 and Table 5
*/

*****************************************************************

* Load Data

use ContagionAtWork_Data, clear


* Table 2

reg flu_ind E i.year i.month [aw=longwt], vce(cluster id)
outreg2 using ContagionAtWork_tab2.tex, replace ctitle(Year/Month FE) label keep(E vacc age age2 age3 sex marry n_conditions student dusize) addtext(Year/Month FE, Yes)  tex(frag) addstat(Pseudo R2, e(r2))
reg flu_ind E i.year i.month age age2 age3 sex marry dusize n_conditions student [aw=longwt], vce(cluster id) 
outreg2 using ContagionAtWork_tab2.tex, append ctitle(Baseline) label keep(E vacc age age2 age3 sex marry n_conditions student dusize) addtext(Year/Month FE, Yes)  tex(frag) addstat(Pseudo R2, e(r2))
reg flu_ind E vacc i.year i.month age age2 age3 sex marry dusize n_conditions student [aw=longwt], vce(cluster id) 
outreg2 using ContagionAtWork_tab2.tex, append ctitle(Vaccines) label keep(E vacc vacc_time  age age2 age3 sex marry n_conditions student dusize) addtext(Year/Month FE, Yes)  tex(frag) addstat(Pseudo R2, e(r2))
reg flu_ind E vacc_time i.year i.month age age2 age3 sex marry dusize n_conditions student [aw=longwt], vce(cluster id) 
outreg2 using ContagionAtWork_tab2.tex, append ctitle(Vaccines) label keep(E vacc vacc_time age age2 age3 sex marry n_conditions student dusize) addtext(Year/Month FE, Yes)  tex(frag) addstat(Pseudo R2, e(r2))
reg flu_ind E ins_round i.year i.month age age2 age3 sex marry dusize n_conditions student [aw=longwt], vce(cluster id) 
outreg2 using ContagionAtWork_tab2.tex, append ctitle(Insurance) label keep(E ins_round vacc vacc_time age age2 age3 sex marry n_conditions student dusize) addtext(Year/Month FE, Yes)  tex(frag) addstat(Pseudo R2, e(r2))
reg flu_ind E i.year i.month age age2 age3 sex marry dusize bad_health student [aw=longwt], vce(cluster id) 
outreg2 using ContagionAtWork_tab2.tex, append ctitle(Subj. Health) label keep(E age age2 age3 sex marry dusize bad_health n_conditions student) addtext(Year/Month FE, Yes)  tex(frag) addstat(Pseudo R2, e(r2))
reg flu_ind E msa i.year i.month age age2 age3 sex marry dusize n_conditions student [aw=longwt], vce(cluster id) 
outreg2 using ContagionAtWork_tab2.tex, append ctitle(MSA) label keep(msa E age age2 age3 sex marry dusize n_conditions student) addtext(Year/Month FE, Yes)  tex(frag) addstat(Pseudo R2, e(r2))
reg flu_ind ib0.E_4 i.year i.month age age2 age3 sex marry dusize n_conditions student [aw=longwt], vce(cluster id) 
outreg2 using ContagionAtWork_tab2.tex, append ctitle(Multiple Categories) label keep(i1.E_4 i2.E_4 i3.E_4 vacc age age2 age3 sex marry n_conditions student dusize) addtext(Year/Month FE, Yes)  tex(frag) addstat(Pseudo R2, e(r2))
reg flu_ind E int_E_H i.year i.month age age2 age3 sex marry dusize n_conditions student [aw=longwt] if !missing(E_earner), vce(cluster id)
outreg2 using ContagionAtWork_tab2.tex, append ctitle(Hours Worked) label keep(E int_E_H  vacc age age2 age3 sex marry n_conditions student dusize) addtext(Year/Month FE, Yes)  tex(frag) addstat(Pseudo R2, e(r2))


* Table 3

reg flu_ind E i.year i.month age age2 age3 sex marry dusize n_conditions student [aw=longwt], vce(cluster id) 
outreg2 using ContagionAtWork_tab3.tex, replace ctitle(Baseline) label keep(E vacc age age2 age3 sex marry n_conditions student dusize) addtext(Year/Month FE, Yes, Individual FE, No)  tex(frag) addstat(Pseudo R2, e(r2))
xtreg flu_ind E i.year i.month age age2 age3 sex marry dusize n_conditions student [aw=longwt], vce(cluster id) fe
outreg2 using ContagionAtWork_tab3.tex, append ctitle(Indiv. FE) label keep(E vacc  age age2 age3 marry n_conditions student dusize) addtext(Year/Month FE, Yes, Individual FE, Yes)  tex(frag) addstat(Pseudo R2, e(r2))
xtreg flu_ind vacc E i.year i.month age age2 age3 sex marry dusize n_conditions student [aw=longwt], vce(cluster id) fe
outreg2 using ContagionAtWork_tab3.tex, append ctitle(Indiv. FE + Vaccine) label keep(E vacc age age2 age3 marry n_conditions student dusize) addtext(Year/Month FE, Yes, Individual FE, Yes)  tex(frag) addstat(Pseudo R2, e(r2))

* Table 4
bys year: egen year_flu = mean(flu_ind)

preserve
bys year: gen x=_n
keep if x==1
su year_flu, d
restore

reg flu_ind E i.year i.month age age2 age3 sex marry dusize n_conditions student [aw=longwt], vce(cluster id) 
outreg2 using ContagionAtWork_tab4.tex, replace ctitle(All years) label keep(E age age2 age3 sex marry n_conditions student dusize) addtext(Year/Month FE, Yes)  tex(frag) addstat(Pseudo R2, e(r2))
reg flu_ind E i.year i.month age age2 age3 sex marry dusize n_conditions student [aw=longwt] if year_flu>= 0.01673, vce(cluster id) 
outreg2 using ContagionAtWork_tab4.tex, append ctitle(High Incidence) label keep(E age age2 age3 sex marry n_conditions student dusize) addtext(Year/Month FE, Yes)  tex(frag) addstat(Pseudo R2, e(r2))
reg flu_ind E i.year i.month age age2 age3 sex marry dusize n_conditions student [aw=longwt] if year_flu< 0.01673, vce(cluster id) 
outreg2 using ContagionAtWork_tab4.tex, append ctitle(Low Incidence) label keep(E age age2 age3 sex marry n_conditions student dusize) addtext(Year/Month FE, Yes)  tex(frag) addstat(Pseudo R2, e(r2))

**********************************************************************
*             Occupation and Industry Analysis                       *
**********************************************************************

* Keep only those in employment
keep if E==1

* Restrict to year 2002 and further (change in occupational codes since round panel 3 round 6)
keep if panel>5
drop if panel==6 & round <3

* Drop occupations and industry
drop if meps_occ==11 | meps_occ==9 | meps_ind==15

* Generate average by year
bys year: egen year_flu2 = mean(flu_ind)


***********************************************************************

* Figure 2

reg flu_ind ib8.meps_occ i.year i.month   [aw=longwt]   , robust
estimates store U
coefplot (U, label(Unconditional)), ylabel(-.005(.0025).0075)  xlabel(,angle(45)) fcolor(*.25) lcolor(blue) bcolor(blue) scheme(s1color) keep(1.meps_occ 2.meps_occ 3.meps_occ 4.meps_occ 5.meps_occ 6.meps_occ 7.meps_occ 8.meps_occ) yline(0, lcolor(black)) recast(bar) ciopts(recast(rcap) lcolor(blue)) citop barwidt(0.5) sort(,) vertical legend(off)
graph export ContagionAtWork_Fig2a.png, replace

reg flu_ind ib8.meps_occ i.year i.month [aw=longwt] if year_flu2>=0.0157, robust 
estimates store UHigh
coefplot (UHigh, label(Unconditional)), ylabel(-.005(.0025).0075) xlabel(,angle(45)) fcolor(*.25) lcolor(blue) bcolor(blue) scheme(s1color) keep( 1.meps_occ 2.meps_occ 3.meps_occ 4.meps_occ 5.meps_occ 6.meps_occ 7.meps_occ 8.meps_occ ) yline(0, lcolor(black)) recast(bar) ciopts(recast(rcap) lcolor(blue)) citop barwidt(0.5) sort(,) vertical legend(off)
graph export ContagionAtWork_Fig2b.png, replace

reg flu_ind ib8.meps_occ i.year i.month   [aw=longwt] if year_flu2<0.0157    , robust
estimates store ULow
coefplot (ULow, label(Unconditional)), ylabel(-.005(.0025).0075) xlabel(,angle(45)) fcolor(*.25) lcolor(blue) bcolor(blue) scheme(s1color) keep(1.meps_occ 2.meps_occ 3.meps_occ 4.meps_occ 5.meps_occ 6.meps_occ 7.meps_occ 8.meps_occ ) yline(0, lcolor(black)) recast(bar) ciopts(recast(rcap) lcolor(blue)) citop barwidt(0.5) sort(,) vertical legend(off)
graph export ContagionAtWork_Fig2c.png, replace

* Figure 3


reg flu_ind ib1.meps_ind  i.year i.month     [aw=longwt], robust
estimates store IU
coefplot (IU, label(Unconditional)), ylabel(-.005(.005).012)  xlabel(,angle(45)) fcolor(*.25) lcolor(red) bcolor(red) scheme(s1color) keep(1.meps_ind 2.meps_ind 3.meps_ind 4.meps_ind 5.meps_ind 6.meps_ind 7.meps_ind 8.meps_ind 9.meps_ind 10.meps_ind 11.meps_ind 12.meps_ind 13.meps_ind) yline(0, lcolor(black)) recast(bar) ciopts(recast(rcap) lcolor(red)) citop barwidt(0.5) sort(,) vertical legend(off)
graph export ContagionAtWork_Fig3a.png, replace

reg flu_ind ib1.meps_ind i.year i.month    [aw=longwt] if year_flu2>=0.0157, robust 
estimates store IUHigh
coefplot (IUHigh, label(Unconditional)), ylabel(-.005(.005).012) xlabel(,angle(45)) fcolor(*.25) lcolor(red) bcolor(red) scheme(s1color) keep(1.meps_ind 2.meps_ind 3.meps_ind 4.meps_ind 5.meps_ind 6.meps_ind 7.meps_ind 8.meps_ind 9.meps_ind 10.meps_ind 11.meps_ind 12.meps_ind 13.meps_ind) yline(0, lcolor(black)) recast(bar) ciopts(recast(rcap) lcolor(red)) citop barwidt(0.5) sort(,) vertical legend(off)
graph export ContagionAtWork_Fig3b.png, replace

reg flu_ind ib1.meps_ind  i.year i.month   [aw=longwt] if year_flu2<0.0157, robust
estimates store IULow
coefplot (IULow, label(Unconditional)), ylabel(-.005(.005).012) xlabel(,angle(45)) fcolor(*.25) lcolor(red) bcolor(red) scheme(s1color) keep(1.meps_ind 2.meps_ind 3.meps_ind 4.meps_ind 5.meps_ind 6.meps_ind 7.meps_ind 8.meps_ind 9.meps_ind 10.meps_ind 11.meps_ind 12.meps_ind 13.meps_ind) yline(0, lcolor(black)) recast(bar) ciopts(recast(rcap) lcolor(red)) citop barwidt(0.5) sort(,) vertical legend(off)
graph export ContagionAtWork_Fig3c.png, replace

* Table 5

gen lnhcs = log(hcs)

* Keep only wage earners
keep if selfcm==0 

reg flu_in lnhcs i.year i.month [aw=longwt], vce(cluster id)
outreg2 using ContagionAtWork_tab5.tex, replace ctitle(Full Sample) label keep(lnhcs age age2 sex marry n_conditions student dusize) addtext(Year/Month FE, Yes, Industry FE, No)   tex(frag) addstat(Pseudo R2, e(r2))
reg flu_ind lnhcs i.year i.month age age2 sex marry dusize n_conditions student [aw=longwt], vce(cluster id) 
outreg2 using ContagionAtWork_tab5.tex, append ctitle(+ Controls) label keep(lnhcs age age2 sex marry  n_conditions student dusize) addtext(Year/Month FE, Yes, Industry FE, No)   tex(frag) addstat(Pseudo R2, e(r2))
reg flu_ind lnhcs  i.year i.month age age2 sex marry dusize n_conditions student [aw=longwt] if year_flu2>=0.0157, vce(cluster id) 
outreg2 using ContagionAtWork_tab5.tex, append ctitle(High Incidence) label keep(lnhcs age age2 sex marry n_conditions numemp nume2 student dusize) addtext(Year/Month FE, Yes, Industry FE, No)   tex(frag) addstat(Pseudo R2, e(r2))
reg flu_ind lnhcs i.year i.month age age2 sex marry dusize n_conditions student [aw=longwt] if year_flu2<0.0157, vce(cluster id) 
outreg2 using ContagionAtWork_tab5.tex, append ctitle(Low Incidence) label keep(lnhcs age age2 sex marry n_conditions numemp nume2 student dusize) addtext(Year/Month FE, Yes, Industry FE, No)   tex(frag) addstat(Pseudo R2, e(r2))
reg flu_ind lnhcs i.year i.month numemp nume2 age age2 sex marry dusize n_conditions student [aw=longwt], vce(cluster id) 
outreg2 using ContagionAtWork_tab5.tex, append ctitle(+ N. Employees) label keep(lnhcs age age2 sex marry n_conditions numemp nume2 student dusize) addtext(Year/Month FE, Yes, Industry FE, No)   tex(frag) addstat(Pseudo R2, e(r2))
reg flu_ind lnhcs i.year i.month morjob age age2 sex marry dusize n_conditions student [aw=longwt], vce(cluster id) 
outreg2 using ContagionAtWork_tab5.tex, append ctitle(More Jobs) label keep(lnhcs age age2 sex marry n_conditions morjob student dusize) addtext(Year/Month FE, Yes, Industry FE, No)   tex(frag) addstat(Pseudo R2, e(r2))
reg flu_ind lnhcs i.year i.month hour age age2 sex marry dusize n_conditions student [aw=longwt], vce(cluster id) 
outreg2 using ContagionAtWork_tab5.tex, append ctitle(Hours Worked) label keep(lnhcs age age2 sex marry n_conditions hour student dusize) addtext(Year/Month FE, Yes, Industry FE, No)   tex(frag) addstat(Pseudo R2, e(r2))







