*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding ridership data on the Bay Area Rapid Transit system, BART.
Dataset Name: barf, ho, barf_interlv, arrv created in external file
STAT6250-01_w17-team-3_project2_data_preparation.sas, which is assumed to be
in the same directory as this file.
See included file for dataset properties
;

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
Question: Is there is a positive or negative corellation between number of 
vehicles available in household Vs number of riderships in a station ?

Rationale:This would help us to find if number of vehicle available in 
household change the number of riderships from particular station. 
In future if new stations needs to be opened up the demographic information 
can be used to evaluate the location.


Methodology: 1. Find the sum of each station
             2.Using proc sql append the total as column
             3.Using the value from percentage of vehicle available at home 
             Vs this column do the regression analysis
;

proc means data=barf_interlv  mean ; 
    id NAME;
    var  RM EN EP NB
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
        ;
    output 
    out =  BART_MEAN_RIDERS (DROP = _TYPE_ _FREQ_); 
run;

title "Using SGPLOT to Produce a Histogram";

proc sgplot data=barf_interlv ;

   histogram NO_V;

run;

 


*******************************************************************************;
* Research Question Analysis Number of Frequent BART riders;
*******************************************************************************;
*
Question: Find the station which has highest and lowest frequent riders ?

(Rationale:) This would help the business to see where there are less 
frequent riders and see if something needs to be improved in that 
station like make it clean, building elevators or other facilities 
which would help us improve the station in general to increase the frequent riders.

Methodology: 1.PROC GGPLOT between the number of riders in station vs Frequent riders
;




title "Linear Regression Model for High frequency riders from Richmond";

proc reg data= barf_interlv;

   model RM = HIGH_FREQ;

run;

quit;




*******************************************************************************;
* Research Question Analysis Increase or decrease BART fair;
*******************************************************************************;
*
Question: On an average in the month of March which income category had highest
 number of riders ?
 
Rationale:This would help Bart to increase or decrease the fare in accordance
 with the income category of riders.

Methodology: 1. Find the max of number in income category 
             2.Compare the number with less income category
             3.Infer based on comparison
;

title "Histogram of High Income riders";

proc univariate data=barf_interlv;

   id NAME;

   var  EN  I_V_HIGH;

   histogram;

   probplot / normal(mu=est sigma=est);

run;
*******************************************************************************;
* Research Question Walkers to BART;
*******************************************************************************;
*
Question: Find the station which has highest number of people walking to
 station ?
 
Rationale:This would help the public transport to introduce more 
transportation facilities.

Methodology: 1.Find the station with highest number of walkers.Again do 
a max of walkers
             2.Find the station and infer based on results
;

title "Scatter Plot for People walking to Bart in Walnut Creek Station ";

proc sgplot data = barf_interlv;

scatter x = WC  y = Walk;

run;


