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
Same variables included in “retagrank.sas7bdat”. Additional bond risk factors include:
1. MKTB: market risk factor
2. Def: default risk factor
3. Term: term risk factor
4. Lrf: liquidity risk factor

-------------------------------------------------------------
“t6edf.dta” includes:
1. Mpermno: Masked identify of CRSP permanent number
2. Data Date: the date of the observation
3. Year: the year of the observation
4. Ag: year-over-year growth in total assets 
5. Tg: year-over-year growth in tangible assets
6. Ig: year-over-year growth in intangible assets
7. Blev: book leverage
8. Blevchge changes in book leverage
9. Edf: expected default frequency
10. Edf_chge: changes in expected default frequency
11. Lead_edf_chge: changes in expected default frequency in the following year

-------------------------------------------------------------
“t7ys.dta” includes:
1. Mbondcusip: Masked identify of corporate bond CUSIP ID.
2. MPERMNO: Masked CRSP Permanent Number
3. Iys: initial bond yield spreads
4. Year: the year of the observation
5. Ag: year-over-year growth in total assets 
6. Logat: the natural logarithm of total assets
7. Blev: book leverage
8. Blevchge changes in book leverage
9. Logsize: the natural logarithm of bond issue size
10. Amihud: Amihud illiquidity measure (per million) based on Amihud (2002).
11. Edf: expected default frequency
12. Coupon: annual coupon rate
13. Put: an indicator variable for puttable bonds 
14. Call: an indicator variable for callable bonds
15. Junk: indicator variable for non-investment grade bonds
16. Lagrating: lagged bond rating
17. Lagduration: lagged bond duration

-------------------------------------------------------------
“yschge.dta” includes:
1. Mbondcusip: Masked identify of corporate bond CUSIP ID.
2. MPERMNO: Masked CRSP Permanent Number
3. Yschge: changes in yield spreads
4. Iys: initial bond yield spreads
5. Year: the year of the observation
6. Ag: year-over-year growth in total assets 
7. Logat: the natural logarithm of total assets
8. Blev: book leverage
9. Blevchge changes in book leverage
10. Logsize: the natural logarithm of bond issue size
11. Amihud: Amihud illiquidity measure (per million) based on Amihud (2002).
12. Edf: expected default frequency
13. Put: an indicator variable for puttable bonds 
14. Call: an indicator variable for callable bonds
15. Junk: indicator variable for non-investment grade bonds
16. Lagrating: lagged bond rating
17. Lagduration: lagged bond duration
18. Coupon: annual coupon rate

-------------------------------------------------------------
“tworet.dta” includes:
1. Mbondcusip: Masked identify of corporate bond CUSIP ID.
2. Mno: The number of sample months started from 1990 which calculated as (Year of Date - 1990)*12 + Month of the Date.
3. Stkret: monthly stock return
4. Bondret: monthly bond return at the issuer level
5. Lagbret: twelve month lagged monthly bond return
6. Lagsret: twelve month lagged monthly stock return
7. Year: the year of the observation
8. Ag: year-over-year growth in total assets 
9. Roa: return on assets
10. Blev: book leverage
11. Bm: book to market ratio
12. Size: the natural logarithm of total assets
13. Beta: monthly stock beta

Note: “tworet.sas7bdat” include same variables as “tworet2.dta,” in SAS data format.

-------------------------------------------------------------
“regsent.sas7bdat” includes:
1. Bret: excess monthly bond return estimated using the transaction from the last five trading days of the month
2. YSD: changes in yield spreads
3. AG: year-over-year growth in total assets
4. GH: the issuer quality measure from Greenwood and Hanson (2013)
5. LSZ: the negative credit spreads measure from L_opez-Salido et al. (2017)
6. AG_LSZ: the interaction term of AG and LSZ
7. BW: overall market sentiment measure from Baker and Wurgler (2006)
8. AG_BW: the interaction term of AG and BW
9. AG_GH: the interaction term of AG and GH
10. LEV: book leverage
11. LEV_CHANGE: changes in book leverage
12. SIZE: the natural logarithm of total assets
13. ILQ: Amihud illiquidity measure (per million) based on Amihud (2002).
14. EDF: expected default frequency
15. DURATION: bond duration in years
16. PAR: the par value of debt initially issued
17. PUT: an indicator variable for puttable bonds 
18. CALL: an indicator variable for callable bonds
19. b_MKT: market risk factor
20. b_def: default risk factor
21. b_term: Term: term risk factor
22. FIRMRATING: lagged bond rating
23. year: the year of the observation
24. permno: CRSP Permanent Number

-------------------------------------------------------------
“regsentys.sas7bdat” includes:
1. ys: initial bond yield spreads
2. AG: year-over-year growth in total assets
3. GH: the issuer quality measure from Greenwood and Hanson (2013)
4. AG_GH: the interaction term of AG and GH
5. LSZ: the negative credit spreads measure from L_opez-Salido et al. (2017)
6. AG_LSZ: the interaction term of AG and LSZ
6. BW: overall market sentiment measure from Baker and Wurgler (2006)
7. AG_BW: the interaction term of AG and BW
8. LEV: book leverage
9. LEV_CHANGE: changes in book leverage
10. SIZE: the natural logarithm of total assets
11. ILQ: Amihud illiquidity measure (per million) based on Amihud (2002).
12. DURATION: bond duration in years
13. PAR: the par value of debt initially issued
14. PUT: an indicator variable for puttable bonds 
15. CALL: an indicator variable for callable bonds
16. FIRMRATING: lagged bond rating
17. year: the year of the observation
permno: CRSP Permanent Number
1
