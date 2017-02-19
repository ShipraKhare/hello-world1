*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding ridership data on the Bay Area Rapid Transit system, BART.

Dataset Name: .....................................created in external file
STAT6250-01_w17-team-3_project2_data_preparation.sas, which is assumed to be
in the same directory as this file

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

Methodology: 
;

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
the BART system -- San Francisco and East Bay.

Methodology: 
;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: What is the standard deviation of ridership between Civic Center 
Station and Embarcadero Station for each hour for one given day?

Rationale: The beginnings of an analysis of variance.

Note: Eventually would like to build prabability distribution.

Methodology: 
;
