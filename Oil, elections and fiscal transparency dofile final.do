

* Cleaning of dataset (removal of non-relevant country-years)* 
drop if countrynr==.


*Manually inserting oil_gas_valuePOP_2014 values from Ross-Mahdavi dataset for Russia, Slovakia and Venezuela*
replace oil_gas_valuepop_2014= 3596.189285229 if countrynr==73 & yearsurveyed==2005
replace oil_gas_valuepop_2014= 3368.864747655 if countrynr==73 & yearsurveyed==2007
replace oil_gas_valuepop_2014= 2293.190309564 if countrynr==73 & yearsurveyed==2009
replace oil_gas_valuepop_2014= 3663.627935622 if countrynr==73 & yearsurveyed==2011

replace oil_gas_valuepop_2014= 3409.10347777 if countrynr==95 & yearsurveyed==2007
replace oil_gas_valuepop_2014= 2350.096322765 if countrynr==95 & yearsurveyed==2009
replace oil_gas_valuepop_2014= 3641.687688461 if countrynr==95 & yearsurveyed==2011

replace oil_gas_valuepop_2014= 3.833579085731 if countrynr==79 & yearsurveyed==2009
replace oil_gas_valuepop_2014= 5.119485787498 if countrynr==79 & yearsurveyed==2011


*Generation of chiefexecutiveelection dummy*
generate chiefexecutiveelection=0
replace chiefexecutiveelection=1 if presidentialsystem==0 & legelec==1
replace chiefexecutiveelection=1 if presidentialsystem==1 & exelec==1


*Generation of modified chief executive election, which takes the value of if the election is held within the first three months of the year*

generate modifiedchiefexecutiveelection= chiefexecutiveelection
replace modifiedchiefexecutiveelection=0 if presidentialsystem==0 & dateleg<4
replace modifiedchiefexecutiveelection=0 if presidentialsystem==1 & dateexec<4


*Generation of endogenous election variable and a scheduled election variable*

generate endogenouselection=0
replace endogenouselection=1 if countrynr==3 & yearsurveyed==2009
replace endogenouselection=1 if countrynr==10 & yearsurveyed==2005
replace endogenouselection=1 if countrynr==10 & yearsurveyed==2009
replace endogenouselection=1 if countrynr==23 & yearsurveyed==2009
replace endogenouselection=1 if countrynr==44 & yearsurveyed==2005
replace endogenouselection=1 if countrynr==44 & yearsurveyed==2011
replace endogenouselection=1 if countrynr==41 & yearsurveyed==2009
replace endogenouselection=1 if countrynr==99 & yearsurveyed==2011

generate scheduledelection= chiefexecutiveelection
replace scheduledelection=0 if endogenouselection==1


*Coding the 2009 Equ. Guinea election as an early election* 
generate endogenouselection2=endogenouselection
replace endogenouselection2= 1 if countrynr==31 & yearsurveyed==2009
generate scheduledelection2= chiefexecutiveelection
replace scheduledelection2=0 if endogenouselection2==1



*Generation of the logged oil and logged gdp variable*
generate logoil= log( oilrentspctofgdpwb)
replace logoil=0 if oilrentspctofgdpwb==0
generate loggdpcapita= log( gdppercapitacurrentdollarimf)

*Generation of oil reserve per population*
generate oilreservepop= oilreserves1000milbarrelsbp/totalpopulationwb


*singepartygovernment dummy*
generate singlepartygov=0
replace singlepartygov=1 if herfgov==1


*Setting of panel data*
tsset countrynr yearsurveyed


*Analysis with  Test with oil production per capita (Ross-Mahdavi data)*



*Generation of log oil per capita variable*
generate logoilprocap= log(oil_gas_valuepop_2014)
replace logoilprocap=0 if oil_gas_valuepop_2014==0
replace logoilprocap=0 if oil_gas_valuepop_2014<1.0


*Appendix A: Countries included in the study*
list country yearsurveyed if ggexpenditure!=. & chiefexecutiveelection!=. & open_budget_index!=. & logoilprocap!=. & polity2!=. &  gdpgrowthimf!=. & loggdpcapita!=. & ggrevenue!=.

*Figure B1a: Scatterplot of fiscal transparency and log of oil*
twoway (scatter open_budget_index logoilprocap), legend(off) xtitle(Log of oil production value per capita) ytitle(Fiscal transparency) graphregion(color(white)),if ggexpenditure!=. & chiefexecutiveelection!=. & open_budget_index!=. & logoilprocap!=. & polity2!=. &  gdpgrowthimf!=. & loggdpcapita!=. & ggrevenue!=.

*Figure B1b: Scatterplot of fiscal transparency and democracy*
twoway (scatter open_budget_index polity2) , legend(off) xtitle(Level of democracy (Polity2)) ytitle(Fiscal transparency) graphregion(color(white)),if ggexpenditure!=. & chiefexecutiveelection!=. & open_budget_index!=. & logoilprocap!=. & polity2!=. &  gdpgrowthimf!=. & loggdpcapita!=. & ggrevenue!=.

*Scatterplot of fiscal transparency and democracy*
twoway (scatter open_budget_index polity2) , legend(off) xtitle(Level of democracy (Polity2)) ytitle(Fiscal transparency) graphregion(color(white)),if ggexpenditure!=. & chiefexecutiveelection!=. & open_budget_index!=. & logoilprocap!=. & polity2!=. &  gdpgrowthimf!=. & loggdpcapita!=. & ggrevenue!=.


*Scatterplot of fiscal transparency and democracy*
twoway (scatter open_budget_index polity2) , legend(off) xtitle(Level of democracy (Polity2)) ytitle(Fiscal transparency) graphregion(color(white)),if ggexpenditure!=. & chiefexecutiveelection!=. & open_budget_index!=. & logoilprocap!=. & polity2!=. &  gdpgrowthimf!=. & loggdpcapita!=. & ggrevenue!=.

*Appendix C: Descriptive statistics*
xtsum ggexpenditure chiefexecutiveelection open_budget_index logoilprocap polity2  gdpgrowthimf loggdpcapita ggrevenue if ggexpenditure!=. & chiefexecutiveelection!=. & open_budget_index!=. & logoilprocap!=. & polity2!=. &  gdpgrowthimf!=. & loggdpcapita!=. & ggrevenue!=.


*Table 1: Pure oil/election *
xtreg  ggexpenditure c.logoilprocap##c.chiefexecutiveelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe

*Table 1: Oil three way interaction*
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed , fe
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed, fe

*Figure 1: Marginal effect of oil: Marginsplot with histogram *
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
margins, dydx(logoil) over(open_budget_index), if chiefexecutiveelection==1
marginsplot, ylabel (3 2 1 0 -1 -2  -3 )level(90) ytitle(Effect of oil on public spending) xtitle(Fiscal transparency)addplot(hist open_budget_index if chiefexecutiveelection==1 & ggexpenditure!=. & logoilprocap!=. & ggrevenue!=. & gdpgrowthimf!=. & polity2!=. & loggdpcapita!=., below discret percent lcolor(black*0.5) fcolor(white) yaxis(2)ylabel(0 60, axis(2)) yscale(off axis(2))) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) title("")


xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
margins, dydx(logoil) over(open_budget_index), if chiefexecutiveelection==0
marginsplot, ylabel ( 2 1 0 -1, format(%9.1f) )level(90) ytitle(Effect of oil on public spending) xtitle(Fiscal transparency)addplot(hist open_budget_index if chiefexecutiveelection==0 & ggexpenditure!=. & logoilprocap!=. & ggrevenue!=. & gdpgrowthimf!=. & polity2!=. & loggdpcapita!=. , below discret percent lcolor(black*0.5) fcolor(white) yaxis(2)ylabel(0 60, axis(2)) yscale(off axis(2))) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) title("")


*Figure 2: Marginsplot with histogram (extra ylabels manually removed for plot in non-election years)*
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
margins, dydx(logoil) over(chiefexecutiveelection),   if open_budget_index<50
marginsplot, ylabel ( 2 1 0 -1   )level(90) ytitle(Effect of oil on public spending) xlabel(0 "No election" 1 "Election", angle(45)) xtitle("") yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)    scheme(s1mono)  title("")


xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
margins, dydx(logoil) over(chiefexecutiveelection), if open_budget_index>=50
marginsplot, ylabel ( 2 1 0 -1   )level(90) ytitle(Effect of oil on public spending) xlabel(0 "No election" 1 "Election", angle(45)) xtitle("") yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)    scheme(s1mono)  title("")


* Appendix D: Ross-Mahdavi data with clustered standard errors*
xtreg  ggexpenditure c.logoilprocap##c.chiefexecutiveelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe cluster(countrynr)
xtreg  ggexpenditure c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe cluster(countrynr)
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed , fe cluster(countrynr)
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed, fe cluster(countrynr)


*Table 2 and 3 Ross-Mahdavida data press freedom and democracy*
generate polity21=polity2+10
replace polity21=. if polity2==. 
xtreg  ggexpenditure  c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection c.polity21##c.logoilprocap##c.chiefexecutiveelection polity2 ggrevenue gdpgrowthimf  loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection c.pressfreedomfreedomhouse##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe


* Appendix E: Controlling for trade openness and exchange rate*
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita trade_pct_gdp_wdi dollar_exhange_rate_wdi i.yearsurveyed  , fe, 

*Foot note without GDP growth and gdp per capita*
xtreg  ggexpenditure c.logoilprocap##c.chiefexecutiveelection  polity2  i.yearsurveyed  , fe, 
xtreg  ggexpenditure c.logoilprocap##c.chiefexecutiveelection ggrevenue  polity2  i.yearsurveyed  , fe
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection  polity2  i.yearsurveyed  , fe
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue  polity2  i.yearsurveyed  , fe



*Foot note: Alternative measure of election year*
xtreg  ggexpenditure c.logoilprocap##c.modifiedchiefexecutiveelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.logoilprocap##c.modifiedchiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.modifiedchiefexecutiveelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.modifiedchiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe 


* Footnote: Time trends instead of year dummies*
xtreg  ggexpenditure c.logoilprocap##c.chiefexecutiveelection gdpgrowthimf polity2 loggdpcapita yearsurveyed  , fe, 
xtreg  ggexpenditure c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita yearsurveyed  , fe
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection gdpgrowthimf polity2 loggdpcapita yearsurveyed  , fe 
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita yearsurveyed  , fe


* Foot note: Removal of countries above 80 on the Open Budget Index*
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if open_budget_index<80

*Footnote*
*Foot note elections as a predictor of fiscal transparency*
xtreg  open_budget_index chiefexecutiveelection  i.yearsurveyed  , fe


*Foot note: Using the V-dem liberal democracy variable variable*

generate electoralautocracy=0
replace electoralautocracy=1 if v2x_regime==1
replace electoralautocracy=. if v2x_regime==.
drop if yearpublished ==.

generate liberaldemocracy=0
replace liberaldemocracy=1 if v2x_regime==3
replace liberaldemocracy=. if v2x_regime==.

xtreg  ggexpenditure  liberaldemocracy##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf  loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure  c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection liberaldemocracy##c.logoil##c.chiefexecutiveelection polity2 ggrevenue gdpgrowthimf  loggdpcapita i.yearsurveyed  , fe



*Table 4 Electoral autocracy part of the analysis*
eststo: xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe,  if v2x_regime!=0
eststo:xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe,  if v2x_regime!=1
eststo: xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe,  if v2x_regime!=2
eststo: xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe,  if v2x_regime!=3
estout, cells(b(fmt(a2)) se (fmt(a2))) stats(r2  N)

*Interacting with the regime variable, not in paper*
eststo: xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection##v2x_regime ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe

*Two of the different categories removed, not in paper*
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe,  if v2x_regime==1 |v2x_regime==2
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe,  if v2x_regime==3 |v2x_regime==2
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe,  if v2x_regime==2
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe,  if v2x_regime==1 


*Figure 3*
hist open_budget_index, graphregion(color(white)) percent color(none)xtitle(Fiscal transparency) fcolor(black),if v2x_regime==1 

*Appendix F: The use of log of oil reserves/population times international oil price as windfalls variable*
generate oilreserves100barrelsbp= oilreserves1000milbarrelsbp*10
generate logoilreserves= log(oilreserves100barrelsbp)
replace logoilreserves=0 if oilreserves100barrelsbp==0

generate logoilpop= logoilreserves/totalpopulationwb
generate oilpricelogoilpop= logoilpop*oilpricebarrel2013bp

xtreg  ggexpenditure c.open_budget_index##c.oilpricelogoilpop##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe

xtreg  ggexpenditure c.open_budget_index##c.oilpricelogoilpop##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
margins, dydx(oilpricelogoilpop) over(open_budget_index), if chiefexecutiveelection==1
marginsplot, level(90) ytitle(Effect of oil on public spending) xtitle(Fiscal transparency)  yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) 

xtreg  ggexpenditure c.open_budget_index##c.oilpricelogoilpop##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
margins, dydx(oilpricelogoilpop) over(open_budget_index), if chiefexecutiveelection==0
marginsplot, level(90) ytitle(Effect of oil on public spending) xtitle(Fiscal transparency)  yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) 

*Appendix G: Listing countries by regime type*
list country yearsurveyed if ggexpenditure!=. & chiefexecutiveelection!=. & open_budget_index!=. & logoilprocap!=. & polity2!=. &  gdpgrowthimf!=. & loggdpcapita!=. & ggrevenue!=. & v2x_regime==0
list country yearsurveyed if ggexpenditure!=. & chiefexecutiveelection!=. & open_budget_index!=. & logoilprocap!=. & polity2!=. &  gdpgrowthimf!=. & loggdpcapita!=. & ggrevenue!=. & v2x_regime==1
list country yearsurveyed if ggexpenditure!=. & chiefexecutiveelection!=. & open_budget_index!=. & logoilprocap!=. & polity2!=. &  gdpgrowthimf!=. & loggdpcapita!=. & ggrevenue!=. & v2x_regime==2
list country yearsurveyed if ggexpenditure!=. & chiefexecutiveelection!=. & open_budget_index!=. & logoilprocap!=. & polity2!=. &  gdpgrowthimf!=. & loggdpcapita!=. & ggrevenue!=. & v2x_regime==3

*Appendix H: By income categories*
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed, fe, if gdppercapitacurrentdollarimf<996 
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed, fe, if gdppercapitacurrentdollarimf>996 & gdppercapitacurrentdollarimf<12055
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed, fe, if  gdppercapitacurrentdollarimf>12055



*Appendix: Removal of Azerbaijan*
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=5 
margins, dydx(logoil) over(open_budget_index), if chiefexecutiveelection==1
marginsplot, ylabel (2 1 0 -1 -2  )level(90) ytitle(Effect of oil on public spending) xtitle(Fiscal transparency)addplot(hist open_budget_index if chiefexecutiveelection==1 & ggexpenditure!=. & logoilprocap!=. & ggrevenue!=. & gdpgrowthimf!=. & polity2!=. & loggdpcapita!=., below discret percent lcolor(black*0.5) fcolor(white) yaxis(2)ylabel(0 60, axis(2)) yscale(off axis(2))) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) title("")


xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=5 
margins, dydx(logoil) over(open_budget_index), if chiefexecutiveelection==0
marginsplot, ylabel ( 2 1 0 -1 -2  )level(90) ytitle(Effect of oil on public spending) xtitle(Fiscal transparency)addplot(hist open_budget_index if chiefexecutiveelection==1 & ggexpenditure!=. & logoilprocap!=. & ggrevenue!=. & gdpgrowthimf!=. & polity2!=. & loggdpcapita!=., below discret percent lcolor(black*0.5) fcolor(white) yaxis(2)ylabel(0 60, axis(2)) yscale(off axis(2))) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) title("")



*Appendix: Removal of Kasakhstan*
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=44 
margins, dydx(logoil) over(open_budget_index), if chiefexecutiveelection==1
marginsplot, ylabel (2 1 0 -1 -2  )level(90) ytitle(Effect of oil on public spending) xtitle(Fiscal transparency)addplot(hist open_budget_index if chiefexecutiveelection==1 & ggexpenditure!=. & logoilprocap!=. & ggrevenue!=. & gdpgrowthimf!=. & polity2!=. & loggdpcapita!=., below discret percent lcolor(black*0.5) fcolor(white) yaxis(2)ylabel(0 60, axis(2)) yscale(off axis(2))) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) title("")


xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=44 
margins, dydx(logoil) over(open_budget_index), if chiefexecutiveelection==0
marginsplot, ylabel ( 2 1 0 -1 -2  )level(90) ytitle(Effect of oil on public spending) xtitle(Fiscal transparency)addplot(hist open_budget_index if chiefexecutiveelection==1 & ggexpenditure!=. & logoilprocap!=. & ggrevenue!=. & gdpgrowthimf!=. & polity2!=. & loggdpcapita!=., below discret percent lcolor(black*0.5) fcolor(white) yaxis(2)ylabel(0 60, axis(2)) yscale(off axis(2))) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) title("")


*Appendix: Removal of Russia*
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=73 
margins, dydx(logoil) over(open_budget_index), if chiefexecutiveelection==1
marginsplot, ylabel (2 1 0 -1 -2  )level(90) ytitle(Effect of oil on public spending) xtitle(Fiscal transparency)addplot(hist open_budget_index if chiefexecutiveelection==1 & ggexpenditure!=. & logoilprocap!=. & ggrevenue!=. & gdpgrowthimf!=. & polity2!=. & loggdpcapita!=., below discret percent lcolor(black*0.5) fcolor(white) yaxis(2)ylabel(0 60, axis(2)) yscale(off axis(2))) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) title("")


xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=73 
margins, dydx(logoil) over(open_budget_index), if chiefexecutiveelection==0
marginsplot, ylabel ( 2 1 0 -1 -2  )level(90) ytitle(Effect of oil on public spending) xtitle(Fiscal transparency)addplot(hist open_budget_index if chiefexecutiveelection==1 & ggexpenditure!=. & logoilprocap!=. & ggrevenue!=. & gdpgrowthimf!=. & polity2!=. & loggdpcapita!=., below discret percent lcolor(black*0.5) fcolor(white) yaxis(2)ylabel(0 60, axis(2)) yscale(off axis(2))) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) title("")

*Appendix: Removal of Equitorial Guinea*
xtreg  ggexpenditure c.logoilprocap##c.chiefexecutiveelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=31 
xtreg  ggexpenditure c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=31
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=31
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=31 
margins, dydx(logoil) over(open_budget_index), if chiefexecutiveelection==1
marginsplot, ylabel ( 1 0 -1,  format(%9.1f) )level(90) ytitle(Effect of oil on public spending) xtitle(Fiscal transparency)addplot(hist open_budget_index if chiefexecutiveelection==1 & ggexpenditure!=. & logoilprocap!=. & ggrevenue!=. & gdpgrowthimf!=. & polity2!=. & loggdpcapita!=., below discret percent lcolor(black*0.5) fcolor(white) yaxis(2)ylabel(0 60, axis(2)) yscale(off axis(2))) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) title("")


xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=31 
margins, dydx(logoil) over(open_budget_index), if chiefexecutiveelection==0
marginsplot, ylabel (  1 0 -1, format(%9.1f)   )level(90) ytitle(Effect of oil on public spending) xtitle(Fiscal transparency)addplot(hist open_budget_index if chiefexecutiveelection==1 & ggexpenditure!=. & logoilprocap!=. & ggrevenue!=. & gdpgrowthimf!=. & polity2!=. & loggdpcapita!=., below discret percent lcolor(black*0.5) fcolor(white) yaxis(2)ylabel(0 60, axis(2)) yscale(off axis(2))) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) title("")



*Appendix: Removal of Nigeria*
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=59 
margins, dydx(logoil) over(open_budget_index), if chiefexecutiveelection==1
marginsplot, ylabel (2 1 0 -1 -2  )level(90) ytitle(Effect of oil on public spending) xtitle(Fiscal transparency)addplot(hist open_budget_index if chiefexecutiveelection==1 & ggexpenditure!=. & logoilprocap!=. & ggrevenue!=. & gdpgrowthimf!=. & polity2!=. & loggdpcapita!=., below discret percent lcolor(black*0.5) fcolor(white) yaxis(2)ylabel(0 60, axis(2)) yscale(off axis(2))) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) title("")


xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=59 
margins, dydx(logoil) over(open_budget_index), if chiefexecutiveelection==0
marginsplot, ylabel ( 2 1 0 -1 -2  )level(90) ytitle(Effect of oil on public spending) xtitle(Fiscal transparency)addplot(hist open_budget_index if chiefexecutiveelection==1 & ggexpenditure!=. & logoilprocap!=. & ggrevenue!=. & gdpgrowthimf!=. & polity2!=. & loggdpcapita!=., below discret percent lcolor(black*0.5) fcolor(white) yaxis(2)ylabel(0 60, axis(2)) yscale(off axis(2))) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) title("")



*Appendix: Removal of Venezuela*
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=95 
margins, dydx(logoil) over(open_budget_index), if chiefexecutiveelection==1
marginsplot, ylabel (2 1 0 -1 -2  )level(90) ytitle(Effect of oil on public spending) xtitle(Fiscal transparency)addplot(hist open_budget_index if chiefexecutiveelection==1 & ggexpenditure!=. & logoilprocap!=. & ggrevenue!=. & gdpgrowthimf!=. & polity2!=. & loggdpcapita!=., below discret percent lcolor(black*0.5) fcolor(white) yaxis(2)ylabel(0 60, axis(2)) yscale(off axis(2))) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) title("")


xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=95 
margins, dydx(logoil) over(open_budget_index), if chiefexecutiveelection==0
marginsplot, ylabel ( 2 1 0 -1 -2  )level(90) ytitle(Effect of oil on public spending) xtitle(Fiscal transparency)addplot(hist open_budget_index if chiefexecutiveelection==1 & ggexpenditure!=. & logoilprocap!=. & ggrevenue!=. & gdpgrowthimf!=. & polity2!=. & loggdpcapita!=., below discret percent lcolor(black*0.5) fcolor(white) yaxis(2)ylabel(0 60, axis(2)) yscale(off axis(2))) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) title("")


*________________________________________________________________*

*Additional tests not in paper* 

*____________________________________________________________________*

*Removal of Bolivia and Kasakhstan*
xtreg  ggexpenditure c.logoilprocap##c.chiefexecutiveelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=10 & countrynr!=44
xtreg  ggexpenditure c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=10 & countrynr!=44
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=10 & countrynr!=44
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=10 & countrynr!=44



* Only scheduled elections: Results are not robust, if the 2009 election in Equitorial Guinea is counted as an early election. However, confer figure I4 where Equitorial Guinea is removed*
xtreg  ggexpenditure c.logoilprocap##c.scheduledelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.logoilprocap##c.scheduledelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.scheduledelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.scheduledelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe

xtreg  ggexpenditure c.logoilprocap##c.scheduledelection2 gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.logoilprocap##c.scheduledelection2 ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.scheduledelection2 gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.open_budget_index##c.logoilprocap##c.scheduledelection2 ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe



*Analysis using World Bank Data for (log of) oil rents as the measure of oil rents: Not in paper*
*____________________________________________________________________________________________________*




*Histogram of fiscal transparency among non-oil producers and oil producers*
generate nonoilproducer=0
replace nonoilproducer=1 if logoil==0
replace nonoilproducer=. if logoil==.
twoway (hist open_budget_index if nonoilproducer==1,  percent color(none)) (hist open_budget_index if nonoilproducer==0, percent fcolor(none)   lpattern(dash) lcolor(black)), legend(order(1 "Non-oil Producer" 2 "Oil Producer" ))graphregion(color(white)) xtitle(Fiscal transparency),if ggexpenditure!=. & chiefexecutiveelection!=. & open_budget_index!=. & logoil!=. & polity2!=. &  gdpgrowthimf!=. & loggdpcapita!=. & ggrevenue!=.


*Histogram of fiscal transparency among democracy and non democracy *

twoway (hist open_budget_index if polity2>5,  percent color(none)) (hist open_budget_index if polity2<=5, percent fcolor(none)   lpattern(dash) lcolor(black)), legend(order(1 "Polity-score>5" 2 "Polity-score =<5" ))graphregion(color(white)) xtitle(Fiscal transparency),if ggexpenditure!=. & chiefexecutiveelection!=. & open_budget_index!=. & logoil!=. & polity2!=. &  gdpgrowthimf!=. & loggdpcapita!=. & ggrevenue!=.







*Scatterplot of fiscal transparency and log of oil*
twoway (scatter open_budget_index logoil), legend(off) xtitle(Log of oil rents) ytitle(Fiscal transparency) graphregion(color(white)),if ggexpenditure!=. & chiefexecutiveelection!=. & open_budget_index!=. & logoil!=. & polity2!=. &  gdpgrowthimf!=. & loggdpcapita!=. & ggrevenue!=.

*Table 1: Descriptive statistics*
xtsum ggexpenditure chiefexecutiveelection open_budget_index logoil polity2  gdpgrowthimf loggdpcapita ggrevenue if ggexpenditure!=. & chiefexecutiveelection!=. & open_budget_index!=. & logoil!=. & polity2!=. &  gdpgrowthimf!=. & loggdpcapita!=. & ggrevenue!=.


*Pure oil pure oil/election *
xtreg  ggexpenditure c.logoil##c.chiefexecutiveelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe

*Three way interaction*
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe 



*Figure 1: Marginsplot with histogram*
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed , fe
margins, dydx(logoil) over(open_budget_index), if chiefexecutiveelection==1
marginsplot, ylabel (5 4 3 2 1 0 -1 -2  -3  -4 -5 -6)level(90) ytitle(Effect of oil on public spending) xtitle(Fiscal transparency)addplot(hist open_budget_index if chiefexecutiveelection==1 & ggexpenditure!=. & logoil!=. & ggrevenue!=. & gdpgrowthimf!=. & polity2!=. & loggdpcapita!=., below discret percent lcolor(black*0.5) fcolor(white) yaxis(2)ylabel(0 60, axis(2)) yscale(off axis(2))) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line)

xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
margins, dydx(logoil) over(open_budget_index), if chiefexecutiveelection==0
marginsplot, ylabel(5 4 3 2 1 0 -1 -2  -3  -4 -5 -6) level(90) ytitle(Effect of oil on public spending) xtitle(Fiscal transparency)addplot(hist open_budget_index if chiefexecutiveelection==0 & ggexpenditure!=. & logoil!=. & ggrevenue!=. & gdpgrowthimf!=. & polity2!=. & loggdpcapita!=., below discret percent  lcolor(black*0.5) fcolor(white) yaxis(2)ylabel(0 60, axis(2)) yscale(off axis(2))) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line)



*Table 3: Democracy* 

generate polity21=polity2+10
replace polity21=. if polity2==. 

xtreg  ggexpenditure   c.polity21##c.logoil##c.chiefexecutiveelection polity2 ggrevenue gdpgrowthimf  loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure  c.open_budget_index##c.logoil##c.chiefexecutiveelection c.polity21##c.logoil##c.chiefexecutiveelection polity2 ggrevenue gdpgrowthimf  loggdpcapita i.yearsurveyed  , fe

xtreg  ggexpenditure  c.open_budget_index##c.logoil##c.chiefexecutiveelection c.polity21##c.logoil##c.chiefexecutiveelection polity2 ggrevenue gdpgrowthimf  loggdpcapita i.yearsurveyed  , fe
margins, dydx(logoil) over(open_budget_index), if chiefexecutiveelection==1
marginsplot, ylabel(-5(1)5) level(90) ytitle(Election effect of oil rents) xtitle(Fiscal transparency) graphregion(color(white))legend (off)   scheme(s1mono)  recastci(rline) recast(line) 



*Table 4: Press freedom*
xtreg  ggexpenditure c.pressfreedomfreedomhouse##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection c.pressfreedomfreedomhouse##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe

xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection c.pressfreedomfreedomhouse##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
margins, dydx(logoil) over(open_budget_index), if chiefexecutiveelection==1
marginsplot, ylabel(-5(1)5) level(90) ytitle(Election effect of oil rents) xtitle(Fiscal transparency) graphregion(color(white))legend (off)   scheme(s1mono)  recastci(rline) recast(line) 


*Four way interactions with placebo factors*
xtreg  ggexpenditure  c.open_budget_index##c.logoil##c.chiefexecutiveelection##c.democracy ggrevenue gdpgrowthimf  loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection##c.pressfreedomfreedomhouse ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe


*Split sample for different levels of democracy*
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if polity2>5
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf  loggdpcapita i.yearsurveyed  , fe, if polity2<=5
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf  loggdpcapita i.yearsurveyed  , fe, if polity2<=0
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf  loggdpcapita i.yearsurveyed  , fe, if polity2<=-5

*Table 5: The use of log of oil reserves/population times international oil price as windfalls variable*
generate oilreserves100barrelsbp= oilreserves1000milbarrelsbp*10
generate logoilreserves= log(oilreserves100barrelsbp)
replace logoilreserves=0 if oilreserves100barrelsbp==0

generate logoilpop= logoilreserves/totalpopulationwb
generate oilpricelogoilpop= logoilpop*oilpricebarrel2013bp

xtreg  ggexpenditure c.open_budget_index##c.oilpricelogoilpop##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe

xtreg  ggexpenditure c.open_budget_index##c.oilpricelogoilpop##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
margins, dydx(oilpricelogoilpop) over(open_budget_index), if chiefexecutiveelection==1
marginsplot, level(90) ytitle(Effect of oil on public spending) xtitle(Fiscal transparency)  yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) 

xtreg  ggexpenditure c.open_budget_index##c.oilpricelogoilpop##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
margins, dydx(oilpricelogoilpop) over(open_budget_index), if chiefexecutiveelection==0
marginsplot, level(90) ytitle(Effect of oil on public spending) xtitle(Fiscal transparency)  yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) 


*Foot note elections as a predictor of fiscal transparency*
xtreg  open_budget_index chiefexecutiveelection  i.yearsurveyed  , fe

*Foot note: Alternative measure of election year*
xtreg  ggexpenditure c.logoil##c.modifiedchiefexecutiveelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.logoil##c.modifiedchiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.modifiedchiefexecutiveelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.modifiedchiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe 

*Foot note: Only scheduled elections and removal of Bolivia and Kazakhstan*
xtreg  ggexpenditure c.logoil##c.scheduledelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.logoil##c.scheduledelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.scheduledelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.scheduledelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe

xtreg  ggexpenditure c.logoil##c.chiefexecutiveelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=10 & countrynr!=44
xtreg  ggexpenditure c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=10 & countrynr!=44
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=10 & countrynr!=44
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=10 & countrynr!=44


* Footnote : Time trends instead of year dummies*
xtreg  ggexpenditure c.logoil##c.chiefexecutiveelection gdpgrowthimf polity2 loggdpcapita yearsurveyed  , fe, 
xtreg  ggexpenditure c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita yearsurveyed  , fe
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection gdpgrowthimf polity2 loggdpcapita yearsurveyed  , fe 
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita yearsurveyed  , fe


* Foot note: Removal of countries above 80 on the Open Budget Index*
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if open_budget_index<81

*Foot note: Using the V-dem liberal democracy variable variable. This part of the analysis requires the main dataset to be merged with the Varieties of Democracy Dataset (2018 version) *


xtreg  ggexpenditure  liberaldemocracy##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf  loggdpcapita i.yearsurveyed  , fe
xtreg  ggexpenditure  c.open_budget_index##c.logoil##c.chiefexecutiveelection liberaldemocracy##c.logoil##c.chiefexecutiveelection polity2 ggrevenue gdpgrowthimf  loggdpcapita i.yearsurveyed  , fe



*Foot note: Number of countries additionally included in table 5*
list country if   logoil==.  & oilpricelogoilpop!=. & ggexpenditure!=. & chiefexecutiveelection!=. & open_budget_index!=.  & polity2!=. &  gdpgrowthimf!=. & loggdpcapita!=. & ggrevenue!=.
list country if   logoil!=.  & oilpricelogoilpop==. & ggexpenditure!=. & chiefexecutiveelection!=. & open_budget_index!=.  & polity2!=. &  gdpgrowthimf!=. & loggdpcapita!=. & ggrevenue!=.

*Appendix A: Countries included in the study*
list country if ggexpenditure!=. & chiefexecutiveelection!=. & open_budget_index!=. & logoil!=. & polity2!=. &  gdpgrowthimf!=. & loggdpcapita!=. & ggrevenue!=.




*Additional countries included*
list country if   logoil==.  & logoilprocap!=. & ggexpenditure!=. & chiefexecutiveelection!=. & open_budget_index!=.  & polity2!=. &  gdpgrowthimf!=. & loggdpcapita!=. & ggrevenue!=.



* Appendix C: Country-clustered standard errors*
xtreg  ggexpenditure c.logoil##c.chiefexecutiveelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe cluster(countrynr)
xtreg  ggexpenditure c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe cluster(countrynr)
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe cluster(countrynr)
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe cluster(countrynr)



*Electoral autocracy part of the analysis*
eststo: xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe,  if v2x_regime!=0
eststo:xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe,  if v2x_regime!=1
eststo: xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe,  if v2x_regime!=2
eststo: xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe,  if v2x_regime!=3
estout, cells(b(fmt(a2)) se (fmt(a2))) stats(r2  N)

eststo: xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection##v2x_regime ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe

xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe,  if v2x_regime==1 |v2x_regime==2
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe,  if v2x_regime==3 |v2x_regime==2
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe,  if v2x_regime==2
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe,  if v2x_regime==1 


hist open_budget_index, graphregion(color(white)) percent color(none)xtitle(Fiscal transparency) fcolor(black),if v2x_regime==1 


*___________________________________________________________________*


*Results without Equitorial Guinea*
xtreg  ggexpenditure c.logoil##c.chiefexecutiveelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=31
xtreg  ggexpenditure c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=31


xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=31
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=31 

xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed , fe, if countrynr!=31
margins, dydx(logoil) over(open_budget_index), if chiefexecutiveelection==1
marginsplot, ylabel (5 4 3 2 1 0 -1 -2  -3  -4 -5 -6)level(90) ytitle(Effect of oil and gas production value) xtitle(Fiscal transparency)addplot(hist open_budget_index if chiefexecutiveelection==1, below discret percent lcolor(black*0.5) fcolor(white) yaxis(2)ylabel(0 60, axis(2)) yscale(off axis(2))) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line)

xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe, if countrynr!=31
margins, dydx(logoil) over(open_budget_index), if chiefexecutiveelection==0
marginsplot, ylabel(5 4 3 2 1 0 -1 -2  -3  -4 -5 -6) level(90) ytitle(Effect of oil and gas production value) xtitle(Fiscal transparency)addplot(hist open_budget_index if chiefexecutiveelection==0, below discret percent  lcolor(black*0.5) fcolor(white) yaxis(2)ylabel(0 60, axis(2)) yscale(off axis(2))) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line)


*Main results with manuel jackknife for countries which held elections in the analyzed time period and had a OBI score below 10*
list country if open_budget_index<10 & logoil!=. & chiefexecutiveelection==1
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe , if countrynr!=9 
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe , if countrynr!=22
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe , if countrynr!=31
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe , if countrynr!=81
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe , if countrynr!=84
xtreg  ggexpenditure c.open_budget_index##c.logoil##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe , if countrynr!=99


*Potential other measure of oil rents* 

*Using an "oil rents possibilities" variable instead* 
generate oilreservepop= oilreserves1000milbarrelsbp/totalpopulationwb
generate oilpricetimesoilreservespop= oilpricebarrel2013bp*oilreservepop


xtreg  ggexpenditure c.open_budget_index##c.oilpricetimesoilreservespop##c.chiefexecutiveelection ggrevenue gdpgrowthimf polity2 loggdpcapita i.yearsurveyed  , fe



