Replication code for “Asset Growth Anomaly of Corporate Bonds: A Decomposition Analysis.”
1.	Run Table1_Table3.sas to produce Table 1 and Table 3, followed by Table2.sas to generate Table 2. It uses the dataset “retagrank.sas7bdat” described below.  
2.	Run Table4_to_Table7_Table9.do to generate Tables 4 through 7 and the first four columns of Table 9. It uses “retreg.dta”, “t6edf.dta”, “t7ys.dta”, “yschge”  and “tworet.dta”.
3.	Run Table8.sas to generate Table 8. It uses “regsent.sas7bdat” and “regsentys.sas7bdat”.
4.	Run Table 9_columns5&6.sas to produce columns 5 and 6 of Table 9. It uses “tworet.sas7bdat”.
5.	Run “Figure2.m” to generate Figure 2.

-------------------------------------------------------------
“retagrank.sas7bdat” includes:
1. Mbondcusip: Masked identify of corporate bond CUSIP ID
2. Date: Month end date of sample bonds in each trading month
3. Ret1: monthly bond return estimated using the transaction from the last five trading days of the month 
4. Ret2: monthly bond return estimated using the last transaction of the month
5. Eret1: excess monthly bond return estimated using the transaction from the last five trading days of the month
6. Eret2: excess monthly bond return estimated using the transaction of the month
7. Yield: bond yield estimated at the end of each month
8. Coupon: annual coupon rate
9. Offering_amt: The par value of debt initially issued.
10. Permno: CRSP Permanent Number
11. Rating: numerical credit rating ranging from 1 to 22, 22 for AAA rated bonds and 1 for D rated bonds.
12. Put: an indicator variable for puttable bonds 
13. Call: an indicator variable for callable bonds
14. Bondsize: The amount of the issue remaining outstanding.
15. Duration: bond duration in years
16. Mno: The number of sample months started from 1990 which calculated as (Year of Date - 1990)*12 + Month of the Date.
17. Year: the year of the observation
18. Ing: indicator variable for investment grade bonds
19. Junk: indicator variable for non-investment grade bonds
20. Logsize: the natural logarithm of bond issue size
21. Short-term: indicator variable for short-term bond with maturity of 10 years or less
22. Secured: indicator variable for secured bonds
23. Tyld: the corresponding treasury bond yield with a similar maturity
24. Ys: yield spreads defined as the difference between bond yield and the corresponding treasury bond yield. 
25. Ys: yield spreads in the previous month.
26. Lagrating: lagged bond rating
27. Lagduration: lagged bond duration
28. Dys: month-to-month change in yield spreads.
29. Gvkey: Global Company Key
30. At: total assets in millions
31. Ag: year-over-year growth in total assets 
32. Tg: year-over-year growth in tangible assets
33. Ig: year-over-year growth in intangible assets
34. Delta_ta_at: changes in tangible assets scaled by total assets
35. Delta_ia_at: changes in intangible assets scaled by total assets
36. Delta_td_at: changes in total debt scaled by total assets
37. Delta_opliab_at: changed in operating liabilities scaled by total assets
38. Edf: expected default frequency
39. Edf_chge: changed in EDF
40. Lead_edf_chge: changes in EDF in the following year
41. Amihud: Amihud illiquidity measure (per million) based on Amihud (2002).
42. Logat: the natural logarithm of total assets
43. Blev: book leverage
44. Blevchge changes in book leverage
45. Agrank: decile ranking for asset growth portfolio ranging from 0 to 9, 0 indicates low asset growth portfolio while 9 indicates high asset growth portfolio.

-------------------------------------------------------------
“retreg.dta” includes:
Same variables included in “retagrank.sas7bdat”
Additional bond risk factors include:
MKTB: market risk factor
Def: default risk factor
Term: term risk factor
Lrf: liquidity risk factor

-------------------------------------------------------------
“t6edf.dta” includes:
Mpermno: Masked identify of CRSP permanent number
Data Date: the date of the observation
Year: the year of the observation
Ag: year-over-year growth in total assets 
Tg: year-over-year growth in tangible assets
Ig: year-over-year growth in intangible assets
Blev: book leverage
Blevchge changes in book leverage
Edf: expected default frequency
Edf_chge: changes in expected default frequency
Lead_edf_chge: changes in expected default frequency in the following year

-------------------------------------------------------------
“t7ys.dta” includes:
Mbondcusip: Masked identify of corporate bond CUSIP ID.
PERMNO: CRSP Permanent Number
Iys: initial bond yield spreads
Year: the year of the observation
Ag: year-over-year growth in total assets 
Logat: the natural logarithm of total assets
Blev: book leverage
Blevchge changes in book leverage
Logsize: the natural logarithm of bond issue size
Amihud: Amihud illiquidity measure (per million) based on Amihud (2002).
Edf: expected default frequency
Coupon: annual coupon rate
Put: an indicator variable for puttable bonds 
Call: an indicator variable for callable bonds
Junk: indicator variable for non-investment grade bonds
Lagrating: lagged bond rating
Lagduration: lagged bond duration

-------------------------------------------------------------
“yschge.dta” includes:
Mbondcusip: Masked identify of corporate bond CUSIP ID.
Permno: CRSP Permanent Number
Yschge: changes in yield spreads
Iys: initial bond yield spreads
Year: the year of the observation
Ag: year-over-year growth in total assets 
Logat: the natural logarithm of total assets
Blev: book leverage
Blevchge changes in book leverage
Logsize: the natural logarithm of bond issue size
Amihud: Amihud illiquidity measure (per million) based on Amihud (2002).
Edf: expected default frequency
Put: an indicator variable for puttable bonds 
Call: an indicator variable for callable bonds
Junk: indicator variable for non-investment grade bonds
Lagrating: lagged bond rating
Lagduration: lagged bond duration
Coupon: annual coupon rate

-------------------------------------------------------------
“tworet.dta” includes:
Mbondcusip: Masked identify of corporate bond CUSIP ID.
Mno: The number of sample months started from 1990 which calculated as (Year of Date - 1990)*12 + Month of the Date.
Stkret: monthly stock return
Bondret: monthly bond return at the issuer level
Lagbret: twelve month lagged monthly bond return
Lagsret: twelve month lagged monthly stock return
Year: the year of the observation
Ag: year-over-year growth in total assets 
Roa: return on assets
Blev: book leverage
Bm: book to market ratio
Size: the natural logarithm of total assets
Beta: monthly stock beta

Note: “tworet.sas7bdat” include same variables as “tworet2.dta,” in SAS data format.
-------------------------------------------------------------

“regsent. sas7bdat” includes:
Bret: excess monthly bond return estimated using the transaction from the last five trading days of the month
YSD: changes in yield spreads
AG: year-over-year growth in total assets
GH: the issuer quality measure from Greenwood and Hanson (2013)
LSZ: the negative credit spreads measure from L_opez-Salido et al. (2017)
AG_LSZ: the interaction term of AG and LSZ
BW: overall market sentiment measure from Baker and Wurgler (2006)
AG_BW: the interaction term of AG and BW
AG_GH: the interaction term of AG and GH
LEV: book leverage
LEV_CHANGE: changes in book leverage
SIZE: the natural logarithm of total assets
ILQ: Amihud illiquidity measure (per million) based on Amihud (2002).
EDF: expected default frequency
DURATION: bond duration in years
PAR: the par value of debt initially issued
PUT: an indicator variable for puttable bonds 
CALL: an indicator variable for callable bonds
b_MKT: market risk factor
b_def: default risk factor
b_term: Term: term risk factor
FIRMRATING: lagged bond rating
year: the year of the observation
permno: CRSP Permanent Number

-------------------------------------------------------------
“regsentys. sas7bdat” includes:
ys: initial bond yield spreads
AG: year-over-year growth in total assets
GH: the issuer quality measure from Greenwood and Hanson (2013)
AG_GH: the interaction term of AG and GH
LSZ: the negative credit spreads measure from L_opez-Salido et al. (2017)
AG_LSZ: the interaction term of AG and LSZ
BW: overall market sentiment measure from Baker and Wurgler (2006)
AG_BW: the interaction term of AG and BW
LEV: book leverage
LEV_CHANGE: changes in book leverage
SIZE: the natural logarithm of total assets
ILQ: Amihud illiquidity measure (per million) based on Amihud (2002).
DURATION: bond duration in years
PAR: the par value of debt initially issued
PUT: an indicator variable for puttable bonds 
CALL: an indicator variable for callable bonds
FIRMRATING: lagged bond rating
year: the year of the observation
permno: CRSP Permanent Number
