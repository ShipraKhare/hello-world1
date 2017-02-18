%let dataPrepFileName = STAT6250-01_w17-team-3_project2_data_preparation.sas;
%let sasUEFilePrefix = team-3_project2;



%macro setup;
%if
	&SYSSCP. = WIN
%then
	%do;
		X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";			
		%include ".\&dataPrepFileName.";
	%end;
%else
	%do;
		%include "~/&sasUEFilePrefix./&dataPrepFileName.";
	%end;
%mend;
%setup;


*******************************************************************************;
* Research Question Analysis Vehicles/Bart Rider;
*******************************************************************************;
*
Question: Is there is a positive or negative corellation between number of vehicles available 
in household Vs number of riderships in a station ?

Rationale:This would help us to find if number of vehicle available in household change the number of riderships from
particular station. In future if new stations needs to be opened up the demographic information can be used
to evaluate the location.

Note: Corellation analysis between number of passengers and number of passengers with zero vehicles

Methodology: 
;

DATA rider_ho;
	SET work.BARF;
	SET work.HO;
RUN;



PROC PRINT DATA=rider_ho ;
id NAME;
sum RM EN
        EP
        NB
        BK
        AS
        MA
        l9
        l2
        LM
        FV
        CL
        SL
        BF
        HY
        SH
        UC
        FM
        CN
        PH
        WC
        LF
        OR
        RR
        OW
        EM
        MT
        PL
        CC
        l6
        z4
        GP
        BP
        DC
        CM
        CV
        ED
        NC
        WP
        SS
        SB
        SO
        MB
        WD
        OA
        WS
;
RUN;

PROC PRINT data=rider_1   ;
  
 RUN;
 
/*PROC MEANS DATA=rider_ho NOPRINT MEAN;
class UID;
var RM
        EN
        EP
        NB
        BK
        AS
        MA
        l9
        l2
        LM
        FV
        CL
        SL
        BF
        HY
        SH;
OUTPUT 
    OUT =  RIDER_MEAN_HO (DROP = _type_ _freq_) mean= median= std= q1= q3= / autoname; 
run;        



/* Transpose the data set so that each statistic becomes an observation. */
/*proc transpose data=RIDER_MEAN_HO out=out;
run;

PROC PRINT data=RIDER_MEAN_HO   ;
RUN;
 
/* Create new variables that contain the statistic name and the */
/* original variable name. */
 
/*data out1;
set out;
varname=scan(_name_,1,'_');
stat=scan(_name_,2,'_');
drop _name_;
run;
 
proc sort data=out1;
by varname;
run;
 
/* Transpose the data to get one observation for each  */
/* original variable name and one variable for each    */
/* statistic.  This mimics the default printed output. */
 
/*proc transpose data=out1 out=out2(drop=_name_);
by varname;
id stat;
var col1;
run;
 
proc print data=out2;
title 'Looks like default printed output';
run;
PROC PRINT data=RIDER_MEAN_HO   ;
  
 RUN;
 

 
 


*******************************************************************************;
* Research Question Analysis Number of Frequent BART riders;
*******************************************************************************;
*
Question: Find the station which has highest and lowest frequent riders ?
(Rationale:) This would help the business to see where there are less frequent riders and see if something needs to be
improved in that station like make it clean, building elevators or other facilities which would help
us improve the station in general to increase the frequent riders.

Note:Data visualization

Methodology: 
;

*******************************************************************************;
* Research Question Analysis Increase or decrease BART fair;
*******************************************************************************;
*
Question: On an average in the month of March which income category had highest number of riders ?
(Rationale: )This would help Bart to increase or decrease the fare in accordance with the income category of riders.

Note: Compare and make decision

Methodology: 
;

*******************************************************************************;
* Research Question Walkers to BART;
*******************************************************************************;
*
Question: Find the station which has highest number of people walking to station ?
(Rationale: )This would help the public transport to introduce more transportation facilities.

Note: derive values and make decision

Methodology: 
;



