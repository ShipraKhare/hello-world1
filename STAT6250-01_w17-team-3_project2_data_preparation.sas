%let mar16DatasetURL =
  /*https://github.com/stat6250/team-3_project2/blob/master/mar_16.xls?raw=true */
  http://filebin.ca/3BljJfFK6653/mar_16.xls
;

%let homeOriginURL =
  /*https://github.com/stat6250/team-3_project2/blob/master/HomeOrigin.xls?raw=true */
  http://filebin.ca/3CQ2hb7QD7Cs/HomeOrigin.xls
;

* Loading raw datafile via Internet;
filename mar16 TEMP;
filename hOrgTEMP TEMP;

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

filename mar16 clear;
filename hOrgTEMP clear;

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