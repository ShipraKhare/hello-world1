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
* Research Question 1                                                          ;
*******************************************************************************;
*
Methodology: Preprocessing within the data preparation file will sort on
exit data, creating a nice work.arrv and work.arrv_off SAS data sets upon which
one can specify the variables upon which to display.  Using a branch conditional
(that is an if-then statement) one can then specify hour and station
of egress.  Summing exits we find the number exiting the most popular
stations during the time for a Giants baseball game in San Francisco.
Then we will do the same thing for a non-ballgame day, and conduct ratio
analysis, percent change in risership.
;

title1 "Research Question: Does the ridership significantly differ during a downtown baseball game at ATT Park during a Giants game, with respect to an evening when there is no game?";
title2 "This should help identify projections for economic opportunity, local vendors.";
footnote1 bcolor=aquamarine bold underlin=1 "This study measures percent change in arrival ridership from the three San Francisco financial district BART stations, an hour before the opening pitch.  Game started at 3:15 PM, BART station arrival time for the entire 2 o'clock hour.";
footnote2 bcolor=aquamarine bold underlin=1 "Game day: September 30, 2016.  Control day: March 31, 2016";

proc print data=work.match_merge_records noobs;
run;

title;
footnote;

*******************************************************************************;
* Research Question 2                                                          ;
*******************************************************************************;
*
Methodology: Here we will focus on both EMBR and West Oakland stations, as 
between these two stations is only the transbay tunnel.  Once calculating
ridership load between the two stations we can compare loading and capacity
with respect to morning and evening commute.
;

title1 "Research Question: How do the ridership loads compare between the morning commute and the evening commute with respect to both directions of travel within the transbay tunnel?";
title2 "Rationale: As the transbay tunnel is the single nexis within the BART system it is imortant to know travel loads in order to forecast general maintenance.";
title3 "Percent change from morning to evening commute, BART San Francisco financial district stations.";
footnote1 bcolor=aquamarine bold underlin=1 "Aggregate entry and exit tracking to answer this question, both sides of the BART system -- San Francisco and East Bay.";
footnote2 bcolor=aquamarine bold underlin=1 "Morning rush hour: 7-9am.  Evening rush hour: 4-6pm.";

proc print data=work.compare_am_pm_rush noobs;
run;

title;
footnote;

*******************************************************************************;
* Research Question 3                                                          ;
*******************************************************************************;
*
Methodology: Sorting and using proc means with variance option it will be
possible to compute the variance between these two stations.
;

title1 "What is the standard deviation of ridership between Civic Center Station and S.F. financial district during the morning weekday commute?";
title2 "Rationale: The beginnings of an analysis of variance.";
title3 "Eventually would like to build prabability distribution.";
footnote1 bcolor=aquamarine bold underlin=1 "This analysis shows the great variagion between government employees headed to work at city hall and the private sector workers who head to their offices in S.F. financial district.";

proc means data=work.civic_center_am_rush;
run;

title;
footnote;