libname agbond 'C:\Users\yifeil\Dropbox\bondag\Replication\Replication Data';

%macro t3diff(in, out);
data d1; set &in;
if agrank=0;
r11=ag; 
r12=delta_ta_at;
r13=delta_ia_at;
r14=delta_td_at; 
r15=delta_opliab_at; 
r16=edf;
r17=edf_chge; 
r18=lead_edf_chge;
r19=amihud; 
r20=tg; 
r21=ig; 
r22 = blev;
keep agrank mno r11-r22;
proc sort; by mno;

data d10; set &in;
if agrank=9;
r101=ag; 
r102=delta_ta_at;
r103=delta_ia_at;
r104=delta_td_at; 
r105=delta_opliab_at; 
r106=edf;
r107=edf_chge; 
r108=lead_edf_chge;
r109=amihud; 
r110=tg; 
r111=ig; 
r112=blev;
keep agrank mno r101-r112;
proc sort; by mno;
run;

data hedge; merge d1 d10;
by mno;
ag=r101-r11; 
delta_ta_at=r102-r12;
delta_ia_at=r103-r13; 
delta_td_at=r104-r14;
delta_opliab_at=r105-r15;
edf=r106-r16; 
edf_chge=r107-r17;
lead_edf_chge=r108-r18;
amihud=r109-r19;
tg=r110 - r20;
ig=r111 - r21;
blev = r112 - r22;
agrank=10;
keep agrank mno ag delta_ta_at delta_ia_at delta_td_at delta_opliab_at edf edf_chge lead_edf_chge amihud tg ig blev;
proc sort; by agrank;
run;

proc means data=hedge noprint;
var ag delta_ta_at delta_ia_at delta_td_at delta_opliab_at tg ig edf edf_chge lead_edf_chge blev amihud;
by agrank;
output out=hedgemean  mean=ag delta_ta_at delta_ia_at delta_td_at delta_opliab_at tg ig edf edf_chge lead_edf_chge blev amihud;
run;

data hedgemean; set hedgemean;
keep agrank ag delta_ta_at delta_ia_at delta_td_at delta_opliab_at tg ig edf edf_chge lead_edf_chge blev amihud;
run;

proc means data=hedge noprint;
var ag delta_ta_at delta_ia_at delta_td_at delta_opliab_at tg ig edf edf_chge lead_edf_chge blev amihud;
by agrank;
output out=hedget  t=ag delta_ta_at delta_ia_at delta_td_at delta_opliab_at tg ig edf edf_chge lead_edf_chge blev amihud;
run;

data hedget; set hedget;
keep ag delta_ta_at delta_ia_at delta_td_at delta_opliab_at tg ig edf edf_chge lead_edf_chge blev amihud:
run;

data &out; set hedgemean hedget; run;
%mend;


/*Table 1: Summary Statistics*/
data t1;
set agbond.retagrank;
OFFERING_AMT = OFFERING_AMT/1000000;
/*in billions*/
at_billion = at/1000;
ret1_pct = ret1 *100;
yield_pct = yield *100;
ys_pct = ys *100;
run;

proc means data= t1 p5 p25 mean median p75 p95 std; 
var ret1_pct yield_pct ys_pct rating duration coupon OFFERING_AMT amihud call put ag tg ig at_billion blev blevchge edf;
run;

/*Table 3*/
proc sort data=agbond.retagrank out=t3; by mno agrank;
proc means data=t3 noprint;
var ag delta_ta_at delta_ia_at delta_td_at delta_opliab_at tg ig  edf edf_chge lead_edf_chge blev amihud;
by mno agrank;
output out=t3group(drop=_type_ _freq_) mean=ag delta_ta_at delta_ia_at delta_td_at delta_opliab_at tg ig  edf edf_chge lead_edf_chge blev amihud  ;
run;

proc sort data=t3group;by agrank;
proc means data=t3group noprint;
var ag delta_ta_at delta_ia_at delta_td_at delta_opliab_at tg ig  edf edf_chge lead_edf_chge blev amihud  ;
by agrank;
output out=decile (drop=_type_ _freq_) mean=ag delta_ta_at delta_ia_at delta_td_at delta_opliab_at tg ig  edf edf_chge lead_edf_chge blev amihud ;
run;

%t3diff(t3group, hedgeport);

data t3; set decile hedgeport ;if agrank =. then agrank =11; run;

/*agrank =10 indicates the differences between top and bottom deciles*/
/*agrank =11 indicates t-stats*/

proc export data=t3 outfile='C:\Users\yifeil\Dropbox\bondag\Replication\Replication Results\t3_results.xlsx' dbms = xlsx replace;
run;




