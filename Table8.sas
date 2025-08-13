/*******Table 8 - Investor Sentiment Effects on Bond Excess Returns, Credit Spread and Credit Spread Changes ************/

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



