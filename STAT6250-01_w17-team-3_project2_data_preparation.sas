%let inputDatasetURL =
  /*https://github.com/stat6250/team-3_project2/blob/master/mar_16.xls?raw=true */
  http://filebin.ca/3BljJfFK6653/mar_16.xls
;

* Loading raw datafile via Internet;
filename BARTtemp TEMP;

proc http
    method="get" 
    url="&inputDatasetURL." 
    out=BARTtemp
    ;
run;

proc import
    file=BARTtemp
    out=bart_raw
    dbms=xls
    ;
run;

filename BARTtemp clear;

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