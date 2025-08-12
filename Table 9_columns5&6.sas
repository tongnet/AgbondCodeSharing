/****************** stock and bond return relationship ***********************/
/**** monthly regressions ******************/

libname agbond 'C:\Users\yifeil\Dropbox\bondag\Replication\Replication Data';

libname agbond "d:\tong\research\agbond\datasets";

data tworet2;set agbond.tworet;run;

/************ simultaneous equation modeling ****************/
proc model data=tworet2;
   endogenous stkret bondret;  /* Declare Y and X2 as endogenous */
   instruments lagbret ag blev roa size bm beta;  /* Use lagged variables as instruments */
   parameters beta1 beta2-beta8 gamma1-gamma7;     /* Declare parameters to be estimated */
   /* Structural Equations */
eq.y_eq =stkret  - (beta1*ag + beta2*bondret+beta3*blev+beta4*roa+beta5*size+beta6*bm+beta7*beta);
eq.x_eq=bondret - (gamma1*ag+gamma2*blev+gamma3*roa+gamma4*size+gamma5*bm+gamma6*beta);

   /* Fit using Generalized Method of Moments (GMM) */
   fit y_eq x_eq / gmm;
run; 

