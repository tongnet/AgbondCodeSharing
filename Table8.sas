/*******Table 8 - Investor Sentiment Effects on Bond Excess Returns, Credit Spread and Credit Spread Changes ************/

/****
Definitions of the variables in “regsent. sas7bdat” data frame:
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
****/

/****
Definitions of the variables in “regsentys. sas7bdat” data frame:
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
****/

libname bret 'C:\Users\fchen\Dropbox\data\Replication\Replication Data for Final Submission';

data regsent1;
set bret.regsent;
run;

/***sentiment test: regression on bond return***/
ods output ParameterEstimates=bret_GH_fixed;
title "Bond RET reg on GH";
proc glm data=regsent1;
    /* Model 14 */
	  class year permno;
      model bret = AG_GH AG GH  LEV LEV_CHANGE SIZE ILQ DURATION PAR PUT CALL  b_MKT b_term b_def FIRMRATING year permno / solution;
run;
quit;

ods output ParameterEstimates=bret_LSZ_fixed;
title "Bond RET reg on LSZ";
proc glm data=regsent1;
    /* Model 16 */
	  class year permno;
      model bret = AG_LSZ AG LSZ  LEV LEV_CHANGE SIZE ILQ DURATION PAR PUT CALL  b_MKT b_term b_def FIRMRATING year permno / solution;   
run;
quit;

ods output ParameterEstimates=bret_BW_fixed;
title "Bond RET reg on BW";
proc glm data=regsent1;
    /* Model 15 */
	  class year permno;
      model bret = AG_BW AG BW  LEV LEV_CHANGE SIZE ILQ DURATION PAR PUT CALL  b_MKT b_term b_def FIRMRATING year permno / solution;	
run;
quit;

/***sentiment test: regression on yield spread change***/
ods output ParameterEstimates=YSD_GH_fixed;
title "Yield Spread Change reg on GH";
proc glm data=regsent1;
	class year permno;
     model ysd = AG_GH AG GH LEV LEV_CHANGE SIZE ILQ DURATION PAR PUT CALL FIRMRATING EDF year permno / solution; 
run;
quit;

ods output ParameterEstimates=YSD_LSZ_fixed;
title "Yield Spread Change reg on LSZ";
proc glm data=regsent1;
	class year permno;
     model ysd = AG_LSZ AG LSZ LEV LEV_CHANGE SIZE ILQ DURATION PAR PUT CALL FIRMRATING EDF year permno / solution;	
run;
quit;

ods output ParameterEstimates=YSD_BW_fixed;
title "Yield Spread Change reg on BW";
proc glm data=regsent1;
	class year permno;
     model ysd = AG_bw AG bw  LEV LEV_CHANGE SIZE ILQ DURATION PAR PUT CALL FIRMRATING EDF year permno / solution; 
run;
quit;


/***sentiment test: regression on yield spread***/

data regsentys;
set bret.regsentys;
run;

/***sentiment test: regression on yield spread***/
ods output ParameterEstimates=ys_GH_fixed;
title "Yield Spread reg on GH";
proc glm data=regsentys;
    class year permno; 
    model ys = AG_GH AG GH  LEV LEV_CHANGE SIZE ILQ DURATION PAR PUT CALL FIRMRATING year permno / solution;  	
run;
quit;

ods output ParameterEstimates=ys_LSZ_fixed;
title "Yield Spread reg on LSZ";
proc glm data=regsentys;
    class year permno; 
    model ys = AG_LSZ AG LSZ  LEV LEV_CHANGE SIZE ILQ DURATION PAR PUT CALL FIRMRATING year permno / solution;  	
run;
quit;

ods output ParameterEstimates=ys_BW_fixed;
title "Yield Spread reg on BW";
proc glm data=regsentys;
    class year permno; 
    model ys = AG_BW AG BW   LEV LEV_CHANGE SIZE ILQ DURATION PAR PUT CALL FIRMRATING year permno / solution;  	
run;
quit;



