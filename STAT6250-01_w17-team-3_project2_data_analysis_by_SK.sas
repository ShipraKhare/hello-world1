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

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question:How significantly does the ridership changes in Embercadero station on 
new year's eve as compare to any normal day?

Rationale:May help rideshare companies to plan surge and availability of rides 
based on ridership usage and can help in targeted advertizing campaigns for 
special events in san Fransisco financial district.

Methodology: When combining jan1 and mar31 datasets we created in data preperation
file a new dataset for the Embarcardero station for hourly data for 0,1 and 2 
hours (1200 hrs,1300 hrs,1400 hrs) for the dates jan 1st and march 31st.Here 
we use proc mean to calculate mean by DATE and then use proc print to print the 
mean data for 1st of Jan as Compared to March 31st for the hours 0,1 and 2.
;
 
proc means data = jan_mar_EMBR mean NOPRINT;  /*calculating average*/
by date;
OUTPUT
out = jan_mar_EMBR_out (DROP = _TYPE_ _FREQ_ HOUR);
run; 

proc print data = jan_mar_EMBR_out NOOBS;  /*Printing avaerages for both dates*/
where _STAT_ = 'MEAN';
run;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: Does the ridership significantely differs for San Francisco stations
as compared to the stations in Hayward and Fremont area for a given month?

Rationale:It would help us understand and plan for proper resources, 
infrastructure, advertisements and fedral funding allocation for major BART
Stations. 

Methodology: We picked up 2 clusters of stations on SF and Hayward area from
the barf dataset. Namely SF stations were EM, MT, PL and CC whereas Fremont 
stations are HY, SH, UC and FM. Using proc means to calculate the mean riders-
-ship date for these 2 clusters shows a 10 times more usage in SF area as 
compated to the Hayward/Fremont BART stations. 
;

proc means data = barf mean;      /*calculating averages for two station clusters*/
var EM MT PL CC HY	SH	UC	FM;
run; 


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question:Which station has the highest number of  people traveling BART for 
reasons of employment? 

Rationale: This will help BART streamline job related advertisements on 
specific station. This data can also be shared with other job sites and
job related services.  

Methodology: Using the interleaved data "barf_interlv" of "barf" and "HO" 
from the data preperation file we have sorted the data by workplace variable
and then used the proc print to print the top BART station with maximum #
of riders traveling for employmnent. 
;

proc sort data = barf_interlv out = barf_interlv_wrkplace_sort ;
by DESCENDING workplace;       /*Sorting data by descending workplace */
run;

proc print data = barf_interlv_wrkplace_sort (obs=1); /*printing top station*/
var Name;
run;

