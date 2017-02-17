%let mar16DatasetURL =
  /*https://github.com/stat6250/team-3_project2/blob/master/data/mar_16.xls?raw=true */
  http://filebin.ca/3BljJfFK6653/mar_16.xls
;

%let homeOriginURL =
  /*https://github.com/stat6250/team-3_project2/blob/master/data/HomeOrigin.xls?raw=true*/
  http://filebin.ca/3CQ2hb7QD7Cs/HomeOrigin.xls
;

%let stnNameURL =
  /*https://github.com/stat6250/team-3_project2/blob/master/data/Station_Names.xls?raw=true */
  http://filebin.ca/3CQHDPUJGoG1/Station_Names.xls
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
