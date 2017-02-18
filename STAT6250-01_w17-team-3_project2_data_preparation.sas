*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

* 
[Team Number] team-3
--
[Dataset 1 Name] mar_16
[Dataset Description] Average BART ridership for the month of March 2016
[Experimental Unit Description] BART Stations
[Number of Observations] 277
[Number of Features] 47
[Data Source]  http://www.bart.gov/sites/default/files/docs/ridership_2016.zip
[Data Dictionary]  http://www.bart.gov/sites/default/files/docs/Station_Names.xls
[Unique ID Schema] The first column in the data set, labeled UID (3-letter code
    for Unique Identification), numeric data type.
--
[Dataset 2 Name] Jan1_16
[Dataset Description] Hourly ridership report for January 1, 2016
[Experimental Unit Description] Number of riders, origin and destination with
    respect to hour traveled.
[Number of Observations] 21,934
[Number of Features] 5
[Data Source] http://64.111.127.166/origin-destination/date-hour-soo-dest-2016.csv.gz
[Data Dictionary] DATE: date of ride, HOUR: the hour of the ride, ENTRY: station
    of entry, EXIT: station of exit, NUM: number of riders who traveled from
    and to.
[Unique ID Schema] Columns Date, Hour, Entry, and Exit uniquely identify each 
    observation, as a composit unique ID.
--
[Dataset 3 Name] Mar31_16
[Dataset Description] Hourly ridership report for March 31, 2016
[Experimental Unit Description] Number of riders, origin and destination with 
    respect to hour traveled.
[Number of Observations] 29,155
[Number of Features] 5
[Data Source]  http://64.111.127.166/origin-destination/date-hour-soo-dest-2016.csv.gz
[Data Dictionary] DATE: date of ride, HOUR: the hour of the ride, ENTRY: station
    of entry, EXIT: station of exit, NUM: number of riders who traveled from and
    to.
[Unique ID Schema] Columns Date, Hour, Entry, and Exit uniquely identify each 
    observation, as a composit unique ID.
--
[Dataset 4 Name] Station_Names
[Dataset Description] Data dictionary reference of two-letter and four-letter 
    station identifiers keys used in entry and exit data sets.
[Experimental Unit Description] Station name equated to two and four letter 
    abbreviations.
[Number of Observations] 46
[Number of Features] 3
[Data Source]  http://www.bart.gov/sites/default/files/docs/Station_Names.xls
[Data Dictionary] This file is a name/value lookup table, data dictionary 
    for variable names.
[Unique ID Schema] The column Code_2 is the unique id.
--
[Dataset 5 Name] HomeOrigin
[Dataset Description] Ridership demographic study conducted by BART.
[Experimental Unit Description] BART station
[Number of Observations] 44
[Number of Features] 22
[Data Source]  http://www.bart.gov/about/reports/profile
[Data Dictionary]
              UID            - ID representing each station
              NO_V           - No Vehicle
              MORE_V         - More than one vehicle
              HIGH_FREQ      - High frequency Uses bart more than 5 times in a week
              AB_AV_FREQ     - Above Averaga frequency 3-4 times in a week
              AV_FREQ        - Avergae frequence 1-2 times a week
              BEL_AV_FREQ    - Below Frequencey 1-3 days per month
              LOW_FREQ       - Low frequency less than once  a month
              I_V_LOW        - Income very low (Under $25,000)
              I_LOW          - Income Low ($25,000 - $34,999
              I_BEL_AVG      - Income below Average($35,000 - $39,999)
              I_AVG          - Income Average($40,000 -49,999)
              I_AB_AVG       - Income above Average($50,000 -$59,999)
              I_HIGH         - Income high($60,000 -$74,999)
              I_V_HIGH       - Income very high($75,000 -$99,999)
              I_B_TOP        - Income below top($100,000 -$149,999)
              I_TOP          - Income Top($150,000+)
              Male           - Male
              Female         - Female
              Walk           - Walk
              Workplace      - work related travel
              W_BUS_APP      - appointment related to work
[Unique ID Schema] Column 1, UID
--
[Dataset 6 Name] Weekday_Entry_Eastbay_2016
[Dataset Description] Eastbay only weekday station entry
[Experimental Unit Description] Stations passenger numbers on weekday in the 
    east bay
[Number of Observations] 552
[Number of Features] 33
[Data Source] https://www.bart.gov/about/reports/ridership
[Data Dictionary] https://www.bart.gov/sites/default/files/docs/Station_Names.xls
[Unique ID Schema] UID
--
;

* setup environmental parameters;
%let mar16DatasetURL =
  /*https://github.com/stat6250/team-3_project2/blob/master/data/mar_16.xls?raw=true */
  http://filebin.ca/3BljJfFK6653/mar_16.xls
;

%let homeOriginURL =
  /*https://github.com/stat6250/team-3_project2/blob/master/data/HomeOrigin.xls?raw=true*/
  http://filebin.ca/3CqUplYkveQw/HomeOrigin.xls
;

%let stnNameURL =
  /*https://github.com/stat6250/team-3_project2/blob/master/data/Station_Names.xls?raw=true */
  http://filebin.ca/3CqVKzJN9RWB/Station_Names.xls
;

%let jan1URL =
  /*https://github.com/stat6250/team-3_project2/blob/master/data/Jan1_16.xls?raw=true */
  http://filebin.ca/3CQT37enXRRb/Jan1_16.xls
;

%let mar31URL =
  /*https://github.com/stat6250/team-3_project2/blob/master/data/mar31_16.xls?raw=true */
  http://filebin.ca/3CQaYKMNsSfI/mar31_16.xls
;

%let ebEntryURL =
  /*https://github.com/stat6250/team-3_project2/blob/master/data/Weekday_Entry_Eastbay_2016.xls?raw=true */
  http://filebin.ca/3CQehaxIvEiW/Weekday_Entry_Eastbay_2016.xls
;

* Loading raw datafile via Internet;
filename mar16 TEMP;
filename hOrgTEMP TEMP;
filename stnName TEMP;
filename jan1_TMP TEMP;
filename mr31_TMP TEMP;
filename ebay_TMP TEMP;

proc http
    method="get" 
    url="&mar16DatasetURL." 
    out=mar16
    ;
run;

proc http
    method="get" 
    url="&homeOriginURL." 
    out=hOrgTEMP
    ;
run;

proc http
    method="get" 
    url="&stnNameURL."
    out=stnName
    ;
run;

proc http
    method="get" 
    url="&jan1URL."
    out=jan1_TMP
    ;
run;

proc http
    method="get" 
    url="&mar31URL."
    out=mr31_TMP
    ;
run;

proc http
    method="get" 
    url="&ebEntryURL."
    out=ebay_TMP
    ;
run;

proc import
    file=mar16
    out=bart_raw
    dbms=xls
    ;
run;

proc import
    file=hOrgTEMP
    out=ho_raw
    dbms=xls
    ;
run;

proc import
    file=stnName
    out=stnName_raw
    dbms=xls
    ;
run;

proc import
    file=jan1_TMP
    out=jan1_raw
    dbms=xls
    ;
run;

proc import
    file=mr31_TMP
    out=mr31_raw
    dbms=xls
    ;
run;

proc import
    file=ebay_TMP
    out=ebay_raw
    dbms=xls
    ;
run;

filename mar16 clear;
filename hOrgTEMP clear;
filename stnName clear;
filename jan1_TMP clear;
filename mr31_TMP clear;
filename ebay_TMP clear;

* Build Data Set.  All data fields will be visible and accessed by field name.;
data barf;
    retain
        UID
        RM
        EN
        EP
        NB
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
        WS
    ;
    keep
        UID
        RM
        EN
        EP
        NB
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
        WS
    ;
    set bart_raw;
run;

data ho;
    retain
        UID
        Code_2
        Name
        NO_V
        MORE_V
        HIGH_FREQ
        AB_AV_FREQ
        AV_FREQ
        BEL_AV_FREQ
        LOW_FREQ
        I_V_LOW
        I_LOW
        I_BEL_AVG
        I_AVG
        I_AB_AVG
        I_HIGH
        I_V_HIGH
        I_B_TOP
        I_TOP
        Male
        Female
        Walk
        Workplace
        W_BUS_APP
    ;
    keep
        UID
        Code_2
        Name
        NO_V
        MORE_V
        HIGH_FREQ
        AB_AV_FREQ
        AV_FREQ
        BEL_AV_FREQ
        LOW_FREQ
        I_V_LOW
        I_LOW
        I_BEL_AVG
        I_AVG
        I_AB_AVG
        I_HIGH
        I_V_HIGH
        I_B_TOP
        I_TOP
        Male
        Female
        Walk
        Workplace
        W_BUS_APP
    ;
    set ho_raw;
run;

data stn;
    retain
        Code_2
        Code_4
        Name
    ;
    keep
        Code_2
        Code_4
        Name
    ;
    set stnName_raw;
run;

data jan1;
    retain
        DATE
        HOUR
        ENTRY
        EXIT
        NUM
    ;
    keep
        DATE
        HOUR
        ENTRY
        EXIT
        NUM
    ;
    set jan1_raw;
run;

data mar31;
    retain
        DATE
        HOUR
        ENTRY
        EXIT
        NUM
    ;
    keep
        DATE
        HOUR
        ENTRY
        EXIT
        NUM
    ;
    set mr31_raw;
run;

data ebay;
    retain
        UID
        RM
        EN
        EP
        NB
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
        CV
        ED
        NC
        WP
        WD
        OA
        WS
    ;
    keep
        UID
        RM
        EN
        EP
        NB
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
        CV
        ED
        NC
        WP
        WD
        OA
        WS
    ;
    set ebay_raw;
run;
