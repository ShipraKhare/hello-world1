*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding Bart Ridership in bay area.

Dataset Name: <datset name> created in external file
STAT6250-01_w17-team-3_project2_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;

* environmental setup;
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

proc print data=barf;
run;

proc print data=ho;
run;

proc print data=stn;
run;

/* Takes a long time to display because there are so many records. */
/* It is best not to print this entire table, but use it in procs  */
/* when creating sub-sets of data.  In other words, use this table */
/* behind the scenes to build your custom SAS data objects.  That  */
/* kind of use will run faster.                                    */
proc print data=jan1;
run;

/* Takes a long time to display because there are so many records. */
/* It is best not to print this entire table, but use it in procs  */
/* when creating sub-sets of data.  In other words, use this table */
/* behind the scenes to build your custom SAS data objects.  That  */
/* kind of use will run faster.                                    */
proc print data=mar31;
run;

proc print data=ebay;
run;
*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question:Find the average ridership load for Saturday for the whole hour of 7pm,
at Hayward Station? 

Rationale:Showing the evening meal ridership usage and can help in targeted adv
-ertizing campaigns for restaurants utilizing social media, and geofencing. 

Note:May be extrapulated to other stations. 

Methodology: 
;




*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question:Does the male/female ridership significantly changes between first half 
and second half on a given day for Hayward station?

Rationale:If demographics shows more college age women ride into and out of Hayw
-ard station, use this as justification for better night lighting. 

Note: CSUEB actively supports security measures for its students
(Proff. eg :This compares the column "Percent (%) Eligible Free (K-12)" from 
frpm1415 to the column PCTGE1500 from sat15.)

Methodology: 

;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question:What total number of people traveling BART from Montgomery to SFO on we
-ekday are do so for reasons of employment? 

Rationale:Provide prospectable ridership locations and number of professionals 
for Uber drivers to service, and other vendors targeting traveling business people. 

Note:Service industry really looks to gain from data metrics as such. 
(This compares the column NUMTSTTAKR from sat15 to the column TOTAL from
gradaf15.)

Methodology: 
;