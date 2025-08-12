/****************** bond return across AG deciles ***********************/

libname agbond 'C:\Users\yifeil\Dropbox\bondag\Replication\Replication Data';

libname agbond "F:\tong\research\agbond\datasets";

/* macro for D10 minus D1 raw return -- used in portfolio analysis part*/
%macro rawdiff(in, out);
data d1; set &in;
if agrank=0;
r11=ret1n; 
r12=ret2n;
r13=yieldn; 
r14=dyieldn; 
r15=ret1d;
r16=ret2d; 
r17=yieldd;
r18=dyieldd; 
keep agrank mno r11-r18;
proc sort; by mno;

data d10; set &in;
if agrank=9;
r101=ret1n; 
r102=ret2n;
r103=yieldn; 
r104=dyieldn; 
r105=ret1d;
r106=ret2d; 
r107=yieldd;
r108=dyieldd; keep agrank mno r101-r108;
proc sort; by mno;
run;

data hedge; merge d1 d10;
by mno;
ret1n=r101-r11; 
ret2n=r102-r12;
yieldn=r103-r13; 
dyieldn=r104-r14;
ret1d=r105-r15;
ret2d=r106-r16; 
yieldd=r107-r17;
dyieldd=r108-r18;
agrank=10;
keep agrank mno ret1n ret2n yieldn dyieldn ret1d ret2d yieldd dyieldd;
proc sort; by agrank;
run;

proc means data=hedge noprint;
var ret1n ret2n yieldn dyieldn ret1d ret2d yieldd dyieldd;
by agrank;
output out=hedgemean  mean=ret1n ret2n yieldn dyieldn ret1d ret2d yieldd dyieldd;
run;

data hedgemean; set hedgemean;
keep agrank ret1n ret2n yieldn dyieldn ret1d ret2d yieldd dyieldd;
run;

proc means data=hedge noprint;
var ret1n ret2n yieldn dyieldn ret1d ret2d yieldd dyieldd;
by agrank;
output out=hedget  t=ret1n ret2n yieldn dyieldn ret1d ret2d yieldd dyieldd;
run;

data hedget; set hedget;
keep ret1n ret2n yieldn dyieldn ret1d ret2d yieldd dyieldd;
run;

data &out; set hedgemean hedget; run;
%mend;


/*Table 2*/
/********* Create and sort the three datasets by  ratings *********/
/*Full Sample*/
data retag1; set agbond.retagrank;proc sort; by mno agrank ;run;
/*Investment Grade Bond Sample*/
data retag2; set retag1;if ing=1;proc sort; by mno agrank ;run;
/*Non-Investment Grade Bond Sample*/
data retag3; set retag1;if ing=0;proc sort; by mno agrank ;run;

/*********Equal-Weighted portfolios*************/
/* raw return */
%macro compute_all_ew;
    %local i datain dataout ret;
    %do i = 1 %to 3;
        %if &i = 1 %then %do;
            %let datain = retag1;
            %let dataout = ew_full;
            %let ret = ew_full;
        %end;
        %else %if &i = 2 %then %do;
            %let datain = retag2;
            %let dataout = ew_ing;
            %let ret = ew_ing;
        %end;
        %else %if &i = 3 %then %do;
            %let datain = retag3;
            %let dataout = ew_jk;
            %let ret = ew_jk;
        %end;

        proc means data=&datain noprint;
            var ret1 ret2 eret1 eret2 ys1 dys;
            by mno agrank;
            output out=groupret mean=ret1n ret2n eret1n eret2n yieldn dyieldn 
                            median=ret1d ret2d eret1d eret2d yieldd dyieldd;
        run;

        proc sort data=groupret; by agrank;

        proc means data=groupret noprint;
            var ret1n ret2n yieldn dyieldn ret1d ret2d yieldd dyieldd;
            by agrank;
            output out=ew_decileret(drop=_type_ _freq_) 
                   mean=ret1n ret2n yieldn dyieldn ret1d ret2d yieldd dyieldd;
        run;

        /* Estimate difference and t-stat of D10 minus D1 */
        %rawdiff(groupret, hedgeport);

        data &dataout;
            set ew_decileret hedgemean hedget;
            &ret = ret1n;
            if agrank = . then agrank = 11;
            keep agrank &ret;
        run;

        proc sort data=&dataout; by agrank;

    %end;

    /* Combine all */
    data ew_ret;
        merge ew_full ew_ing ew_jk;
        by agrank;
		proc sort;by agrank;
    run;
%mend;

/* Call the macro */
%compute_all_ew;

/*********Value-Weighted portfolios*************/
/* raw return */
%macro compute_all_vw;
    %local i datain dataout ret;
    %do i = 1 %to 3;
        %if &i = 1 %then %do;
            %let datain = retag1;
            %let dataout = vw_full;
            %let ret = vw_full;
        %end;
        %else %if &i = 2 %then %do;
            %let datain = retag2;
            %let dataout = vw_ing;
            %let ret = vw_ing;
        %end;
        %else %if &i = 3 %then %do;
            %let datain = retag3;
            %let dataout = vw_jk;
            %let ret = vw_jk;
        %end;

        proc means data=&datain noprint;
            var ret1 ret2 eret1 eret2 ys1 dys;
            by mno agrank;weight bondsize;
            output out=groupret mean=ret1n ret2n eret1n eret2n yieldn dyieldn 
                            median=ret1d ret2d eret1d eret2d yieldd dyieldd;
        run;

        proc sort data=groupret; by agrank;

        proc means data=groupret noprint;
            var ret1n ret2n yieldn dyieldn ret1d ret2d yieldd dyieldd;
            by agrank;
            output out=ew_decileret(drop=_type_ _freq_) 
                   mean=ret1n ret2n yieldn dyieldn ret1d ret2d yieldd dyieldd;
        run;

        /* Estimate difference and t-stat of D10 minus D1 */
        %rawdiff(groupret, hedgeport);

        data &dataout;
            set ew_decileret hedgemean hedget;
            &ret = ret1n;
            if agrank = . then agrank = 11;
            keep agrank &ret;
        run;

        proc sort data=&dataout; by agrank;

    %end;

    /* Combine all */
    data vw_ret;
        merge vw_full vw_ing vw_jk;
        by agrank;
		proc sort;by agrank;
    run;
%mend;

/* Call the macro */
%compute_all_vw;

data rawret;merge ew_ret vw_ret;by agrank;run;

/*agrank =10 indicates the return differences.*/
/*agrank =11 indicates t-stats.*/

proc export data=rawret outfile='C:\Users\yifeil\Dropbox\bondag\Duplicate\Replication Results\t2_rawret.xlsx' dbms = xlsx replace;
run;

/*Estimating EW alphas*/
%macro ew_alpha;

%let n = 3;  /* number of datasets to loop over */
%do i = 1 %to &n;

    /* Set inputs and outputs based on loop index */
    %if &i = 1 %then %do;
        %let datain = retag1;
        %let dataout = ew_full;
        %let alphaout = ew_full_alpha;
        %let nwtout = ew_full_nwt;
    %end;
    %else %if &i = 2 %then %do;
        %let datain = retag2;
        %let dataout = ew_ing;
        %let alphaout = ew_ing_alpha;
        %let nwtout = ew_ing_nwt;
    %end;
    %else %if &i = 3 %then %do;
        %let datain = retag3;
        %let dataout = ew_jk;
        %let alphaout = ew_jk_alpha;
        %let nwtout = ew_jk_nwt;
    %end;

    /* Step 1: Calculate average return for each group */
    proc means data=&datain noprint;
        var eret1;
        by mno agrank;
        output out=groupret mean=ret1n;
    run;

    /* Step 2: Extract group 0 and group 9 returns */
    data d1; set groupret;
        if agrank = 0;
        r1 = ret1n;
        keep mno r1;
    run;

    data d10; set groupret;
        if agrank = 9;
        r10 = ret1n;
        keep mno r10;
    run;

    proc sort data=d1; by mno; run;
    proc sort data=d10; by mno; run;

    /* Step 3: Load factors */
    data factors;
        set agbond.bfactors;
        mno = (year(date) - 1990) * 12 + month(date);
        keep mno date mktb def term lrf;
    run;

    proc sort data=factors; by mno; run;

    /* Step 4: Merge and create return difference */
    data ret_diff;
        merge d1(in=a) d10(in=b) factors;
        by mno;
        if a and b;
        ret_diff = r10 - r1;
        keep mno date ret_diff mktb def term lrf;
    run;

    /* Step 5: Time-series regression to estimate alphs */

	proc reg data=ret_diff;
    model ret_diff = mktb def term lrf;
    ods output ParameterEstimates=param2;
	run;

	data &dataout;
    set param2;
    if Variable = "Intercept";
	type = "&dataout";
    alpha = estimate;
    tvalue = tvalue;
	pvalue =Probt;
    keep type alpha tvalue pvalue;
    run;

%end;

%mend ew_alpha;

/* Run the macro */
%ew_alpha;


/*Estimating VW alphas*/
%macro vw_alpha;

%let n = 3;  /* number of datasets to loop over */
%do i = 1 %to &n;

    /* Set inputs and outputs based on loop index */
    %if &i = 1 %then %do;
        %let datain = retag1;
        %let dataout = vw_full;
        %let alphaout = vw_full_alpha;
        %let nwtout = vw_full_nwt;
    %end;
    %else %if &i = 2 %then %do;
        %let datain = retag2;
        %let dataout = vw_ing;
        %let alphaout = vw_ing_alpha;
        %let nwtout = vw_ing_nwt;
    %end;
    %else %if &i = 3 %then %do;
        %let datain = retag3;
        %let dataout = vw_jk;
        %let alphaout = vw_jk_alpha;
        %let nwtout = vw_jk_nwt;
    %end;

    /* Step 1: Calculate average return for each group */
    proc means data=&datain noprint;
        var eret1;weight bondsize;
        by mno agrank;
        output out=groupret mean=ret1n;
    run;

    /* Step 2: Extract group 0 and group 9 returns */
    data d1; set groupret;
        if agrank = 0;
        r1 = ret1n;
        keep mno r1;
    run;

    data d10; set groupret;
        if agrank = 9;
        r10 = ret1n;
        keep mno r10;
    run;

    proc sort data=d1; by mno; run;
    proc sort data=d10; by mno; run;

    /* Step 3: Load factors */
    data factors;
        set agbond.bfactors;
        mno = (year(date) - 1990) * 12 + month(date);
        keep mno date mktb def term lrf;
    run;

    proc sort data=factors; by mno; run;

    /* Step 4: Merge and create return difference */
    data ret_diff;
        merge d1(in=a) d10(in=b) factors;
        by mno;
        if a and b;
        ret_diff = r10 - r1;
        keep mno date ret_diff mktb def term lrf;
    run;

    /* Step 5: Time-series regression to estimate alphs */

	proc reg data=ret_diff;
    model ret_diff = mktb def term lrf;
    ods output ParameterEstimates=param2;
	run;

	data &dataout;
    set param2;
    if Variable = "Intercept";
	type = "&dataout";
    alpha = estimate;
    tvalue = tvalue;
	pvalue =Probt;
    keep type alpha tvalue pvalue;
    run;

%end;

%mend vw_alpha;

/* Run the macro */
%vw_alpha;

data t2_alphas;retain type alpha;set ew_full ew_ing ew_jk vw_full vw_ing vw_jk;run;

proc export data=t2_alphas outfile='C:\Users\yifeil\Dropbox\bondag\Duplicate\Replication Results\t2_alpha.xlsx' dbms = xlsx replace;
run;
