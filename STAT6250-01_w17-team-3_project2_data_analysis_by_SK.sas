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

proc print data = jan_mar_EMBR_out noobs label;  /*Printing averages for both dates*/
where _STAT_ = 'MEAN';
label _STAT_ = "Measure";
label NUM = "Average Ridership";
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
the barf_interlv dataset. Namely SF stations were EM, MT, PL and CC whereas Fremont 
stations are HY, SH, UC and FM. Using proc means to calculate the mean riders-
-ship date for these 2 clusters shows a 10 times more usage in SF area as 
compared to the Hayward/Fremont BART stations. 
;

proc means data = barf_interlv mean; /*calculating mean for 2 station clusters*/
var EM MT PL CC HY	SH	UC	FM;
label EM = "Embarcadero( SFO station)";
label MT = "Montgomery (SFO Station)" ;
label PL = "Powell Street (SFO Station)";
label CC = "Civic Center( SFO Station)";
label HY = "Hayward (Fremont Station)";
label SH = "south Hayward (Fremont station)";
label UC = "Union City ( Fremont Station)";
label FM = "Fremont (Fremont Station)";
run; 


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question:Which station has the highest bart ridership for the reason of workplace
and what are the top two destinations of their work?

Rationale: This will help BART streamline job related advertisements on 
specific station. This data can also be shared with other job sites and
job related services.  

Methodology: Using the interleaved data "barf_interlv" of "barf" and "HO" 
from the data preperation file we have sorted the data by workplace variable
and then used the proc print to print the top BART station with maximum #
of riders traveling for work.And then sorting the data to get the top station
where the people are going for work. 
;

proc print data = barf_interlv_wrkplace_sort (obs=1) label; /*print top station*/
var Name;
label Name = "Top Station with work ridership";
run;

proc print data = barf_interlv_SH (obs=2) label; /*print 2 top station for SH*/
var Name;
label Name = " Top destinations for workplace";
run;

