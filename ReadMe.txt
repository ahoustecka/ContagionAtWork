This folder contains the following files that replicate tables and figures in

"Contagion at Work: Occupations, Industries and Human Contact"

by Anna Houstecka, Dongya Koh and Raul Santaeulalia-Llopis


----------------------------
1. ContagionAtWork_Data.dta: 
MEPS data 1996-2016 in a Stata dta format.

2. Contagion_at_Work.do: 
Stata do file that replicates Tables 2, 3, 4 and 5 and Figures 2 and 3 of the paper 
by using ContagionAtWork_Data.dta from 1996-2016 for Tables 2, 3, 4 and 2002-2016 for Figures 2 and 3 and Table 5.

3. MEPS_Industry_Occupation_Flu_HumanContact.dta: 
MEPS data 2002-2016 in a Stata dta format contains the estimates and confidence intervals for conditional (baseline) 
and unconditional (only year and month) regressions for each
	(a) occupation x industry
	(b) occupation
	(c) industry.
This main dataset contains the Human Contact Score for occupation-industry mix that we construct from O'NET and OES
and the total employment of occupation-industry mix based on the MEPS.
It also contains flu incidence, both conditional and unconditional, for each
	(a) occupation x industry
	(b) occupation
	(c) industry.

4. Contagion_at_Work_Ind_Occ.do: 
Stata do file that replicates replicates Figures 4 and 6 by using MEPS_Industry_Occupation_Flu_HumanContact.dta.

5. ONET_HumanContactScore.dta: 
O'NET data in a Stata dta format that contains Human Contact Score that we construct by using a principal component 
analysis through an eigenvalue decomposition of the covariance of all 19 descriptors across all occupations. 
Details about the construction of this measure are described in the paper and the appendix.
----------------------------



