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
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: Does the ridership significantly differ during a downtown baseball 
game at ATT Park during a Giants game, with respect to an evening when there is
no game?

Rationale: This should help identify projections for economic opportunity, 
local vendors.

Note: Extending this analysis to a time series, regression analysis and 
projections may be presented, reported to congress in annual reports.

Methodology: Preprocessing within the data preparation file will sort on
exit data, creating a nice work.arrv SAS data object upon which one can 
specify the variables upon which to display.  Using a branch conditional
(that is an if-then statement) one can then specify hour and station
of egress.  Summing exits we find the number exiting the most popular
stations during the time for a Giants baseball game in San Francisco.
Then we will do the sam thing for a non-ballgame day, and conduct ratio
analysis.
;

proc print data=work.arrv;
    var exit hour;
    where exit in ('MONT', 'EMBR', 'POWL') and hour in (14, 15, 16);
    sum num;
run;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: How do the ridership loads compare between the morning commute and the
evening commute with respect to both directions of travel within the transbay 
tunnel?

Rationale: As the transbay tunnel is the single nexis within the BART system it
is imortant to know travel loads in order to forecast general maintenance.

Note: Aggregate entry and exit tracking to answer this question, both sides of 
the BART system -- San Francisco and East Bay.  Morning rush hour: 7-9am.
Evening rush hour: 4-6pm.

Methodology: Here we will focus on both EMBR and West Oakland stations, as 
between these two stations is only the transbay tunnel.  Once calculating
ridership load between the two stations we can compare loading and capacity
with respect to morning and evening commute.
;

proc print data=work.m_rush(keep=exit tot_num) noobs;
    sum tot_num;
run;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: What is the standard deviation of ridership between Civic Center 
Station and Embarcadero Station for each hour for one given day?

Rationale: The beginnings of an analysis of variance.

Note: Eventually would like to build prabability distribution.

Methodology: Sorting and using proc means with variance option it will be
possible to compute the variance between these two stations.
;
