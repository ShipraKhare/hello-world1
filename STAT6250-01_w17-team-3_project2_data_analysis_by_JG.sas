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

proc print data=ebay;
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
