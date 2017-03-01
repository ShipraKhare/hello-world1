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

title1 
"Research Question:How significantly does the ridership changes in Embercadero station on new year's eve as compare to any normal day?"
;

title2
"Rationale:This should help rideshare companies to plan surge and availability of rides and plan targeted advertizing campaigns for special events in SFO financial district."
;

footnote1 bcolor=antiquewhite bold underlin=1
" Average ridership during event hours for Embercadero station on normal day Vs New year's evening."
;

footnote2 bcolor=antiquewhite bold underlin=1
"Ridership on special events has a very significant rise as compared to any normal day."
;

*
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

title;
footnote;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
title1
" Question: Does the ridership significantely differs for San Francisco stations as compared to the stations in Hayward and Fremont area for a given month?"
;

title2
"Rationale:It would help us understand and plan for proper resources,infrastructure, advertisements and fedral funding allocation for major BART Stations."
;

footnote1 bcolor=antiquewhite bold underlin=1
" Stations in the SFO area shows very high avarage rideship as compare to stations in Fremont. "
;

footnote2 bcolor=antiquewhite bold underlin=1
" Very high amount of people uses bart for comute to SFO and back as compare to any other area. "
;

*
Methodology: We picked up 2 clusters of stations on SF and Hayward area from
the barf_interlv dataset. Namely SF stations were EM, MT, PL and CC whereas Fremont 
stations are HY, SH, UC and FM. Using proc means to calculate the mean riders-
-ship date for these 2 clusters shows a 10 times more usage in SF area as 
compared to the Hayward/Fremont BART stations. 
;

proc means data = barf_interlv mean ; /*calculating mean for 2 station clusters*/
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

title;
footnote;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
"Question:Which station has the highest bart ridership for the reason of workplace and what are the top two destinations of their work?"
;

title2
" Rationale: This will help BART streamline job related advertisements on specific station. This data can also be shared with other job sites and job related services."  
;

footnote bcolor=antiquewhite bold underlin=1
" South Hayward is the station with highest rideship for people who use bart for Workplace. "
;

*
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

title;
footnote;

footnote bcolor=antiquewhite bold underlin=1
"Top two destinations for workplace comute using bart are Embarcadero and Montgomary."
;

proc print data = barf_interlv_SH (obs=2) label;/* top 2 stations for South Hayward*/
var Name;
label Name = " Top destinations for workplace";
run;

footnote;

