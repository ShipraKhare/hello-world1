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

*proc print data=barf (firstobs=6 obs=36);

*******************************************************************************;
* Research Question Analysis Starting Point;
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

PROC PRINT data=rider_ho NOOBS obs =10 ;
  
 RUN;


*******************************************************************************;
* Research Question Analysis Starting Point;
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
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: On an average in the month of March which income category had highest number of riders ?
(Rationale: )This would help Bart to increase or decrease the fare in accordance with the income category of riders.

Note: Compare and make decision

Methodology: 
;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: Find the station which has highest number of people walking to station ?
(Rationale: )This would help the public transport to introduce more transportation facilities.

Note: derive values and make decision

Methodology: 
;




run;
