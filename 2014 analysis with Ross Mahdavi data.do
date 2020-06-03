
*Cleaning of dataset*
drop if countrynr==.

*Generation of chiefexecutiveelection dummy*
generate chiefexecutiveelection=0
replace chiefexecutiveelection=1 if presidentialsystem==0 & legelec==1
replace chiefexecutiveelection=1 if presidentialsystem==1 & exelec==1


*singepartygovernment dummy*
generate singlepartygov=0
replace singlepartygov=1 if herfgov==1


*Generate of kvartiles in the open budget index*
generate OBIquart=.
replace OBIquart= 1 if openbudgetindex<25
replace OBIquart= 2 if openbudgetindex>24.999 & OBIquart<50
replace OBIquart= 3 if openbudgetindex>49.999 & openbudgetindex<75
replace OBIquart= 4 if openbudgetindex>74.999 & openbudgetindex<100.01
replace OBIquart=. if openbudgetindex==.


*Generation of high and low fiscal transparency variable*
generate OBIhigh=.
replace OBIhigh=1 if openbudgetindex>50
replace OBIhigh=0 if openbudgetindex<49.999999
replace OBIhigh=. if openbudgetindex==. 


*Setting of panel data*
tsset countrynr year

*Generation of of log of GDP per capita*
generate loggdpcapita= log( gdppercapitapppconstant2011inter)

*Logging Ross-Mahdavi Data
generate logoilprocap= log(oil_gas_valuePOP_2014)
replace logoilprocap=0 if oil_gas_valuePOP_2014==0
replace logoilprocap=0 if oil_gas_valuePOP_2014<1.0


*Countries included*
list year country if ggtotalexpenditurepctofgdpimf!=.  & openbudgetindex!=. & logoilprocap!=. & chiefexecutiveelection!=. & gdppercapitagrowthannual!=. & polity2!=. & loggdpcapita!=.& ggrevenuepctofgdpimf!=.

*Main analysis*
xtreg ggtotalexpenditurepctofgdpimf c.openbudgetindex##c.logoilprocap##c.chiefexecutiveelection gdppercapitagrowthannual polity2 loggdpcapita ggrevenuepctofgdpimf i.year , fe 
margins, dydx(logoilprocap) over(openbudgetindex), if chiefexecutiveelection==1
marginsplot, ylabel (4 3 2 1 0 -1 -2 -3 -4) level (90) ytitle(Effect of oil rents) xtitle(Fiscal transparency)  yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) 


xtreg ggtotalexpenditurepctofgdpimf c.openbudgetindex##c.logoilprocap##c.chiefexecutiveelection gdppercapitagrowthannual polity2 loggdpcapita ggrevenuepctofgdpimf i.year  , fe 
margins, dydx(logoilprocap) over(openbudgetindex), if chiefexecutiveelection==0
marginsplot, ylabel(4 3 2 1 0 -1 -2  -3 -4) level(90) ytitle(Effect of oil rents) xtitle(Fiscal transparency)    yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)   scheme(s1mono)  recastci(rline) recast(line) 


*With clustered standard errors: Marginsplot *

xtreg ggtotalexpenditurepctofgdpimf c.openbudgetindex##c.logoilprocap##c.chiefexecutiveelection gdppercapitagrowthannual polity2 loggdpcapita ggrevenuepctofgdpimf i.year , fe vce (cluster countrynr)
margins, dydx(logoilprocap) over(openbudgetindex), if chiefexecutiveelection==1
marginsplot, ylabel (4 3 2 1 0 -1 -2 -3 -4) level (90) ytitle(Effect of oil rents) xtitle(Fiscal transparency)  yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) 


xtreg ggtotalexpenditurepctofgdpimf c.openbudgetindex##c.logoilprocap##c.chiefexecutiveelection gdppercapitagrowthannual polity2 loggdpcapita ggrevenuepctofgdpimf i.year  , fe vce (cluster countrynr)
margins, dydx(logoilprocap) over(openbudgetindex), if chiefexecutiveelection==0
marginsplot, ylabel(4 3 2 1 0 -1 -2  -3 -4) level(90) ytitle(Effect of oil rents) xtitle(Fiscal transparency)    yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)   scheme(s1mono)  recastci(rline) recast(line) 


*Marginsplot with interpolated data*
xtreg ggtotalexpenditurepctofgdpimf c.openbudgetindexinterpoleret##c.logoilprocap##c.chiefexecutiveelection gdppercapitagrowthannual polity2 loggdpcapita ggrevenuepctofgdpimf i.year , fe 
margins, dydx(logoilprocap) over(openbudgetindexinterpoleret), if chiefexecutiveelection==1
marginsplot, ylabel (4 3 2 1 0 -1 -2 -3 -4) level (90) ytitle(Effect of oil rents) xtitle(Fiscal transparency)  yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) 


xtreg ggtotalexpenditurepctofgdpimf c.openbudgetindexinterpoleret##c.logoilprocap##c.chiefexecutiveelection gdppercapitagrowthannual polity2 loggdpcapita ggrevenuepctofgdpimf i.year  , fe 
margins, dydx(logoilprocap) over(openbudgetindexinterpoleret), if chiefexecutiveelection==0
marginsplot, ylabel(4 3 2 1 0 -1 -2  -3 -4) level(90) ytitle(Effect of oil rents) xtitle(Fiscal transparency)    yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)   scheme(s1mono)  recastci(rline) recast(line) 



*Marginsplot with rugplot interpolated data and clustered standard errors*
xtreg ggtotalexpenditurepctofgdpimf c.openbudgetindexinterpoleret##c.logoilprocap##c.chiefexecutiveelection gdppercapitagrowthannual polity2 loggdpcapita ggrevenuepctofgdpimf i.year , fe vce (cluster countrynr)
margins, dydx(logoilprocap) over(openbudgetindexinterpoleret), if chiefexecutiveelection==1
marginsplot, ylabel (4 3 2 1 0 -1 -2 -3 -4) level (90) ytitle(Effect of oil rents) xtitle(Fiscal transparency)  yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) 


xtreg ggtotalexpenditurepctofgdpimf c.openbudgetindexinterpoleret##c.logoilprocap##c.chiefexecutiveelection gdppercapitagrowthannual polity2 loggdpcapita ggrevenuepctofgdpimf i.year  , fe vce (cluster countrynr)
margins, dydx(logoilprocap) over(openbudgetindexinterpoleret), if chiefexecutiveelection==0
marginsplot, ylabel(4 3 2 1 0 -1 -2  -3 -4) level(90) ytitle(Effect of oil rents) xtitle(Fiscal transparency)    yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)   scheme(s1mono)  recastci(rline) recast(line) 



*Excluding Equitorial Gunieau*
xtreg ggtotalexpenditurepctofgdpimf c.openbudgetindex##c.logoilprocap##c.chiefexecutiveelection gdppercapitagrowthannual polity2 loggdpcapita ggrevenuepctofgdpimf i.year , fe vce (cluster countrynr) , if countrynr!=52
margins, dydx(logoilprocap) over(openbudgetindexinterpoleret), if chiefexecutiveelection==1
marginsplot, ylabel (4 3 2 1 0 -1 -2 -3 -4) level (90) ytitle(Effect of oil rents) xtitle(Fiscal transparency)  yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) 


xtreg ggtotalexpenditurepctofgdpimf c.openbudgetindex##c.logoilprocap##c.chiefexecutiveelection gdppercapitagrowthannual polity2 loggdpcapita ggrevenuepctofgdpimf i.year , fe vce (cluster countrynr) , if countrynr!=52
margins, dydx(logoilprocap) over(openbudgetindexinterpoleret), if chiefexecutiveelection==0
marginsplot, ylabel (4 3 2 1 0 -1 -2 -3 -4) level (90) ytitle(Effect of oil rents) xtitle(Fiscal transparency)  yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) 


*Excluding Equitorial Gunieau: Alterntive measure of oil rents*
xtreg ggtotalexpenditurepctofgdpimf c.openbudgetindex##c.oilrentsofgdp##c.chiefexecutiveelection gdppercapitagrowthannual polity2 loggdpcapita ggrevenuepctofgdpimf i.year , fe vce (cluster countrynr) , if countrynr!=52
margins, dydx(oilrentsofgdp) over(openbudgetindexinterpoleret), if chiefexecutiveelection==1
marginsplot, ylabel (4 3 2 1 0 -1 -2 -3 -4) level (90) ytitle(Effect of oil rents) xtitle(Fiscal transparency)  yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) 

xtreg ggtotalexpenditurepctofgdpimf c.openbudgetindex##c.oilrentsofgdp##c.chiefexecutiveelection gdppercapitagrowthannual polity2 loggdpcapita ggrevenuepctofgdpimf i.year , fe vce (cluster countrynr) , if countrynr!=52
margins, dydx(oilrentsofgdp) over(openbudgetindexinterpoleret), if chiefexecutiveelection==0
marginsplot, ylabel (4 3 2 1 0 -1 -2 -3 -4) level (90) ytitle(Effect of oil rents) xtitle(Fiscal transparency)  yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line) 


