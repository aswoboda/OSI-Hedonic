Aaron's First Cleaning of the Data
========================================================

This document describes and shows the first data cleaning done via R after the data file was uploaded to the R Server. We'll do most of the spatial display via ArcMap, but much of the data manipulation, analysis and non-spatial display via R.


```r
require(foreign)
```

```
## Loading required package: foreign
```

```r
getwd()
```

```
## [1] "/home/aswoboda/OSI Hedonic Project/OSI-Hedonic/writeup/02-AllData"
```

```r
HouseData = read.dbf("../../../Data/GIS2R/allData.dbf")
```



```r
options(width = 160)
```


What's in this file? What is the underlying structure of the data? What are the variables? How many of them? What are their values?

```r
str(HouseData)
```

```
## 'data.frame':	51394 obs. of  76 variables:
##  $ COUNTY_ID : Factor w/ 5 levels "003","037","123",..: 2 2 2 2 2 2 2 2 2 2 ...
##  $ PIN       : Factor w/ 51367 levels "003-013024110022",..: 14879 14882 10056 17023 17024 12061 12063 12067 12068 12071 ...
##  $ CITY      : Factor w/ 74 levels "ANDOVER","ANOKA",..: 40 40 3 48 48 6 6 6 6 7 ...
##  $ ZIP4      : Factor w/ 3338 levels "1000","1001",..: NA NA NA NA NA NA NA NA NA NA ...
##  $ LOT       : Factor w/ 809 levels "001","002","003",..: NA NA NA NA NA NA NA NA NA NA ...
##  $ ACRES_POLY: num  0.3 0.28 0.37 0.84 0.61 0.92 0.53 0.54 0.33 1.25 ...
##  $ ACRES_DEED: num  0 0 0 0 0 0 0 0 0 0 ...
##  $ USE1_DESC : Factor w/ 7 levels "100 Res 1 unit",..: 4 4 4 4 4 4 4 4 4 4 ...
##  $ HOMESTEAD : Factor w/ 3 levels "N","P","Y": 3 3 3 3 3 3 3 3 3 3 ...
##  $ EMV_LAND  : int  50600 53000 64200 118700 149400 84700 116400 101600 59300 40500 ...
##  $ EMV_BLDG  : int  135700 213100 121700 284900 599400 216600 441800 318700 178300 183300 ...
##  $ EMV_TOTAL : int  186300 266100 185900 403600 748800 301300 558200 420300 237600 223800 ...
##  $ TAX_CAPAC : int  1906 2713 1915 4277 8614 3075 5853 4283 2423 2367 ...
##  $ TOTAL_TAX : int  2088 3130 2300 4124 8211 3872 7381 5436 2921 2528 ...
##  $ XUSE1_DESC: Factor w/ 7 levels "BENEVOLENT INST. (CHEM. DEPT TRTMNT CTR)",..: NA NA NA NA NA NA NA NA NA NA ...
##  $ DWELL_TYPE: Factor w/ 13 levels "Condominium",..: 6 6 6 6 6 6 6 6 6 6 ...
##  $ HOME_STYLE: Factor w/ 71 levels "1 1/2 Story Finished",..: 62 62 62 70 70 62 70 70 70 47 ...
##  $ FIN_SQ_FT : int  1756 2806 1509 3587 6225 2944 5104 3773 2746 2960 ...
##  $ GARAGE    : Factor w/ 2 levels "N","Y": NA NA NA NA NA NA NA NA NA NA ...
##  $ GARAGESQFT: Factor w/ 1745 levels "0","10","1000",..: 974 1317 825 341 73 1262 1452 1215 740 1379 ...
##  $ BASEMENT  : Factor w/ 2 levels "N","Y": NA NA NA NA NA NA NA NA NA NA ...
##  $ HEATING   : Factor w/ 13 levels "Electric","ELECTRIC",..: NA NA NA NA NA NA NA NA NA NA ...
##  $ COOLING   : Factor w/ 5 levels "CENTRAL","CENTRAL W/AIR COND",..: NA NA NA NA NA NA NA NA NA NA ...
##  $ YEAR_BUILT: int  1979 1991 1972 1988 1995 1979 1992 1988 1986 1966 ...
##  $ NUM_UNITS : Factor w/ 4 levels "0","1","2","3": 2 2 2 2 2 2 2 2 2 2 ...
##  $ SALE_DATE : Date, format: "2009-08-28" "2011-01-14" "2009-10-30" "2010-07-20" ...
##  $ SALE_VALUE: int  213400 261000 177000 465000 730000 250000 597000 369000 231000 179350 ...
##  $ SCHOOL_DST: Factor w/ 29 levels "006","11","12",..: 13 13 11 12 12 10 8 8 8 9 ...
##  $ WSHD_DIST : Factor w/ 22 levels "BLACK DOG","Capital Region W/S",..: 6 6 17 6 6 4 4 1 1 17 ...
##  $ MYPIN     : int  0 1 2 3 4 5 6 7 8 9 ...
##  $ X_COORD   : num  496830 495747 484574 491579 491388 ...
##  $ Y_COORD   : num  496830 495747 484574 491579 491388 ...
##  $ REPLACEFID: int  0 1 2 3 4 5 6 7 8 9 ...
##  $ CITY_DUMMY: int  37 37 3 45 45 6 6 6 6 7 ...
##  $ GEOID10   : Factor w/ 7434 levels "270030501101002",..: 536 573 1590 670 671 1049 1049 1028 787 1752 ...
##  $ tenthkmSUM: num  27000 108000 81000 65184 27000 ...
##  $ qtrkmSUM  : num  838847 584558 535368 747625 443717 ...
##  $ onekmSUM  : num  17029800 18514700 13397700 29468300 26886400 ...
##  $ twokmSUM  : num  6.11e+07 8.66e+07 7.12e+07 1.13e+08 1.16e+08 ...
##  $ Census_POP: num  41 41 188 183 218 ...
##  $ WhiteDense: num  0.878 1 0.878 0.945 0.936 ...
##  $ White_POP : num  36 41 165 173 204 21 21 648 18 0 ...
##  $ Amind_POP : num  0 0 0 0 0 0 0 3 0 0 ...
##  $ Asian_POP : num  2 0 16 5 11 13 13 31 12 0 ...
##  $ Pacif_POP : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ Other_POP : num  0 0 0 0 0 0 0 4 0 0 ...
##  $ Multi_POP : num  0 0 2 3 0 0 0 29 0 0 ...
##  $ Hisp_POP  : num  1 0 2 2 3 0 0 205 1 4 ...
##  $ NotHis_POP: num  40 41 186 181 215 34 34 868 35 0 ...
##  $ VACANT    : num  0 1 0 1 1 1 1 50 1 0 ...
##  $ POPUnder18: num  75 67 322 317 388 ...
##  $ POPOver65 : num  3 0 8 12 7 2 2 49 1 0 ...
##  $ SDNUM     : int  199 199 196 197 197 194 191 191 191 192 ...
##  $ SDNAME    : Factor w/ 27 levels "Anoka-Hennepin",..: 9 9 16 26 26 11 2 2 2 6 ...
##  $ ELEMENTARY: Factor w/ 196 levels "ADAMS","AFTON-LAKELAND",..: 136 78 62 110 110 126 182 57 189 46 ...
##  $ MIDDLE    : Factor w/ 56 levels "ANOKA MIDDLE SCHOOL FOR THE ARTS",..: 21 21 13 16 16 26 25 25 23 39 ...
##  $ HIGH      : Factor w/ 43 levels "ANDOVER","ANOKA",..: 34 34 13 19 19 35 5 5 5 15 ...
##  $ STATEFP10 : Factor w/ 1 level "27": 1 1 1 1 1 1 1 1 1 1 ...
##  $ COUNTYFP10: Factor w/ 5 levels "003","037","123",..: 2 2 2 2 2 2 2 2 2 2 ...
##  $ TRACTCE10 : Factor w/ 322 levels "030100","030201",..: 199 202 255 208 208 230 230 229 213 262 ...
##  $ NAME10    : Factor w/ 381 levels "Block 1000","Block 1001",..: 308 136 121 1 5 125 125 1 114 108 ...
##  $ Block_Area: num  40000 25000 120000 150000 260000 50000 50000 580000 56000 84000 ...
##  $ POP_Dense : num  0.001025 0.00164 0.001567 0.00122 0.000838 ...
##  $ fam_income: int  63953 99750 123628 121685 121685 76509 76509 89786 96111 78431 ...
##  $ income_err: Factor w/ 320 levels "10022","10059",..: 294 316 116 63 63 7 7 109 306 229 ...
##  $ StPaulDist: num  13907 12915 23100 8332 8394 ...
##  $ MinneaDist: num  23129 21868 24282 16132 16017 ...
##  $ parkArea05: num  36468 2960 64540 3951 43448 ...
##  $ parkArea02: num  322917 0 12390200 0 0 ...
##  $ parkArea01: num  0 0 4673 0 0 ...
##  $ parkArea10: num  0 206107 385935 401638 557911 ...
##  $ Over65Dens: num  0.0732 0 0.0425 0.0656 0.0321 ...
##  $ Less18Dens: num  1.83 1.63 1.71 1.73 1.78 ...
##  $ VacantDens: num  0 0 0 0 0 0 0 0 0 0 ...
##  $ OSV05KM   : int  3569670 2687240 2190160 4111410 3692540 3958300 3832840 3952690 2579150 2784770 ...
##  $ GarageBin : int  1 1 1 1 1 1 1 1 1 1 ...
##  - attr(*, "data_types")= chr  "C" "C" "C" "C" ...
```

```r
summary(HouseData)
```

```
##  COUNTY_ID              PIN                           CITY            ZIP4            LOT          ACRES_POLY      ACRES_DEED   
##  003: 9479   139-254160010:    8   SAINT PAUL           : 8083   1613   :   12   1      : 2249   Min.   : 0.00   Min.   : 0.00  
##  037: 9677   139-254160030:    8   CITY OF WOODBURY     : 4938   2329   :   10   2      : 2151   1st Qu.: 0.14   1st Qu.: 0.00  
##  123:14057   139-250950090:    2   CITY OF SHAKOPEE     : 3113   3918   :   10   3      : 2126   Median : 0.25   Median : 0.00  
##  139: 6919   139-252310040:    2   BLAINE               : 2416   4820   :   10   4      : 1959   Mean   : 0.37   Mean   : 0.11  
##  163:11262   139-252310100:    2   CITY OF COTTAGE GROVE: 2121   1409   :    9   5      : 1757   3rd Qu.: 0.34   3rd Qu.: 0.11  
##              139-254160170:    2   CITY OF SAVAGE       : 1895   (Other): 7350   (Other):25624   Max.   :39.98   Max.   :40.00  
##              (Other)      :51370   (Other)              :28828   NA's   :43993   NA's   :15528                                  
##                                                  USE1_DESC     HOMESTEAD    EMV_LAND          EMV_BLDG         EMV_TOTAL         TAX_CAPAC       TOTAL_TAX    
##  100 Res 1 unit                                       :18181   N: 7748   Min.   :   1800   Min.   :      0   Min.   :      0   Min.   :    0   Min.   :    0  
##  COMMERCIAL-PREFFERED                                 :    3   P:  120   1st Qu.:  42200   1st Qu.: 104600   1st Qu.: 154000   1st Qu.:    0   1st Qu.:    0  
##  EXEMPT                                               :    2   Y:43526   Median :  61700   Median : 131300   Median : 195200   Median :    0   Median : 1969  
##  RESIDENTIAL                                          : 9672             Mean   :  68962   Mean   : 156701   Mean   : 225662   Mean   :  816   Mean   : 1866  
##  RESIDENTIAL SINGLE FAMILY                            : 9478             3rd Qu.:  81000   3rd Qu.: 184700   3rd Qu.: 263200   3rd Qu.: 1684   3rd Qu.: 2762  
##  RESIDENTIAL SINGLE FAMILY, RESIDENTIAL SINGLE FAMILY,:    1             Max.   :1955300   Max.   :1994500   Max.   :3437200   Max.   :25949   Max.   :49323  
##  Single Family Dwelling, Platted Lot                  :14057                                                                                                  
##                                     XUSE1_DESC                             DWELL_TYPE            HOME_STYLE      FIN_SQ_FT      GARAGE         GARAGESQFT   
##  Muni Srvc Other                         :    4   SINGLE FAMILY DWELLING        :14057   One Story    : 7412   Min.   :  300   N   :  960   440     : 3251  
##  RESIDENTIAL SINGLE FAMILY               :    2   S.FAM.RES                     : 9677   Two Story    : 4850   1st Qu.: 1092   Y   :33838   484     : 1835  
##  BENEVOLENT INST. (CHEM. DEPT TRTMNT CTR):    1   RESIDENTIAL SINGLE FAMILY     : 9478   SPLIT LEVL   : 4140   Median : 1454   NA's:16596   528     : 1793  
##  CDA,ECON DEV/HABITAT FOR HUMANITY/MHFA  :    1   Single-Family / Owner Occupied: 7699   TWO STORY    : 3834   Mean   : 1648                440.0000: 1352  
##  Church-Other Res                        :    1   Townhouse                     : 2994   Bungalow     : 3610   3rd Qu.: 1978                576     : 1231  
##  (Other)                                 :    2   (Other)                       :  570   2 Story Frame: 3509   Max.   :18116                (Other) :32055  
##  NA's                                    :51383   NA's                          : 6919   (Other)      :24039                                NA's    : 9877  
##  BASEMENT          HEATING                    COOLING        YEAR_BUILT   NUM_UNITS      SALE_DATE            SALE_VALUE        SCHOOL_DST   
##  N   : 1566   FA Gas   : 8637   CENTRAL           : 4276   Min.   :1840   0   : 9502   Min.   :2005-01-01   Min.   :    500   625    : 8083  
##  Y   :33231   HOT AIR  : 6449   CENTRAL W/AIR COND: 9682   1st Qu.:1959   1   :34962   1st Qu.:2005-09-09   1st Qu.: 177500   11     : 5925  
##  NA's:16597   Yes      : 2529   NON CENTRAL       :   93   Median :1986   2   :   10   Median :2006-07-10   Median : 227500   196    : 3766  
##               HOT WATER: 1699   NONE              :    3   Mean   :1977   3   :    1   Mean   :2007-06-19   Mean   : 257784   720    : 3272  
##               Oil F.A. :   63   Y                 :10841   3rd Qu.:2000   NA's: 6919   3rd Qu.:2009-08-31   3rd Qu.: 301000   719    : 2892  
##               (Other)  :   59   NA's              :26499   Max.   :2011                Max.   :2011-12-08   Max.   :7785000   (Other):19918  
##               NA's     :31958                                                                                                 NA's   : 7538  
##                          WSHD_DIST         MYPIN          X_COORD          Y_COORD         REPLACEFID      CITY_DUMMY              GEOID10     
##  WS SOUTH WASHINGTON          : 6692   Min.   :    0   Min.   :     0   Min.   :     0   Min.   :    0   Min.   : 0.0   271390803011036:  125  
##  Capital Region W/S           : 5859   1st Qu.:12854   1st Qu.:     0   1st Qu.:     0   1st Qu.:    0   1st Qu.: 0.0   271630710181000:   86  
##  COON CREEK WATERSHED DISTRICT: 4264   Median :25756   Median :     0   Median :     0   Median :    0   Median : 0.0   271630702031040:   59  
##  Metro Watershed              : 4126   Mean   :25736   Mean   :178708   Mean   :178708   Mean   : 3415   Mean   :12.9   271390809042006:   58  
##  VERMILLION RIVER             : 4081   3rd Qu.:38605   3rd Qu.:486347   3rd Qu.:486347   3rd Qu.: 5888   3rd Qu.:22.0   271390807001019:   55  
##  (Other)                      :17660   Max.   :51453   Max.   :515822   Max.   :515822   Max.   :18733   Max.   :70.0   (Other)        :18351  
##  NA's                         : 8712                                                                                    NA's           :32660  
##    tenthkmSUM         qtrkmSUM          onekmSUM           twokmSUM          Census_POP     WhiteDense      White_POP        Amind_POP       Asian_POP    
##  Min.   :      0   Min.   :      0   Min.   :0.00e+00   Min.   :0.00e+00   Min.   :   0   Min.   :0.000   Min.   :   0.0   Min.   : 0.00   Min.   :  0.0  
##  1st Qu.:      0   1st Qu.:      0   1st Qu.:0.00e+00   1st Qu.:0.00e+00   1st Qu.:  59   1st Qu.:0.826   1st Qu.:   0.0   1st Qu.: 0.00   1st Qu.:  0.0  
##  Median :      0   Median :      0   Median :0.00e+00   Median :0.00e+00   Median : 105   Median :0.920   Median :   0.0   Median : 0.00   Median :  0.0  
##  Mean   :  34930   Mean   : 267043   Mean   :6.93e+06   Mean   :3.58e+07   Mean   : 193   Mean   :0.860   Mean   :  50.3   Mean   : 0.29   Mean   :  6.2  
##  3rd Qu.:  54000   3rd Qu.: 465551   3rd Qu.:1.22e+07   3rd Qu.:6.31e+07   3rd Qu.: 228   3rd Qu.:0.967   3rd Qu.:  46.0   3rd Qu.: 0.00   3rd Qu.:  1.0  
##  Max.   :1347100   Max.   :7589400   Max.   :1.21e+08   Max.   :4.81e+08   Max.   :2381   Max.   :1.000   Max.   :1394.0   Max.   :82.00   Max.   :484.0  
##                                                                                                                                                           
##    Pacif_POP        Other_POP        Multi_POP        Hisp_POP       NotHis_POP         VACANT        POPUnder18     POPOver65         SDNUM    
##  Min.   : 0.000   Min.   : 0.000   Min.   : 0.00   Min.   :  0.0   Min.   :   0.0   Min.   : 0.00   Min.   :   0   Min.   :  0.0   Min.   :  0  
##  1st Qu.: 0.000   1st Qu.: 0.000   1st Qu.: 0.00   1st Qu.:  0.0   1st Qu.:   0.0   1st Qu.: 0.00   1st Qu.:   0   1st Qu.:  0.0   1st Qu.:  0  
##  Median : 0.000   Median : 0.000   Median : 0.00   Median :  0.0   Median :   0.0   Median : 0.00   Median :   0   Median :  0.0   Median :  0  
##  Mean   : 0.021   Mean   : 0.098   Mean   : 1.49   Mean   :  3.1   Mean   :  61.9   Mean   : 1.17   Mean   : 108   Mean   :  5.5   Mean   :213  
##  3rd Qu.: 0.000   3rd Qu.: 0.000   3rd Qu.: 0.00   3rd Qu.:  1.0   3rd Qu.:  60.0   3rd Qu.: 1.00   3rd Qu.: 109   3rd Qu.:  4.0   3rd Qu.:622  
##  Max.   :23.000   Max.   :12.000   Max.   :71.00   Max.   :504.0   Max.   :1645.0   Max.   :85.00   Max.   :2709   Max.   :438.0   Max.   :834  
##                                                                                                                                                 
##                           SDNAME           ELEMENTARY                   MIDDLE                 HIGH       STATEFP10    COUNTYFP10     TRACTCE10    
##  St. Paul                    : 4255   RED OAK   :  992   SHAKOPEE          : 1367   SHAKOPEE     : 1367   27  :18734   003 :  330   071018 :  724  
##  South Washington County     : 2969   PEARSON   :  956   BATTLE CREEK      : 1343   PRIOR LAKE   : 1139   NA's:32660   037 : 3217   080302 :  447  
##  North St. Paul-Maplewood    : 1619   BAILEY    :  933   TWIN & HIDDEN OAKS: 1139   NORTH & SOUTH: 1125                123 : 7125   080301 :  377  
##  Shakopee                    : 1367   LAKE ELMO :  879   LAKE              :  927   WOODBURY     : 1033                139 : 2833   071017 :  299  
##  Rosemount-Apple Valley-Eagan: 1271   FIVE HAWKS:  794   WOODBURY          :  755   EAST RIDGE   : 1005                163 : 5229   071206 :  299  
##  (Other)                     : 7253   WOODCREST :  783   (Other)           :12970   (Other)      :13065                NA's:32660   (Other):16588  
##  NA's                        :32660   (Other)   :46057   NA's              :32893   NA's         :32660                             NA's   :32660  
##         NAME10        Block_Area        POP_Dense         fam_income       income_err      StPaulDist      MinneaDist      parkArea05       parkArea02      
##  Block 2000:  407   Min.   :      0   Min.   :0.00000   Min.   : 15625   7118   :  724   Min.   :  629   Min.   : 4765   Min.   :     0   Min.   :0.00e+00  
##  Block 1000:  376   1st Qu.:      0   1st Qu.:0.00000   1st Qu.: 61692   5610   :  447   1st Qu.:11056   1st Qu.:18462   1st Qu.: 13126   1st Qu.:0.00e+00  
##  Block 2006:  344   Median :      0   Median :0.00000   Median : 74375   6132   :  377   Median :18355   Median :24653   Median : 43577   Median :0.00e+00  
##  Block 1008:  299   Mean   : 102858   Mean   :0.00070   Mean   : 76585   19338  :  299   Mean   :20077   Mean   :23153   Mean   : 66625   Mean   :4.89e+07  
##  Block 2001:  279   3rd Qu.:  27000   3rd Qu.:0.00114   3rd Qu.: 89417   5732   :  299   3rd Qu.:29493   3rd Qu.:28523   3rd Qu.: 94706   3rd Qu.:0.00e+00  
##  (Other)   :17029   Max.   :6200000   Max.   :0.01930   Max.   :160025   (Other):16588   Max.   :49892   Max.   :41925   Max.   :584901   Max.   :1.06e+10  
##  NA's      :32660                                                        NA's   :32660                                                                      
##    parkArea01      parkArea10        Over65Dens       Less18Dens      VacantDens        OSV05KM           GarageBin    
##  Min.   :    0   Min.   :      0   Min.   :0.0000   Min.   :0.000   Min.   :0.0000   Min.   :       0   Min.   :0.000  
##  1st Qu.:    0   1st Qu.:      0   1st Qu.:0.0186   1st Qu.:0.270   1st Qu.:0.0000   1st Qu.: 2293662   1st Qu.:1.000  
##  Median :    0   Median :      0   Median :0.0539   Median :0.365   Median :0.0000   Median : 3192500   Median :1.000  
##  Mean   :  470   Mean   : 114930   Mean   :0.0798   Mean   :0.795   Mean   :0.0085   Mean   : 3744967   Mean   :0.981  
##  3rd Qu.:    0   3rd Qu.: 155429   3rd Qu.:0.1139   3rd Qu.:1.632   3rd Qu.:0.0043   3rd Qu.: 4614896   3rd Qu.:1.000  
##  Max.   :24099   Max.   :1934393   Max.   :1.0000   Max.   :2.000   Max.   :1.3333   Max.   :30763200   Max.   :1.000  
##                                                                                                                        
```

```r
names(HouseData)
```

```
##  [1] "COUNTY_ID"  "PIN"        "CITY"       "ZIP4"       "LOT"        "ACRES_POLY" "ACRES_DEED" "USE1_DESC"  "HOMESTEAD"  "EMV_LAND"   "EMV_BLDG"   "EMV_TOTAL" 
## [13] "TAX_CAPAC"  "TOTAL_TAX"  "XUSE1_DESC" "DWELL_TYPE" "HOME_STYLE" "FIN_SQ_FT"  "GARAGE"     "GARAGESQFT" "BASEMENT"   "HEATING"    "COOLING"    "YEAR_BUILT"
## [25] "NUM_UNITS"  "SALE_DATE"  "SALE_VALUE" "SCHOOL_DST" "WSHD_DIST"  "MYPIN"      "X_COORD"    "Y_COORD"    "REPLACEFID" "CITY_DUMMY" "GEOID10"    "tenthkmSUM"
## [37] "qtrkmSUM"   "onekmSUM"   "twokmSUM"   "Census_POP" "WhiteDense" "White_POP"  "Amind_POP"  "Asian_POP"  "Pacif_POP"  "Other_POP"  "Multi_POP"  "Hisp_POP"  
## [49] "NotHis_POP" "VACANT"     "POPUnder18" "POPOver65"  "SDNUM"      "SDNAME"     "ELEMENTARY" "MIDDLE"     "HIGH"       "STATEFP10"  "COUNTYFP10" "TRACTCE10" 
## [61] "NAME10"     "Block_Area" "POP_Dense"  "fam_income" "income_err" "StPaulDist" "MinneaDist" "parkArea05" "parkArea02" "parkArea01" "parkArea10" "Over65Dens"
## [73] "Less18Dens" "VacantDens" "OSV05KM"    "GarageBin" 
```



Our primary interest is testing for a relationship between the house sale price and the OSI variables. 
------------
* What are the units of the OSI variable?

```r
vars = c("SALE_VALUE", "tenthkmSUM", "qtrkmSUM", "halfkmSUM", "onekmSUM", "twokmSUM")
whichVars = which(names(HouseData) %in% vars)
corMatrix = cor(HouseData[, whichVars])
round(corMatrix, 2)
```

```
##            SALE_VALUE tenthkmSUM qtrkmSUM onekmSUM twokmSUM
## SALE_VALUE       1.00      -0.07    -0.08    -0.09    -0.11
## tenthkmSUM      -0.07       1.00     0.87     0.67     0.63
## qtrkmSUM        -0.08       0.87     1.00     0.82     0.77
## onekmSUM        -0.09       0.67     0.82     1.00     0.93
## twokmSUM        -0.11       0.63     0.77     0.93     1.00
```


Our primary dependent variable has a skewed right distribution typical of house price distributions. A log-transformation results in an approximately normal-shaped distribution.

```r
par(mfrow = c(1, 2))
plot(density(HouseData$SALE_VALUE), ylab = "relative frequency")
plot(density(log(HouseData$SALE_VALUE)), ylab = "relative frequency")
curve(dnorm(x, mean = mean(log(HouseData$SALE_VALUE)), sd = sd(log(HouseData$SALE_VALUE))), add = TRUE, col = "red")
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 


The following graphs show the distributions of our five Open Space Index variables. Notice that the OSI values are less skewed for the larger OSI radii. That is, the distribution of the OSI values for the 2km radius is more symmetrical than the OSI values for the .1km radius.

```r
par(mfrow = c(2, 3))
for (myVar in whichVars[-1]) {
    plot(density(HouseData[, myVar]), ylab = "relative frequency", xlab = "", main = names(HouseData)[myVar])
}
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6.png) 


Basic Hedonic Regression
------

Let's start constructing our basic hedonic regression by formally creating the logged sale price variable, converting a couple variables from string to numeric, and creating some time related variables (year of sale, month of sale, etc.).

```r
HouseData$logPRICE = log(HouseData$SALE_VALUE)
HouseData$GARAGEsqft = as.numeric(as.character(HouseData$GARAGESQFT))
HouseData$SALE_YEAR = 1900 + as.POSIXlt(HouseData$SALE_DATE)$year
HouseData$SALE_MONTH = 1 + as.POSIXlt(HouseData$SALE_DATE)$mon
HouseData$YEARMON = 12 * (HouseData$SALE_YEAR - 2009) + HouseData$SALE_MONTH  # number of months since january 1, 2009
```


Now let's run an Ordinary Least Squares regression of the logged price on a few of our basic structural characteristics. The table below suggests that the four structural characteristics of finished square footage, lot size, garage size, and year built can explain almost half of the total variation in logged sales price. 

```r
StructuralModel1 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT, data = HouseData)
summary(StructuralModel1)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT, 
##     data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -6.312 -0.159  0.051  0.228  3.353 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 3.64e+00   1.35e-01    27.0   <2e-16 ***
## FIN_SQ_FT   3.54e-04   2.70e-06   131.1   <2e-16 ***
## ACRES_POLY  4.96e-02   2.30e-03    21.6   <2e-16 ***
## YEAR_BUILT  4.09e-03   6.86e-05    59.6   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.437 on 51390 degrees of freedom
## Multiple R-squared: 0.363,	Adjusted R-squared: 0.363 
## F-statistic: 9.75e+03 on 3 and 51390 DF,  p-value: <2e-16 
## 
```


We now add fixed effects for the home's construction style to our regression equation in order to further explain another five percent of the variation in our logged sale price variable.

```r
StructuralModel2 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HOME_STYLE, data = HouseData)
summary(StructuralModel2)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + 
##     HOME_STYLE, data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -6.309 -0.138  0.049  0.198  3.367 
## 
## Coefficients:
##                                           Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                               3.87e+00   1.93e-01   20.07  < 2e-16 ***
## FIN_SQ_FT                                 3.39e-04   3.34e-06  101.41  < 2e-16 ***
## ACRES_POLY                                4.22e-02   2.25e-03   18.76  < 2e-16 ***
## YEAR_BUILT                                3.97e-03   9.68e-05   40.99  < 2e-16 ***
## HOME_STYLE1 1/2 Story Frame              -2.77e-01   8.14e-02   -3.40  0.00067 ***
## HOME_STYLE1 1/2 STRY                      1.43e-01   7.11e-02    2.01  0.04441 *  
## HOME_STYLE1-1/2 STRY                      1.15e-01   5.81e-02    1.97  0.04829 *  
## HOME_STYLE1 1/4 story - 25% finished      1.96e-02   4.21e-01    0.05  0.96289    
## HOME_STYLE1 1/4 story 50% finished        1.73e-01   2.15e-01    0.81  0.41950    
## HOME_STYLE1 1/4 story finished            1.11e-01   5.63e-02    1.97  0.04871 *  
## HOME_STYLE1 1/4 story - unfinished       -1.08e-01   1.08e-01   -0.99  0.32095    
## HOME_STYLE1 1/4 STRY                      1.46e-01   1.11e-01    1.32  0.18589    
## HOME_STYLE1-1/4 STRY                      7.96e-02   5.47e-02    1.46  0.14561    
## HOME_STYLE1-2 STRY                        4.26e-01   5.55e-02    7.67  1.7e-14 ***
## HOME_STYLE1 3/4 story finished            9.89e-02   8.26e-02    1.20  0.23130    
## HOME_STYLE1 3/4 STRY                      4.28e-01   1.01e-01    4.25  2.1e-05 ***
## HOME_STYLE1-3/4 STRY                      1.80e-01   6.42e-02    2.80  0.00512 ** 
## HOME_STYLE1 Story Brick                   2.80e-01   2.46e-01    1.14  0.25517    
## HOME_STYLE1 Story Condo                  -5.13e-01   6.19e-02   -8.29  < 2e-16 ***
## HOME_STYLE1 Story Frame                   9.06e-02   5.17e-02    1.75  0.07940 .  
## HOME_STYLE1 Story Townhouse               4.38e-02   5.33e-02    0.82  0.41184    
## HOME_STYLE2 1/2 Story Finished           -3.62e-01   4.21e-01   -0.86  0.39019    
## HOME_STYLE2 Story Brick                   2.60e-01   4.21e-01    0.62  0.53690    
## HOME_STYLE2 Story Condo                  -4.13e-01   5.50e-02   -7.51  5.9e-14 ***
## HOME_STYLE2 Story Frame                   6.34e-02   5.16e-02    1.23  0.21916    
## HOME_STYLE2 Story Townhouse              -3.41e-01   5.20e-02   -6.56  5.4e-11 ***
## HOME_STYLE3-LVL SPLT                      1.89e-01   5.94e-02    3.18  0.00149 ** 
## HOME_STYLE4 LVL SPLT                      2.54e-01   5.69e-02    4.46  8.3e-06 ***
## HOME_STYLEBi-level                        1.53e-01   5.20e-02    2.94  0.00331 ** 
## HOME_STYLEBungalow                        8.96e-03   5.12e-02    0.18  0.86090    
## HOME_STYLECabin                          -1.23e-01   4.21e-01   -0.29  0.77058    
## HOME_STYLECONDO                          -4.78e-01   6.14e-02   -7.79  6.9e-15 ***
## HOME_STYLECondo - CO                     -1.37e-01   1.94e-01   -0.71  0.48067    
## HOME_STYLEDetached Townhome - 1 story     3.46e-01   5.90e-02    5.86  4.6e-09 ***
## HOME_STYLEDetached Townhome - 2 story     2.52e-02   7.50e-02    0.34  0.73687    
## HOME_STYLEDetached Townhome - Split Foy*  4.57e-01   2.46e-01    1.85  0.06375 .  
## HOME_STYLEDetached Townhome - Split lev*  2.21e-01   1.19e-01    1.85  0.06393 .  
## HOME_STYLEDouble bungalow - split foyer   2.55e-01   4.21e-01    0.61  0.54418    
## HOME_STYLEDUP/TRI                         1.01e-01   1.94e-01    0.52  0.60280    
## HOME_STYLEEARTHBERM                      -3.80e-02   4.21e-01   -0.09  0.92794    
## HOME_STYLEEARTH SHEL                      9.55e-02   4.21e-01    0.23  0.82046    
## HOME_STYLELOG                             5.69e-01   2.47e-01    2.31  0.02116 *  
## HOME_STYLEMfd Home (Double)              -6.92e-01   4.21e-01   -1.64  0.10018    
## HOME_STYLEMini-Warehouse - Condo         -2.39e+00   1.66e-01  -14.37  < 2e-16 ***
## HOME_STYLEModified two story              1.59e-01   5.42e-02    2.94  0.00329 ** 
## HOME_STYLEModular                        -1.56e+00   3.00e-01   -5.22  1.8e-07 ***
## HOME_STYLEN/A                             4.91e-01   1.78e-01    2.76  0.00576 ** 
## HOME_STYLEOne And 3/4 Story              -1.12e-01   5.19e-02   -2.15  0.03156 *  
## HOME_STYLEOne Story                       2.27e-02   5.10e-02    0.44  0.65666    
## HOME_STYLEONE STORY                       6.66e-03   5.16e-02    0.13  0.89725    
## HOME_STYLEOther                          -9.11e-01   2.15e-01   -4.24  2.3e-05 ***
## HOME_STYLEQuad - one story               -1.17e-01   1.94e-01   -0.61  0.54455    
## HOME_STYLEQuad - split level/foyer       -7.85e-02   6.10e-02   -1.29  0.19822    
## HOME_STYLEQuad - Two story               -1.13e-01   3.00e-01   -0.38  0.70572    
## HOME_STYLERAMBLER                         2.36e-01   5.29e-02    4.46  8.1e-06 ***
## HOME_STYLERow                            -1.12e-02   4.21e-01   -0.03  0.97877    
## HOME_STYLESalvage                        -9.40e-02   2.15e-01   -0.44  0.66192    
## HOME_STYLESPLIT-ENT                       9.95e-02   5.33e-02    1.87  0.06194 .  
## HOME_STYLESplit/entry                    -9.51e-02   5.24e-02   -1.81  0.06959 .  
## HOME_STYLESPLIT-FOY                       1.70e-01   5.87e-02    2.90  0.00378 ** 
## HOME_STYLESplit Foyer Frame               7.04e-02   5.21e-02    1.35  0.17665    
## HOME_STYLESplit/level                     3.23e-02   5.29e-02    0.61  0.54184    
## HOME_STYLESplit Level                     2.08e-01   5.24e-02    3.98  6.9e-05 ***
## HOME_STYLESplit Level Frame               1.49e-01   5.27e-02    2.82  0.00475 ** 
## HOME_STYLESPLIT LEVL                     -8.10e-03   5.14e-02   -0.16  0.87478    
## HOME_STYLEThree Story                    -2.74e-01   9.18e-02   -2.99  0.00282 ** 
## HOME_STYLETOWNHOME                       -7.06e-02   5.18e-02   -1.36  0.17355    
## HOME_STYLETWIN HOME                       7.06e-02   5.98e-02    1.18  0.23736    
## HOME_STYLETwin home - one story          -3.26e-01   1.03e-01   -3.18  0.00148 ** 
## HOME_STYLETwin home - spit level/ split* -3.10e-01   7.11e-02   -4.36  1.3e-05 ***
## HOME_STYLETwin home - two story          -6.40e-01   1.48e-01   -4.32  1.6e-05 ***
## HOME_STYLETwo Story                       3.91e-02   5.12e-02    0.76  0.44577    
## HOME_STYLETWO STORY                       1.60e-01   5.15e-02    3.10  0.00195 ** 
## HOME_STYLETWO+ STORY                     -5.29e-02   1.42e-01   -0.37  0.70862    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.418 on 51320 degrees of freedom
## Multiple R-squared: 0.42,	Adjusted R-squared: 0.419 
## F-statistic:  508 on 73 and 51320 DF,  p-value: <2e-16 
## 
```


Additional structural variables, such as the presence and type of cooling system are not reported for some counties in our study area and prevent us from including them in our regressions. We will rerun our regressions in the subset of area with cooling data to test the robustness of our results in a later section.

```r
table(is.na(HouseData$COOLING), HouseData$COUNTY_ID)
```

```
##        
##           003   037   123   139   163
##   FALSE     0     0 14054     0 10841
##   TRUE   9479  9677     3  6919   421
```


Adding Neighborhood Variables to the Regression
--------------

We now include a few of the most commonly used neighborhood characteristics in housing hedonic functions, namely



```r
neighborhoodModel1 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HOME_STYLE + CITY + SCHOOL_DST + WhiteDense + fam_income, data = HouseData)
summary(neighborhoodModel1)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + 
##     HOME_STYLE + CITY + SCHOOL_DST + WhiteDense + fam_income, 
##     data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -6.547 -0.118  0.035  0.174  3.250 
## 
## Coefficients: (6 not defined because of singularities)
##                                           Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                               4.85e+00   2.39e-01   20.33  < 2e-16 ***
## FIN_SQ_FT                                 3.52e-04   3.90e-06   90.47  < 2e-16 ***
## ACRES_POLY                                3.43e-02   2.58e-03   13.30  < 2e-16 ***
## YEAR_BUILT                                3.02e-03   1.18e-04   25.66  < 2e-16 ***
## HOME_STYLE1 1/2 Story Frame              -3.02e-01   1.66e-01   -1.82  0.06861 .  
## HOME_STYLE1 1/2 STRY                     -1.85e-01   1.00e-01   -1.85  0.06503 .  
## HOME_STYLE1-1/2 STRY                      2.95e-01   8.97e-02    3.29  0.00101 ** 
## HOME_STYLE1 1/4 story - 25% finished     -7.18e-02   3.91e-01   -0.18  0.85419    
## HOME_STYLE1 1/4 story 50% finished        1.22e-01   2.00e-01    0.61  0.53986    
## HOME_STYLE1 1/4 story finished            9.47e-02   5.30e-02    1.79  0.07399 .  
## HOME_STYLE1 1/4 story - unfinished       -1.31e-01   1.01e-01   -1.29  0.19665    
## HOME_STYLE1 1/4 STRY                     -2.31e-01   1.27e-01   -1.81  0.06994 .  
## HOME_STYLE1-1/4 STRY                      2.61e-01   8.76e-02    2.98  0.00290 ** 
## HOME_STYLE1-2 STRY                        9.86e-02   9.04e-02    1.09  0.27525    
## HOME_STYLE1 3/4 story finished            1.18e-01   7.70e-02    1.53  0.12647    
## HOME_STYLE1 3/4 STRY                      1.01e-01   1.20e-01    0.85  0.39797    
## HOME_STYLE1-3/4 STRY                      3.37e-01   9.35e-02    3.61  0.00031 ***
## HOME_STYLE1 Story Brick                   6.11e-01   4.11e-01    1.49  0.13753    
## HOME_STYLE1 Story Condo                  -2.99e-01   1.32e-01   -2.26  0.02395 *  
## HOME_STYLE1 Story Frame                   2.81e-01   1.25e-01    2.24  0.02495 *  
## HOME_STYLE1 Story Townhouse               2.27e-01   1.28e-01    1.77  0.07598 .  
## HOME_STYLE2 1/2 Story Finished           -2.60e-01   4.00e-01   -0.65  0.51567    
## HOME_STYLE2 Story Condo                  -2.98e-01   1.30e-01   -2.29  0.02215 *  
## HOME_STYLE2 Story Frame                   2.19e-01   1.25e-01    1.75  0.08080 .  
## HOME_STYLE2 Story Townhouse              -1.03e-01   1.26e-01   -0.81  0.41591    
## HOME_STYLE3-LVL SPLT                     -1.43e-01   9.34e-02   -1.53  0.12620    
## HOME_STYLE4 LVL SPLT                     -6.42e-02   9.23e-02   -0.70  0.48696    
## HOME_STYLEBi-level                        2.41e-01   4.90e-02    4.92  8.9e-07 ***
## HOME_STYLEBungalow                        8.00e-02   4.89e-02    1.64  0.10195    
## HOME_STYLECabin                          -1.23e-01   3.91e-01   -0.31  0.75305    
## HOME_STYLECONDO                          -8.46e-01   9.46e-02   -8.94  < 2e-16 ***
## HOME_STYLECondo - CO                     -7.62e-03   1.80e-01   -0.04  0.96630    
## HOME_STYLEDetached Townhome - 1 story     3.87e-01   5.58e-02    6.94  4.1e-12 ***
## HOME_STYLEDetached Townhome - 2 story     7.04e-02   7.26e-02    0.97  0.33193    
## HOME_STYLEDetached Townhome - Split Foy*  4.90e-01   2.30e-01    2.13  0.03283 *  
## HOME_STYLEDetached Townhome - Split lev*  3.03e-01   1.12e-01    2.71  0.00679 ** 
## HOME_STYLEDouble bungalow - split foyer   2.91e-01   3.92e-01    0.74  0.45892    
## HOME_STYLEDUP/TRI                        -2.73e-01   1.95e-01   -1.40  0.16036    
## HOME_STYLEEARTHBERM                      -4.86e-01   3.98e-01   -1.22  0.22196    
## HOME_STYLEEARTH SHEL                     -2.30e-01   3.98e-01   -0.58  0.56356    
## HOME_STYLELOG                             4.64e-01   2.43e-01    1.91  0.05632 .  
## HOME_STYLEMini-Warehouse - Condo         -2.29e+00   1.55e-01  -14.78  < 2e-16 ***
## HOME_STYLEModified two story              2.28e-01   5.12e-02    4.45  8.8e-06 ***
## HOME_STYLEModular                        -1.57e+00   2.79e-01   -5.62  1.9e-08 ***
## HOME_STYLEN/A                             1.01e-01   1.81e-01    0.56  0.57624    
## HOME_STYLEOne And 3/4 Story               2.54e-02   4.95e-02    0.51  0.60780    
## HOME_STYLEOne Story                       9.23e-02   4.84e-02    1.91  0.05664 .  
## HOME_STYLEONE STORY                       1.99e-01   8.67e-02    2.29  0.02189 *  
## HOME_STYLEOther                          -9.10e-01   2.00e-01   -4.55  5.4e-06 ***
## HOME_STYLEQuad - one story               -6.72e-02   1.80e-01   -0.37  0.70933    
## HOME_STYLEQuad - split level/foyer       -4.95e-02   5.77e-02   -0.86  0.39067    
## HOME_STYLEQuad - Two story               -2.91e-02   2.78e-01   -0.10  0.91684    
## HOME_STYLERAMBLER                        -1.22e-01   8.96e-02   -1.36  0.17456    
## HOME_STYLERow                            -2.86e-02   3.92e-01   -0.07  0.94171    
## HOME_STYLESalvage                        -9.59e-01   4.07e-01   -2.35  0.01859 *  
## HOME_STYLESPLIT-ENT                      -1.96e-01   9.02e-02   -2.17  0.02978 *  
## HOME_STYLESplit/entry                     4.12e-03   5.03e-02    0.08  0.93471    
## HOME_STYLESPLIT-FOY                      -1.34e-01   9.24e-02   -1.45  0.14671    
## HOME_STYLESplit Foyer Frame               3.26e-01   1.26e-01    2.58  0.00990 ** 
## HOME_STYLESplit/level                     7.97e-02   5.08e-02    1.57  0.11657    
## HOME_STYLESplit Level                     2.75e-01   4.94e-02    5.57  2.5e-08 ***
## HOME_STYLESplit Level Frame               3.76e-01   1.27e-01    2.97  0.00301 ** 
## HOME_STYLESPLIT LEVL                      2.08e-01   8.71e-02    2.38  0.01709 *  
## HOME_STYLEThree Story                    -5.21e-02   8.66e-02   -0.60  0.54749    
## HOME_STYLETOWNHOME                       -3.55e-01   8.87e-02   -4.00  6.3e-05 ***
## HOME_STYLETWIN HOME                      -2.26e-01   9.34e-02   -2.43  0.01527 *  
## HOME_STYLETwin home - one story          -2.41e-01   9.61e-02   -2.51  0.01203 *  
## HOME_STYLETwin home - spit level/ split* -2.41e-01   6.69e-02   -3.60  0.00031 ***
## HOME_STYLETwin home - two story          -5.46e-01   1.38e-01   -3.95  7.7e-05 ***
## HOME_STYLETwo Story                       8.61e-02   4.86e-02    1.77  0.07662 .  
## HOME_STYLETWO STORY                       1.88e-01   8.73e-02    2.15  0.03139 *  
## HOME_STYLETWO+ STORY                      1.15e-01   1.50e-01    0.77  0.44368    
## CITYANOKA                                -3.89e-02   2.29e-02   -1.69  0.09013 .  
## CITYAPPLE VALLEY                         -4.72e-02   3.89e-02   -1.21  0.22439    
## CITYARDEN HILLS                          -4.04e-01   8.18e-02   -4.93  8.1e-07 ***
## CITYBLAINE                               -3.43e-02   1.68e-02   -2.04  0.04128 *  
## CITYBURNSVILLE                           -4.02e-02   4.05e-02   -0.99  0.32047    
## CITYCASTLE ROCK TWP                       1.12e-01   2.00e-01    0.56  0.57679    
## CITYCENTERVILLE                          -1.20e-01   4.75e-02   -2.53  0.01136 *  
## CITYCIRCLE PINES                         -2.30e-02   4.62e-02   -0.50  0.61836    
## CITYCITY OF BIRCHWOOD                     2.74e-01   1.71e-01    1.60  0.10969    
## CITYCITY OF COTTAGE GROVE                -8.72e-02   1.30e-01   -0.67  0.50154    
## CITYCITY OF DELLWOOD                      1.87e-01   1.25e-01    1.49  0.13632    
## CITYCITY OF GRANT                        -8.39e-02   1.35e-01   -0.62  0.53286    
## CITYCITY OF HUGO                         -5.80e-02   1.59e-01   -0.37  0.71431    
## CITYCITY OF LAKE ELMO                    -2.95e-02   5.44e-02   -0.54  0.58791    
## CITYCITY OF MAHTOMEDI                     9.92e-03   1.13e-01    0.09  0.93027    
## CITYCITY OF OAKDALE                      -1.38e-01   2.48e-02   -5.59  2.3e-08 ***
## CITYCITY OF PINE SPRINGS                  1.85e-02   1.94e-01    0.10  0.92391    
## CITYCITY OF PRIOR LAKE                    4.39e-01   4.81e-02    9.12  < 2e-16 ***
## CITYCITY OF SAVAGE                        4.92e-01   4.57e-02   10.78  < 2e-16 ***
## CITYCITY OF SHAKOPEE                      3.30e-01   5.51e-02    5.99  2.2e-09 ***
## CITYCITY OF WHITE BEAR LAKE              -1.45e-01   1.58e-01   -0.91  0.36036    
## CITYCITY OF WILLERNIE                    -2.87e-01   1.53e-01   -1.88  0.06032 .  
## CITYCITY OF WOODBURY                            NA         NA      NA       NA    
## CITYCOLUMBIA HEIGHTS                      7.12e-02   5.75e-02    1.24  0.21571    
## CITYCOLUMBUS                             -2.07e-01   1.40e-01   -1.48  0.13886    
## CITYCOON RAPIDS                          -2.85e-02   1.57e-02   -1.82  0.06936 .  
## CITYEAGAN                                 1.33e-02   3.58e-02    0.37  0.71099    
## CITYEAST BETHEL                           3.34e-02   7.39e-02    0.45  0.65133    
## CITYEMPIRE TWP                           -1.21e-01   6.72e-02   -1.79  0.07268 .  
## CITYFALCON HEIGHTS                       -2.52e-01   8.87e-02   -2.84  0.00453 ** 
## CITYFARMINGTON                           -1.14e-01   5.09e-02   -2.24  0.02522 *  
## CITYFRIDLEY                               2.84e-02   4.01e-02    0.71  0.47965    
## CITYGEM LAKE                             -5.95e-01   1.15e-01   -5.19  2.1e-07 ***
## CITYHAM LAKE                             -2.74e-02   2.24e-02   -1.22  0.22130    
## CITYHILLTOP                              -4.17e-01   2.80e-01   -1.49  0.13603    
## CITYINVER GROVE HEIGHTS                   4.45e-02   5.24e-02    0.85  0.39544    
## CITYLAKEVILLE                            -7.22e-02   4.17e-02   -1.73  0.08312 .  
## CITYLAUDERDALE                           -3.71e-01   9.79e-02   -3.79  0.00015 ***
## CITYLEXINGTON                            -5.11e-02   6.76e-02   -0.76  0.45007    
## CITYLINO LAKES                           -3.91e-02   3.70e-02   -1.06  0.29099    
## CITYLITTLE CANADA                        -3.96e-01   8.43e-02   -4.70  2.6e-06 ***
## CITYMAPLEWOOD                            -4.49e-01   8.52e-02   -5.27  1.4e-07 ***
## CITYMENDOTA                               2.15e-02   1.95e-01    0.11  0.91201    
## CITYMENDOTA HEIGHTS                       2.42e-02   2.95e-02    0.82  0.41261    
## CITYMOUNDS VIEW                          -5.39e-01   8.04e-02   -6.71  2.0e-11 ***
## CITYNEW BRIGHTON                         -4.37e-01   7.91e-02   -5.52  3.3e-08 ***
## CITYNORTH OAKS                           -3.34e-01   8.06e-02   -4.14  3.5e-05 ***
## CITYNORTH SAINT PAUL                     -5.37e-01   8.86e-02   -6.06  1.4e-09 ***
## CITYNOWTHEN                              -1.01e-01   8.75e-02   -1.15  0.24821    
## CITYOAK GROVE                             6.79e-02   1.14e-01    0.60  0.55115    
## CITYRAMSEY                               -1.96e-01   1.76e-02  -11.15  < 2e-16 ***
## CITYROSEMOUNT                            -4.71e-02   4.04e-02   -1.17  0.24382    
## CITYROSEVILLE                            -3.88e-01   8.09e-02   -4.79  1.7e-06 ***
## CITYSAINT ANTHONY                        -2.63e-01   1.58e-01   -1.67  0.09534 .  
## CITYSAINT PAUL                            5.23e-02   5.17e-02    1.01  0.31156    
## CITYSHOREVIEW                            -3.75e-01   7.84e-02   -4.78  1.8e-06 ***
## CITYSOUTH ST PAUL                        -2.03e-01   5.36e-02   -3.80  0.00015 ***
## CITYSPRING LAKE PARK                     -1.76e-01   3.86e-02   -4.57  5.0e-06 ***
## CITYSUNFISH LAKE                          2.13e-01   1.06e-01    2.01  0.04437 *  
## CITYTOWN OF CREDIT RIVER                  3.96e-01   1.27e-01    3.11  0.00188 ** 
## CITYTOWN OF JACKSON                       4.99e-01   3.91e-01    1.27  0.20261    
## CITYTOWN OF LOUISVILLE                    2.94e-01   2.31e-01    1.27  0.20347    
## CITYTOWN OF SPRING LAKE                   5.02e-01   6.89e-02    7.29  3.0e-13 ***
## CITYVADNAIS HEIGHTS                      -3.19e-01   6.93e-02   -4.60  4.3e-06 ***
## CITYWEST ST PAUL                                NA         NA      NA       NA    
## CITYWHITE BEAR LAKE                      -3.02e-01   6.71e-02   -4.50  6.8e-06 ***
## CITYWHITE BEAR TOWNSHIP                  -3.15e-01   6.89e-02   -4.58  4.8e-06 ***
## SCHOOL_DST11                             -3.86e-02   4.89e-02   -0.79  0.42931    
## SCHOOL_DST12                              4.91e-03   4.08e-02    0.12  0.90416    
## SCHOOL_DST13                              5.76e-03   7.12e-02    0.08  0.93551    
## SCHOOL_DST14                              4.20e-02   6.44e-02    0.65  0.51415    
## SCHOOL_DST15                             -1.81e-01   7.40e-02   -2.44  0.01451 *  
## SCHOOL_DST16                              1.00e-01   4.95e-02    2.02  0.04357 *  
## SCHOOL_DST191                            -1.48e-01   3.31e-02   -4.46  8.1e-06 ***
## SCHOOL_DST192                            -1.30e-01   4.91e-02   -2.65  0.00803 ** 
## SCHOOL_DST194                            -1.60e-01   4.18e-02   -3.82  0.00013 ***
## SCHOOL_DST196                            -1.54e-01   3.81e-02   -4.05  5.1e-05 ***
## SCHOOL_DST197                            -1.30e-01   4.88e-02   -2.67  0.00749 ** 
## SCHOOL_DST199                            -2.06e-01   5.58e-02   -3.68  0.00023 ***
## SCHOOL_DST282                             4.13e-01   1.32e-01    3.14  0.00168 ** 
## SCHOOL_DST621                             4.33e-01   7.92e-02    5.47  4.4e-08 ***
## SCHOOL_DST622                             4.20e-01   8.80e-02    4.77  1.8e-06 ***
## SCHOOL_DST623                             4.77e-01   8.28e-02    5.76  8.3e-09 ***
## SCHOOL_DST624                             2.88e-01   6.69e-02    4.30  1.7e-05 ***
## SCHOOL_DST625                                   NA         NA      NA       NA    
## SCHOOL_DST717                            -1.76e-01   1.58e-01   -1.11  0.26496    
## SCHOOL_DST719                            -2.69e-02   3.10e-02   -0.87  0.38414    
## SCHOOL_DST720                                   NA         NA      NA       NA    
## SCHOOL_DST728                            -2.46e-02   8.77e-02   -0.28  0.77882    
## SCHOOL_DST831                                   NA         NA      NA       NA    
## SCHOOL_DSTISD622                         -5.58e-02   1.07e-01   -0.52  0.60118    
## SCHOOL_DSTISD624                         -1.70e-01   1.90e-01   -0.89  0.37090    
## SCHOOL_DSTISD831                         -4.99e-01   2.09e-01   -2.39  0.01671 *  
## SCHOOL_DSTISD832                         -2.94e-02   1.52e-01   -0.19  0.84672    
## SCHOOL_DSTISD833                                NA         NA      NA       NA    
## WhiteDense                                8.54e-01   1.21e-02   70.49  < 2e-16 ***
## fam_income                                1.07e-06   1.25e-07    8.56  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.388 on 43693 degrees of freedom
##   (7538 observations deleted due to missingness)
## Multiple R-squared: 0.506,	Adjusted R-squared: 0.504 
## F-statistic:  276 on 162 and 43693 DF,  p-value: <2e-16 
## 
```


Surprisingly, few of the city or school district fixed effects seem to statistically differ from zero. Let's try a smaller scale measure of location - the elementary school catchment basin. This model now describes about two-thirds of the variation in logged sale price.

```r
neighborhoodModel2 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income, data = HouseData)
summary(neighborhoodModel2)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + 
##     HOME_STYLE + ELEMENTARY + WhiteDense + fam_income, data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -6.826 -0.106  0.033  0.165  3.175 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                  3.64e+00   2.19e-01   16.63  < 2e-16 ***
## FIN_SQ_FT                                    3.32e-04   3.48e-06   95.59  < 2e-16 ***
## ACRES_POLY                                   3.89e-02   2.12e-03   18.31  < 2e-16 ***
## YEAR_BUILT                                   3.87e-03   1.10e-04   35.04  < 2e-16 ***
## HOME_STYLE1 1/2 Story Frame                 -1.60e-01   7.56e-02   -2.11  0.03491 *  
## HOME_STYLE1 1/2 STRY                        -1.98e-01   6.62e-02   -3.00  0.00272 ** 
## HOME_STYLE1-1/2 STRY                         1.36e-01   5.41e-02    2.51  0.01195 *  
## HOME_STYLE1 1/4 story - 25% finished        -8.47e-02   3.68e-01   -0.23  0.81807    
## HOME_STYLE1 1/4 story 50% finished           1.58e-01   1.88e-01    0.84  0.40034    
## HOME_STYLE1 1/4 story finished               7.56e-02   4.99e-02    1.51  0.13007    
## HOME_STYLE1 1/4 story - unfinished          -1.01e-01   9.52e-02   -1.06  0.28738    
## HOME_STYLE1 1/4 STRY                        -2.61e-01   9.95e-02   -2.62  0.00883 ** 
## HOME_STYLE1-1/4 STRY                         9.13e-02   5.17e-02    1.77  0.07726 .  
## HOME_STYLE1-2 STRY                           2.70e-02   5.33e-02    0.51  0.61198    
## HOME_STYLE1 3/4 story finished               1.00e-01   7.30e-02    1.37  0.17078    
## HOME_STYLE1 3/4 STRY                         1.03e-01   9.10e-02    1.13  0.25669    
## HOME_STYLE1-3/4 STRY                         2.02e-01   5.91e-02    3.42  0.00062 ***
## HOME_STYLE1 Story Brick                      4.02e-01   2.17e-01    1.85  0.06376 .  
## HOME_STYLE1 Story Condo                     -4.15e-01   6.01e-02   -6.91  5.0e-12 ***
## HOME_STYLE1 Story Frame                      2.01e-01   5.16e-02    3.89  0.00010 ***
## HOME_STYLE1 Story Townhouse                  1.34e-01   5.32e-02    2.53  0.01155 *  
## HOME_STYLE2 1/2 Story Finished              -2.70e-01   3.68e-01   -0.73  0.46403    
## HOME_STYLE2 Story Brick                      2.15e-01   3.69e-01    0.58  0.56037    
## HOME_STYLE2 Story Condo                     -2.99e-01   5.49e-02   -5.44  5.4e-08 ***
## HOME_STYLE2 Story Frame                      1.28e-01   5.18e-02    2.47  0.01369 *  
## HOME_STYLE2 Story Townhouse                 -2.11e-01   5.20e-02   -4.05  5.1e-05 ***
## HOME_STYLE3-LVL SPLT                        -2.10e-01   5.64e-02   -3.73  0.00019 ***
## HOME_STYLE4 LVL SPLT                        -1.20e-01   5.45e-02   -2.20  0.02778 *  
## HOME_STYLEBi-level                           1.81e-01   4.62e-02    3.92  9.0e-05 ***
## HOME_STYLEBungalow                           6.49e-02   4.61e-02    1.41  0.15912    
## HOME_STYLECabin                             -1.65e-01   3.68e-01   -0.45  0.65476    
## HOME_STYLECONDO                             -9.07e-01   5.92e-02  -15.32  < 2e-16 ***
## HOME_STYLECondo - CO                        -9.04e-02   1.70e-01   -0.53  0.59580    
## HOME_STYLEDetached Townhome - 1 story        3.35e-01   5.29e-02    6.33  2.4e-10 ***
## HOME_STYLEDetached Townhome - 2 story        6.22e-02   6.78e-02    0.92  0.35881    
## HOME_STYLEDetached Townhome - Split Foy*     4.27e-01   2.16e-01    1.97  0.04838 *  
## HOME_STYLEDetached Townhome - Split lev*     2.78e-01   1.06e-01    2.61  0.00902 ** 
## HOME_STYLEDouble bungalow - split foyer      2.80e-01   3.69e-01    0.76  0.44850    
## HOME_STYLEDUP/TRI                           -2.39e-01   1.71e-01   -1.40  0.16194    
## HOME_STYLEEARTHBERM                         -6.49e-01   3.68e-01   -1.76  0.07810 .  
## HOME_STYLEEARTH SHEL                        -2.06e-01   3.68e-01   -0.56  0.57545    
## HOME_STYLELOG                                2.68e-01   2.17e-01    1.24  0.21600    
## HOME_STYLEMfd Home (Double)                 -3.94e-01   3.69e-01   -1.07  0.28581    
## HOME_STYLEMini-Warehouse - Condo            -2.38e+00   1.47e-01  -16.17  < 2e-16 ***
## HOME_STYLEModified two story                 1.80e-01   4.82e-02    3.74  0.00019 ***
## HOME_STYLEModular                           -1.57e+00   2.63e-01   -5.98  2.2e-09 ***
## HOME_STYLEN/A                                3.13e-02   1.57e-01    0.20  0.84232    
## HOME_STYLEOne And 3/4 Story                  4.73e-02   4.67e-02    1.01  0.31145    
## HOME_STYLEOne Story                          6.07e-02   4.56e-02    1.33  0.18342    
## HOME_STYLEONE STORY                          3.91e-02   4.88e-02    0.80  0.42239    
## HOME_STYLEOther                             -9.96e-01   1.88e-01   -5.29  1.2e-07 ***
## HOME_STYLEQuad - one story                  -1.02e-01   1.70e-01   -0.60  0.55081    
## HOME_STYLEQuad - split level/foyer          -6.66e-02   5.47e-02   -1.22  0.22347    
## HOME_STYLEQuad - Two story                  -8.57e-02   2.62e-01   -0.33  0.74408    
## HOME_STYLERAMBLER                           -1.66e-01   5.13e-02   -3.24  0.00118 ** 
## HOME_STYLERow                               -1.16e-01   3.68e-01   -0.31  0.75282    
## HOME_STYLESalvage                            1.04e-01   1.89e-01    0.55  0.58302    
## HOME_STYLESPLIT-ENT                         -2.21e-01   5.16e-02   -4.28  1.9e-05 ***
## HOME_STYLESplit/entry                       -3.92e-02   4.73e-02   -0.83  0.40703    
## HOME_STYLESPLIT-FOY                         -1.90e-01   5.61e-02   -3.40  0.00069 ***
## HOME_STYLESplit Foyer Frame                  2.01e-01   5.22e-02    3.86  0.00011 ***
## HOME_STYLESplit/level                        3.02e-02   4.77e-02    0.63  0.52698    
## HOME_STYLESplit Level                        2.25e-01   4.67e-02    4.82  1.4e-06 ***
## HOME_STYLESplit Level Frame                  2.62e-01   5.25e-02    4.99  6.2e-07 ***
## HOME_STYLESPLIT LEVL                         3.85e-02   4.87e-02    0.79  0.42934    
## HOME_STYLEThree Story                       -1.46e-01   8.17e-02   -1.79  0.07296 .  
## HOME_STYLETOWNHOME                          -4.73e-01   5.04e-02   -9.39  < 2e-16 ***
## HOME_STYLETWIN HOME                         -3.30e-01   5.69e-02   -5.79  7.0e-09 ***
## HOME_STYLETwin home - one story             -2.85e-01   9.10e-02   -3.13  0.00175 ** 
## HOME_STYLETwin home - spit level/ split*    -2.79e-01   6.33e-02   -4.40  1.1e-05 ***
## HOME_STYLETwin home - two story             -6.03e-01   1.31e-01   -4.62  3.9e-06 ***
## HOME_STYLETwo Story                          2.14e-02   4.58e-02    0.47  0.64008    
## HOME_STYLETWO STORY                          6.48e-02   4.90e-02    1.32  0.18583    
## HOME_STYLETWO+ STORY                        -2.96e-02   1.25e-01   -0.24  0.81304    
## ELEMENTARYAFTON-LAKELAND                    -4.33e-02   4.41e-02   -0.98  0.32641    
## ELEMENTARYAKIN ROAD                         -2.53e-02   3.58e-02   -0.71  0.48008    
## ELEMENTARYAMES                               1.23e-01   4.51e-02    2.73  0.00634 ** 
## ELEMENTARYANDERSEN                           2.09e-01   6.57e-02    3.18  0.00146 ** 
## ELEMENTARYANDERSON & WILDWOOD                1.88e-01   3.77e-02    5.01  5.6e-07 ***
## ELEMENTARYANDOVER                            8.84e-02   2.93e-02    3.02  0.00252 ** 
## ELEMENTARYARMSTRONG                         -9.37e-02   3.89e-02   -2.41  0.01592 *  
## ELEMENTARYBAILEY                             8.53e-02   3.54e-02    2.41  0.01606 *  
## ELEMENTARYBATTLE CREEK                       4.18e-02   4.41e-02    0.95  0.34236    
## ELEMENTARYBEL AIR                            1.17e-01   3.15e-02    3.71  0.00021 ***
## ELEMENTARYBIRCH LAKE                         8.41e-03   3.70e-02    0.23  0.82034    
## ELEMENTARYBLUE HERON                        -1.25e-02   3.34e-02   -0.37  0.70909    
## ELEMENTARYBRIMHALL                           2.54e-01   3.24e-02    7.82  5.2e-15 ***
## ELEMENTARYBRUCE F. VENTO                    -3.57e-01   3.64e-02   -9.81  < 2e-16 ***
## ELEMENTARYCARVER                             1.41e-02   3.31e-02    0.43  0.67068    
## ELEMENTARYCASTLE                            -4.39e-02   3.75e-02   -1.17  0.24220    
## ELEMENTARYCEDAR CREEK                       -3.39e-01   7.10e-02   -4.78  1.8e-06 ***
## ELEMENTARYCEDAR PARK                         3.11e-02   4.27e-02    0.73  0.46725    
## ELEMENTARYCENTENNIAL                         3.87e-02   3.67e-02    1.06  0.29135    
## ELEMENTARYCENTERVILLE                        4.99e-02   3.44e-02    1.45  0.14735    
## ELEMENTARYCENTRAL PARK                       1.38e-01   3.35e-02    4.13  3.7e-05 ***
## ELEMENTARYCHELSEA HEIGHTS                    1.72e-01   2.93e-02    5.88  4.1e-09 ***
## ELEMENTARYCHERRY VIEW                       -6.41e-03   4.10e-02   -0.16  0.87583    
## ELEMENTARYCHRISTINA HUDDLESTON               9.50e-03   4.15e-02    0.23  0.81918    
## ELEMENTARYCOMO PARK                          7.85e-02   3.22e-02    2.44  0.01469 *  
## ELEMENTARYCOTTAGE GROVE                     -2.64e-02   3.70e-02   -0.71  0.47489    
## ELEMENTARYCOWERN                            -8.77e-02   3.36e-02   -2.61  0.00911 ** 
## ELEMENTARYCRESTVIEW                         -1.03e-01   4.08e-02   -2.52  0.01159 *  
## ELEMENTARYCROOKED LAKE                       2.73e-02   3.45e-02    0.79  0.42932    
## ELEMENTARYCRYSTAL LAKE                       4.39e-02   4.05e-02    1.08  0.27817    
## ELEMENTARYDAYTONS BLUFF                     -3.57e-01   3.27e-02  -10.92  < 2e-16 ***
## ELEMENTARYDEERWOOD                           9.68e-02   4.35e-02    2.23  0.02596 *  
## ELEMENTARYDIAMOND PATH                       4.46e-02   3.64e-02    1.22  0.22121    
## ELEMENTARYEAGLE CREEK                        4.10e-01   3.59e-02   11.41  < 2e-16 ***
## ELEMENTARYEAGLE POINT                       -2.29e-02   4.10e-02   -0.56  0.57658    
## ELEMENTARYEAST BETHEL & CEDAR CREEK          3.29e-02   4.41e-02    0.74  0.45628    
## ELEMENTARYEASTERN HEIGHTS                   -2.19e-01   3.06e-02   -7.14  9.4e-13 ***
## ELEMENTARYEASTVIEW                           6.68e-02   4.14e-02    1.61  0.10694    
## ELEMENTARYECHO PARK                          4.22e-03   3.71e-02    0.11  0.90925    
## ELEMENTARYEDGERTON                           4.74e-02   3.53e-02    1.34  0.17972    
## ELEMENTARYEDWARD NEILL                       8.05e-04   3.93e-02    0.02  0.98365    
## ELEMENTARYEISENHOWER                         2.51e-02   4.12e-02    0.61  0.54273    
## ELEMENTARYEMMET D. WILLIAMS                  1.93e-01   3.30e-02    5.84  5.2e-09 ***
## ELEMENTARYFALCON HEIGHTS                     1.95e-01   3.21e-02    6.07  1.3e-09 ***
## ELEMENTARYFARMINGTON                        -3.05e-02   3.53e-02   -0.87  0.38616    
## ELEMENTARYFARNSWORTH                         2.02e-01   3.84e-02    5.26  1.4e-07 ***
## ELEMENTARYFARNSWORTH LOWER                  -3.23e-01   3.80e-02   -8.51  < 2e-16 ***
## ELEMENTARYFIVE HAWKS                         6.43e-01   3.35e-02   19.18  < 2e-16 ***
## ELEMENTARYFOREST VIEW                       -3.50e-01   1.27e-01   -2.77  0.00569 ** 
## ELEMENTARYFOREST VIEW & FOREST LAKE         -5.57e-01   1.42e-01   -3.92  8.8e-05 ***
## ELEMENTARYFRANKLIN                          -9.18e-02   3.18e-02   -2.88  0.00394 ** 
## ELEMENTARYFRANKLIN MUSIC                    -2.54e-01   1.51e-01   -1.68  0.09261 .  
## ELEMENTARYFROST LAKE                        -3.69e-02   3.73e-02   -0.99  0.32245    
## ELEMENTARYGALTIER & MAXFIELD                -3.33e-02   2.97e-02   -1.12  0.26261    
## ELEMENTARYGARLOUGH                           5.58e-02   4.11e-02    1.36  0.17441    
## ELEMENTARYGIDEON POND                        1.78e-02   4.38e-02    0.41  0.68413    
## ELEMENTARYGLACIER HILLS                      1.42e-01   4.23e-02    3.37  0.00076 ***
## ELEMENTARYGLENDALE                           5.91e-01   3.66e-02   16.13  < 2e-16 ***
## ELEMENTARYGOLDEN LAKE                        1.35e-01   4.22e-02    3.19  0.00141 ** 
## ELEMENTARYGRAINWOOD                          1.88e-01   4.24e-02    4.44  9.2e-06 ***
## ELEMENTARYGREENLEAF                          3.77e-02   3.59e-02    1.05  0.29354    
## ELEMENTARYGREY CLOUD                        -7.68e-02   3.90e-02   -1.97  0.04861 *  
## ELEMENTARYGROVELAND PARK                     6.02e-01   3.17e-02   18.98  < 2e-16 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  2.87e-01   3.63e-02    7.91  2.7e-15 ***
## ELEMENTARYHAMILTON                          -9.20e-03   3.52e-02   -0.26  0.79354    
## ELEMENTARYHANCOCK                           -7.13e-02   5.04e-02   -1.41  0.15753    
## ELEMENTARYHANCOCK EL.                        3.14e-01   4.33e-02    7.27  3.7e-13 ***
## ELEMENTARYHARRIET BISHOP                     4.79e-01   3.87e-02   12.36  < 2e-16 ***
## ELEMENTARYHAYDEN HEIGHTS                     7.91e-02   3.83e-02    2.06  0.03907 *  
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -3.44e-01   3.21e-02  -10.71  < 2e-16 ***
## ELEMENTARYHAYES                              1.29e-01   3.51e-02    3.68  0.00024 ***
## ELEMENTARYHIDDEN VALLEY                      3.76e-01   4.00e-02    9.41  < 2e-16 ***
## ELEMENTARYHIGHLAND                           9.36e-02   3.09e-02    3.03  0.00246 ** 
## ELEMENTARYHIGHLAND PARK                      4.53e-01   3.10e-02   14.63  < 2e-16 ***
## ELEMENTARYHIGHWOOD HILLS                    -5.58e-02   3.72e-02   -1.50  0.13386    
## ELEMENTARYHILLSIDE                          -1.25e-01   4.00e-02   -3.13  0.00177 ** 
## ELEMENTARYHILLTOP                            1.02e-02   4.04e-02    0.25  0.80137    
## ELEMENTARYHOMECROFT                          3.17e-01   4.63e-02    6.85  7.6e-12 ***
## ELEMENTARYHOOVER                             6.90e-02   3.99e-02    1.73  0.08408 .  
## ELEMENTARYHUGO                              -3.62e-03   3.62e-02   -0.10  0.92029    
## ELEMENTARYHUGO & ONEKA                      -2.25e-01   3.72e-02   -6.05  1.5e-09 ***
## ELEMENTARYISLAND LAKE                        1.93e-01   3.14e-02    6.15  8.0e-10 ***
## ELEMENTARYJACKSON                           -5.62e-01   4.26e-02  -13.19  < 2e-16 ***
## ELEMENTARYJEFFERSON                          2.03e-02   3.31e-02    0.61  0.53967    
## ELEMENTARYJEFFERS POND                       4.81e-01   4.03e-02   11.92  < 2e-16 ***
## ELEMENTARYJOHN F. KENNEDY                    2.54e-02   5.52e-02    0.46  0.64585    
## ELEMENTARYJOHNSON A+                        -2.86e-01   4.12e-02   -6.95  3.7e-12 ***
## ELEMENTARYJOHNSVILLE                         6.98e-02   2.98e-02    2.34  0.01920 *  
## ELEMENTARYJORDAN                             4.96e-01   1.33e-01    3.72  0.00020 ***
## ELEMENTARYKAPOSIA                           -8.28e-03   3.53e-02   -0.23  0.81441    
## ELEMENTARYKENNETH HALL                       8.01e-03   3.40e-02    0.24  0.81383    
## ELEMENTARYLAKEAIRES                          1.63e-01   3.16e-02    5.16  2.5e-07 ***
## ELEMENTARYLAKE ELMO                          1.06e-01   3.56e-02    2.99  0.00282 ** 
## ELEMENTARYLAKE MARION                        1.15e-02   4.52e-02    0.25  0.79935    
## ELEMENTARYLAKEVIEW                           1.23e-02   3.83e-02    0.32  0.74846    
## ELEMENTARYLiberty Ridge                      1.72e-01   3.82e-02    4.49  7.1e-06 ***
## ELEMENTARYLIBERTY RIDGE                      8.76e-02   3.76e-02    2.33  0.02000 *  
## ELEMENTARYLINCOLN                            2.19e-02   2.88e-02    0.76  0.44840    
## ELEMENTARYLINO LAKES                         1.39e-02   4.10e-02    0.34  0.73499    
## ELEMENTARYLITTLE CANADA                      1.50e-01   3.66e-02    4.10  4.2e-05 ***
## ELEMENTARYL.O. JACOB                         7.20e-02   4.35e-02    1.66  0.09780 .  
## ELEMENTARYLONGFELLOW                         5.74e-01   3.42e-02   16.76  < 2e-16 ***
## ELEMENTARYMADISON                            6.69e-02   3.56e-02    1.88  0.05986 .  
## ELEMENTARYMANN                               4.42e-01   3.07e-02   14.44  < 2e-16 ***
## ELEMENTARYMARION W. SAVAGE                   4.13e-01   3.64e-02   11.35  < 2e-16 ***
## ELEMENTARYMATOSKA INTERNATIONAL              2.03e-03   4.10e-02    0.05  0.96049    
## ELEMENTARYMCKINLEY                           5.98e-02   3.11e-02    1.92  0.05432 .  
## ELEMENTARYMEADOWVIEW                        -4.17e-02   3.72e-02   -1.12  0.26316    
## ELEMENTARYMENDOTA                            1.63e-01   3.99e-02    4.08  4.6e-05 ***
## ELEMENTARYMIDDLETON                          1.58e-01   3.76e-02    4.21  2.6e-05 ***
## ELEMENTARYMISSISSIPPI                       -1.94e-02   3.25e-02   -0.60  0.54940    
## ELEMENTARYMONROE                            -1.01e-01   3.28e-02   -3.08  0.00208 ** 
## ELEMENTARYMORELAND                           5.46e-02   3.67e-02    1.49  0.13667    
## ELEMENTARYMORRIS BYE                        -1.86e-02   3.30e-02   -0.56  0.57328    
## ELEMENTARYNEWPORT                           -1.39e-01   3.84e-02   -3.62  0.00030 ***
## ELEMENTARYNORTH END                         -3.60e-01   3.22e-02  -11.20  < 2e-16 ***
## ELEMENTARYNORTH PARK                         6.25e-02   3.44e-02    1.82  0.06926 .  
## ELEMENTARYNORTH TRAIL                       -4.40e-03   3.67e-02   -0.12  0.90443    
## ELEMENTARYNORTHVIEW                          9.69e-02   3.97e-02    2.44  0.01449 *  
## ELEMENTARYOAKDALE                           -1.43e-01   3.59e-02   -3.98  7.0e-05 ***
## ELEMENTARYOAK HILLS                         -5.12e-04   4.35e-02   -0.01  0.99060    
## ELEMENTARYOAKRIDGE                           7.20e-01   3.60e-02   20.04  < 2e-16 ***
## ELEMENTARYOAK RIDGE                          1.12e-01   3.97e-02    2.81  0.00491 ** 
## ELEMENTARYOBAMA                              4.67e-01   7.50e-02    6.22  5.0e-10 ***
## ELEMENTARYORCHARD LAKE                       8.94e-02   4.20e-02    2.13  0.03308 *  
## ELEMENTARYOTTER LAKE                         1.60e-01   3.25e-02    4.92  8.5e-07 ***
## ELEMENTARYPARKER                            -1.32e-02   8.13e-02   -0.16  0.87104    
## ELEMENTARYPARK TERRACE                       8.60e-02   3.46e-02    2.49  0.01294 *  
## ELEMENTARYPARK TERRACE & WESTWOOD           -3.29e-01   2.59e-01   -1.27  0.20325    
## ELEMENTARYPARKVIEW                           8.52e-02   3.31e-02    2.57  0.01012 *  
## ELEMENTARYPARKWAY                            1.10e-01   3.91e-02    2.81  0.00495 ** 
## ELEMENTARYPEARSON                            4.65e-01   3.32e-02   14.03  < 2e-16 ***
## ELEMENTARYPHALEN LAKE                       -2.86e-01   3.48e-02   -8.22  < 2e-16 ***
## ELEMENTARYPILOT KNOB                         1.19e-01   4.26e-02    2.80  0.00507 ** 
## ELEMENTARYPINE BEND                          9.41e-02   4.00e-02    2.35  0.01855 *  
## ELEMENTARYPINE HILL                         -1.66e-01   3.76e-02   -4.40  1.1e-05 ***
## ELEMENTARYPINEWOOD                           1.65e-02   3.01e-02    0.55  0.58483    
## ELEMENTARYPROSPERITY HEIGHTS                 1.81e-01   5.39e-02    3.36  0.00078 ***
## ELEMENTARYPULLMAN                           -2.42e-01   3.77e-02   -6.41  1.4e-10 ***
## ELEMENTARYRAHN                               5.83e-02   3.95e-02    1.48  0.13988    
## ELEMENTARYRAMSEY                            -9.64e-02   2.71e-02   -3.56  0.00037 ***
## ELEMENTARYRANDOLPH HEIGHTS                   5.23e-01   3.02e-02   17.34  < 2e-16 ***
## ELEMENTARYRED OAK                            5.83e-01   3.27e-02   17.83  < 2e-16 ***
## ELEMENTARYRED PINE                           1.03e-01   3.73e-02    2.75  0.00600 ** 
## ELEMENTARYRED ROCK                           1.60e-01   3.88e-02    4.11  4.0e-05 ***
## ELEMENTARYREDTAIL RIDGE                      4.20e-01   3.78e-02   11.12  < 2e-16 ***
## ELEMENTARYRICE LAKE                          1.40e-01   3.32e-02    4.21  2.5e-05 ***
## ELEMENTARYRICHARDSON                         1.47e-02   3.20e-02    0.46  0.64600    
## ELEMENTARYRIVERVIEW                         -1.59e-01   4.99e-02   -3.18  0.00149 ** 
## ELEMENTARYRIVERVIEW & CHEROKEE              -2.76e-01   3.60e-02   -7.66  1.9e-14 ***
## ELEMENTARYROOSEVELT & RIVERVIEW & CHEROKEE   2.23e-01   3.81e-02    5.84  5.2e-09 ***
## ELEMENTARYROSEMOUNT                         -1.76e-03   3.79e-02   -0.05  0.96302    
## ELEMENTARYROYAL OAKS                         2.10e-02   3.79e-02    0.55  0.58063    
## ELEMENTARYRUM RIVER                         -1.12e-02   3.13e-02   -0.36  0.72008    
## ELEMENTARYRUTHERFORD                         2.26e-01   5.31e-02    4.26  2.1e-05 ***
## ELEMENTARYSALEM HILLS                        6.65e-02   5.46e-02    1.22  0.22316    
## ELEMENTARYSAND CREEK                         2.48e-02   3.03e-02    0.82  0.41327    
## ELEMENTARYSHANNON PARK                       9.01e-03   3.69e-02    0.24  0.80720    
## ELEMENTARYSHERIDAN                           1.45e-01   4.50e-02    3.23  0.00126 ** 
## ELEMENTARYSHERIDAN & AMES                   -3.97e-01   3.17e-02  -12.52  < 2e-16 ***
## ELEMENTARYSIOUX TRAIL                        5.02e-02   4.17e-02    1.20  0.22885    
## ELEMENTARYSKY OAKS                          -2.02e-02   4.02e-02   -0.50  0.61566    
## ELEMENTARYSKYVIEW                           -1.63e-01   3.91e-02   -4.18  2.9e-05 ***
## ELEMENTARYSKYVIEW COMMUNITY SCHOOL           1.44e-01   3.79e-02    3.80  0.00014 ***
## ELEMENTARYSOMERSET HEIGHTS                   1.64e-01   3.72e-02    4.40  1.1e-05 ***
## ELEMENTARYSORTEBERG                         -6.46e-03   3.52e-02   -0.18  0.85462    
## ELEMENTARYSOUTH GROVE                        5.27e-02   5.30e-02    1.00  0.31957    
## ELEMENTARYSOUTHVIEW                          2.18e-02   3.67e-02    0.59  0.55332    
## ELEMENTARYST ANTHONY PARK                    5.59e-01   4.11e-02   13.62  < 2e-16 ***
## ELEMENTARYSTEVENSON                          1.06e-01   3.69e-02    2.88  0.00400 ** 
## ELEMENTARYSUNNYSIDE                          4.96e-02   3.39e-02    1.46  0.14301    
## ELEMENTARYSUN PATH                           1.68e-01   3.61e-02    4.66  3.2e-06 ***
## ELEMENTARYSWEENEY                            3.31e-01   3.51e-02    9.42  < 2e-16 ***
## ELEMENTARYTHOMAS LAKE                        8.56e-02   4.15e-02    2.06  0.03899 *  
## ELEMENTARYTURTLE LAKE                        2.79e-01   2.98e-02    9.39  < 2e-16 ***
## ELEMENTARYTWIN LAKES                        -7.33e-01   1.67e-01   -4.40  1.1e-05 ***
## ELEMENTARYUNIVERSITY                        -7.49e-02   2.91e-02   -2.57  0.01015 *  
## ELEMENTARYVADNAIS HEIGHTS                    4.77e-02   3.60e-02    1.33  0.18447    
## ELEMENTARYVALENTINE HILLS                    1.36e-01   3.12e-02    4.35  1.4e-05 ***
## ELEMENTARYVALLEY VIEW                        1.29e-01   3.55e-02    3.62  0.00029 ***
## ELEMENTARYVISTA VIEW                         1.92e-02   3.89e-02    0.49  0.62091    
## ELEMENTARYWASHINGTON                         3.48e-02   3.84e-02    0.90  0.36596    
## ELEMENTARYWEAVER                             4.31e-02   3.05e-02    1.41  0.15735    
## ELEMENTARYWEBSTER                            9.72e-02   3.63e-02    2.68  0.00740 ** 
## ELEMENTARYWESTVIEW                           3.79e-02   3.72e-02    1.02  0.30764    
## ELEMENTARYWESTWOOD                           3.60e-01   4.01e-02    8.96  < 2e-16 ***
## ELEMENTARYWESTWOOD & GRAINWOOD               5.96e-01   3.56e-02   16.72  < 2e-16 ***
## ELEMENTARYWILLIAM BYRNE                     -1.88e-02   4.13e-02   -0.46  0.64854    
## ELEMENTARYWILLOW LANE                        2.36e-03   3.96e-02    0.06  0.95254    
## ELEMENTARYWILSHIRE PARK                      1.22e-01   6.79e-02    1.80  0.07181 .  
## ELEMENTARYWILSON                            -8.31e-02   3.56e-02   -2.33  0.01961 *  
## ELEMENTARYWOODBURY                           3.32e-02   3.76e-02    0.88  0.37781    
## ELEMENTARYWOODCREST                          2.07e-01   2.71e-02    7.64  2.2e-14 ***
## ELEMENTARYWOODCREST & WESTWOOD              -7.07e-02   2.59e-01   -0.27  0.78482    
## ELEMENTARYWOODLAND                           1.09e-01   4.11e-02    2.65  0.00804 ** 
## WhiteDense                                   4.99e-01   1.20e-02   41.60  < 2e-16 ***
## fam_income                                  -1.09e-06   1.24e-07   -8.75  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.365 on 51123 degrees of freedom
## Multiple R-squared: 0.559,	Adjusted R-squared: 0.557 
## F-statistic:  240 on 270 and 51123 DF,  p-value: <2e-16 
## 
```


Time
----
The years of 2005 - 2011 were different for the real estate market relative to the early years of the 2000s. We now incorporate fixed effects for the sale year and month of sale to limit the confounding effects of the changing real estate conditions.
* Here we should create a graph of sales price indices for the region (such as Case Schiller) and the nation.


```r
TimeModel1 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH), data = HouseData)
summary(TimeModel1)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + 
##     HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + 
##     factor(SALE_MONTH), data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -7.003 -0.098  0.023  0.150  3.169 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                  4.84e+00   2.07e-01   23.40  < 2e-16 ***
## FIN_SQ_FT                                    3.14e-04   3.28e-06   95.58  < 2e-16 ***
## ACRES_POLY                                   3.91e-02   2.00e-03   19.55  < 2e-16 ***
## YEAR_BUILT                                   3.23e-03   1.04e-04   30.94  < 2e-16 ***
## HOME_STYLE1 1/2 Story Frame                 -1.76e-01   7.12e-02   -2.47  0.01338 *  
## HOME_STYLE1 1/2 STRY                        -1.64e-01   6.23e-02   -2.63  0.00866 ** 
## HOME_STYLE1-1/2 STRY                         1.09e-01   5.10e-02    2.14  0.03209 *  
## HOME_STYLE1 1/4 story - 25% finished        -6.49e-02   3.47e-01   -0.19  0.85161    
## HOME_STYLE1 1/4 story 50% finished           1.56e-01   1.77e-01    0.88  0.37710    
## HOME_STYLE1 1/4 story finished               7.83e-02   4.70e-02    1.67  0.09578 .  
## HOME_STYLE1 1/4 story - unfinished          -1.06e-01   8.96e-02   -1.18  0.23677    
## HOME_STYLE1 1/4 STRY                        -2.41e-01   9.38e-02   -2.57  0.01017 *  
## HOME_STYLE1-1/4 STRY                         7.73e-02   4.87e-02    1.59  0.11222    
## HOME_STYLE1-2 STRY                          -1.46e-03   5.02e-02   -0.03  0.97684    
## HOME_STYLE1 3/4 story finished               1.01e-01   6.87e-02    1.47  0.14257    
## HOME_STYLE1 3/4 STRY                         1.19e-01   8.57e-02    1.39  0.16473    
## HOME_STYLE1-3/4 STRY                         1.67e-01   5.57e-02    3.00  0.00273 ** 
## HOME_STYLE1 Story Brick                      2.61e-01   2.04e-01    1.28  0.20083    
## HOME_STYLE1 Story Condo                     -4.69e-01   5.66e-02   -8.29  < 2e-16 ***
## HOME_STYLE1 Story Frame                      1.61e-01   4.86e-02    3.31  0.00092 ***
## HOME_STYLE1 Story Townhouse                  9.48e-02   5.01e-02    1.89  0.05834 .  
## HOME_STYLE2 1/2 Story Finished              -1.10e-01   3.47e-01   -0.32  0.75190    
## HOME_STYLE2 Story Brick                      1.78e-01   3.47e-01    0.51  0.60830    
## HOME_STYLE2 Story Condo                     -4.14e-01   5.18e-02   -7.99  1.3e-15 ***
## HOME_STYLE2 Story Frame                      9.24e-02   4.88e-02    1.89  0.05826 .  
## HOME_STYLE2 Story Townhouse                 -2.84e-01   4.90e-02   -5.80  6.5e-09 ***
## HOME_STYLE3-LVL SPLT                        -2.00e-01   5.31e-02   -3.76  0.00017 ***
## HOME_STYLE4 LVL SPLT                        -1.27e-01   5.13e-02   -2.48  0.01316 *  
## HOME_STYLEBi-level                           1.68e-01   4.35e-02    3.85  0.00012 ***
## HOME_STYLEBungalow                           6.35e-02   4.34e-02    1.46  0.14310    
## HOME_STYLECabin                             -2.69e-01   3.47e-01   -0.78  0.43815    
## HOME_STYLECONDO                             -8.75e-01   5.58e-02  -15.68  < 2e-16 ***
## HOME_STYLECondo - CO                        -1.03e-01   1.60e-01   -0.64  0.51932    
## HOME_STYLEDetached Townhome - 1 story        2.95e-01   4.98e-02    5.92  3.2e-09 ***
## HOME_STYLEDetached Townhome - 2 story        5.17e-02   6.38e-02    0.81  0.41782    
## HOME_STYLEDetached Townhome - Split Foy*     4.67e-01   2.04e-01    2.29  0.02196 *  
## HOME_STYLEDetached Townhome - Split lev*     2.78e-01   1.00e-01    2.78  0.00549 ** 
## HOME_STYLEDouble bungalow - split foyer      2.13e-01   3.47e-01    0.61  0.53956    
## HOME_STYLEDUP/TRI                           -1.56e-01   1.61e-01   -0.97  0.33276    
## HOME_STYLEEARTHBERM                         -6.49e-01   3.47e-01   -1.87  0.06140 .  
## HOME_STYLEEARTH SHEL                        -1.81e-01   3.47e-01   -0.52  0.60264    
## HOME_STYLELOG                                1.71e-01   2.04e-01    0.84  0.40206    
## HOME_STYLEMfd Home (Double)                 -2.36e-01   3.47e-01   -0.68  0.49675    
## HOME_STYLEMini-Warehouse - Condo            -2.38e+00   1.39e-01  -17.13  < 2e-16 ***
## HOME_STYLEModified two story                 1.51e-01   4.54e-02    3.33  0.00085 ***
## HOME_STYLEModular                           -1.60e+00   2.47e-01   -6.46  1.1e-10 ***
## HOME_STYLEN/A                                1.07e-02   1.48e-01    0.07  0.94260    
## HOME_STYLEOne And 3/4 Story                  4.07e-02   4.40e-02    0.92  0.35547    
## HOME_STYLEOne Story                          6.46e-02   4.30e-02    1.50  0.13288    
## HOME_STYLEONE STORY                          2.22e-02   4.59e-02    0.48  0.62868    
## HOME_STYLEOther                             -1.05e+00   1.77e-01   -5.89  3.8e-09 ***
## HOME_STYLEQuad - one story                  -8.77e-02   1.61e-01   -0.55  0.58477    
## HOME_STYLEQuad - split level/foyer          -8.62e-02   5.15e-02   -1.67  0.09435 .  
## HOME_STYLEQuad - Two story                  -1.10e-01   2.47e-01   -0.45  0.65510    
## HOME_STYLERAMBLER                           -1.63e-01   4.83e-02   -3.38  0.00072 ***
## HOME_STYLERow                               -1.40e-01   3.47e-01   -0.41  0.68535    
## HOME_STYLESalvage                            5.46e-02   1.78e-01    0.31  0.75954    
## HOME_STYLESPLIT-ENT                         -2.08e-01   4.86e-02   -4.29  1.8e-05 ***
## HOME_STYLESplit/entry                       -1.46e-02   4.46e-02   -0.33  0.74264    
## HOME_STYLESPLIT-FOY                         -1.92e-01   5.28e-02   -3.64  0.00027 ***
## HOME_STYLESplit Foyer Frame                  1.63e-01   4.91e-02    3.32  0.00090 ***
## HOME_STYLESplit/level                        4.94e-02   4.49e-02    1.10  0.27097    
## HOME_STYLESplit Level                        2.08e-01   4.39e-02    4.72  2.3e-06 ***
## HOME_STYLESplit Level Frame                  2.14e-01   4.95e-02    4.32  1.6e-05 ***
## HOME_STYLESPLIT LEVL                        -1.79e-03   4.59e-02   -0.04  0.96880    
## HOME_STYLEThree Story                       -1.67e-01   7.69e-02   -2.18  0.02957 *  
## HOME_STYLETOWNHOME                          -4.90e-01   4.75e-02  -10.33  < 2e-16 ***
## HOME_STYLETWIN HOME                         -3.02e-01   5.36e-02   -5.63  1.8e-08 ***
## HOME_STYLETwin home - one story             -2.87e-01   8.57e-02   -3.35  0.00080 ***
## HOME_STYLETwin home - spit level/ split*    -2.68e-01   5.96e-02   -4.50  6.9e-06 ***
## HOME_STYLETwin home - two story             -5.25e-01   1.23e-01   -4.27  2.0e-05 ***
## HOME_STYLETwo Story                          9.16e-03   4.31e-02    0.21  0.83190    
## HOME_STYLETWO STORY                          3.40e-02   4.61e-02    0.74  0.46114    
## HOME_STYLETWO+ STORY                        -5.33e-03   1.18e-01   -0.05  0.96395    
## ELEMENTARYAFTON-LAKELAND                    -2.88e-02   4.16e-02   -0.69  0.48780    
## ELEMENTARYAKIN ROAD                          7.44e-02   3.38e-02    2.20  0.02755 *  
## ELEMENTARYAMES                               1.56e-01   4.25e-02    3.67  0.00024 ***
## ELEMENTARYANDERSEN                           1.80e-01   6.19e-02    2.91  0.00367 ** 
## ELEMENTARYANDERSON & WILDWOOD                1.97e-01   3.55e-02    5.55  2.9e-08 ***
## ELEMENTARYANDOVER                            2.83e-02   2.76e-02    1.02  0.30540    
## ELEMENTARYARMSTRONG                         -2.07e-02   3.66e-02   -0.57  0.57163    
## ELEMENTARYBAILEY                             4.01e-02   3.34e-02    1.20  0.22964    
## ELEMENTARYBATTLE CREEK                       1.79e-01   4.15e-02    4.31  1.6e-05 ***
## ELEMENTARYBEL AIR                            1.77e-01   2.97e-02    5.95  2.7e-09 ***
## ELEMENTARYBIRCH LAKE                         9.82e-02   3.49e-02    2.81  0.00489 ** 
## ELEMENTARYBLUE HERON                        -3.33e-02   3.14e-02   -1.06  0.28973    
## ELEMENTARYBRIMHALL                           3.29e-01   3.06e-02   10.76  < 2e-16 ***
## ELEMENTARYBRUCE F. VENTO                    -1.85e-01   3.43e-02   -5.39  7.0e-08 ***
## ELEMENTARYCARVER                             7.43e-02   3.12e-02    2.39  0.01708 *  
## ELEMENTARYCASTLE                             9.78e-02   3.54e-02    2.76  0.00574 ** 
## ELEMENTARYCEDAR CREEK                       -7.72e-02   6.70e-02   -1.15  0.24917    
## ELEMENTARYCEDAR PARK                         1.29e-01   4.03e-02    3.20  0.00135 ** 
## ELEMENTARYCENTENNIAL                        -7.16e-04   3.46e-02   -0.02  0.98349    
## ELEMENTARYCENTERVILLE                        9.06e-03   3.24e-02    0.28  0.78002    
## ELEMENTARYCENTRAL PARK                       2.14e-01   3.16e-02    6.77  1.3e-11 ***
## ELEMENTARYCHELSEA HEIGHTS                    2.56e-01   2.76e-02    9.28  < 2e-16 ***
## ELEMENTARYCHERRY VIEW                        2.99e-03   3.86e-02    0.08  0.93827    
## ELEMENTARYCHRISTINA HUDDLESTON               4.76e-02   3.91e-02    1.22  0.22413    
## ELEMENTARYCOMO PARK                          1.80e-01   3.03e-02    5.92  3.1e-09 ***
## ELEMENTARYCOTTAGE GROVE                      6.13e-02   3.49e-02    1.76  0.07867 .  
## ELEMENTARYCOWERN                             7.03e-02   3.17e-02    2.22  0.02672 *  
## ELEMENTARYCRESTVIEW                         -1.62e-02   3.85e-02   -0.42  0.67452    
## ELEMENTARYCROOKED LAKE                       1.85e-02   3.25e-02    0.57  0.56870    
## ELEMENTARYCRYSTAL LAKE                       3.26e-02   3.81e-02    0.86  0.39237    
## ELEMENTARYDAYTONS BLUFF                     -1.62e-01   3.09e-02   -5.24  1.6e-07 ***
## ELEMENTARYDEERWOOD                           7.55e-02   4.09e-02    1.84  0.06519 .  
## ELEMENTARYDIAMOND PATH                       1.07e-01   3.43e-02    3.12  0.00180 ** 
## ELEMENTARYEAGLE CREEK                        4.96e-01   3.39e-02   14.66  < 2e-16 ***
## ELEMENTARYEAGLE POINT                        5.40e-02   3.86e-02    1.40  0.16239    
## ELEMENTARYEAST BETHEL & CEDAR CREEK          1.90e-03   4.16e-02    0.05  0.96351    
## ELEMENTARYEASTERN HEIGHTS                   -3.09e-02   2.89e-02   -1.07  0.28548    
## ELEMENTARYEASTVIEW                           3.04e-02   3.90e-02    0.78  0.43544    
## ELEMENTARYECHO PARK                          2.37e-02   3.49e-02    0.68  0.49685    
## ELEMENTARYEDGERTON                           1.72e-01   3.33e-02    5.17  2.4e-07 ***
## ELEMENTARYEDWARD NEILL                       6.44e-02   3.70e-02    1.74  0.08214 .  
## ELEMENTARYEISENHOWER                         4.47e-02   3.88e-02    1.15  0.24961    
## ELEMENTARYEMMET D. WILLIAMS                  2.49e-01   3.11e-02    7.99  1.4e-15 ***
## ELEMENTARYFALCON HEIGHTS                     2.66e-01   3.03e-02    8.77  < 2e-16 ***
## ELEMENTARYFARMINGTON                         4.83e-02   3.32e-02    1.45  0.14593    
## ELEMENTARYFARNSWORTH                         2.14e-01   3.62e-02    5.93  3.1e-09 ***
## ELEMENTARYFARNSWORTH LOWER                  -9.55e-02   3.59e-02   -2.66  0.00780 ** 
## ELEMENTARYFIVE HAWKS                         6.09e-01   3.16e-02   19.28  < 2e-16 ***
## ELEMENTARYFOREST VIEW                       -2.80e-01   1.19e-01   -2.35  0.01898 *  
## ELEMENTARYFOREST VIEW & FOREST LAKE         -3.28e-01   1.34e-01   -2.45  0.01418 *  
## ELEMENTARYFRANKLIN                          -7.80e-02   3.00e-02   -2.60  0.00931 ** 
## ELEMENTARYFRANKLIN MUSIC                     1.36e-01   1.42e-01    0.96  0.33851    
## ELEMENTARYFROST LAKE                         7.90e-02   3.51e-02    2.25  0.02458 *  
## ELEMENTARYGALTIER & MAXFIELD                 5.54e-02   2.80e-02    1.98  0.04796 *  
## ELEMENTARYGARLOUGH                           2.01e-01   3.88e-02    5.19  2.1e-07 ***
## ELEMENTARYGIDEON POND                        1.32e-01   4.13e-02    3.19  0.00144 ** 
## ELEMENTARYGLACIER HILLS                      1.23e-01   3.98e-02    3.10  0.00195 ** 
## ELEMENTARYGLENDALE                           5.23e-01   3.45e-02   15.16  < 2e-16 ***
## ELEMENTARYGOLDEN LAKE                        1.34e-01   3.97e-02    3.37  0.00075 ***
## ELEMENTARYGRAINWOOD                          3.45e-01   4.00e-02    8.62  < 2e-16 ***
## ELEMENTARYGREENLEAF                          2.49e-02   3.38e-02    0.74  0.46164    
## ELEMENTARYGREY CLOUD                         3.18e-02   3.67e-02    0.86  0.38721    
## ELEMENTARYGROVELAND PARK                     5.39e-01   2.99e-02   18.05  < 2e-16 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  4.46e-01   3.43e-02   13.03  < 2e-16 ***
## ELEMENTARYHAMILTON                           2.27e-02   3.31e-02    0.68  0.49355    
## ELEMENTARYHANCOCK                            2.19e-01   4.76e-02    4.59  4.4e-06 ***
## ELEMENTARYHANCOCK EL.                        3.19e-01   4.07e-02    7.83  5.1e-15 ***
## ELEMENTARYHARRIET BISHOP                     4.03e-01   3.65e-02   11.05  < 2e-16 ***
## ELEMENTARYHAYDEN HEIGHTS                     6.63e-02   3.61e-02    1.84  0.06646 .  
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -1.10e-01   3.04e-02   -3.62  0.00030 ***
## ELEMENTARYHAYES                              1.36e-01   3.30e-02    4.12  3.8e-05 ***
## ELEMENTARYHIDDEN VALLEY                      3.89e-01   3.77e-02   10.34  < 2e-16 ***
## ELEMENTARYHIGHLAND                           9.54e-02   2.91e-02    3.28  0.00104 ** 
## ELEMENTARYHIGHLAND PARK                      4.47e-01   2.92e-02   15.33  < 2e-16 ***
## ELEMENTARYHIGHWOOD HILLS                     1.18e-01   3.51e-02    3.36  0.00078 ***
## ELEMENTARYHILLSIDE                           1.24e-02   3.78e-02    0.33  0.74178    
## ELEMENTARYHILLTOP                            1.52e-01   3.81e-02    3.98  6.8e-05 ***
## ELEMENTARYHOMECROFT                          2.98e-01   4.36e-02    6.84  8.0e-12 ***
## ELEMENTARYHOOVER                             8.27e-02   3.76e-02    2.20  0.02785 *  
## ELEMENTARYHUGO                               6.08e-02   3.41e-02    1.78  0.07434 .  
## ELEMENTARYHUGO & ONEKA                       6.45e-02   3.52e-02    1.83  0.06703 .  
## ELEMENTARYISLAND LAKE                        1.82e-01   2.96e-02    6.15  7.9e-10 ***
## ELEMENTARYJACKSON                           -4.31e-01   4.02e-02  -10.73  < 2e-16 ***
## ELEMENTARYJEFFERSON                          2.51e-02   3.12e-02    0.80  0.42177    
## ELEMENTARYJEFFERS POND                       5.40e-01   3.80e-02   14.22  < 2e-16 ***
## ELEMENTARYJOHN F. KENNEDY                    8.26e-02   5.20e-02    1.59  0.11206    
## ELEMENTARYJOHNSON A+                        -1.62e-01   3.88e-02   -4.18  3.0e-05 ***
## ELEMENTARYJOHNSVILLE                         4.93e-02   2.81e-02    1.76  0.07878 .  
## ELEMENTARYJORDAN                             4.26e-01   1.26e-01    3.40  0.00068 ***
## ELEMENTARYKAPOSIA                            1.22e-01   3.33e-02    3.65  0.00026 ***
## ELEMENTARYKENNETH HALL                       2.12e-02   3.20e-02    0.66  0.50853    
## ELEMENTARYLAKEAIRES                          2.44e-01   2.98e-02    8.19  2.8e-16 ***
## ELEMENTARYLAKE ELMO                          9.28e-02   3.35e-02    2.77  0.00564 ** 
## ELEMENTARYLAKE MARION                        3.87e-02   4.26e-02    0.91  0.36317    
## ELEMENTARYLAKEVIEW                          -4.31e-03   3.61e-02   -0.12  0.90492    
## ELEMENTARYLiberty Ridge                     -2.07e-02   3.61e-02   -0.57  0.56554    
## ELEMENTARYLIBERTY RIDGE                      1.74e-01   3.55e-02    4.91  9.1e-07 ***
## ELEMENTARYLINCOLN                            1.02e-01   2.72e-02    3.76  0.00017 ***
## ELEMENTARYLINO LAKES                         1.43e-02   3.86e-02    0.37  0.71181    
## ELEMENTARYLITTLE CANADA                      2.27e-01   3.45e-02    6.57  4.9e-11 ***
## ELEMENTARYL.O. JACOB                         7.11e-02   4.10e-02    1.74  0.08256 .  
## ELEMENTARYLONGFELLOW                         4.87e-01   3.23e-02   15.09  < 2e-16 ***
## ELEMENTARYMADISON                            6.74e-02   3.35e-02    2.01  0.04404 *  
## ELEMENTARYMANN                               4.66e-01   2.89e-02   16.15  < 2e-16 ***
## ELEMENTARYMARION W. SAVAGE                   4.75e-01   3.43e-02   13.84  < 2e-16 ***
## ELEMENTARYMATOSKA INTERNATIONAL              2.38e-01   3.88e-02    6.14  8.1e-10 ***
## ELEMENTARYMCKINLEY                           4.88e-02   2.93e-02    1.67  0.09504 .  
## ELEMENTARYMEADOWVIEW                         4.73e-02   3.51e-02    1.35  0.17807    
## ELEMENTARYMENDOTA                            1.31e-01   3.76e-02    3.49  0.00049 ***
## ELEMENTARYMIDDLETON                          1.04e-01   3.54e-02    2.92  0.00348 ** 
## ELEMENTARYMISSISSIPPI                        5.35e-02   3.06e-02    1.75  0.08066 .  
## ELEMENTARYMONROE                             6.58e-02   3.10e-02    2.12  0.03365 *  
## ELEMENTARYMORELAND                           1.32e-01   3.46e-02    3.83  0.00013 ***
## ELEMENTARYMORRIS BYE                        -6.76e-02   3.11e-02   -2.18  0.02956 *  
## ELEMENTARYNEWPORT                            4.96e-02   3.62e-02    1.37  0.17031    
## ELEMENTARYNORTH END                         -1.64e-01   3.04e-02   -5.38  7.5e-08 ***
## ELEMENTARYNORTH PARK                         8.43e-02   3.24e-02    2.60  0.00924 ** 
## ELEMENTARYNORTH TRAIL                        7.16e-02   3.45e-02    2.07  0.03829 *  
## ELEMENTARYNORTHVIEW                          2.41e-02   3.74e-02    0.64  0.51910    
## ELEMENTARYOAKDALE                            3.45e-02   3.38e-02    1.02  0.30827    
## ELEMENTARYOAK HILLS                         -1.97e-02   4.09e-02   -0.48  0.62990    
## ELEMENTARYOAKRIDGE                           5.94e-01   3.39e-02   17.53  < 2e-16 ***
## ELEMENTARYOAK RIDGE                          1.25e-01   3.74e-02    3.35  0.00082 ***
## ELEMENTARYOBAMA                              5.65e-01   7.07e-02    8.00  1.2e-15 ***
## ELEMENTARYORCHARD LAKE                       1.49e-01   3.95e-02    3.78  0.00016 ***
## ELEMENTARYOTTER LAKE                         1.15e-01   3.07e-02    3.73  0.00019 ***
## ELEMENTARYPARKER                            -4.96e-02   7.66e-02   -0.65  0.51741    
## ELEMENTARYPARK TERRACE                       8.35e-02   3.26e-02    2.56  0.01039 *  
## ELEMENTARYPARK TERRACE & WESTWOOD           -1.14e-01   2.44e-01   -0.47  0.63914    
## ELEMENTARYPARKVIEW                           1.21e-01   3.12e-02    3.88  0.00010 ***
## ELEMENTARYPARKWAY                            8.82e-02   3.68e-02    2.39  0.01670 *  
## ELEMENTARYPEARSON                            4.57e-01   3.12e-02   14.64  < 2e-16 ***
## ELEMENTARYPHALEN LAKE                       -1.29e-01   3.29e-02   -3.91  9.2e-05 ***
## ELEMENTARYPILOT KNOB                         1.36e-01   4.01e-02    3.38  0.00071 ***
## ELEMENTARYPINE BEND                          1.32e-01   3.76e-02    3.51  0.00045 ***
## ELEMENTARYPINE HILL                          2.48e-02   3.55e-02    0.70  0.48491    
## ELEMENTARYPINEWOOD                           4.59e-02   2.84e-02    1.62  0.10585    
## ELEMENTARYPROSPERITY HEIGHTS                 1.72e-01   5.08e-02    3.38  0.00073 ***
## ELEMENTARYPULLMAN                           -3.30e-02   3.56e-02   -0.93  0.35340    
## ELEMENTARYRAHN                               1.30e-01   3.72e-02    3.49  0.00049 ***
## ELEMENTARYRAMSEY                            -9.82e-02   2.55e-02   -3.85  0.00012 ***
## ELEMENTARYRANDOLPH HEIGHTS                   5.20e-01   2.84e-02   18.30  < 2e-16 ***
## ELEMENTARYRED OAK                            5.37e-01   3.08e-02   17.41  < 2e-16 ***
## ELEMENTARYRED PINE                           1.05e-01   3.51e-02    2.98  0.00290 ** 
## ELEMENTARYRED ROCK                           7.56e-02   3.66e-02    2.06  0.03901 *  
## ELEMENTARYREDTAIL RIDGE                      5.41e-01   3.56e-02   15.19  < 2e-16 ***
## ELEMENTARYRICE LAKE                          2.84e-02   3.13e-02    0.91  0.36357    
## ELEMENTARYRICHARDSON                         1.40e-01   3.02e-02    4.62  3.8e-06 ***
## ELEMENTARYRIVERVIEW                          1.01e-01   4.72e-02    2.15  0.03149 *  
## ELEMENTARYRIVERVIEW & CHEROKEE               5.00e-03   3.41e-02    0.15  0.88329    
## ELEMENTARYROOSEVELT & RIVERVIEW & CHEROKEE   1.95e-01   3.59e-02    5.43  5.6e-08 ***
## ELEMENTARYROSEMOUNT                          8.99e-02   3.58e-02    2.51  0.01195 *  
## ELEMENTARYROYAL OAKS                         6.15e-02   3.57e-02    1.72  0.08514 .  
## ELEMENTARYRUM RIVER                         -4.11e-02   2.95e-02   -1.39  0.16341    
## ELEMENTARYRUTHERFORD                         1.67e-01   5.00e-02    3.34  0.00085 ***
## ELEMENTARYSALEM HILLS                        1.25e-01   5.14e-02    2.42  0.01533 *  
## ELEMENTARYSAND CREEK                        -1.94e-02   2.85e-02   -0.68  0.49770    
## ELEMENTARYSHANNON PARK                       2.82e-02   3.48e-02    0.81  0.41707    
## ELEMENTARYSHERIDAN                           1.65e-01   4.24e-02    3.88  0.00010 ***
## ELEMENTARYSHERIDAN & AMES                   -9.98e-02   3.01e-02   -3.32  0.00089 ***
## ELEMENTARYSIOUX TRAIL                        1.40e-01   3.93e-02    3.55  0.00038 ***
## ELEMENTARYSKY OAKS                           9.65e-02   3.79e-02    2.55  0.01090 *  
## ELEMENTARYSKYVIEW                            4.19e-02   3.69e-02    1.13  0.25660    
## ELEMENTARYSKYVIEW COMMUNITY SCHOOL           1.07e-01   3.57e-02    3.00  0.00274 ** 
## ELEMENTARYSOMERSET HEIGHTS                   1.73e-01   3.50e-02    4.93  8.3e-07 ***
## ELEMENTARYSORTEBERG                          2.79e-04   3.32e-02    0.01  0.99329    
## ELEMENTARYSOUTH GROVE                        1.05e-01   4.99e-02    2.11  0.03490 *  
## ELEMENTARYSOUTHVIEW                          7.20e-02   3.46e-02    2.08  0.03745 *  
## ELEMENTARYST ANTHONY PARK                    5.73e-01   3.87e-02   14.83  < 2e-16 ***
## ELEMENTARYSTEVENSON                          1.55e-01   3.47e-02    4.45  8.7e-06 ***
## ELEMENTARYSUNNYSIDE                          1.31e-01   3.19e-02    4.10  4.2e-05 ***
## ELEMENTARYSUN PATH                           3.51e-01   3.41e-02   10.28  < 2e-16 ***
## ELEMENTARYSWEENEY                            3.95e-01   3.31e-02   11.94  < 2e-16 ***
## ELEMENTARYTHOMAS LAKE                        7.12e-02   3.90e-02    1.82  0.06821 .  
## ELEMENTARYTURTLE LAKE                        1.90e-01   2.80e-02    6.78  1.2e-11 ***
## ELEMENTARYTWIN LAKES                        -5.09e-01   1.57e-01   -3.25  0.00117 ** 
## ELEMENTARYUNIVERSITY                        -1.25e-01   2.75e-02   -4.54  5.6e-06 ***
## ELEMENTARYVADNAIS HEIGHTS                    1.17e-01   3.39e-02    3.44  0.00059 ***
## ELEMENTARYVALENTINE HILLS                    2.13e-01   2.94e-02    7.23  5.0e-13 ***
## ELEMENTARYVALLEY VIEW                        1.68e-01   3.34e-02    5.02  5.2e-07 ***
## ELEMENTARYVISTA VIEW                         1.33e-01   3.67e-02    3.62  0.00029 ***
## ELEMENTARYWASHINGTON                         2.50e-02   3.62e-02    0.69  0.49059    
## ELEMENTARYWEAVER                             1.45e-01   2.88e-02    5.06  4.3e-07 ***
## ELEMENTARYWEBSTER                            2.24e-01   3.42e-02    6.55  5.8e-11 ***
## ELEMENTARYWESTVIEW                           5.34e-02   3.50e-02    1.53  0.12697    
## ELEMENTARYWESTWOOD                           4.40e-01   3.78e-02   11.64  < 2e-16 ***
## ELEMENTARYWESTWOOD & GRAINWOOD               5.01e-01   3.36e-02   14.94  < 2e-16 ***
## ELEMENTARYWILLIAM BYRNE                      3.20e-02   3.89e-02    0.82  0.41053    
## ELEMENTARYWILLOW LANE                        1.19e-01   3.74e-02    3.20  0.00139 ** 
## ELEMENTARYWILSHIRE PARK                      2.76e-01   6.40e-02    4.32  1.6e-05 ***
## ELEMENTARYWILSON                            -7.63e-02   3.35e-02   -2.27  0.02293 *  
## ELEMENTARYWOODBURY                           1.07e-01   3.54e-02    3.01  0.00260 ** 
## ELEMENTARYWOODCREST                          1.74e-01   2.55e-02    6.81  9.8e-12 ***
## ELEMENTARYWOODCREST & WESTWOOD               2.61e-01   2.44e-01    1.07  0.28544    
## ELEMENTARYWOODLAND                           5.34e-02   3.87e-02    1.38  0.16739    
## WhiteDense                                   1.99e-01   1.20e-02   16.61  < 2e-16 ***
## fam_income                                   4.62e-06   1.39e-07   33.32  < 2e-16 ***
## factor(SALE_YEAR)2006                        6.22e-03   3.84e-03    1.62  0.10566    
## factor(SALE_YEAR)2009                       -3.40e-01   5.66e-03  -60.02  < 2e-16 ***
## factor(SALE_YEAR)2010                       -3.58e-01   5.83e-03  -61.41  < 2e-16 ***
## factor(SALE_YEAR)2011                       -5.14e-01   1.02e-02  -50.31  < 2e-16 ***
## factor(SALE_MONTH)2                         -1.41e-02   9.07e-03   -1.55  0.12013    
## factor(SALE_MONTH)3                          1.39e-02   8.44e-03    1.64  0.10028    
## factor(SALE_MONTH)4                          7.69e-03   8.27e-03    0.93  0.35252    
## factor(SALE_MONTH)5                          3.93e-02   8.16e-03    4.82  1.4e-06 ***
## factor(SALE_MONTH)6                          4.48e-02   7.99e-03    5.61  2.0e-08 ***
## factor(SALE_MONTH)7                          4.44e-02   8.27e-03    5.36  8.2e-08 ***
## factor(SALE_MONTH)8                          4.39e-02   8.21e-03    5.35  9.0e-08 ***
## factor(SALE_MONTH)9                          2.79e-02   8.45e-03    3.30  0.00097 ***
## factor(SALE_MONTH)10                         4.05e-02   8.52e-03    4.75  2.0e-06 ***
## factor(SALE_MONTH)11                         5.85e-03   8.79e-03    0.67  0.50558    
## factor(SALE_MONTH)12                        -5.68e-03   9.09e-03   -0.62  0.53203    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.343 on 51108 degrees of freedom
## Multiple R-squared: 0.609,	Adjusted R-squared: 0.607 
## F-statistic:  280 on 285 and 51108 DF,  p-value: <2e-16 
## 
```


Open Space
---------
Now we'll bring in the open space measures, both Open Space Index and park area.



```r
osiModel05KM.1 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    parkArea05, data = HouseData)
summary(osiModel05KM.1)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + 
##     HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + 
##     factor(SALE_MONTH) + parkArea05, data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -7.008 -0.099  0.022  0.150  3.171 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                  4.86e+00   2.07e-01   23.47  < 2e-16 ***
## FIN_SQ_FT                                    3.13e-04   3.28e-06   95.48  < 2e-16 ***
## ACRES_POLY                                   3.94e-02   2.00e-03   19.65  < 2e-16 ***
## YEAR_BUILT                                   3.22e-03   1.04e-04   30.82  < 2e-16 ***
## HOME_STYLE1 1/2 Story Frame                 -1.73e-01   7.12e-02   -2.42  0.01543 *  
## HOME_STYLE1 1/2 STRY                        -1.62e-01   6.23e-02   -2.60  0.00934 ** 
## HOME_STYLE1-1/2 STRY                         1.10e-01   5.10e-02    2.15  0.03147 *  
## HOME_STYLE1 1/4 story - 25% finished        -6.79e-02   3.47e-01   -0.20  0.84479    
## HOME_STYLE1 1/4 story 50% finished           1.57e-01   1.77e-01    0.89  0.37378    
## HOME_STYLE1 1/4 story finished               7.87e-02   4.70e-02    1.67  0.09406 .  
## HOME_STYLE1 1/4 story - unfinished          -1.06e-01   8.96e-02   -1.18  0.23758    
## HOME_STYLE1 1/4 STRY                        -2.40e-01   9.38e-02   -2.56  0.01048 *  
## HOME_STYLE1-1/4 STRY                         7.78e-02   4.87e-02    1.60  0.10995    
## HOME_STYLE1-2 STRY                          -1.79e-03   5.02e-02   -0.04  0.97150    
## HOME_STYLE1 3/4 story finished               1.01e-01   6.87e-02    1.46  0.14332    
## HOME_STYLE1 3/4 STRY                         1.20e-01   8.57e-02    1.40  0.16169    
## HOME_STYLE1-3/4 STRY                         1.66e-01   5.57e-02    2.99  0.00281 ** 
## HOME_STYLE1 Story Brick                      2.66e-01   2.04e-01    1.30  0.19301    
## HOME_STYLE1 Story Condo                     -4.65e-01   5.66e-02   -8.21  < 2e-16 ***
## HOME_STYLE1 Story Frame                      1.64e-01   4.86e-02    3.38  0.00073 ***
## HOME_STYLE1 Story Townhouse                  9.81e-02   5.01e-02    1.96  0.05024 .  
## HOME_STYLE2 1/2 Story Finished              -1.10e-01   3.47e-01   -0.32  0.75081    
## HOME_STYLE2 Story Brick                      1.88e-01   3.47e-01    0.54  0.58920    
## HOME_STYLE2 Story Condo                     -4.11e-01   5.18e-02   -7.93  2.2e-15 ***
## HOME_STYLE2 Story Frame                      9.53e-02   4.88e-02    1.95  0.05076 .  
## HOME_STYLE2 Story Townhouse                 -2.80e-01   4.90e-02   -5.72  1.0e-08 ***
## HOME_STYLE3-LVL SPLT                        -1.99e-01   5.31e-02   -3.75  0.00018 ***
## HOME_STYLE4 LVL SPLT                        -1.27e-01   5.13e-02   -2.47  0.01345 *  
## HOME_STYLEBi-level                           1.67e-01   4.35e-02    3.85  0.00012 ***
## HOME_STYLEBungalow                           6.37e-02   4.34e-02    1.47  0.14200    
## HOME_STYLECabin                             -2.69e-01   3.46e-01   -0.78  0.43692    
## HOME_STYLECONDO                             -8.74e-01   5.58e-02  -15.67  < 2e-16 ***
## HOME_STYLECondo - CO                        -1.14e-01   1.61e-01   -0.71  0.47714    
## HOME_STYLEDetached Townhome - 1 story        2.95e-01   4.98e-02    5.92  3.3e-09 ***
## HOME_STYLEDetached Townhome - 2 story        5.21e-02   6.38e-02    0.82  0.41412    
## HOME_STYLEDetached Townhome - Split Foy*     4.69e-01   2.04e-01    2.30  0.02145 *  
## HOME_STYLEDetached Townhome - Split lev*     2.81e-01   1.00e-01    2.81  0.00496 ** 
## HOME_STYLEDouble bungalow - split foyer      2.13e-01   3.47e-01    0.61  0.53931    
## HOME_STYLEDUP/TRI                           -1.54e-01   1.61e-01   -0.96  0.33767    
## HOME_STYLEEARTHBERM                         -6.48e-01   3.47e-01   -1.87  0.06149 .  
## HOME_STYLEEARTH SHEL                        -1.76e-01   3.47e-01   -0.51  0.61112    
## HOME_STYLELOG                                1.74e-01   2.04e-01    0.85  0.39306    
## HOME_STYLEMfd Home (Double)                 -2.31e-01   3.47e-01   -0.67  0.50505    
## HOME_STYLEMini-Warehouse - Condo            -2.37e+00   1.39e-01  -17.12  < 2e-16 ***
## HOME_STYLEModified two story                 1.51e-01   4.54e-02    3.32  0.00091 ***
## HOME_STYLEModular                           -1.59e+00   2.47e-01   -6.44  1.2e-10 ***
## HOME_STYLEN/A                                8.07e-03   1.48e-01    0.05  0.95652    
## HOME_STYLEOne And 3/4 Story                  4.05e-02   4.40e-02    0.92  0.35767    
## HOME_STYLEOne Story                          6.47e-02   4.30e-02    1.51  0.13224    
## HOME_STYLEONE STORY                          2.21e-02   4.59e-02    0.48  0.63087    
## HOME_STYLEOther                             -1.05e+00   1.77e-01   -5.91  3.5e-09 ***
## HOME_STYLEQuad - one story                  -8.62e-02   1.61e-01   -0.54  0.59132    
## HOME_STYLEQuad - split level/foyer          -8.87e-02   5.15e-02   -1.72  0.08520 .  
## HOME_STYLEQuad - Two story                  -1.11e-01   2.47e-01   -0.45  0.65194    
## HOME_STYLERAMBLER                           -1.62e-01   4.83e-02   -3.36  0.00079 ***
## HOME_STYLERow                               -1.37e-01   3.47e-01   -0.39  0.69293    
## HOME_STYLESalvage                            5.86e-02   1.78e-01    0.33  0.74237    
## HOME_STYLESPLIT-ENT                         -2.08e-01   4.86e-02   -4.28  1.9e-05 ***
## HOME_STYLESplit/entry                       -1.47e-02   4.46e-02   -0.33  0.74088    
## HOME_STYLESPLIT-FOY                         -1.92e-01   5.28e-02   -3.63  0.00029 ***
## HOME_STYLESplit Foyer Frame                  1.67e-01   4.92e-02    3.39  0.00069 ***
## HOME_STYLESplit/level                        4.90e-02   4.49e-02    1.09  0.27499    
## HOME_STYLESplit Level                        2.07e-01   4.39e-02    4.71  2.4e-06 ***
## HOME_STYLESplit Level Frame                  2.17e-01   4.95e-02    4.38  1.2e-05 ***
## HOME_STYLESPLIT LEVL                        -1.95e-03   4.59e-02   -0.04  0.96616    
## HOME_STYLEThree Story                       -1.66e-01   7.69e-02   -2.15  0.03121 *  
## HOME_STYLETOWNHOME                          -4.89e-01   4.75e-02  -10.30  < 2e-16 ***
## HOME_STYLETWIN HOME                         -3.01e-01   5.36e-02   -5.61  2.0e-08 ***
## HOME_STYLETwin home - one story             -2.87e-01   8.57e-02   -3.35  0.00081 ***
## HOME_STYLETwin home - spit level/ split*    -2.68e-01   5.96e-02   -4.50  6.9e-06 ***
## HOME_STYLETwin home - two story             -5.28e-01   1.23e-01   -4.29  1.8e-05 ***
## HOME_STYLETwo Story                          8.89e-03   4.31e-02    0.21  0.83676    
## HOME_STYLETWO STORY                          3.39e-02   4.61e-02    0.74  0.46182    
## HOME_STYLETWO+ STORY                        -4.07e-03   1.18e-01   -0.03  0.97251    
## ELEMENTARYAFTON-LAKELAND                    -3.08e-02   4.16e-02   -0.74  0.45873    
## ELEMENTARYAKIN ROAD                          7.21e-02   3.38e-02    2.14  0.03269 *  
## ELEMENTARYAMES                               1.58e-01   4.25e-02    3.71  0.00021 ***
## ELEMENTARYANDERSEN                           1.81e-01   6.19e-02    2.92  0.00347 ** 
## ELEMENTARYANDERSON & WILDWOOD                1.97e-01   3.55e-02    5.55  2.9e-08 ***
## ELEMENTARYANDOVER                            3.06e-02   2.76e-02    1.11  0.26726    
## ELEMENTARYARMSTRONG                         -2.26e-02   3.66e-02   -0.62  0.53660    
## ELEMENTARYBAILEY                             3.57e-02   3.34e-02    1.07  0.28545    
## ELEMENTARYBATTLE CREEK                       1.67e-01   4.18e-02    3.99  6.8e-05 ***
## ELEMENTARYBEL AIR                            1.78e-01   2.97e-02    5.98  2.2e-09 ***
## ELEMENTARYBIRCH LAKE                         9.89e-02   3.49e-02    2.84  0.00456 ** 
## ELEMENTARYBLUE HERON                        -3.34e-02   3.14e-02   -1.06  0.28768    
## ELEMENTARYBRIMHALL                           3.31e-01   3.06e-02   10.82  < 2e-16 ***
## ELEMENTARYBRUCE F. VENTO                    -1.84e-01   3.43e-02   -5.35  8.7e-08 ***
## ELEMENTARYCARVER                             7.30e-02   3.12e-02    2.34  0.01913 *  
## ELEMENTARYCASTLE                             9.51e-02   3.54e-02    2.68  0.00726 ** 
## ELEMENTARYCEDAR CREEK                       -7.46e-02   6.70e-02   -1.11  0.26527    
## ELEMENTARYCEDAR PARK                         1.29e-01   4.03e-02    3.20  0.00138 ** 
## ELEMENTARYCENTENNIAL                        -3.44e-04   3.46e-02   -0.01  0.99207    
## ELEMENTARYCENTERVILLE                        1.02e-02   3.24e-02    0.31  0.75401    
## ELEMENTARYCENTRAL PARK                       2.12e-01   3.16e-02    6.70  2.2e-11 ***
## ELEMENTARYCHELSEA HEIGHTS                    2.57e-01   2.76e-02    9.31  < 2e-16 ***
## ELEMENTARYCHERRY VIEW                        2.53e-03   3.86e-02    0.07  0.94768    
## ELEMENTARYCHRISTINA HUDDLESTON               4.96e-02   3.91e-02    1.27  0.20518    
## ELEMENTARYCOMO PARK                          1.79e-01   3.03e-02    5.91  3.5e-09 ***
## ELEMENTARYCOTTAGE GROVE                      5.57e-02   3.49e-02    1.59  0.11120    
## ELEMENTARYCOWERN                             6.99e-02   3.17e-02    2.20  0.02759 *  
## ELEMENTARYCRESTVIEW                         -2.28e-02   3.86e-02   -0.59  0.55463    
## ELEMENTARYCROOKED LAKE                       2.15e-02   3.25e-02    0.66  0.50904    
## ELEMENTARYCRYSTAL LAKE                       3.49e-02   3.81e-02    0.92  0.35956    
## ELEMENTARYDAYTONS BLUFF                     -1.63e-01   3.09e-02   -5.26  1.5e-07 ***
## ELEMENTARYDEERWOOD                           7.61e-02   4.09e-02    1.86  0.06287 .  
## ELEMENTARYDIAMOND PATH                       1.08e-01   3.43e-02    3.14  0.00169 ** 
## ELEMENTARYEAGLE CREEK                        4.96e-01   3.39e-02   14.65  < 2e-16 ***
## ELEMENTARYEAGLE POINT                        5.44e-02   3.86e-02    1.41  0.15934    
## ELEMENTARYEAST BETHEL & CEDAR CREEK          5.15e-03   4.16e-02    0.12  0.90139    
## ELEMENTARYEASTERN HEIGHTS                   -2.91e-02   2.89e-02   -1.01  0.31450    
## ELEMENTARYEASTVIEW                           3.08e-02   3.90e-02    0.79  0.42947    
## ELEMENTARYECHO PARK                          2.38e-02   3.49e-02    0.68  0.49535    
## ELEMENTARYEDGERTON                           1.73e-01   3.33e-02    5.21  1.9e-07 ***
## ELEMENTARYEDWARD NEILL                       6.42e-02   3.70e-02    1.73  0.08295 .  
## ELEMENTARYEISENHOWER                         4.69e-02   3.88e-02    1.21  0.22766    
## ELEMENTARYEMMET D. WILLIAMS                  2.48e-01   3.11e-02    7.96  1.7e-15 ***
## ELEMENTARYFALCON HEIGHTS                     2.68e-01   3.03e-02    8.83  < 2e-16 ***
## ELEMENTARYFARMINGTON                         4.86e-02   3.32e-02    1.46  0.14340    
## ELEMENTARYFARNSWORTH                         2.14e-01   3.61e-02    5.92  3.2e-09 ***
## ELEMENTARYFARNSWORTH LOWER                  -9.62e-02   3.59e-02   -2.68  0.00739 ** 
## ELEMENTARYFIVE HAWKS                         6.07e-01   3.16e-02   19.24  < 2e-16 ***
## ELEMENTARYFOREST VIEW                       -2.81e-01   1.19e-01   -2.36  0.01839 *  
## ELEMENTARYFOREST VIEW & FOREST LAKE         -3.29e-01   1.34e-01   -2.46  0.01390 *  
## ELEMENTARYFRANKLIN                          -7.96e-02   3.00e-02   -2.65  0.00795 ** 
## ELEMENTARYFRANKLIN MUSIC                     1.36e-01   1.42e-01    0.96  0.33933    
## ELEMENTARYFROST LAKE                         7.92e-02   3.51e-02    2.25  0.02419 *  
## ELEMENTARYGALTIER & MAXFIELD                 5.78e-02   2.80e-02    2.06  0.03925 *  
## ELEMENTARYGARLOUGH                           2.02e-01   3.88e-02    5.21  1.9e-07 ***
## ELEMENTARYGIDEON POND                        1.30e-01   4.13e-02    3.16  0.00159 ** 
## ELEMENTARYGLACIER HILLS                      1.26e-01   3.98e-02    3.16  0.00159 ** 
## ELEMENTARYGLENDALE                           5.24e-01   3.45e-02   15.18  < 2e-16 ***
## ELEMENTARYGOLDEN LAKE                        1.32e-01   3.97e-02    3.32  0.00091 ***
## ELEMENTARYGRAINWOOD                          3.39e-01   4.01e-02    8.46  < 2e-16 ***
## ELEMENTARYGREENLEAF                          2.51e-02   3.38e-02    0.74  0.45817    
## ELEMENTARYGREY CLOUD                         2.76e-02   3.68e-02    0.75  0.45351    
## ELEMENTARYGROVELAND PARK                     5.42e-01   2.99e-02   18.13  < 2e-16 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  4.48e-01   3.43e-02   13.07  < 2e-16 ***
## ELEMENTARYHAMILTON                           2.16e-02   3.31e-02    0.65  0.51484    
## ELEMENTARYHANCOCK                            2.20e-01   4.76e-02    4.62  3.8e-06 ***
## ELEMENTARYHANCOCK EL.                        3.20e-01   4.07e-02    7.86  3.8e-15 ***
## ELEMENTARYHARRIET BISHOP                     4.03e-01   3.65e-02   11.05  < 2e-16 ***
## ELEMENTARYHAYDEN HEIGHTS                     6.77e-02   3.61e-02    1.88  0.06074 .  
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -1.10e-01   3.04e-02   -3.61  0.00031 ***
## ELEMENTARYHAYES                              1.36e-01   3.30e-02    4.11  3.9e-05 ***
## ELEMENTARYHIDDEN VALLEY                      3.87e-01   3.77e-02   10.27  < 2e-16 ***
## ELEMENTARYHIGHLAND                           9.51e-02   2.91e-02    3.27  0.00108 ** 
## ELEMENTARYHIGHLAND PARK                      4.50e-01   2.92e-02   15.41  < 2e-16 ***
## ELEMENTARYHIGHWOOD HILLS                     1.13e-01   3.52e-02    3.21  0.00134 ** 
## ELEMENTARYHILLSIDE                           9.11e-03   3.78e-02    0.24  0.80947    
## ELEMENTARYHILLTOP                            1.53e-01   3.81e-02    4.02  5.9e-05 ***
## ELEMENTARYHOMECROFT                          2.97e-01   4.36e-02    6.80  1.1e-11 ***
## ELEMENTARYHOOVER                             8.38e-02   3.76e-02    2.23  0.02592 *  
## ELEMENTARYHUGO                               5.98e-02   3.41e-02    1.76  0.07908 .  
## ELEMENTARYHUGO & ONEKA                       6.48e-02   3.52e-02    1.84  0.06570 .  
## ELEMENTARYISLAND LAKE                        1.78e-01   2.96e-02    6.02  1.7e-09 ***
## ELEMENTARYJACKSON                           -4.30e-01   4.02e-02  -10.69  < 2e-16 ***
## ELEMENTARYJEFFERSON                          2.68e-02   3.12e-02    0.86  0.39008    
## ELEMENTARYJEFFERS POND                       5.39e-01   3.80e-02   14.19  < 2e-16 ***
## ELEMENTARYJOHN F. KENNEDY                    8.22e-02   5.20e-02    1.58  0.11387    
## ELEMENTARYJOHNSON A+                        -1.62e-01   3.88e-02   -4.17  3.1e-05 ***
## ELEMENTARYJOHNSVILLE                         5.26e-02   2.81e-02    1.87  0.06118 .  
## ELEMENTARYJORDAN                             4.29e-01   1.26e-01    3.42  0.00063 ***
## ELEMENTARYKAPOSIA                            1.24e-01   3.33e-02    3.72  0.00020 ***
## ELEMENTARYKENNETH HALL                       2.28e-02   3.20e-02    0.71  0.47597    
## ELEMENTARYLAKEAIRES                          2.47e-01   2.98e-02    8.28  < 2e-16 ***
## ELEMENTARYLAKE ELMO                          8.69e-02   3.36e-02    2.59  0.00969 ** 
## ELEMENTARYLAKE MARION                        3.78e-02   4.26e-02    0.89  0.37443    
## ELEMENTARYLAKEVIEW                          -3.27e-03   3.61e-02   -0.09  0.92777    
## ELEMENTARYLiberty Ridge                     -2.82e-02   3.62e-02   -0.78  0.43682    
## ELEMENTARYLIBERTY RIDGE                      1.72e-01   3.55e-02    4.85  1.3e-06 ***
## ELEMENTARYLINCOLN                            1.04e-01   2.72e-02    3.81  0.00014 ***
## ELEMENTARYLINO LAKES                         1.64e-02   3.86e-02    0.42  0.67161    
## ELEMENTARYLITTLE CANADA                      2.28e-01   3.45e-02    6.62  3.7e-11 ***
## ELEMENTARYL.O. JACOB                         6.82e-02   4.10e-02    1.66  0.09621 .  
## ELEMENTARYLONGFELLOW                         4.89e-01   3.23e-02   15.14  < 2e-16 ***
## ELEMENTARYMADISON                            6.91e-02   3.35e-02    2.06  0.03912 *  
## ELEMENTARYMANN                               4.68e-01   2.89e-02   16.21  < 2e-16 ***
## ELEMENTARYMARION W. SAVAGE                   4.74e-01   3.43e-02   13.81  < 2e-16 ***
## ELEMENTARYMATOSKA INTERNATIONAL              2.40e-01   3.88e-02    6.19  5.9e-10 ***
## ELEMENTARYMCKINLEY                           5.26e-02   2.93e-02    1.80  0.07255 .  
## ELEMENTARYMEADOWVIEW                         4.74e-02   3.51e-02    1.35  0.17633    
## ELEMENTARYMENDOTA                            1.30e-01   3.76e-02    3.46  0.00054 ***
## ELEMENTARYMIDDLETON                          1.00e-01   3.54e-02    2.83  0.00468 ** 
## ELEMENTARYMISSISSIPPI                        5.39e-02   3.06e-02    1.76  0.07805 .  
## ELEMENTARYMONROE                             6.77e-02   3.10e-02    2.18  0.02895 *  
## ELEMENTARYMORELAND                           1.35e-01   3.46e-02    3.90  9.5e-05 ***
## ELEMENTARYMORRIS BYE                        -6.61e-02   3.11e-02   -2.13  0.03334 *  
## ELEMENTARYNEWPORT                            4.60e-02   3.62e-02    1.27  0.20464    
## ELEMENTARYNORTH END                         -1.62e-01   3.04e-02   -5.34  9.3e-08 ***
## ELEMENTARYNORTH PARK                         8.52e-02   3.24e-02    2.63  0.00854 ** 
## ELEMENTARYNORTH TRAIL                        7.29e-02   3.45e-02    2.11  0.03482 *  
## ELEMENTARYNORTHVIEW                          2.12e-02   3.74e-02    0.57  0.56974    
## ELEMENTARYOAKDALE                            3.42e-02   3.38e-02    1.01  0.31166    
## ELEMENTARYOAK HILLS                         -2.24e-02   4.09e-02   -0.55  0.58377    
## ELEMENTARYOAKRIDGE                           5.95e-01   3.39e-02   17.56  < 2e-16 ***
## ELEMENTARYOAK RIDGE                          1.26e-01   3.74e-02    3.36  0.00078 ***
## ELEMENTARYOBAMA                              5.68e-01   7.07e-02    8.04  9.5e-16 ***
## ELEMENTARYORCHARD LAKE                       1.50e-01   3.95e-02    3.80  0.00014 ***
## ELEMENTARYOTTER LAKE                         1.12e-01   3.07e-02    3.64  0.00027 ***
## ELEMENTARYPARKER                            -4.83e-02   7.66e-02   -0.63  0.52853    
## ELEMENTARYPARK TERRACE                       8.55e-02   3.26e-02    2.62  0.00871 ** 
## ELEMENTARYPARK TERRACE & WESTWOOD           -1.13e-01   2.44e-01   -0.46  0.64356    
## ELEMENTARYPARKVIEW                           1.22e-01   3.12e-02    3.91  9.1e-05 ***
## ELEMENTARYPARKWAY                            8.87e-02   3.68e-02    2.41  0.01602 *  
## ELEMENTARYPEARSON                            4.58e-01   3.12e-02   14.66  < 2e-16 ***
## ELEMENTARYPHALEN LAKE                       -1.29e-01   3.29e-02   -3.92  8.7e-05 ***
## ELEMENTARYPILOT KNOB                         1.38e-01   4.01e-02    3.44  0.00057 ***
## ELEMENTARYPINE BEND                          1.34e-01   3.76e-02    3.55  0.00039 ***
## ELEMENTARYPINE HILL                          2.43e-02   3.55e-02    0.68  0.49361    
## ELEMENTARYPINEWOOD                           4.51e-02   2.84e-02    1.59  0.11192    
## ELEMENTARYPROSPERITY HEIGHTS                 1.71e-01   5.08e-02    3.36  0.00078 ***
## ELEMENTARYPULLMAN                           -3.42e-02   3.56e-02   -0.96  0.33638    
## ELEMENTARYRAHN                               1.31e-01   3.72e-02    3.53  0.00042 ***
## ELEMENTARYRAMSEY                            -9.63e-02   2.55e-02   -3.77  0.00016 ***
## ELEMENTARYRANDOLPH HEIGHTS                   5.22e-01   2.84e-02   18.38  < 2e-16 ***
## ELEMENTARYRED OAK                            5.36e-01   3.08e-02   17.37  < 2e-16 ***
## ELEMENTARYRED PINE                           1.06e-01   3.51e-02    3.02  0.00249 ** 
## ELEMENTARYRED ROCK                           7.15e-02   3.66e-02    1.95  0.05092 .  
## ELEMENTARYREDTAIL RIDGE                      5.41e-01   3.56e-02   15.18  < 2e-16 ***
## ELEMENTARYRICE LAKE                          2.93e-02   3.13e-02    0.94  0.34957    
## ELEMENTARYRICHARDSON                         1.38e-01   3.02e-02    4.59  4.5e-06 ***
## ELEMENTARYRIVERVIEW                          9.80e-02   4.72e-02    2.08  0.03768 *  
## ELEMENTARYRIVERVIEW & CHEROKEE               5.25e-03   3.41e-02    0.15  0.87751    
## ELEMENTARYROOSEVELT & RIVERVIEW & CHEROKEE   1.95e-01   3.59e-02    5.43  5.7e-08 ***
## ELEMENTARYROSEMOUNT                          9.18e-02   3.58e-02    2.57  0.01029 *  
## ELEMENTARYROYAL OAKS                         5.69e-02   3.58e-02    1.59  0.11191    
## ELEMENTARYRUM RIVER                         -3.81e-02   2.95e-02   -1.29  0.19650    
## ELEMENTARYRUTHERFORD                         1.67e-01   5.00e-02    3.33  0.00085 ***
## ELEMENTARYSALEM HILLS                        1.27e-01   5.14e-02    2.47  0.01358 *  
## ELEMENTARYSAND CREEK                        -2.45e-02   2.86e-02   -0.85  0.39270    
## ELEMENTARYSHANNON PARK                       2.81e-02   3.48e-02    0.81  0.41857    
## ELEMENTARYSHERIDAN                           1.67e-01   4.24e-02    3.94  8.0e-05 ***
## ELEMENTARYSHERIDAN & AMES                   -9.83e-02   3.01e-02   -3.27  0.00107 ** 
## ELEMENTARYSIOUX TRAIL                        1.34e-01   3.94e-02    3.40  0.00067 ***
## ELEMENTARYSKY OAKS                           9.64e-02   3.79e-02    2.54  0.01103 *  
## ELEMENTARYSKYVIEW                            4.11e-02   3.69e-02    1.11  0.26604    
## ELEMENTARYSKYVIEW COMMUNITY SCHOOL           1.04e-01   3.57e-02    2.91  0.00358 ** 
## ELEMENTARYSOMERSET HEIGHTS                   1.73e-01   3.50e-02    4.95  7.5e-07 ***
## ELEMENTARYSORTEBERG                         -2.06e-03   3.32e-02   -0.06  0.95042    
## ELEMENTARYSOUTH GROVE                        1.07e-01   4.99e-02    2.14  0.03233 *  
## ELEMENTARYSOUTHVIEW                          7.19e-02   3.46e-02    2.08  0.03758 *  
## ELEMENTARYST ANTHONY PARK                    5.75e-01   3.87e-02   14.86  < 2e-16 ***
## ELEMENTARYSTEVENSON                          1.55e-01   3.47e-02    4.47  8.0e-06 ***
## ELEMENTARYSUNNYSIDE                          1.32e-01   3.19e-02    4.12  3.8e-05 ***
## ELEMENTARYSUN PATH                           3.52e-01   3.41e-02   10.31  < 2e-16 ***
## ELEMENTARYSWEENEY                            3.95e-01   3.31e-02   11.92  < 2e-16 ***
## ELEMENTARYTHOMAS LAKE                        6.90e-02   3.91e-02    1.77  0.07735 .  
## ELEMENTARYTURTLE LAKE                        1.87e-01   2.81e-02    6.65  3.1e-11 ***
## ELEMENTARYTWIN LAKES                        -5.08e-01   1.57e-01   -3.24  0.00119 ** 
## ELEMENTARYUNIVERSITY                        -1.24e-01   2.75e-02   -4.52  6.2e-06 ***
## ELEMENTARYVADNAIS HEIGHTS                    1.14e-01   3.39e-02    3.37  0.00074 ***
## ELEMENTARYVALENTINE HILLS                    2.12e-01   2.94e-02    7.21  5.7e-13 ***
## ELEMENTARYVALLEY VIEW                        1.70e-01   3.34e-02    5.08  3.8e-07 ***
## ELEMENTARYVISTA VIEW                         1.33e-01   3.67e-02    3.62  0.00030 ***
## ELEMENTARYWASHINGTON                         2.62e-02   3.62e-02    0.72  0.46948    
## ELEMENTARYWEAVER                             1.45e-01   2.88e-02    5.03  4.9e-07 ***
## ELEMENTARYWEBSTER                            2.24e-01   3.42e-02    6.55  5.7e-11 ***
## ELEMENTARYWESTVIEW                           5.48e-02   3.50e-02    1.57  0.11739    
## ELEMENTARYWESTWOOD                           4.40e-01   3.78e-02   11.64  < 2e-16 ***
## ELEMENTARYWESTWOOD & GRAINWOOD               4.98e-01   3.36e-02   14.83  < 2e-16 ***
## ELEMENTARYWILLIAM BYRNE                      3.08e-02   3.89e-02    0.79  0.42799    
## ELEMENTARYWILLOW LANE                        1.19e-01   3.74e-02    3.18  0.00146 ** 
## ELEMENTARYWILSHIRE PARK                      2.79e-01   6.40e-02    4.36  1.3e-05 ***
## ELEMENTARYWILSON                            -7.78e-02   3.36e-02   -2.32  0.02036 *  
## ELEMENTARYWOODBURY                           1.01e-01   3.55e-02    2.86  0.00424 ** 
## ELEMENTARYWOODCREST                          1.77e-01   2.56e-02    6.92  4.7e-12 ***
## ELEMENTARYWOODCREST & WESTWOOD               2.63e-01   2.44e-01    1.08  0.28143    
## ELEMENTARYWOODLAND                           5.33e-02   3.87e-02    1.38  0.16870    
## WhiteDense                                   1.98e-01   1.20e-02   16.57  < 2e-16 ***
## fam_income                                   4.61e-06   1.39e-07   33.27  < 2e-16 ***
## factor(SALE_YEAR)2006                        6.29e-03   3.84e-03    1.64  0.10178    
## factor(SALE_YEAR)2009                       -3.39e-01   5.66e-03  -59.91  < 2e-16 ***
## factor(SALE_YEAR)2010                       -3.57e-01   5.83e-03  -61.31  < 2e-16 ***
## factor(SALE_YEAR)2011                       -5.13e-01   1.02e-02  -50.27  < 2e-16 ***
## factor(SALE_MONTH)2                         -1.42e-02   9.07e-03   -1.57  0.11744    
## factor(SALE_MONTH)3                          1.38e-02   8.44e-03    1.64  0.10128    
## factor(SALE_MONTH)4                          7.62e-03   8.27e-03    0.92  0.35700    
## factor(SALE_MONTH)5                          3.92e-02   8.16e-03    4.81  1.5e-06 ***
## factor(SALE_MONTH)6                          4.48e-02   7.99e-03    5.61  2.1e-08 ***
## factor(SALE_MONTH)7                          4.43e-02   8.27e-03    5.36  8.6e-08 ***
## factor(SALE_MONTH)8                          4.40e-02   8.21e-03    5.35  8.6e-08 ***
## factor(SALE_MONTH)9                          2.79e-02   8.45e-03    3.30  0.00098 ***
## factor(SALE_MONTH)10                         4.05e-02   8.52e-03    4.75  2.0e-06 ***
## factor(SALE_MONTH)11                         5.85e-03   8.79e-03    0.67  0.50594    
## factor(SALE_MONTH)12                        -5.57e-03   9.09e-03   -0.61  0.53987    
## parkArea05                                   6.07e-08   2.38e-08    2.55  0.01073 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.343 on 51107 degrees of freedom
## Multiple R-squared: 0.609,	Adjusted R-squared: 0.607 
## F-statistic:  279 on 286 and 51107 DF,  p-value: <2e-16 
## 
```



```r
osiModel05KM.2 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + factor(SALE_YEAR) + factor(SALE_MONTH) + parkArea05, 
    data = HouseData)
summary(osiModel05KM.2)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + 
##     HOME_STYLE + ELEMENTARY + WhiteDense + factor(SALE_YEAR) + 
##     factor(SALE_MONTH) + parkArea05, data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -6.965 -0.098  0.024  0.151  3.173 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                  4.56e+00   2.09e-01   21.81  < 2e-16 ***
## FIN_SQ_FT                                    3.30e-04   3.28e-06  100.45  < 2e-16 ***
## ACRES_POLY                                   4.27e-02   2.02e-03   21.13  < 2e-16 ***
## YEAR_BUILT                                   3.47e-03   1.05e-04   32.96  < 2e-16 ***
## HOME_STYLE1 1/2 Story Frame                 -1.59e-01   7.20e-02   -2.21  0.02698 *  
## HOME_STYLE1 1/2 STRY                        -1.55e-01   6.30e-02   -2.46  0.01380 *  
## HOME_STYLE1-1/2 STRY                         1.44e-01   5.15e-02    2.79  0.00522 ** 
## HOME_STYLE1 1/4 story - 25% finished        -5.95e-02   3.51e-01   -0.17  0.86532    
## HOME_STYLE1 1/4 story 50% finished           1.47e-01   1.79e-01    0.82  0.41269    
## HOME_STYLE1 1/4 story finished               6.65e-02   4.75e-02    1.40  0.16162    
## HOME_STYLE1 1/4 story - unfinished          -1.08e-01   9.06e-02   -1.20  0.23182    
## HOME_STYLE1 1/4 STRY                        -2.01e-01   9.48e-02   -2.12  0.03378 *  
## HOME_STYLE1-1/4 STRY                         1.07e-01   4.92e-02    2.18  0.02940 *  
## HOME_STYLE1-2 STRY                           6.11e-02   5.07e-02    1.20  0.22837    
## HOME_STYLE1 3/4 story finished               8.27e-02   6.95e-02    1.19  0.23373    
## HOME_STYLE1 3/4 STRY                         1.56e-01   8.66e-02    1.81  0.07087 .  
## HOME_STYLE1-3/4 STRY                         2.07e-01   5.63e-02    3.68  0.00023 ***
## HOME_STYLE1 Story Brick                      3.55e-01   2.06e-01    1.72  0.08515 .  
## HOME_STYLE1 Story Condo                     -4.51e-01   5.72e-02   -7.88  3.4e-15 ***
## HOME_STYLE1 Story Frame                      1.80e-01   4.92e-02    3.66  0.00025 ***
## HOME_STYLE1 Story Townhouse                  1.12e-01   5.06e-02    2.21  0.02680 *  
## HOME_STYLE2 1/2 Story Finished              -1.26e-01   3.50e-01   -0.36  0.71998    
## HOME_STYLE2 Story Brick                      2.26e-01   3.51e-01    0.64  0.52043    
## HOME_STYLE2 Story Condo                     -3.51e-01   5.23e-02   -6.71  1.9e-11 ***
## HOME_STYLE2 Story Frame                      1.08e-01   4.93e-02    2.19  0.02875 *  
## HOME_STYLE2 Story Townhouse                 -2.56e-01   4.95e-02   -5.16  2.4e-07 ***
## HOME_STYLE3-LVL SPLT                        -1.56e-01   5.37e-02   -2.90  0.00372 ** 
## HOME_STYLE4 LVL SPLT                        -7.20e-02   5.18e-02   -1.39  0.16468    
## HOME_STYLEBi-level                           1.74e-01   4.40e-02    3.95  7.7e-05 ***
## HOME_STYLEBungalow                           6.61e-02   4.38e-02    1.51  0.13138    
## HOME_STYLECabin                             -2.42e-01   3.50e-01   -0.69  0.48911    
## HOME_STYLECONDO                             -8.46e-01   5.64e-02  -15.01  < 2e-16 ***
## HOME_STYLECondo - CO                        -1.31e-01   1.62e-01   -0.81  0.42066    
## HOME_STYLEDetached Townhome - 1 story        3.14e-01   5.04e-02    6.23  4.7e-10 ***
## HOME_STYLEDetached Townhome - 2 story        4.41e-02   6.45e-02    0.68  0.49445    
## HOME_STYLEDetached Townhome - Split Foy*     4.41e-01   2.06e-01    2.14  0.03224 *  
## HOME_STYLEDetached Townhome - Split lev*     2.68e-01   1.01e-01    2.65  0.00802 ** 
## HOME_STYLEDouble bungalow - split foyer      2.18e-01   3.51e-01    0.62  0.53543    
## HOME_STYLEDUP/TRI                           -1.17e-01   1.63e-01   -0.72  0.47181    
## HOME_STYLEEARTHBERM                         -6.68e-01   3.50e-01   -1.91  0.05669 .  
## HOME_STYLEEARTH SHEL                        -1.52e-01   3.51e-01   -0.43  0.66461    
## HOME_STYLELOG                                2.27e-01   2.06e-01    1.10  0.27115    
## HOME_STYLEMfd Home (Double)                 -2.61e-01   3.51e-01   -0.74  0.45682    
## HOME_STYLEMini-Warehouse - Condo            -2.35e+00   1.40e-01  -16.77  < 2e-16 ***
## HOME_STYLEModified two story                 1.56e-01   4.59e-02    3.39  0.00070 ***
## HOME_STYLEModular                           -1.65e+00   2.50e-01   -6.62  3.7e-11 ***
## HOME_STYLEN/A                                6.71e-02   1.50e-01    0.45  0.65368    
## HOME_STYLEOne And 3/4 Story                  4.22e-02   4.45e-02    0.95  0.34271    
## HOME_STYLEOne Story                          6.21e-02   4.34e-02    1.43  0.15258    
## HOME_STYLEONE STORY                          6.39e-02   4.64e-02    1.38  0.16839    
## HOME_STYLEOther                             -1.05e+00   1.79e-01   -5.88  4.1e-09 ***
## HOME_STYLEQuad - one story                  -8.96e-02   1.62e-01   -0.55  0.58095    
## HOME_STYLEQuad - split level/foyer          -7.66e-02   5.21e-02   -1.47  0.14162    
## HOME_STYLEQuad - Two story                  -9.42e-02   2.50e-01   -0.38  0.70594    
## HOME_STYLERAMBLER                           -1.20e-01   4.88e-02   -2.45  0.01412 *  
## HOME_STYLERow                               -2.20e-01   3.50e-01   -0.63  0.53019    
## HOME_STYLESalvage                            1.25e-01   1.80e-01    0.69  0.48901    
## HOME_STYLESPLIT-ENT                         -1.66e-01   4.91e-02   -3.39  0.00071 ***
## HOME_STYLESplit/entry                       -2.11e-02   4.50e-02   -0.47  0.63958    
## HOME_STYLESPLIT-FOY                         -1.40e-01   5.33e-02   -2.63  0.00858 ** 
## HOME_STYLESplit Foyer Frame                  1.81e-01   4.97e-02    3.65  0.00027 ***
## HOME_STYLESplit/level                        4.46e-02   4.54e-02    0.98  0.32568    
## HOME_STYLESplit Level                        2.14e-01   4.44e-02    4.81  1.5e-06 ***
## HOME_STYLESplit Level Frame                  2.36e-01   5.00e-02    4.73  2.3e-06 ***
## HOME_STYLESPLIT LEVL                         5.52e-02   4.63e-02    1.19  0.23339    
## HOME_STYLEThree Story                       -1.61e-01   7.78e-02   -2.08  0.03785 *  
## HOME_STYLETOWNHOME                          -4.32e-01   4.80e-02   -9.01  < 2e-16 ***
## HOME_STYLETWIN HOME                         -2.70e-01   5.41e-02   -4.98  6.4e-07 ***
## HOME_STYLETwin home - one story             -2.92e-01   8.66e-02   -3.37  0.00075 ***
## HOME_STYLETwin home - spit level/ split*    -2.86e-01   6.03e-02   -4.75  2.1e-06 ***
## HOME_STYLETwin home - two story             -5.71e-01   1.24e-01   -4.59  4.5e-06 ***
## HOME_STYLETwo Story                          1.07e-02   4.36e-02    0.25  0.80639    
## HOME_STYLETWO STORY                          9.12e-02   4.66e-02    1.96  0.05020 .  
## HOME_STYLETWO+ STORY                        -1.41e-03   1.19e-01   -0.01  0.99060    
## ELEMENTARYAFTON-LAKELAND                     1.28e-01   4.17e-02    3.07  0.00217 ** 
## ELEMENTARYAKIN ROAD                          2.70e-02   3.41e-02    0.79  0.42881    
## ELEMENTARYAMES                               8.04e-02   4.29e-02    1.87  0.06087 .  
## ELEMENTARYANDERSEN                           3.25e-01   6.24e-02    5.22  1.8e-07 ***
## ELEMENTARYANDERSON & WILDWOOD                3.02e-01   3.57e-02    8.46  < 2e-16 ***
## ELEMENTARYANDOVER                            1.01e-01   2.78e-02    3.65  0.00026 ***
## ELEMENTARYARMSTRONG                          2.36e-02   3.70e-02    0.64  0.52294    
## ELEMENTARYBAILEY                             1.56e-01   3.36e-02    4.65  3.3e-06 ***
## ELEMENTARYBATTLE CREEK                       1.20e-01   4.22e-02    2.85  0.00437 ** 
## ELEMENTARYBEL AIR                            2.17e-01   3.00e-02    7.23  4.8e-13 ***
## ELEMENTARYBIRCH LAKE                         1.15e-01   3.52e-02    3.25  0.00114 ** 
## ELEMENTARYBLUE HERON                         3.42e-03   3.18e-02    0.11  0.91421    
## ELEMENTARYBRIMHALL                           3.54e-01   3.09e-02   11.45  < 2e-16 ***
## ELEMENTARYBRUCE F. VENTO                    -2.87e-01   3.45e-02   -8.30  < 2e-16 ***
## ELEMENTARYCARVER                             1.18e-01   3.15e-02    3.75  0.00018 ***
## ELEMENTARYCASTLE                             1.04e-01   3.58e-02    2.92  0.00356 ** 
## ELEMENTARYCEDAR CREEK                       -3.69e-02   6.77e-02   -0.54  0.58583    
## ELEMENTARYCEDAR PARK                         8.62e-02   4.07e-02    2.12  0.03400 *  
## ELEMENTARYCENTENNIAL                         4.17e-02   3.49e-02    1.19  0.23286    
## ELEMENTARYCENTERVILLE                        6.15e-02   3.28e-02    1.88  0.06041 .  
## ELEMENTARYCENTRAL PARK                       2.22e-01   3.19e-02    6.94  4.0e-12 ***
## ELEMENTARYCHELSEA HEIGHTS                    2.67e-01   2.79e-02    9.58  < 2e-16 ***
## ELEMENTARYCHERRY VIEW                        3.90e-02   3.90e-02    1.00  0.31777    
## ELEMENTARYCHRISTINA HUDDLESTON               7.44e-02   3.95e-02    1.88  0.05987 .  
## ELEMENTARYCOMO PARK                          1.54e-01   3.07e-02    5.02  5.1e-07 ***
## ELEMENTARYCOTTAGE GROVE                      6.44e-02   3.53e-02    1.82  0.06822 .  
## ELEMENTARYCOWERN                             4.56e-02   3.21e-02    1.42  0.15504    
## ELEMENTARYCRESTVIEW                          1.99e-02   3.90e-02    0.51  0.60887    
## ELEMENTARYCROOKED LAKE                       7.09e-02   3.28e-02    2.16  0.03092 *  
## ELEMENTARYCRYSTAL LAKE                       8.23e-02   3.85e-02    2.14  0.03259 *  
## ELEMENTARYDAYTONS BLUFF                     -2.68e-01   3.11e-02   -8.62  < 2e-16 ***
## ELEMENTARYDEERWOOD                           1.36e-01   4.13e-02    3.29  0.00101 ** 
## ELEMENTARYDIAMOND PATH                       8.52e-02   3.47e-02    2.46  0.01396 *  
## ELEMENTARYEAGLE CREEK                        5.48e-01   3.42e-02   16.02  < 2e-16 ***
## ELEMENTARYEAGLE POINT                        1.16e-01   3.90e-02    2.96  0.00303 ** 
## ELEMENTARYEAST BETHEL & CEDAR CREEK          3.22e-02   4.20e-02    0.77  0.44292    
## ELEMENTARYEASTERN HEIGHTS                   -9.78e-02   2.92e-02   -3.36  0.00079 ***
## ELEMENTARYEASTVIEW                           8.60e-02   3.94e-02    2.18  0.02897 *  
## ELEMENTARYECHO PARK                          4.19e-02   3.53e-02    1.19  0.23463    
## ELEMENTARYEDGERTON                           1.46e-01   3.37e-02    4.33  1.5e-05 ***
## ELEMENTARYEDWARD NEILL                       3.84e-02   3.74e-02    1.03  0.30459    
## ELEMENTARYEISENHOWER                         3.90e-02   3.93e-02    0.99  0.32086    
## ELEMENTARYEMMET D. WILLIAMS                  2.96e-01   3.14e-02    9.44  < 2e-16 ***
## ELEMENTARYFALCON HEIGHTS                     2.98e-01   3.06e-02    9.73  < 2e-16 ***
## ELEMENTARYFARMINGTON                        -4.24e-03   3.35e-02   -0.13  0.89934    
## ELEMENTARYFARNSWORTH                         1.73e-01   3.65e-02    4.74  2.1e-06 ***
## ELEMENTARYFARNSWORTH LOWER                  -1.34e-01   3.63e-02   -3.69  0.00023 ***
## ELEMENTARYFIVE HAWKS                         6.49e-01   3.19e-02   20.34  < 2e-16 ***
## ELEMENTARYFOREST VIEW                       -3.23e-01   1.20e-01   -2.68  0.00740 ** 
## ELEMENTARYFOREST VIEW & FOREST LAKE         -3.23e-01   1.35e-01   -2.39  0.01698 *  
## ELEMENTARYFRANKLIN                          -7.77e-02   3.03e-02   -2.56  0.01035 *  
## ELEMENTARYFRANKLIN MUSIC                    -7.18e-02   1.44e-01   -0.50  0.61728    
## ELEMENTARYFROST LAKE                         5.77e-02   3.55e-02    1.62  0.10425    
## ELEMENTARYGALTIER & MAXFIELD                 1.67e-03   2.83e-02    0.06  0.95296    
## ELEMENTARYGARLOUGH                           1.11e-01   3.91e-02    2.84  0.00452 ** 
## ELEMENTARYGIDEON POND                        7.16e-02   4.17e-02    1.72  0.08588 .  
## ELEMENTARYGLACIER HILLS                      1.57e-01   4.02e-02    3.91  9.2e-05 ***
## ELEMENTARYGLENDALE                           5.97e-01   3.48e-02   17.15  < 2e-16 ***
## ELEMENTARYGOLDEN LAKE                        1.36e-01   4.01e-02    3.39  0.00070 ***
## ELEMENTARYGRAINWOOD                          3.46e-01   4.05e-02    8.55  < 2e-16 ***
## ELEMENTARYGREENLEAF                          7.87e-02   3.41e-02    2.31  0.02112 *  
## ELEMENTARYGREY CLOUD                         8.34e-02   3.71e-02    2.25  0.02468 *  
## ELEMENTARYGROVELAND PARK                     6.81e-01   2.99e-02   22.74  < 2e-16 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  4.96e-01   3.46e-02   14.32  < 2e-16 ***
## ELEMENTARYHAMILTON                          -8.44e-04   3.35e-02   -0.03  0.97988    
## ELEMENTARYHANCOCK                            1.47e-01   4.81e-02    3.06  0.00221 ** 
## ELEMENTARYHANCOCK EL.                        2.79e-01   4.12e-02    6.78  1.2e-11 ***
## ELEMENTARYHARRIET BISHOP                     4.84e-01   3.68e-02   13.17  < 2e-16 ***
## ELEMENTARYHAYDEN HEIGHTS                     5.11e-02   3.65e-02    1.40  0.16122    
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -1.58e-01   3.07e-02   -5.16  2.5e-07 ***
## ELEMENTARYHAYES                              1.28e-01   3.34e-02    3.84  0.00013 ***
## ELEMENTARYHIDDEN VALLEY                      3.93e-01   3.81e-02   10.31  < 2e-16 ***
## ELEMENTARYHIGHLAND                           1.13e-01   2.94e-02    3.85  0.00012 ***
## ELEMENTARYHIGHLAND PARK                      5.46e-01   2.94e-02   18.61  < 2e-16 ***
## ELEMENTARYHIGHWOOD HILLS                     5.57e-02   3.55e-02    1.57  0.11660    
## ELEMENTARYHILLSIDE                           2.12e-02   3.82e-02    0.56  0.57842    
## ELEMENTARYHILLTOP                            1.02e-01   3.84e-02    2.65  0.00807 ** 
## ELEMENTARYHOMECROFT                          2.95e-01   4.41e-02    6.68  2.4e-11 ***
## ELEMENTARYHOOVER                             8.21e-02   3.80e-02    2.16  0.03074 *  
## ELEMENTARYHUGO                               4.45e-02   3.44e-02    1.29  0.19579    
## ELEMENTARYHUGO & ONEKA                       7.21e-02   3.56e-02    2.03  0.04276 *  
## ELEMENTARYISLAND LAKE                        2.67e-01   2.98e-02    8.95  < 2e-16 ***
## ELEMENTARYJACKSON                           -5.44e-01   4.05e-02  -13.44  < 2e-16 ***
## ELEMENTARYJEFFERSON                          2.96e-02   3.15e-02    0.94  0.34852    
## ELEMENTARYJEFFERS POND                       6.45e-01   3.83e-02   16.85  < 2e-16 ***
## ELEMENTARYJOHN F. KENNEDY                    6.11e-02   5.26e-02    1.16  0.24499    
## ELEMENTARYJOHNSON A+                        -2.64e-01   3.91e-02   -6.74  1.6e-11 ***
## ELEMENTARYJOHNSVILLE                         8.68e-02   2.84e-02    3.06  0.00222 ** 
## ELEMENTARYJORDAN                             4.70e-01   1.27e-01    3.71  0.00021 ***
## ELEMENTARYKAPOSIA                            4.35e-02   3.35e-02    1.30  0.19512    
## ELEMENTARYKENNETH HALL                       1.13e-02   3.24e-02    0.35  0.72684    
## ELEMENTARYLAKEAIRES                          2.78e-01   3.01e-02    9.23  < 2e-16 ***
## ELEMENTARYLAKE ELMO                          2.03e-01   3.38e-02    6.02  1.7e-09 ***
## ELEMENTARYLAKE MARION                        3.35e-02   4.31e-02    0.78  0.43652    
## ELEMENTARYLAKEVIEW                           6.46e-02   3.64e-02    1.77  0.07638 .  
## ELEMENTARYLiberty Ridge                      1.37e-01   3.63e-02    3.77  0.00016 ***
## ELEMENTARYLIBERTY RIDGE                      3.13e-01   3.56e-02    8.80  < 2e-16 ***
## ELEMENTARYLINCOLN                            8.35e-02   2.75e-02    3.04  0.00237 ** 
## ELEMENTARYLINO LAKES                         4.95e-02   3.90e-02    1.27  0.20507    
## ELEMENTARYLITTLE CANADA                      2.34e-01   3.49e-02    6.71  2.0e-11 ***
## ELEMENTARYL.O. JACOB                         6.08e-02   4.14e-02    1.47  0.14247    
## ELEMENTARYLONGFELLOW                         5.25e-01   3.26e-02   16.11  < 2e-16 ***
## ELEMENTARYMADISON                            7.69e-02   3.38e-02    2.27  0.02313 *  
## ELEMENTARYMANN                               5.52e-01   2.91e-02   18.99  < 2e-16 ***
## ELEMENTARYMARION W. SAVAGE                   4.48e-01   3.47e-02   12.93  < 2e-16 ***
## ELEMENTARYMATOSKA INTERNATIONAL              2.63e-01   3.92e-02    6.72  1.8e-11 ***
## ELEMENTARYMCKINLEY                           9.65e-02   2.96e-02    3.26  0.00110 ** 
## ELEMENTARYMEADOWVIEW                         6.77e-03   3.54e-02    0.19  0.84859    
## ELEMENTARYMENDOTA                            1.94e-01   3.79e-02    5.11  3.2e-07 ***
## ELEMENTARYMIDDLETON                          2.51e-01   3.55e-02    7.06  1.7e-12 ***
## ELEMENTARYMISSISSIPPI                        7.77e-03   3.09e-02    0.25  0.80155    
## ELEMENTARYMONROE                             1.87e-02   3.13e-02    0.60  0.55083    
## ELEMENTARYMORELAND                           8.31e-02   3.49e-02    2.38  0.01734 *  
## ELEMENTARYMORRIS BYE                        -1.35e-02   3.14e-02   -0.43  0.66712    
## ELEMENTARYNEWPORT                           -1.44e-02   3.66e-02   -0.39  0.69432    
## ELEMENTARYNORTH END                         -2.82e-01   3.05e-02   -9.24  < 2e-16 ***
## ELEMENTARYNORTH PARK                         5.87e-02   3.27e-02    1.79  0.07281 .  
## ELEMENTARYNORTH TRAIL                        2.43e-02   3.49e-02    0.70  0.48649    
## ELEMENTARYNORTHVIEW                          1.05e-01   3.77e-02    2.78  0.00547 ** 
## ELEMENTARYOAKDALE                            6.91e-03   3.42e-02    0.20  0.83986    
## ELEMENTARYOAK HILLS                          2.99e-02   4.14e-02    0.72  0.47027    
## ELEMENTARYOAKRIDGE                           6.36e-01   3.42e-02   18.56  < 2e-16 ***
## ELEMENTARYOAK RIDGE                          1.21e-01   3.78e-02    3.21  0.00135 ** 
## ELEMENTARYOBAMA                              6.65e-01   7.14e-02    9.32  < 2e-16 ***
## ELEMENTARYORCHARD LAKE                       1.48e-01   4.00e-02    3.70  0.00021 ***
## ELEMENTARYOTTER LAKE                         2.03e-01   3.09e-02    6.59  4.5e-11 ***
## ELEMENTARYPARKER                            -1.50e-02   7.74e-02   -0.19  0.84658    
## ELEMENTARYPARK TERRACE                       8.46e-02   3.29e-02    2.57  0.01022 *  
## ELEMENTARYPARK TERRACE & WESTWOOD           -1.39e-01   2.46e-01   -0.57  0.57188    
## ELEMENTARYPARKVIEW                           1.09e-01   3.16e-02    3.46  0.00055 ***
## ELEMENTARYPARKWAY                            3.06e-02   3.72e-02    0.82  0.41135    
## ELEMENTARYPEARSON                            4.62e-01   3.16e-02   14.64  < 2e-16 ***
## ELEMENTARYPHALEN LAKE                       -2.28e-01   3.31e-02   -6.90  5.3e-12 ***
## ELEMENTARYPILOT KNOB                         1.51e-01   4.05e-02    3.71  0.00021 ***
## ELEMENTARYPINE BEND                          1.21e-01   3.81e-02    3.17  0.00154 ** 
## ELEMENTARYPINE HILL                         -3.04e-04   3.59e-02   -0.01  0.99325    
## ELEMENTARYPINEWOOD                           9.17e-02   2.86e-02    3.20  0.00136 ** 
## ELEMENTARYPROSPERITY HEIGHTS                 1.23e-01   5.13e-02    2.41  0.01613 *  
## ELEMENTARYPULLMAN                           -8.58e-02   3.59e-02   -2.39  0.01694 *  
## ELEMENTARYRAHN                               9.52e-02   3.76e-02    2.53  0.01133 *  
## ELEMENTARYRAMSEY                            -6.31e-02   2.58e-02   -2.45  0.01429 *  
## ELEMENTARYRANDOLPH HEIGHTS                   6.04e-01   2.86e-02   21.11  < 2e-16 ***
## ELEMENTARYRED OAK                            5.49e-01   3.12e-02   17.62  < 2e-16 ***
## ELEMENTARYRED PINE                           1.34e-01   3.55e-02    3.78  0.00016 ***
## ELEMENTARYRED ROCK                           2.37e-01   3.67e-02    6.46  1.0e-10 ***
## ELEMENTARYREDTAIL RIDGE                      5.90e-01   3.60e-02   16.41  < 2e-16 ***
## ELEMENTARYRICE LAKE                          1.45e-01   3.14e-02    4.60  4.2e-06 ***
## ELEMENTARYRICHARDSON                         1.29e-01   3.05e-02    4.22  2.5e-05 ***
## ELEMENTARYRIVERVIEW                          5.29e-02   4.77e-02    1.11  0.26733    
## ELEMENTARYRIVERVIEW & CHEROKEE              -8.43e-02   3.43e-02   -2.45  0.01412 *  
## ELEMENTARYROOSEVELT & RIVERVIEW & CHEROKEE   1.59e-01   3.63e-02    4.40  1.1e-05 ***
## ELEMENTARYROSEMOUNT                          3.34e-02   3.61e-02    0.92  0.35544    
## ELEMENTARYROYAL OAKS                         1.59e-01   3.60e-02    4.41  1.0e-05 ***
## ELEMENTARYRUM RIVER                          2.36e-02   2.98e-02    0.79  0.42787    
## ELEMENTARYRUTHERFORD                         3.25e-01   5.03e-02    6.46  1.1e-10 ***
## ELEMENTARYSALEM HILLS                        1.12e-01   5.20e-02    2.16  0.03049 *  
## ELEMENTARYSAND CREEK                         2.40e-02   2.89e-02    0.83  0.40642    
## ELEMENTARYSHANNON PARK                       6.00e-02   3.51e-02    1.71  0.08754 .  
## ELEMENTARYSHERIDAN                           1.09e-01   4.28e-02    2.55  0.01069 *  
## ELEMENTARYSHERIDAN & AMES                   -2.17e-01   3.02e-02   -7.20  6.2e-13 ***
## ELEMENTARYSIOUX TRAIL                        8.06e-02   3.98e-02    2.03  0.04268 *  
## ELEMENTARYSKY OAKS                           2.70e-02   3.83e-02    0.71  0.48064    
## ELEMENTARYSKYVIEW                            9.65e-02   3.73e-02    2.59  0.00965 ** 
## ELEMENTARYSKYVIEW COMMUNITY SCHOOL           1.56e-01   3.60e-02    4.34  1.4e-05 ***
## ELEMENTARYSOMERSET HEIGHTS                   2.12e-01   3.54e-02    5.98  2.2e-09 ***
## ELEMENTARYSORTEBERG                         -3.65e-03   3.36e-02   -0.11  0.91329    
## ELEMENTARYSOUTH GROVE                        3.31e-02   5.04e-02    0.66  0.51079    
## ELEMENTARYSOUTHVIEW                          6.51e-02   3.50e-02    1.86  0.06277 .  
## ELEMENTARYST ANTHONY PARK                    6.33e-01   3.90e-02   16.21  < 2e-16 ***
## ELEMENTARYSTEVENSON                          1.14e-01   3.51e-02    3.23  0.00122 ** 
## ELEMENTARYSUNNYSIDE                          1.48e-01   3.23e-02    4.58  4.7e-06 ***
## ELEMENTARYSUN PATH                           3.30e-01   3.45e-02    9.58  < 2e-16 ***
## ELEMENTARYSWEENEY                            3.65e-01   3.35e-02   10.90  < 2e-16 ***
## ELEMENTARYTHOMAS LAKE                        1.18e-01   3.94e-02    2.98  0.00287 ** 
## ELEMENTARYTURTLE LAKE                        3.52e-01   2.79e-02   12.61  < 2e-16 ***
## ELEMENTARYTWIN LAKES                        -5.04e-01   1.59e-01   -3.18  0.00147 ** 
## ELEMENTARYUNIVERSITY                        -7.01e-02   2.77e-02   -2.53  0.01137 *  
## ELEMENTARYVADNAIS HEIGHTS                    1.49e-01   3.42e-02    4.34  1.4e-05 ***
## ELEMENTARYVALENTINE HILLS                    2.37e-01   2.97e-02    7.96  1.8e-15 ***
## ELEMENTARYVALLEY VIEW                        1.26e-01   3.38e-02    3.73  0.00019 ***
## ELEMENTARYVISTA VIEW                         5.97e-02   3.70e-02    1.61  0.10675    
## ELEMENTARYWASHINGTON                         3.81e-02   3.66e-02    1.04  0.29775    
## ELEMENTARYWEAVER                             1.41e-01   2.91e-02    4.86  1.2e-06 ***
## ELEMENTARYWEBSTER                            2.01e-01   3.46e-02    5.81  6.2e-09 ***
## ELEMENTARYWESTVIEW                           7.11e-02   3.54e-02    2.01  0.04435 *  
## ELEMENTARYWESTWOOD                           4.97e-01   3.82e-02   13.01  < 2e-16 ***
## ELEMENTARYWESTWOOD & GRAINWOOD               5.26e-01   3.39e-02   15.49  < 2e-16 ***
## ELEMENTARYWILLIAM BYRNE                      1.91e-02   3.93e-02    0.49  0.62721    
## ELEMENTARYWILLOW LANE                        1.13e-01   3.78e-02    2.98  0.00286 ** 
## ELEMENTARYWILSHIRE PARK                      2.18e-01   6.47e-02    3.37  0.00076 ***
## ELEMENTARYWILSON                            -7.35e-02   3.39e-02   -2.17  0.03015 *  
## ELEMENTARYWOODBURY                           1.44e-01   3.58e-02    4.01  6.0e-05 ***
## ELEMENTARYWOODCREST                          2.14e-01   2.58e-02    8.28  < 2e-16 ***
## ELEMENTARYWOODCREST & WESTWOOD               1.70e-01   2.46e-01    0.69  0.49031    
## ELEMENTARYWOODLAND                           1.40e-01   3.90e-02    3.58  0.00034 ***
## WhiteDense                                   2.63e-01   1.19e-02   22.10  < 2e-16 ***
## factor(SALE_YEAR)2006                        5.16e-03   3.88e-03    1.33  0.18357    
## factor(SALE_YEAR)2009                       -2.55e-01   5.12e-03  -49.83  < 2e-16 ***
## factor(SALE_YEAR)2010                       -2.73e-01   5.31e-03  -51.48  < 2e-16 ***
## factor(SALE_YEAR)2011                       -4.31e-01   1.00e-02  -43.02  < 2e-16 ***
## factor(SALE_MONTH)2                         -1.52e-02   9.17e-03   -1.66  0.09626 .  
## factor(SALE_MONTH)3                          1.32e-02   8.53e-03    1.54  0.12288    
## factor(SALE_MONTH)4                          7.37e-03   8.36e-03    0.88  0.37787    
## factor(SALE_MONTH)5                          3.96e-02   8.25e-03    4.80  1.6e-06 ***
## factor(SALE_MONTH)6                          4.61e-02   8.07e-03    5.71  1.1e-08 ***
## factor(SALE_MONTH)7                          4.36e-02   8.36e-03    5.21  1.9e-07 ***
## factor(SALE_MONTH)8                          4.37e-02   8.30e-03    5.27  1.4e-07 ***
## factor(SALE_MONTH)9                          2.83e-02   8.54e-03    3.31  0.00094 ***
## factor(SALE_MONTH)10                         3.94e-02   8.61e-03    4.58  4.6e-06 ***
## factor(SALE_MONTH)11                         6.09e-03   8.89e-03    0.69  0.49320    
## factor(SALE_MONTH)12                        -5.13e-03   9.19e-03   -0.56  0.57660    
## parkArea05                                   7.56e-08   2.41e-08    3.14  0.00166 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.347 on 51108 degrees of freedom
## Multiple R-squared: 0.601,	Adjusted R-squared: 0.599 
## F-statistic:  270 on 285 and 51108 DF,  p-value: <2e-16 
## 
```



```r
osiModel05KM.3 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    OSV05KM, data = HouseData)
summary(osiModel05KM.3)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + 
##     YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + 
##     factor(SALE_YEAR) + factor(SALE_MONTH) + OSV05KM, data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -7.022 -0.095  0.021  0.149  2.993 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                  3.96e+00   2.30e-01   17.17  < 2e-16 ***
## FIN_SQ_FT                                    2.74e-04   3.61e-06   75.82  < 2e-16 ***
## ACRES_POLY                                   4.21e-02   2.66e-03   15.83  < 2e-16 ***
## GARAGEsqft                                   1.51e-04   1.02e-05   14.75  < 2e-16 ***
## YEAR_BUILT                                   3.54e-03   1.14e-04   31.05  < 2e-16 ***
## HOME_STYLE1 1/2 STRY                         2.99e-02   7.31e-02    0.41  0.68285    
## HOME_STYLE1-1/2 STRY                         2.75e-01   6.36e-02    4.33  1.5e-05 ***
## HOME_STYLE1 1/4 STRY                        -3.40e-02   1.01e-01   -0.34  0.73498    
## HOME_STYLE1-1/4 STRY                         2.36e-01   6.18e-02    3.82  0.00014 ***
## HOME_STYLE1-2 STRY                           1.61e-01   6.31e-02    2.56  0.01051 *  
## HOME_STYLE1 3/4 STRY                         3.04e-01   9.33e-02    3.26  0.00111 ** 
## HOME_STYLE1-3/4 STRY                         3.44e-01   6.74e-02    5.10  3.3e-07 ***
## HOME_STYLE1 Story Brick                      3.80e-01   2.02e-01    1.88  0.06007 .  
## HOME_STYLE1 Story Condo                     -2.77e-01   5.99e-02   -4.63  3.7e-06 ***
## HOME_STYLE1 Story Frame                      3.20e-01   5.26e-02    6.09  1.1e-09 ***
## HOME_STYLE1 Story Townhouse                  2.69e-01   5.39e-02    4.99  6.2e-07 ***
## HOME_STYLE2 Story Brick                      3.49e-01   3.43e-01    1.02  0.30828    
## HOME_STYLE2 Story Condo                     -2.26e-01   5.52e-02   -4.10  4.1e-05 ***
## HOME_STYLE2 Story Frame                      2.72e-01   5.27e-02    5.15  2.6e-07 ***
## HOME_STYLE2 Story Townhouse                 -9.40e-02   5.31e-02   -1.77  0.07660 .  
## HOME_STYLE3-LVL SPLT                        -2.55e-02   6.54e-02   -0.39  0.69677    
## HOME_STYLE4 LVL SPLT                         4.43e-02   6.40e-02    0.69  0.48861    
## HOME_STYLEBungalow                           2.45e-01   5.68e-02    4.31  1.6e-05 ***
## HOME_STYLECONDO                             -6.22e-01   6.80e-02   -9.15  < 2e-16 ***
## HOME_STYLEDUP/TRI                            4.21e-02   1.63e-01    0.26  0.79666    
## HOME_STYLEEARTHBERM                         -4.50e-01   3.44e-01   -1.31  0.19082    
## HOME_STYLEEARTH SHEL                        -1.97e-01   3.44e-01   -0.57  0.56769    
## HOME_STYLELOG                                3.52e-01   2.05e-01    1.71  0.08667 .  
## HOME_STYLEMfd Home (Double)                 -9.36e-02   3.43e-01   -0.27  0.78479    
## HOME_STYLEModular                           -1.44e+00   2.46e-01   -5.83  5.6e-09 ***
## HOME_STYLEN/A                                1.72e-01   1.51e-01    1.14  0.25416    
## HOME_STYLEOne And 3/4 Story                  2.39e-01   5.74e-02    4.16  3.1e-05 ***
## HOME_STYLEOne Story                          2.00e-01   5.66e-02    3.54  0.00041 ***
## HOME_STYLEONE STORY                          1.85e-01   5.96e-02    3.11  0.00188 ** 
## HOME_STYLEOther                             -8.56e-01   1.78e-01   -4.80  1.6e-06 ***
## HOME_STYLERAMBLER                            1.11e-02   6.17e-02    0.18  0.85688    
## HOME_STYLERow                                1.80e-01   3.44e-01    0.52  0.60035    
## HOME_STYLESalvage                            1.31e-01   1.77e-01    0.74  0.46164    
## HOME_STYLESPLIT-ENT                         -3.97e-02   6.19e-02   -0.64  0.52129    
## HOME_STYLESplit/entry                        1.61e-01   5.73e-02    2.81  0.00496 ** 
## HOME_STYLESPLIT-FOY                         -2.09e-02   6.51e-02   -0.32  0.74877    
## HOME_STYLESplit Foyer Frame                  3.19e-01   5.31e-02    6.02  1.8e-09 ***
## HOME_STYLESplit/level                        2.23e-01   5.77e-02    3.86  0.00011 ***
## HOME_STYLESplit Level Frame                  3.68e-01   5.35e-02    6.89  5.7e-12 ***
## HOME_STYLESPLIT LEVL                         1.63e-01   5.96e-02    2.73  0.00634 ** 
## HOME_STYLETOWNHOME                          -2.94e-01   6.11e-02   -4.82  1.5e-06 ***
## HOME_STYLETWIN HOME                         -1.11e-01   6.58e-02   -1.69  0.09199 .  
## HOME_STYLETwo Story                          2.89e-01   5.70e-02    5.07  4.1e-07 ***
## HOME_STYLETWO STORY                          2.12e-01   5.98e-02    3.55  0.00039 ***
## HOME_STYLETWO+ STORY                         2.12e-01   1.23e-01    1.73  0.08333 .  
## ELEMENTARYAKIN ROAD                          1.35e-01   4.41e-02    3.07  0.00217 ** 
## ELEMENTARYAMES                               2.29e-01   5.03e-02    4.54  5.6e-06 ***
## ELEMENTARYANDERSEN                           1.70e-01   5.89e-02    2.89  0.00381 ** 
## ELEMENTARYANDERSON & WILDWOOD                2.28e-01   3.13e-02    7.30  2.9e-13 ***
## ELEMENTARYARMSTRONG                          2.21e-02   3.26e-02    0.68  0.49867    
## ELEMENTARYBAILEY                             8.56e-02   2.89e-02    2.96  0.00304 ** 
## ELEMENTARYBATTLE CREEK                       2.21e-01   5.12e-02    4.32  1.6e-05 ***
## ELEMENTARYBEL AIR                            2.29e-01   3.99e-02    5.74  9.3e-09 ***
## ELEMENTARYBIRCH LAKE                         1.45e-01   4.38e-02    3.31  0.00093 ***
## ELEMENTARYBRIMHALL                           4.07e-01   4.07e-02    9.99  < 2e-16 ***
## ELEMENTARYBRUCE F. VENTO                    -1.29e-01   4.40e-02   -2.94  0.00324 ** 
## ELEMENTARYCARVER                             9.95e-02   4.03e-02    2.47  0.01350 *  
## ELEMENTARYCASTLE                             1.35e-01   3.16e-02    4.27  2.0e-05 ***
## ELEMENTARYCEDAR PARK                         2.00e-01   4.91e-02    4.07  4.6e-05 ***
## ELEMENTARYCENTRAL PARK                       2.83e-01   4.16e-02    6.80  1.0e-11 ***
## ELEMENTARYCHELSEA HEIGHTS                    3.19e-01   3.85e-02    8.28  < 2e-16 ***
## ELEMENTARYCHERRY VIEW                        8.36e-02   4.76e-02    1.76  0.07890 .  
## ELEMENTARYCHRISTINA HUDDLESTON               1.26e-01   4.80e-02    2.62  0.00867 ** 
## ELEMENTARYCOMO PARK                          2.41e-01   4.06e-02    5.94  2.9e-09 ***
## ELEMENTARYCOTTAGE GROVE                      1.09e-01   3.10e-02    3.50  0.00046 ***
## ELEMENTARYCOWERN                             1.22e-01   3.62e-02    3.37  0.00075 ***
## ELEMENTARYCRESTVIEW                          2.86e-02   3.47e-02    0.82  0.40954    
## ELEMENTARYCRYSTAL LAKE                       1.17e-01   4.72e-02    2.48  0.01323 *  
## ELEMENTARYDAYTONS BLUFF                     -9.93e-02   4.14e-02   -2.40  0.01648 *  
## ELEMENTARYDEERWOOD                           1.56e-01   4.93e-02    3.17  0.00152 ** 
## ELEMENTARYDIAMOND PATH                       1.88e-01   4.44e-02    4.23  2.3e-05 ***
## ELEMENTARYEAGLE CREEK                        5.07e-01   4.40e-02   11.52  < 2e-16 ***
## ELEMENTARYEAGLE POINT                        9.50e-02   3.47e-02    2.74  0.00622 ** 
## ELEMENTARYEASTERN HEIGHTS                    4.26e-02   3.99e-02    1.07  0.28553    
## ELEMENTARYEASTVIEW                           1.12e-01   4.78e-02    2.34  0.01927 *  
## ELEMENTARYECHO PARK                          1.14e-01   4.48e-02    2.54  0.01101 *  
## ELEMENTARYEDGERTON                           2.40e-01   4.30e-02    5.57  2.6e-08 ***
## ELEMENTARYEDWARD NEILL                       1.58e-01   4.65e-02    3.40  0.00068 ***
## ELEMENTARYEMMET D. WILLIAMS                  3.05e-01   4.09e-02    7.46  9.1e-14 ***
## ELEMENTARYFALCON HEIGHTS                     3.37e-01   4.05e-02    8.32  < 2e-16 ***
## ELEMENTARYFARMINGTON                         1.10e-01   4.37e-02    2.52  0.01180 *  
## ELEMENTARYFARNSWORTH                         2.83e-01   4.52e-02    6.28  3.5e-10 ***
## ELEMENTARYFARNSWORTH LOWER                  -4.75e-02   4.53e-02   -1.05  0.29485    
## ELEMENTARYFIVE HAWKS                         6.17e-01   4.27e-02   14.46  < 2e-16 ***
## ELEMENTARYFOREST VIEW                       -3.23e-01   1.17e-01   -2.76  0.00578 ** 
## ELEMENTARYFOREST VIEW & FOREST LAKE         -3.47e-01   1.31e-01   -2.64  0.00828 ** 
## ELEMENTARYFRANKLIN                           1.35e-01   1.73e-01    0.78  0.43633    
## ELEMENTARYFRANKLIN MUSIC                     1.77e-01   1.43e-01    1.24  0.21619    
## ELEMENTARYFROST LAKE                         1.63e-01   4.52e-02    3.62  0.00030 ***
## ELEMENTARYGALTIER & MAXFIELD                 1.16e-01   3.91e-02    2.96  0.00305 ** 
## ELEMENTARYGARLOUGH                           2.96e-01   4.80e-02    6.17  6.7e-10 ***
## ELEMENTARYGIDEON POND                        2.20e-01   5.00e-02    4.41  1.0e-05 ***
## ELEMENTARYGLACIER HILLS                      2.03e-01   4.85e-02    4.18  3.0e-05 ***
## ELEMENTARYGLENDALE                           5.36e-01   4.47e-02   11.99  < 2e-16 ***
## ELEMENTARYGRAINWOOD                          3.54e-01   4.90e-02    7.23  4.9e-13 ***
## ELEMENTARYGREENLEAF                          1.07e-01   4.38e-02    2.43  0.01507 *  
## ELEMENTARYGREY CLOUD                         6.68e-02   3.27e-02    2.04  0.04114 *  
## ELEMENTARYGROVELAND PARK                     5.77e-01   3.98e-02   14.50  < 2e-16 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  4.74e-01   4.34e-02   10.94  < 2e-16 ***
## ELEMENTARYHANCOCK                            2.51e-01   5.46e-02    4.60  4.3e-06 ***
## ELEMENTARYHANCOCK EL.                        3.78e-01   4.88e-02    7.74  1.0e-14 ***
## ELEMENTARYHARRIET BISHOP                     4.33e-01   4.61e-02    9.38  < 2e-16 ***
## ELEMENTARYHAYDEN HEIGHTS                     1.34e-01   4.50e-02    2.97  0.00298 ** 
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -4.05e-02   4.08e-02   -0.99  0.32098    
## ELEMENTARYHIDDEN VALLEY                      4.33e-01   4.72e-02    9.17  < 2e-16 ***
## ELEMENTARYHIGHLAND                           1.28e-01   4.54e-02    2.81  0.00491 ** 
## ELEMENTARYHIGHLAND PARK                      5.09e-01   3.94e-02   12.92  < 2e-16 ***
## ELEMENTARYHIGHWOOD HILLS                     1.72e-01   4.49e-02    3.84  0.00012 ***
## ELEMENTARYHILLSIDE                           6.27e-02   3.42e-02    1.83  0.06705 .  
## ELEMENTARYHILLTOP                            2.22e-01   4.73e-02    4.68  2.8e-06 ***
## ELEMENTARYHOMECROFT                          3.75e-01   5.11e-02    7.35  2.0e-13 ***
## ELEMENTARYHUGO                               8.60e-02   3.05e-02    2.82  0.00487 ** 
## ELEMENTARYHUGO & ONEKA                       8.88e-02   3.12e-02    2.84  0.00447 ** 
## ELEMENTARYISLAND LAKE                        2.17e-01   3.95e-02    5.48  4.2e-08 ***
## ELEMENTARYJACKSON                           -3.70e-01   4.86e-02   -7.62  2.6e-14 ***
## ELEMENTARYJEFFERS POND                       5.42e-01   4.72e-02   11.50  < 2e-16 ***
## ELEMENTARYJOHN F. KENNEDY                    1.55e-01   5.88e-02    2.64  0.00822 ** 
## ELEMENTARYJOHNSON A+                        -1.03e-01   4.74e-02   -2.16  0.03050 *  
## ELEMENTARYJORDAN                             4.04e-01   1.27e-01    3.18  0.00149 ** 
## ELEMENTARYKAPOSIA                            2.05e-01   4.39e-02    4.67  3.1e-06 ***
## ELEMENTARYLAKEAIRES                          3.01e-01   4.00e-02    7.53  5.3e-14 ***
## ELEMENTARYLAKE ELMO                          1.28e-01   2.89e-02    4.43  9.3e-06 ***
## ELEMENTARYLAKE MARION                        1.09e-01   5.09e-02    2.15  0.03173 *  
## ELEMENTARYLAKEVIEW                           6.46e-02   4.55e-02    1.42  0.15579    
## ELEMENTARYLiberty Ridge                      2.55e-02   3.16e-02    0.81  0.42077    
## ELEMENTARYLIBERTY RIDGE                      2.15e-01   3.08e-02    6.98  2.9e-12 ***
## ELEMENTARYLINCOLN                            1.87e-01   3.96e-02    4.72  2.3e-06 ***
## ELEMENTARYLINO LAKES                        -1.81e-01   1.72e-01   -1.05  0.29404    
## ELEMENTARYLITTLE CANADA                      2.80e-01   4.35e-02    6.44  1.2e-10 ***
## ELEMENTARYLONGFELLOW                         5.21e-01   4.20e-02   12.40  < 2e-16 ***
## ELEMENTARYMANN                               5.24e-01   3.92e-02   13.38  < 2e-16 ***
## ELEMENTARYMARION W. SAVAGE                   4.96e-01   4.48e-02   11.06  < 2e-16 ***
## ELEMENTARYMATOSKA INTERNATIONAL              3.10e-01   4.56e-02    6.79  1.1e-11 ***
## ELEMENTARYMEADOWVIEW                         1.02e-01   4.51e-02    2.26  0.02408 *  
## ELEMENTARYMENDOTA                            2.16e-01   4.67e-02    4.62  3.8e-06 ***
## ELEMENTARYMIDDLETON                          1.47e-01   3.08e-02    4.77  1.8e-06 ***
## ELEMENTARYMISSISSIPPI                        1.97e-01   5.02e-02    3.93  8.4e-05 ***
## ELEMENTARYMONROE                             1.21e-01   4.11e-02    2.94  0.00332 ** 
## ELEMENTARYMORELAND                           2.26e-01   4.47e-02    5.04  4.6e-07 ***
## ELEMENTARYNEWPORT                            9.26e-02   3.28e-02    2.82  0.00478 ** 
## ELEMENTARYNORTH END                         -1.01e-01   4.10e-02   -2.45  0.01414 *  
## ELEMENTARYNORTH TRAIL                        1.40e-01   4.47e-02    3.14  0.00172 ** 
## ELEMENTARYNORTHVIEW                          1.02e-01   4.65e-02    2.19  0.02820 *  
## ELEMENTARYOAKDALE                            7.77e-02   3.17e-02    2.45  0.01431 *  
## ELEMENTARYOAK HILLS                          5.82e-02   4.94e-02    1.18  0.23856    
## ELEMENTARYOAKRIDGE                           6.00e-01   4.45e-02   13.49  < 2e-16 ***
## ELEMENTARYOAK RIDGE                          2.07e-01   4.68e-02    4.42  1.0e-05 ***
## ELEMENTARYOBAMA                              5.82e-01   7.46e-02    7.80  6.5e-15 ***
## ELEMENTARYORCHARD LAKE                       2.20e-01   4.84e-02    4.54  5.6e-06 ***
## ELEMENTARYOTTER LAKE                         1.36e-01   3.65e-02    3.72  0.00020 ***
## ELEMENTARYPARKVIEW                           1.88e-01   4.08e-02    4.61  4.0e-06 ***
## ELEMENTARYPARKWAY                            1.62e-01   4.58e-02    3.54  0.00040 ***
## ELEMENTARYPEARSON                            4.75e-01   4.25e-02   11.17  < 2e-16 ***
## ELEMENTARYPHALEN LAKE                       -5.62e-02   4.27e-02   -1.32  0.18815    
## ELEMENTARYPILOT KNOB                         2.16e-01   4.88e-02    4.42  1.0e-05 ***
## ELEMENTARYPINE BEND                          1.90e-01   4.70e-02    4.04  5.4e-05 ***
## ELEMENTARYPINE HILL                          5.58e-02   3.20e-02    1.75  0.08086 .  
## ELEMENTARYPINEWOOD                           1.08e-01   3.89e-02    2.77  0.00562 ** 
## ELEMENTARYPROSPERITY HEIGHTS                 2.50e-01   5.73e-02    4.36  1.3e-05 ***
## ELEMENTARYPULLMAN                            9.01e-03   3.23e-02    0.28  0.78036    
## ELEMENTARYRAHN                               2.07e-01   4.67e-02    4.44  9.1e-06 ***
## ELEMENTARYRANDOLPH HEIGHTS                   5.70e-01   3.89e-02   14.67  < 2e-16 ***
## ELEMENTARYRED OAK                            5.52e-01   4.22e-02   13.10  < 2e-16 ***
## ELEMENTARYRED PINE                           1.76e-01   4.49e-02    3.93  8.7e-05 ***
## ELEMENTARYRED ROCK                           1.16e-01   3.21e-02    3.61  0.00031 ***
## ELEMENTARYREDTAIL RIDGE                      5.41e-01   4.55e-02   11.90  < 2e-16 ***
## ELEMENTARYRICHARDSON                         1.93e-01   3.95e-02    4.88  1.1e-06 ***
## ELEMENTARYRIVERVIEW                          1.53e-01   5.47e-02    2.79  0.00528 ** 
## ELEMENTARYRIVERVIEW & CHEROKEE               6.51e-02   4.38e-02    1.49  0.13725    
## ELEMENTARYROOSEVELT & RIVERVIEW & CHEROKEE   2.47e-01   4.50e-02    5.49  3.9e-08 ***
## ELEMENTARYROSEMOUNT                          1.63e-01   4.56e-02    3.57  0.00036 ***
## ELEMENTARYROYAL OAKS                         1.05e-01   3.14e-02    3.32  0.00089 ***
## ELEMENTARYRUTHERFORD                         1.85e-01   4.65e-02    3.98  6.8e-05 ***
## ELEMENTARYSALEM HILLS                        1.95e-01   5.83e-02    3.35  0.00080 ***
## ELEMENTARYSHANNON PARK                       1.03e-01   4.46e-02    2.31  0.02086 *  
## ELEMENTARYSHERIDAN                           2.44e-01   5.02e-02    4.86  1.2e-06 ***
## ELEMENTARYSHERIDAN & AMES                   -2.35e-02   4.11e-02   -0.57  0.56741    
## ELEMENTARYSIOUX TRAIL                        2.28e-01   4.84e-02    4.71  2.5e-06 ***
## ELEMENTARYSKY OAKS                           1.88e-01   4.73e-02    3.98  6.8e-05 ***
## ELEMENTARYSKYVIEW                            8.16e-02   3.28e-02    2.49  0.01292 *  
## ELEMENTARYSKYVIEW COMMUNITY SCHOOL           1.49e-01   3.20e-02    4.66  3.2e-06 ***
## ELEMENTARYSOMERSET HEIGHTS                   2.66e-01   4.48e-02    5.95  2.8e-09 ***
## ELEMENTARYSOUTH GROVE                        1.80e-01   5.72e-02    3.15  0.00162 ** 
## ELEMENTARYSOUTHVIEW                          1.51e-01   4.46e-02    3.38  0.00074 ***
## ELEMENTARYST ANTHONY PARK                    6.06e-01   4.73e-02   12.83  < 2e-16 ***
## ELEMENTARYSUNNYSIDE                          1.77e-01   4.15e-02    4.25  2.1e-05 ***
## ELEMENTARYSUN PATH                           3.64e-01   4.45e-02    8.18  2.9e-16 ***
## ELEMENTARYSWEENEY                            4.16e-01   4.40e-02    9.46  < 2e-16 ***
## ELEMENTARYTHOMAS LAKE                        1.49e-01   4.79e-02    3.11  0.00188 ** 
## ELEMENTARYTURTLE LAKE                        2.13e-01   3.80e-02    5.62  1.9e-08 ***
## ELEMENTARYVADNAIS HEIGHTS                    1.45e-01   4.28e-02    3.40  0.00068 ***
## ELEMENTARYVALENTINE HILLS                    2.77e-01   3.97e-02    6.98  2.9e-12 ***
## ELEMENTARYVISTA VIEW                         2.23e-01   4.63e-02    4.80  1.6e-06 ***
## ELEMENTARYWEAVER                             2.00e-01   3.93e-02    5.09  3.6e-07 ***
## ELEMENTARYWEBSTER                            2.62e-01   4.36e-02    6.00  2.0e-09 ***
## ELEMENTARYWESTVIEW                           1.31e-01   4.48e-02    2.92  0.00347 ** 
## ELEMENTARYWESTWOOD                           5.75e-01   5.00e-02   11.49  < 2e-16 ***
## ELEMENTARYWESTWOOD & GRAINWOOD               5.19e-01   4.42e-02   11.72  < 2e-16 ***
## ELEMENTARYWILLIAM BYRNE                      1.22e-01   4.79e-02    2.55  0.01079 *  
## ELEMENTARYWILLOW LANE                        1.38e-01   4.60e-02    3.00  0.00266 ** 
## ELEMENTARYWILSHIRE PARK                      3.37e-01   7.11e-02    4.74  2.2e-06 ***
## ELEMENTARYWOODBURY                           1.54e-01   3.15e-02    4.90  9.6e-07 ***
## ELEMENTARYWOODLAND                           1.32e-01   4.75e-02    2.78  0.00548 ** 
## WhiteDense                                   2.18e-01   1.26e-02   17.23  < 2e-16 ***
## fam_income                                   4.72e-06   1.43e-07   32.92  < 2e-16 ***
## factor(SALE_YEAR)2006                        5.33e-03   4.45e-03    1.20  0.23088    
## factor(SALE_YEAR)2009                       -3.34e-01   5.82e-03  -57.34  < 2e-16 ***
## factor(SALE_YEAR)2010                       -3.55e-01   5.99e-03  -59.23  < 2e-16 ***
## factor(SALE_YEAR)2011                       -5.04e-01   1.05e-02  -47.92  < 2e-16 ***
## factor(SALE_MONTH)2                         -1.65e-02   9.89e-03   -1.67  0.09438 .  
## factor(SALE_MONTH)3                          1.43e-02   9.20e-03    1.56  0.11867    
## factor(SALE_MONTH)4                          1.13e-02   9.03e-03    1.25  0.21162    
## factor(SALE_MONTH)5                          4.16e-02   8.90e-03    4.67  3.0e-06 ***
## factor(SALE_MONTH)6                          5.34e-02   8.72e-03    6.12  9.4e-10 ***
## factor(SALE_MONTH)7                          4.48e-02   9.06e-03    4.95  7.5e-07 ***
## factor(SALE_MONTH)8                          4.34e-02   9.00e-03    4.82  1.4e-06 ***
## factor(SALE_MONTH)9                          2.81e-02   9.27e-03    3.04  0.00241 ** 
## factor(SALE_MONTH)10                         4.25e-02   9.33e-03    4.56  5.2e-06 ***
## factor(SALE_MONTH)11                         1.54e-02   9.59e-03    1.61  0.10840    
## factor(SALE_MONTH)12                        -4.55e-03   9.95e-03   -0.46  0.64791    
## OSV05KM                                      3.38e-09   9.23e-10    3.66  0.00025 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.338 on 41291 degrees of freedom
##   (9877 observations deleted due to missingness)
## Multiple R-squared: 0.644,	Adjusted R-squared: 0.642 
## F-statistic:  331 on 225 and 41291 DF,  p-value: <2e-16 
## 
```



```r
osiModel05KM.4 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    OSV05KM, data = HouseData)
summary(osiModel05KM.4)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + 
##     YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + factor(SALE_YEAR) + 
##     factor(SALE_MONTH) + OSV05KM, data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -6.980 -0.096  0.023  0.150  2.984 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                  3.95e+00   2.33e-01   16.90  < 2e-16 ***
## FIN_SQ_FT                                    2.91e-04   3.62e-06   80.33  < 2e-16 ***
## ACRES_POLY                                   4.68e-02   2.69e-03   17.38  < 2e-16 ***
## GARAGEsqft                                   1.56e-04   1.04e-05   15.03  < 2e-16 ***
## YEAR_BUILT                                   3.73e-03   1.15e-04   32.37  < 2e-16 ***
## HOME_STYLE1 1/2 STRY                        -6.80e-03   7.40e-02   -0.09  0.92679    
## HOME_STYLE1-1/2 STRY                         2.72e-01   6.45e-02    4.23  2.4e-05 ***
## HOME_STYLE1 1/4 STRY                        -3.87e-02   1.02e-01   -0.38  0.70382    
## HOME_STYLE1-1/4 STRY                         2.29e-01   6.26e-02    3.66  0.00025 ***
## HOME_STYLE1-2 STRY                           1.85e-01   6.39e-02    2.90  0.00378 ** 
## HOME_STYLE1 3/4 STRY                         2.97e-01   9.45e-02    3.14  0.00168 ** 
## HOME_STYLE1-3/4 STRY                         3.46e-01   6.83e-02    5.07  4.0e-07 ***
## HOME_STYLE1 Story Brick                      4.58e-01   2.05e-01    2.24  0.02537 *  
## HOME_STYLE1 Story Condo                     -2.72e-01   6.07e-02   -4.48  7.3e-06 ***
## HOME_STYLE1 Story Frame                      3.25e-01   5.33e-02    6.09  1.1e-09 ***
## HOME_STYLE1 Story Townhouse                  2.74e-01   5.46e-02    5.02  5.3e-07 ***
## HOME_STYLE2 Story Brick                      3.75e-01   3.47e-01    1.08  0.28024    
## HOME_STYLE2 Story Condo                     -1.75e-01   5.59e-02   -3.13  0.00173 ** 
## HOME_STYLE2 Story Frame                      2.73e-01   5.34e-02    5.12  3.1e-07 ***
## HOME_STYLE2 Story Townhouse                 -7.77e-02   5.38e-02   -1.45  0.14836    
## HOME_STYLE3-LVL SPLT                        -2.12e-02   6.63e-02   -0.32  0.74942    
## HOME_STYLE4 LVL SPLT                         5.97e-02   6.48e-02    0.92  0.35666    
## HOME_STYLEBungalow                           2.35e-01   5.75e-02    4.08  4.5e-05 ***
## HOME_STYLECONDO                             -6.29e-01   6.88e-02   -9.14  < 2e-16 ***
## HOME_STYLEDUP/TRI                            3.90e-02   1.65e-01    0.24  0.81362    
## HOME_STYLEEARTHBERM                         -5.11e-01   3.48e-01   -1.47  0.14283    
## HOME_STYLEEARTH SHEL                        -2.22e-01   3.49e-01   -0.64  0.52508    
## HOME_STYLELOG                                3.53e-01   2.08e-01    1.70  0.09001 .  
## HOME_STYLEMfd Home (Double)                 -1.34e-01   3.47e-01   -0.39  0.69851    
## HOME_STYLEModular                           -1.51e+00   2.50e-01   -6.05  1.4e-09 ***
## HOME_STYLEN/A                                1.89e-01   1.53e-01    1.24  0.21643    
## HOME_STYLEOne And 3/4 Story                  2.27e-01   5.81e-02    3.90  9.6e-05 ***
## HOME_STYLEOne Story                          1.85e-01   5.74e-02    3.23  0.00125 ** 
## HOME_STYLEONE STORY                          1.90e-01   6.04e-02    3.15  0.00165 ** 
## HOME_STYLEOther                             -8.71e-01   1.81e-01   -4.82  1.5e-06 ***
## HOME_STYLERAMBLER                            1.23e-02   6.25e-02    0.20  0.84423    
## HOME_STYLERow                                8.52e-02   3.48e-01    0.24  0.80660    
## HOME_STYLESalvage                            1.75e-01   1.80e-01    0.97  0.33024    
## HOME_STYLESPLIT-ENT                         -3.78e-02   6.27e-02   -0.60  0.54689    
## HOME_STYLESplit/entry                        1.44e-01   5.80e-02    2.48  0.01326 *  
## HOME_STYLESPLIT-FOY                         -8.35e-03   6.60e-02   -0.13  0.89926    
## HOME_STYLESplit Foyer Frame                  3.24e-01   5.37e-02    6.03  1.7e-09 ***
## HOME_STYLESplit/level                        2.07e-01   5.84e-02    3.54  0.00040 ***
## HOME_STYLESplit Level Frame                  3.78e-01   5.41e-02    6.98  2.9e-12 ***
## HOME_STYLESPLIT LEVL                         1.83e-01   6.04e-02    3.03  0.00243 ** 
## HOME_STYLETOWNHOME                          -2.75e-01   6.19e-02   -4.44  9.1e-06 ***
## HOME_STYLETWIN HOME                         -1.18e-01   6.66e-02   -1.78  0.07588 .  
## HOME_STYLETwo Story                          2.79e-01   5.77e-02    4.84  1.3e-06 ***
## HOME_STYLETWO STORY                          2.31e-01   6.06e-02    3.81  0.00014 ***
## HOME_STYLETWO+ STORY                         1.75e-01   1.24e-01    1.41  0.15974    
## ELEMENTARYAKIN ROAD                         -4.29e-02   4.43e-02   -0.97  0.33298    
## ELEMENTARYAMES                              -1.09e-02   5.05e-02   -0.22  0.82952    
## ELEMENTARYANDERSEN                           1.51e-01   5.97e-02    2.52  0.01167 *  
## ELEMENTARYANDERSON & WILDWOOD                1.72e-01   3.17e-02    5.42  6.0e-08 ***
## ELEMENTARYARMSTRONG                         -9.19e-02   3.29e-02   -2.79  0.00520 ** 
## ELEMENTARYBAILEY                             4.82e-02   2.92e-02    1.65  0.09915 .  
## ELEMENTARYBATTLE CREEK                       1.90e-02   5.15e-02    0.37  0.71212    
## ELEMENTARYBEL AIR                            1.08e-01   4.03e-02    2.69  0.00717 ** 
## ELEMENTARYBIRCH LAKE                        -7.17e-04   4.41e-02   -0.02  0.98704    
## ELEMENTARYBRIMHALL                           2.69e-01   4.10e-02    6.55  5.6e-11 ***
## ELEMENTARYBRUCE F. VENTO                    -3.97e-01   4.38e-02   -9.07  < 2e-16 ***
## ELEMENTARYCARVER                            -1.44e-02   4.06e-02   -0.35  0.72387    
## ELEMENTARYCASTLE                            -1.75e-02   3.16e-02   -0.55  0.57959    
## ELEMENTARYCEDAR PARK                         2.33e-02   4.94e-02    0.47  0.63731    
## ELEMENTARYCENTRAL PARK                       1.35e-01   4.19e-02    3.21  0.00132 ** 
## ELEMENTARYCHELSEA HEIGHTS                    1.70e-01   3.87e-02    4.39  1.1e-05 ***
## ELEMENTARYCHERRY VIEW                       -1.08e-02   4.81e-02   -0.22  0.82230    
## ELEMENTARYCHRISTINA HUDDLESTON               1.85e-02   4.85e-02    0.38  0.70278    
## ELEMENTARYCOMO PARK                          5.52e-02   4.07e-02    1.36  0.17529    
## ELEMENTARYCOTTAGE GROVE                     -4.29e-02   3.10e-02   -1.38  0.16660    
## ELEMENTARYCOWERN                            -6.26e-02   3.62e-02   -1.73  0.08378 .  
## ELEMENTARYCRESTVIEW                         -8.79e-02   3.50e-02   -2.51  0.01194 *  
## ELEMENTARYCRYSTAL LAKE                       3.11e-02   4.77e-02    0.65  0.51412    
## ELEMENTARYDAYTONS BLUFF                     -3.69e-01   4.11e-02   -8.98  < 2e-16 ***
## ELEMENTARYDEERWOOD                           8.39e-02   4.99e-02    1.68  0.09271 .  
## ELEMENTARYDIAMOND PATH                       3.24e-02   4.48e-02    0.72  0.46950    
## ELEMENTARYEAGLE CREEK                        4.28e-01   4.46e-02    9.60  < 2e-16 ***
## ELEMENTARYEAGLE POINT                       -4.19e-03   3.50e-02   -0.12  0.90484    
## ELEMENTARYEASTERN HEIGHTS                   -1.87e-01   3.98e-02   -4.71  2.4e-06 ***
## ELEMENTARYEASTVIEW                           3.45e-02   4.84e-02    0.71  0.47601    
## ELEMENTARYECHO PARK                         -1.21e-03   4.52e-02   -0.03  0.97860    
## ELEMENTARYEDGERTON                           4.94e-02   4.32e-02    1.14  0.25299    
## ELEMENTARYEDWARD NEILL                      -1.77e-03   4.68e-02   -0.04  0.96977    
## ELEMENTARYEMMET D. WILLIAMS                  1.94e-01   4.13e-02    4.69  2.8e-06 ***
## ELEMENTARYFALCON HEIGHTS                     2.07e-01   4.08e-02    5.08  3.9e-07 ***
## ELEMENTARYFARMINGTON                        -7.81e-02   4.39e-02   -1.78  0.07515 .  
## ELEMENTARYFARNSWORTH                         8.16e-02   4.53e-02    1.80  0.07161 .  
## ELEMENTARYFARNSWORTH LOWER                  -2.40e-01   4.55e-02   -5.28  1.3e-07 ***
## ELEMENTARYFIVE HAWKS                         5.27e-01   4.32e-02   12.22  < 2e-16 ***
## ELEMENTARYFOREST VIEW                       -5.41e-01   1.18e-01   -4.57  4.9e-06 ***
## ELEMENTARYFOREST VIEW & FOREST LAKE         -5.09e-01   1.33e-01   -3.83  0.00013 ***
## ELEMENTARYFRANKLIN                          -9.56e-02   1.75e-01   -0.55  0.58496    
## ELEMENTARYFRANKLIN MUSIC                    -1.97e-01   1.45e-01   -1.36  0.17314    
## ELEMENTARYFROST LAKE                        -1.87e-02   4.54e-02   -0.41  0.67965    
## ELEMENTARYGALTIER & MAXFIELD                -1.04e-01   3.90e-02   -2.67  0.00769 ** 
## ELEMENTARYGARLOUGH                           6.81e-02   4.81e-02    1.41  0.15718    
## ELEMENTARYGIDEON POND                        2.76e-02   5.03e-02    0.55  0.58312    
## ELEMENTARYGLACIER HILLS                      1.00e-01   4.91e-02    2.04  0.04101 *  
## ELEMENTARYGLENDALE                           4.79e-01   4.52e-02   10.59  < 2e-16 ***
## ELEMENTARYGRAINWOOD                          2.31e-01   4.95e-02    4.66  3.1e-06 ***
## ELEMENTARYGREENLEAF                          2.85e-02   4.43e-02    0.64  0.52014    
## ELEMENTARYGREY CLOUD                        -3.75e-02   3.30e-02   -1.14  0.25575    
## ELEMENTARYGROVELAND PARK                     5.57e-01   4.03e-02   13.82  < 2e-16 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  3.58e-01   4.38e-02    8.19  2.8e-16 ***
## ELEMENTARYHANCOCK                            1.46e-02   5.49e-02    0.27  0.79043    
## ELEMENTARYHANCOCK EL.                        1.74e-01   4.90e-02    3.55  0.00039 ***
## ELEMENTARYHARRIET BISHOP                     3.86e-01   4.67e-02    8.26  < 2e-16 ***
## ELEMENTARYHAYDEN HEIGHTS                    -4.31e-02   4.53e-02   -0.95  0.34099    
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -2.51e-01   4.08e-02   -6.14  8.2e-10 ***
## ELEMENTARYHIDDEN VALLEY                      3.08e-01   4.77e-02    6.47  9.9e-11 ***
## ELEMENTARYHIGHLAND                           4.58e-02   4.59e-02    1.00  0.31820    
## ELEMENTARYHIGHLAND PARK                      4.48e-01   3.99e-02   11.23  < 2e-16 ***
## ELEMENTARYHIGHWOOD HILLS                    -4.46e-02   4.50e-02   -0.99  0.32172    
## ELEMENTARYHILLSIDE                          -8.54e-02   3.44e-02   -2.49  0.01293 *  
## ELEMENTARYHILLTOP                            3.53e-02   4.76e-02    0.74  0.45776    
## ELEMENTARYHOMECROFT                          2.14e-01   5.15e-02    4.15  3.3e-05 ***
## ELEMENTARYHUGO                              -9.27e-02   3.04e-02   -3.05  0.00231 ** 
## ELEMENTARYHUGO & ONEKA                      -6.66e-02   3.13e-02   -2.13  0.03315 *  
## ELEMENTARYISLAND LAKE                        1.46e-01   4.00e-02    3.65  0.00026 ***
## ELEMENTARYJACKSON                           -6.50e-01   4.84e-02  -13.43  < 2e-16 ***
## ELEMENTARYJEFFERS POND                       5.18e-01   4.78e-02   10.85  < 2e-16 ***
## ELEMENTARYJOHN F. KENNEDY                    2.29e-03   5.94e-02    0.04  0.96924    
## ELEMENTARYJOHNSON A+                        -3.70e-01   4.73e-02   -7.81  6.1e-15 ***
## ELEMENTARYJORDAN                             3.07e-01   1.29e-01    2.38  0.01732 *  
## ELEMENTARYKAPOSIA                           -1.24e-02   4.39e-02   -0.28  0.77741    
## ELEMENTARYLAKEAIRES                          1.71e-01   4.03e-02    4.25  2.2e-05 ***
## ELEMENTARYLAKE ELMO                          8.64e-02   2.93e-02    2.95  0.00319 ** 
## ELEMENTARYLAKE MARION                       -3.08e-02   5.14e-02   -0.60  0.54895    
## ELEMENTARYLAKEVIEW                           1.11e-03   4.61e-02    0.02  0.98086    
## ELEMENTARYLiberty Ridge                      3.43e-02   3.20e-02    1.07  0.28465    
## ELEMENTARYLIBERTY RIDGE                      1.98e-01   3.11e-02    6.36  2.1e-10 ***
## ELEMENTARYLINCOLN                            2.25e-02   3.98e-02    0.56  0.57262    
## ELEMENTARYLINO LAKES                        -3.65e-01   1.74e-01   -2.10  0.03605 *  
## ELEMENTARYLITTLE CANADA                      1.25e-01   4.38e-02    2.84  0.00449 ** 
## ELEMENTARYLONGFELLOW                         3.96e-01   4.24e-02    9.34  < 2e-16 ***
## ELEMENTARYMANN                               4.48e-01   3.96e-02   11.32  < 2e-16 ***
## ELEMENTARYMARION W. SAVAGE                   3.39e-01   4.52e-02    7.50  6.4e-14 ***
## ELEMENTARYMATOSKA INTERNATIONAL              1.75e-01   4.61e-02    3.80  0.00015 ***
## ELEMENTARYMEADOWVIEW                        -7.35e-02   4.54e-02   -1.62  0.10539    
## ELEMENTARYMENDOTA                            1.47e-01   4.72e-02    3.11  0.00189 ** 
## ELEMENTARYMIDDLETON                          1.40e-01   3.12e-02    4.49  7.2e-06 ***
## ELEMENTARYMISSISSIPPI                       -1.07e-01   5.00e-02   -2.15  0.03145 *  
## ELEMENTARYMONROE                            -9.10e-02   4.11e-02   -2.21  0.02693 *  
## ELEMENTARYMORELAND                           3.75e-02   4.50e-02    0.83  0.40385    
## ELEMENTARYNEWPORT                           -1.31e-01   3.25e-02   -4.04  5.4e-05 ***
## ELEMENTARYNORTH END                         -3.85e-01   4.06e-02   -9.47  < 2e-16 ***
## ELEMENTARYNORTH TRAIL                       -4.25e-02   4.49e-02   -0.95  0.34375    
## ELEMENTARYNORTHVIEW                          5.48e-02   4.71e-02    1.16  0.24404    
## ELEMENTARYOAKDALE                           -1.12e-01   3.16e-02   -3.56  0.00038 ***
## ELEMENTARYOAK HILLS                         -2.01e-02   5.00e-02   -0.40  0.68750    
## ELEMENTARYOAKRIDGE                           5.09e-01   4.49e-02   11.32  < 2e-16 ***
## ELEMENTARYOAK RIDGE                          6.91e-02   4.72e-02    1.46  0.14293    
## ELEMENTARYOBAMA                              5.16e-01   7.56e-02    6.83  8.5e-12 ***
## ELEMENTARYORCHARD LAKE                       8.24e-02   4.88e-02    1.69  0.09177 .  
## ELEMENTARYOTTER LAKE                         6.01e-02   3.69e-02    1.63  0.10354    
## ELEMENTARYPARKVIEW                           3.29e-02   4.11e-02    0.80  0.42416    
## ELEMENTARYPARKWAY                           -5.84e-02   4.59e-02   -1.27  0.20268    
## ELEMENTARYPEARSON                            3.49e-01   4.29e-02    8.13  4.3e-16 ***
## ELEMENTARYPHALEN LAKE                       -3.18e-01   4.25e-02   -7.48  7.6e-14 ***
## ELEMENTARYPILOT KNOB                         9.38e-02   4.93e-02    1.90  0.05717 .  
## ELEMENTARYPINE BEND                          4.07e-02   4.74e-02    0.86  0.38969    
## ELEMENTARYPINE HILL                         -1.32e-01   3.19e-02   -4.13  3.6e-05 ***
## ELEMENTARYPINEWOOD                           8.52e-03   3.92e-02    0.22  0.82806    
## ELEMENTARYPROSPERITY HEIGHTS                 4.18e-02   5.77e-02    0.72  0.46901    
## ELEMENTARYPULLMAN                           -2.06e-01   3.20e-02   -6.43  1.3e-10 ***
## ELEMENTARYRAHN                               3.62e-02   4.70e-02    0.77  0.44109    
## ELEMENTARYRANDOLPH HEIGHTS                   4.92e-01   3.93e-02   12.51  < 2e-16 ***
## ELEMENTARYRED OAK                            4.34e-01   4.26e-02   10.21  < 2e-16 ***
## ELEMENTARYRED PINE                           7.00e-02   4.54e-02    1.54  0.12307    
## ELEMENTARYRED ROCK                           1.25e-01   3.26e-02    3.84  0.00012 ***
## ELEMENTARYREDTAIL RIDGE                      4.60e-01   4.60e-02    9.99  < 2e-16 ***
## ELEMENTARYRICHARDSON                         2.32e-02   3.97e-02    0.58  0.55889    
## ELEMENTARYRIVERVIEW                         -2.75e-02   5.51e-02   -0.50  0.61818    
## ELEMENTARYRIVERVIEW & CHEROKEE              -1.87e-01   4.37e-02   -4.29  1.8e-05 ***
## ELEMENTARYROOSEVELT & RIVERVIEW & CHEROKEE   4.94e-02   4.51e-02    1.10  0.27333    
## ELEMENTARYROSEMOUNT                         -3.01e-02   4.58e-02   -0.66  0.51152    
## ELEMENTARYROYAL OAKS                         4.85e-02   3.18e-02    1.53  0.12704    
## ELEMENTARYRUTHERFORD                         1.81e-01   4.72e-02    3.83  0.00013 ***
## ELEMENTARYSALEM HILLS                        4.51e-02   5.88e-02    0.77  0.44329    
## ELEMENTARYSHANNON PARK                       2.92e-03   4.51e-02    0.06  0.94832    
## ELEMENTARYSHERIDAN                           2.44e-02   5.04e-02    0.48  0.62773    
## ELEMENTARYSHERIDAN & AMES                   -3.07e-01   4.07e-02   -7.55  4.6e-14 ***
## ELEMENTARYSIOUX TRAIL                        4.05e-02   4.87e-02    0.83  0.40470    
## ELEMENTARYSKY OAKS                          -1.59e-02   4.75e-02   -0.33  0.73789    
## ELEMENTARYSKYVIEW                           -2.38e-02   3.31e-02   -0.72  0.47202    
## ELEMENTARYSKYVIEW COMMUNITY SCHOOL           4.13e-02   3.22e-02    1.28  0.19993    
## ELEMENTARYSOMERSET HEIGHTS                   1.71e-01   4.53e-02    3.77  0.00016 ***
## ELEMENTARYSOUTH GROVE                       -2.87e-02   5.76e-02   -0.50  0.61838    
## ELEMENTARYSOUTHVIEW                          1.10e-02   4.50e-02    0.24  0.80737    
## ELEMENTARYST ANTHONY PARK                    5.02e-01   4.78e-02   10.51  < 2e-16 ***
## ELEMENTARYSUNNYSIDE                          3.31e-02   4.18e-02    0.79  0.42871    
## ELEMENTARYSUN PATH                           2.11e-01   4.48e-02    4.71  2.5e-06 ***
## ELEMENTARYSWEENEY                            2.55e-01   4.43e-02    5.75  8.7e-09 ***
## ELEMENTARYTHOMAS LAKE                        6.56e-02   4.84e-02    1.35  0.17551    
## ELEMENTARYTURTLE LAKE                        2.21e-01   3.85e-02    5.75  9.0e-09 ***
## ELEMENTARYVADNAIS HEIGHTS                    1.97e-02   4.32e-02    0.46  0.64750    
## ELEMENTARYVALENTINE HILLS                    1.42e-01   4.00e-02    3.54  0.00040 ***
## ELEMENTARYVISTA VIEW                         1.47e-02   4.65e-02    0.32  0.75247    
## ELEMENTARYWEAVER                             3.65e-02   3.95e-02    0.92  0.35556    
## ELEMENTARYWEBSTER                            7.79e-02   4.38e-02    1.78  0.07553 .  
## ELEMENTARYWESTVIEW                           1.39e-02   4.53e-02    0.31  0.75935    
## ELEMENTARYWESTWOOD                           5.10e-01   5.06e-02   10.08  < 2e-16 ***
## ELEMENTARYWESTWOOD & GRAINWOOD               4.16e-01   4.47e-02    9.30  < 2e-16 ***
## ELEMENTARYWILLIAM BYRNE                     -2.31e-02   4.83e-02   -0.48  0.63315    
## ELEMENTARYWILLOW LANE                       -3.05e-02   4.63e-02   -0.66  0.50955    
## ELEMENTARYWILSHIRE PARK                      1.16e-01   7.17e-02    1.62  0.10621    
## ELEMENTARYWOODBURY                           3.73e-02   3.17e-02    1.17  0.24013    
## ELEMENTARYWOODLAND                           8.80e-02   4.81e-02    1.83  0.06752 .  
## WhiteDense                                   2.82e-01   1.27e-02   22.24  < 2e-16 ***
## factor(SALE_YEAR)2006                        4.53e-03   4.51e-03    1.00  0.31530    
## factor(SALE_YEAR)2009                       -2.48e-01   5.28e-03  -47.05  < 2e-16 ***
## factor(SALE_YEAR)2010                       -2.69e-01   5.47e-03  -49.25  < 2e-16 ***
## factor(SALE_YEAR)2011                       -4.19e-01   1.03e-02  -40.62  < 2e-16 ***
## factor(SALE_MONTH)2                         -1.72e-02   1.00e-02   -1.72  0.08529 .  
## factor(SALE_MONTH)3                          1.37e-02   9.31e-03    1.47  0.14089    
## factor(SALE_MONTH)4                          1.10e-02   9.15e-03    1.20  0.23027    
## factor(SALE_MONTH)5                          4.23e-02   9.02e-03    4.69  2.8e-06 ***
## factor(SALE_MONTH)6                          5.50e-02   8.84e-03    6.23  4.8e-10 ***
## factor(SALE_MONTH)7                          4.36e-02   9.17e-03    4.76  2.0e-06 ***
## factor(SALE_MONTH)8                          4.37e-02   9.12e-03    4.79  1.7e-06 ***
## factor(SALE_MONTH)9                          2.90e-02   9.39e-03    3.09  0.00202 ** 
## factor(SALE_MONTH)10                         4.21e-02   9.45e-03    4.45  8.6e-06 ***
## factor(SALE_MONTH)11                         1.60e-02   9.71e-03    1.65  0.09991 .  
## factor(SALE_MONTH)12                        -4.13e-03   1.01e-02   -0.41  0.68237    
## OSV05KM                                      4.09e-09   9.35e-10    4.37  1.2e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.343 on 41292 degrees of freedom
##   (9877 observations deleted due to missingness)
## Multiple R-squared: 0.634,	Adjusted R-squared: 0.632 
## F-statistic:  320 on 224 and 41292 DF,  p-value: <2e-16 
## 
```

