Aaron's First Cleaning of the Data
========================================================

This document describes and shows the first data cleaning done via R after the data file was uploaded to the R Server. We'll do most of the spatial display via ArcMap, but much of the data manipulation, analysis and non-spatial display via R.


```r
require(foreign)
getwd()
```

```
## [1] "/home/aswoboda/OSI Hedonic Project/OSI-Hedonic/writeup/01-DataCleaning"
```

```r
HouseData = read.dbf("../../../Data/DataFromARCMAP.dbf")
```


What's in this file? What is the underlying structure of the data? What are the variables? How many of them? What are their values?

```r
str(HouseData)
```

```
## 'data.frame':	18734 obs. of  68 variables:
##  $ COUNTY_ID : Factor w/ 5 levels "003","037","123",..: 2 2 2 2 2 2 2 2 2 2 ...
##  $ PIN       : Factor w/ 18727 levels "003-013123120005",..: 2139 2140 535 2830 2831 1238 1239 1240 1241 1242 ...
##  $ CITY      : Factor w/ 70 levels "ANDOVER","ANOKA",..: 37 37 3 45 45 6 6 6 6 7 ...
##  $ ZIP4      : Factor w/ 3338 levels "1000","1001",..: NA NA NA NA NA NA NA NA NA NA ...
##  $ LOT       : Factor w/ 372 levels "001","002","003",..: NA NA NA NA NA NA NA NA NA NA ...
##  $ ACRES_POLY: num  0.3 0.28 0.37 0.84 0.61 0.92 0.53 0.54 0.33 1.25 ...
##  $ ACRES_DEED: num  0 0 0 0 0 0 0 0 0 0 ...
##  $ USE1_DESC : Factor w/ 4 levels "100 Res 1 unit",..: 2 2 2 2 2 2 2 2 2 2 ...
##  $ HOMESTEAD : Factor w/ 3 levels "N","P","Y": 3 3 3 3 3 3 3 3 3 3 ...
##  $ EMV_LAND  : int  50600 53000 64200 118700 149400 84700 116400 101600 59300 40500 ...
##  $ EMV_BLDG  : int  135700 213100 121700 284900 599400 216600 441800 318700 178300 183300 ...
##  $ EMV_TOTAL : int  186300 266100 185900 403600 748800 301300 558200 420300 237600 223800 ...
##  $ TAX_CAPAC : int  1906 2713 1915 4277 8614 3075 5853 4283 2423 2367 ...
##  $ TOTAL_TAX : int  2088 3130 2300 4124 8211 3872 7381 5436 2921 2528 ...
##  $ XUSE1_DESC: Factor w/ 5 levels "Church-Other Res",..: NA NA NA NA NA NA NA NA NA NA ...
##  $ DWELL_TYPE: Factor w/ 12 levels "Condominium",..: 5 5 5 5 5 5 5 5 5 5 ...
##  $ HOME_STYLE: Factor w/ 52 levels "1 1/2 Story Finished",..: 45 45 45 51 51 45 51 51 51 34 ...
##  $ FIN_SQ_FT : int  1756 2806 1509 3587 6225 2944 5104 3773 2746 2960 ...
##  $ GARAGE    : Factor w/ 2 levels "N","Y": NA NA NA NA NA NA NA NA NA NA ...
##  $ GARAGESQFT: Factor w/ 1312 levels "0","10","1000",..: 674 975 548 186 45 924 1086 884 472 1027 ...
##  $ BASEMENT  : Factor w/ 2 levels "N","Y": NA NA NA NA NA NA NA NA NA NA ...
##  $ HEATING   : Factor w/ 11 levels "Electric","ELECTRIC",..: NA NA NA NA NA NA NA NA NA NA ...
##  $ COOLING   : Factor w/ 5 levels "CENTRAL","CENTRAL W/AIR COND",..: NA NA NA NA NA NA NA NA NA NA ...
##  $ YEAR_BUILT: int  1979 1991 1972 1988 1995 1979 1992 1988 1986 1966 ...
##  $ NUM_UNITS : Factor w/ 3 levels "0","1","2": 2 2 2 2 2 2 2 2 2 2 ...
##  $ SALE_DATE : Date, format: "2009-08-28" "2011-01-14" ...
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
##  $ halfkmSUM : num  3569670 2687240 2190160 4111410 3692540 ...
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
##  $ ELEMENTARY: Factor w/ 165 levels "AFTON-LAKELAND",..: 115 69 56 94 94 108 154 52 159 43 ...
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
##  $ StPaulDist: num  NA NA NA NA NA NA NA NA NA NA ...
##  $ MinneaDist: num  NA NA NA NA NA NA NA NA NA NA ...
##  - attr(*, "data_types")= chr  "C" "C" "C" "C" ...
```

```r
summary(HouseData)
```

```
##  COUNTY_ID                 PIN                           CITY     
##  003: 330   139-252310100    :    2   SAINT PAUL           :4255  
##  037:3217   163-1202721230021:    2   CITY OF WOODBURY     :2255  
##  123:7125   163-1802821340123:    2   CITY OF SHAKOPEE     :1314  
##  139:2833   163-2003021320031:    2   CITY OF COTTAGE GROVE:1001  
##  163:5229   163-2402722440001:    2   CITY OF OAKDALE      : 800  
##             163-3003021240080:    2   CITY OF SAVAGE       : 767  
##             (Other)          :18722   (Other)              :8342  
##       ZIP4            LOT         ACRES_POLY       ACRES_DEED    
##  1613   :   12   1      : 769   Min.   : 0.000   Min.   : 0.000  
##  2329   :   10   2      : 754   1st Qu.: 0.140   1st Qu.: 0.000  
##  3918   :   10   3      : 733   Median : 0.240   Median : 0.000  
##  4820   :   10   4      : 647   Mean   : 0.375   Mean   : 0.155  
##  1409   :    9   5      : 601   3rd Qu.: 0.330   3rd Qu.: 0.150  
##  (Other): 7350   (Other):9168   Max.   :29.460   Max.   :30.000  
##  NA's   :11333   NA's   :6062                                    
##                                USE1_DESC    HOMESTEAD    EMV_LAND      
##  100 Res 1 unit                     :8062   N: 3019   Min.   :   9000  
##  RESIDENTIAL                        :3217   P:   51   1st Qu.:  43000  
##  RESIDENTIAL SINGLE FAMILY          : 330   Y:15664   Median :  67000  
##  Single Family Dwelling, Platted Lot:7125             Mean   :  73619  
##                                                       3rd Qu.:  86000  
##                                                       Max.   :1750600  
##                                                                        
##     EMV_BLDG         EMV_TOTAL         TAX_CAPAC       TOTAL_TAX    
##  Min.   :      0   Min.   :      0   Min.   :    0   Min.   :    0  
##  1st Qu.: 102000   1st Qu.: 155700   1st Qu.:    0   1st Qu.:    0  
##  Median : 129600   Median : 197100   Median :    0   Median : 1722  
##  Mean   : 154234   Mean   : 227850   Mean   :  466   Mean   : 1642  
##  3rd Qu.: 182100   3rd Qu.: 265900   3rd Qu.:    0   3rd Qu.: 2618  
##  Max.   :1180100   Max.   :2600600   Max.   :17711   Max.   :35214  
##                                                                     
##                      XUSE1_DESC                             DWELL_TYPE  
##  Church-Other Res         :    1   SINGLE FAMILY DWELLING        :7125  
##  Church-Residence         :    1   Single-Family / Owner Occupied:3713  
##  Muni Srvc Other          :    4   S.FAM.RES                     :3217  
##  RESIDENTIAL SINGLE FAMILY:    2   Townhouse                     :1265  
##  Schools-Priv Res         :    1   RESIDENTIAL SINGLE FAMILY     : 330  
##  NA's                     :18725   (Other)                       : 251  
##                                    NA's                          :2833  
##          HOME_STYLE     FIN_SQ_FT      GARAGE         GARAGESQFT   
##  One Story    :2640   Min.   :  424   N   :   10   440     : 1301  
##  Bungalow     :1795   1st Qu.: 1091   Y   :12674   484     :  774  
##  2 Story Frame:1663   Median : 1425   NA's: 6050   528     :  748  
##  TWO STORY    :1499   Mean   : 1645                440.0000:  639  
##  SPLIT LEVL   :1294   3rd Qu.: 1976                576     :  564  
##  Two Story    :1117   Max.   :13426                (Other) :13980  
##  (Other)      :8726                                NA's    :  728  
##  BASEMENT          HEATING                   COOLING       YEAR_BUILT  
##  N   :   81   FA Gas   :4030   CENTRAL           :2220   Min.   :1840  
##  Y   :12603   HOT AIR  :3276   CENTRAL W/AIR COND:4834   1st Qu.:1955  
##  NA's: 6050   Yes      :1150   NON CENTRAL       :  66   Median :1981  
##               HOT WATER: 830   NONE              :   2   Mean   :1972  
##               Oil F.A. :  32   Y                 :4999   3rd Qu.:1999  
##               (Other)  :  28   NA's              :6613   Max.   :2011  
##               NA's     :9388                                           
##  NUM_UNITS      SALE_DATE            SALE_VALUE        SCHOOL_DST  
##  0   :  353   Min.   :2009-01-01   Min.   :   1000   625    :4255  
##  1   :15542   1st Qu.:2009-07-28   1st Qu.: 135502   720    :1368  
##  2   :    6   Median :2010-01-07   Median : 191900   196    :1271  
##  NA's: 2833   Mean   :2010-01-29   Mean   : 218015   719    :1139  
##               3rd Qu.:2010-07-11   3rd Qu.: 265000   ISD622 : 981  
##               Max.   :2011-12-08   Max.   :5783200   (Other):6200  
##                                                      NA's   :3520  
##                WSHD_DIST        MYPIN          X_COORD      
##  WS SOUTH WASHINGTON:3100   Min.   :    0   Min.   :453873  
##  Capital Region W/S :2931   1st Qu.: 4689   1st Qu.:484039  
##  Metro Watershed    :2266   Median : 9372   Median :492081  
##  VERMILLION RIVER   :1347   Mean   : 9371   Mean   :490259  
##  Rice Creek W/S     :1083   3rd Qu.:14056   3rd Qu.:501074  
##  (Other)            :4322   Max.   :18739   Max.   :515822  
##  NA's               :3685                                   
##     Y_COORD         REPLACEFID      CITY_DUMMY              GEOID10     
##  Min.   :453873   Min.   :    0   Min.   : 1.0   271390803011036:  125  
##  1st Qu.:484039   1st Qu.: 4686   1st Qu.:21.0   271630710181000:   86  
##  Median :492081   Median : 9370   Median :29.0   271630702031040:   59  
##  Mean   :490259   Mean   : 9368   Mean   :35.4   271390809042006:   58  
##  3rd Qu.:501074   3rd Qu.:14053   3rd Qu.:56.0   271390807001019:   55  
##  Max.   :515822   Max.   :18733   Max.   :70.0   271390807001008:   52  
##                                                  (Other)        :18299  
##    tenthkmSUM         qtrkmSUM         halfkmSUM           onekmSUM       
##  Min.   :      0   Min.   :      0   Min.   :       0   Min.   :0.00e+00  
##  1st Qu.:  38184   1st Qu.: 416184   1st Qu.: 2156065   1st Qu.:1.12e+07  
##  Median :  81000   Median : 603698   Median : 3054725   Median :1.58e+07  
##  Mean   :  95827   Mean   : 732594   Mean   : 3661434   Mean   :1.90e+07  
##  3rd Qu.: 119184   3rd Qu.: 869130   3rd Qu.: 4490825   3rd Qu.:2.41e+07  
##  Max.   :1347100   Max.   :7589400   Max.   :24899800   Max.   :1.21e+08  
##                                                                           
##     twokmSUM          Census_POP     WhiteDense      White_POP   
##  Min.   :0.00e+00   Min.   :   0   Min.   :0.000   Min.   :   0  
##  1st Qu.:5.74e+07   1st Qu.:  57   1st Qu.:0.701   1st Qu.:  39  
##  Median :8.44e+07   Median :  92   Median :0.840   Median :  70  
##  Mean   :9.83e+07   Mean   : 178   Mean   :0.779   Mean   : 138  
##  3rd Qu.:1.29e+08   3rd Qu.: 205   3rd Qu.:0.919   3rd Qu.: 165  
##  Max.   :4.81e+08   Max.   :1681   Max.   :1.000   Max.   :1394  
##                                                                  
##    Amind_POP      Asian_POP     Pacif_POP        Other_POP     
##  Min.   : 0.0   Min.   :  0   Min.   : 0.000   Min.   : 0.000  
##  1st Qu.: 0.0   1st Qu.:  1   1st Qu.: 0.000   1st Qu.: 0.000  
##  Median : 0.0   Median :  6   Median : 0.000   Median : 0.000  
##  Mean   : 0.8   Mean   : 17   Mean   : 0.057   Mean   : 0.269  
##  3rd Qu.: 1.0   3rd Qu.: 18   3rd Qu.: 0.000   3rd Qu.: 0.000  
##  Max.   :82.0   Max.   :484   Max.   :23.000   Max.   :12.000  
##                                                                
##    Multi_POP        Hisp_POP       NotHis_POP       VACANT     
##  Min.   : 0.00   Min.   :  0.0   Min.   :   0   Min.   : 0.00  
##  1st Qu.: 0.00   1st Qu.:  0.0   1st Qu.:  53   1st Qu.: 0.00  
##  Median : 2.00   Median :  4.0   Median :  87   Median : 1.00  
##  Mean   : 4.07   Mean   :  8.6   Mean   : 170   Mean   : 3.21  
##  3rd Qu.: 5.00   3rd Qu.:  9.0   3rd Qu.: 197   3rd Qu.: 3.00  
##  Max.   :71.00   Max.   :504.0   Max.   :1645   Max.   :85.00  
##                                                                
##    POPUnder18     POPOver65         SDNUM    
##  Min.   :   0   Min.   :  0.0   Min.   :  6  
##  1st Qu.:  95   1st Qu.:  3.0   1st Qu.:621  
##  Median : 154   Median :  7.0   Median :625  
##  Mean   : 297   Mean   : 15.2   Mean   :585  
##  3rd Qu.: 346   3rd Qu.: 16.0   3rd Qu.:720  
##  Max.   :2709   Max.   :438.0   Max.   :834  
##                                              
##                           SDNAME               ELEMENTARY   
##  St. Paul                    :4255   LIBERTY RIDGE  :  500  
##  South Washington County     :2969   HUGO & ONEKA   :  468  
##  North St. Paul-Maplewood    :1619   SUN PATH       :  386  
##  Shakopee                    :1367   LAKE ELMO      :  382  
##  Rosemount-Apple Valley-Eagan:1271   EAGLE CREEK    :  369  
##  Prior Lake-Savage           :1139   SHERIDAN & AMES:  341  
##  (Other)                     :6114   (Other)        :16288  
##                 MIDDLE                 HIGH       STATEFP10  COUNTYFP10
##  SHAKOPEE          : 1367   SHAKOPEE     : 1367   27:18734   003: 330  
##  BATTLE CREEK      : 1343   PRIOR LAKE   : 1139              037:3217  
##  TWIN & HIDDEN OAKS: 1139   NORTH & SOUTH: 1125              123:7125  
##  LAKE              :  927   WOODBURY     : 1033              139:2833  
##  WOODBURY          :  755   EAST RIDGE   : 1005              163:5229  
##  (Other)           :12970   NORTH        :  973                        
##  NA's              :  233   (Other)      :12092                        
##    TRACTCE10            NAME10        Block_Area        POP_Dense       
##  071018 :  724   Block 2000:  407   Min.   :   1900   Min.   :0.000000  
##  080302 :  447   Block 1000:  376   1st Qu.:  22000   1st Qu.:0.000889  
##  080301 :  377   Block 2006:  344   Median :  51000   Median :0.001678  
##  071017 :  299   Block 1008:  299   Mean   : 282176   Mean   :0.001921  
##  071206 :  299   Block 2001:  279   3rd Qu.: 200000   3rd Qu.:0.002584  
##  070203 :  277   Block 1001:  278   Max.   :6200000   Max.   :0.019298  
##  (Other):16311   (Other)   :16751                                       
##    fam_income       income_err      StPaulDist      MinneaDist   
##  Min.   : 15625   7118   :  724   Min.   : NA     Min.   : NA    
##  1st Qu.: 70288   5610   :  447   1st Qu.: NA     1st Qu.: NA    
##  Median : 87969   6132   :  377   Median : NA     Median : NA    
##  Mean   : 86765   19338  :  299   Mean   :NaN     Mean   :NaN    
##  3rd Qu.:104881   5732   :  299   3rd Qu.: NA     3rd Qu.: NA    
##  Max.   :160025   5979   :  277   Max.   : NA     Max.   : NA    
##                   (Other):16311   NA's   :18734   NA's   :18734  
```

```r
names(HouseData)
```

```
##  [1] "COUNTY_ID"  "PIN"        "CITY"       "ZIP4"       "LOT"       
##  [6] "ACRES_POLY" "ACRES_DEED" "USE1_DESC"  "HOMESTEAD"  "EMV_LAND"  
## [11] "EMV_BLDG"   "EMV_TOTAL"  "TAX_CAPAC"  "TOTAL_TAX"  "XUSE1_DESC"
## [16] "DWELL_TYPE" "HOME_STYLE" "FIN_SQ_FT"  "GARAGE"     "GARAGESQFT"
## [21] "BASEMENT"   "HEATING"    "COOLING"    "YEAR_BUILT" "NUM_UNITS" 
## [26] "SALE_DATE"  "SALE_VALUE" "SCHOOL_DST" "WSHD_DIST"  "MYPIN"     
## [31] "X_COORD"    "Y_COORD"    "REPLACEFID" "CITY_DUMMY" "GEOID10"   
## [36] "tenthkmSUM" "qtrkmSUM"   "halfkmSUM"  "onekmSUM"   "twokmSUM"  
## [41] "Census_POP" "WhiteDense" "White_POP"  "Amind_POP"  "Asian_POP" 
## [46] "Pacif_POP"  "Other_POP"  "Multi_POP"  "Hisp_POP"   "NotHis_POP"
## [51] "VACANT"     "POPUnder18" "POPOver65"  "SDNUM"      "SDNAME"    
## [56] "ELEMENTARY" "MIDDLE"     "HIGH"       "STATEFP10"  "COUNTYFP10"
## [61] "TRACTCE10"  "NAME10"     "Block_Area" "POP_Dense"  "fam_income"
## [66] "income_err" "StPaulDist" "MinneaDist"
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
##            SALE_VALUE tenthkmSUM qtrkmSUM halfkmSUM onekmSUM twokmSUM
## SALE_VALUE       1.00       0.10     0.14      0.17     0.16     0.15
## tenthkmSUM       0.10       1.00     0.79      0.59     0.40     0.31
## qtrkmSUM         0.14       0.79     1.00      0.83     0.59     0.45
## halfkmSUM        0.17       0.59     0.83      1.00     0.81     0.59
## onekmSUM         0.16       0.40     0.59      0.81     1.00     0.81
## twokmSUM         0.15       0.31     0.45      0.59     0.81     1.00
```


Our primary dependent variable has a skewed right distribution typical of house price distributions. A log-transformation results in an approximately normal-shaped distribution.

```r
par(mfrow = c(1, 2))
plot(density(HouseData$SALE_VALUE), ylab = "relative frequency")
plot(density(log(HouseData$SALE_VALUE)), ylab = "relative frequency")
curve(dnorm(x, mean = mean(log(HouseData$SALE_VALUE)), sd = sd(log(HouseData$SALE_VALUE))), 
    add = TRUE, col = "red")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 


The following graphs show the distributions of our five Open Space Index variables. Notice that the OSI values are less skewed for the larger OSI radii. That is, the distribution of the OSI values for the 2km radius is more symmetrical than the OSI values for the .1km radius.

```r
par(mfrow = c(2, 3))
for (myVar in whichVars[-1]) {
    plot(density(HouseData[, myVar]), ylab = "relative frequency", xlab = "", 
        main = names(HouseData)[myVar])
}
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 


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
StructuralModel1 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + YEAR_BUILT, 
    data = HouseData)
summary(StructuralModel1)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + 
##     YEAR_BUILT, data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -5.275 -0.184  0.049  0.257  2.777 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 1.63e+00   2.29e-01    7.13  1.1e-12 ***
## FIN_SQ_FT   3.68e-04   5.19e-06   70.88  < 2e-16 ***
## ACRES_POLY  4.98e-02   5.59e-03    8.91  < 2e-16 ***
## GARAGEsqft  4.59e-04   2.00e-05   22.91  < 2e-16 ***
## YEAR_BUILT  4.88e-03   1.18e-04   41.53  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.476 on 18001 degrees of freedom
##   (728 observations deleted due to missingness)
## Multiple R-squared: 0.441,	Adjusted R-squared: 0.441 
## F-statistic: 3.55e+03 on 4 and 18001 DF,  p-value: <2e-16 
## 
```


We now add fixed effects for the home's construction style to our regression equation in order to further explain another five percent of the variation in our logged sale price variable.

```r
options(width = 160)
StructuralModel2 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + YEAR_BUILT + 
    HOME_STYLE, data = HouseData)
summary(StructuralModel2)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + 
##     YEAR_BUILT + HOME_STYLE, data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -5.091 -0.159  0.037  0.218  2.842 
## 
## Coefficients:
##                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                 -3.18e-01   3.77e-01   -0.84  0.39918    
## FIN_SQ_FT                    3.40e-04   6.27e-06   54.26  < 2e-16 ***
## ACRES_POLY                   5.91e-02   5.47e-03   10.79  < 2e-16 ***
## GARAGEsqft                   2.27e-04   2.07e-05   10.93  < 2e-16 ***
## YEAR_BUILT                   5.82e-03   1.91e-04   30.54  < 2e-16 ***
## HOME_STYLE1 1/2 STRY         3.57e-01   1.25e-01    2.85  0.00431 ** 
## HOME_STYLE1-1/2 STRY         4.28e-01   1.06e-01    4.04  5.4e-05 ***
## HOME_STYLE1 1/4 STRY         3.55e-01   1.77e-01    2.01  0.04427 *  
## HOME_STYLE1-1/4 STRY         4.18e-01   9.93e-02    4.21  2.6e-05 ***
## HOME_STYLE1-2 STRY           5.78e-01   9.93e-02    5.82  6.0e-09 ***
## HOME_STYLE1 3/4 STRY         7.72e-01   1.60e-01    4.84  1.3e-06 ***
## HOME_STYLE1-3/4 STRY         5.25e-01   1.19e-01    4.41  1.0e-05 ***
## HOME_STYLE1 Story Brick      9.04e-01   4.64e-01    1.95  0.05108 .  
## HOME_STYLE1 Story Condo     -4.23e-01   1.08e-01   -3.90  9.7e-05 ***
## HOME_STYLE1 Story Frame      3.05e-01   9.23e-02    3.31  0.00095 ***
## HOME_STYLE1 Story Townhouse  2.63e-01   9.51e-02    2.77  0.00561 ** 
## HOME_STYLE2 Story Condo     -2.42e-01   9.80e-02   -2.47  0.01370 *  
## HOME_STYLE2 Story Frame      2.72e-01   9.22e-02    2.95  0.00321 ** 
## HOME_STYLE2 Story Townhouse -1.92e-01   9.34e-02   -2.06  0.03931 *  
## HOME_STYLE3-LVL SPLT         4.40e-01   1.05e-01    4.18  2.9e-05 ***
## HOME_STYLE4 LVL SPLT         4.53e-01   1.00e-01    4.50  6.7e-06 ***
## HOME_STYLEBungalow           2.63e-01   9.17e-02    2.86  0.00418 ** 
## HOME_STYLECONDO             -5.62e-01   1.15e-01   -4.87  1.1e-06 ***
## HOME_STYLEDUP/TRI            4.25e-01   2.78e-01    1.53  0.12590    
## HOME_STYLEEARTH SHEL         9.56e-02   4.64e-01    0.21  0.83684    
## HOME_STYLELOG               -9.68e-01   4.63e-01   -2.09  0.03668 *  
## HOME_STYLEMfd Home (Double) -4.22e-01   4.63e-01   -0.91  0.36283    
## HOME_STYLEN/A                5.95e-01   2.78e-01    2.14  0.03249 *  
## HOME_STYLEOne And 3/4 Story  1.10e-01   9.27e-02    1.18  0.23700    
## HOME_STYLEOne Story          2.27e-01   9.15e-02    2.48  0.01329 *  
## HOME_STYLEONE STORY          2.94e-01   9.25e-02    3.18  0.00150 ** 
## HOME_STYLEOther             -2.22e+00   4.63e-01   -4.80  1.6e-06 ***
## HOME_STYLERAMBLER            4.14e-01   9.43e-02    4.38  1.2e-05 ***
## HOME_STYLESalvage            2.03e-02   2.78e-01    0.07  0.94177    
## HOME_STYLESPLIT-ENT          3.06e-01   9.45e-02    3.23  0.00122 ** 
## HOME_STYLESplit/entry        1.40e-01   9.35e-02    1.49  0.13578    
## HOME_STYLESPLIT-FOY          3.54e-01   1.05e-01    3.36  0.00078 ***
## HOME_STYLESplit Foyer Frame  2.95e-01   9.30e-02    3.17  0.00152 ** 
## HOME_STYLESplit/level        3.00e-01   9.43e-02    3.18  0.00149 ** 
## HOME_STYLESplit Level Frame  3.86e-01   9.38e-02    4.12  3.8e-05 ***
## HOME_STYLESPLIT LEVL         2.55e-01   9.22e-02    2.76  0.00576 ** 
## HOME_STYLETOWNHOME           7.48e-02   9.33e-02    0.80  0.42264    
## HOME_STYLETWIN HOME          2.24e-01   1.05e-01    2.13  0.03351 *  
## HOME_STYLETwo Story          4.30e-01   9.20e-02    4.67  3.0e-06 ***
## HOME_STYLETWO STORY          3.88e-01   9.22e-02    4.21  2.6e-05 ***
## HOME_STYLETWO+ STORY        -3.76e-02   2.45e-01   -0.15  0.87805    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.454 on 17960 degrees of freedom
##   (728 observations deleted due to missingness)
## Multiple R-squared: 0.493,	Adjusted R-squared: 0.491 
## F-statistic:  387 on 45 and 17960 DF,  p-value: <2e-16 
## 
```


Additional structural variables, such as the presence and type of cooling system are not reported for some counties in our study area and prevent us from including them in our regressions. We will rerun our regressions in the subset of area with cooling data to test the robustness of our results in a later section.

```r
table(is.na(HouseData$COOLING), HouseData$COUNTY_ID)
```

```
##        
##          003  037  123  139  163
##   FALSE    0    0 7122    0 4999
##   TRUE   330 3217    3 2833  230
```


Adding Neighborhood Variables to the Regression
--------------

We now include a few of the most commonly used neighborhood characteristics in housing hedonic functions, namely



```r
neighborhoodModel1 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + YEAR_BUILT + HOME_STYLE + CITY + SCHOOL_DST + WhiteDense + fam_income, data = HouseData)
summary(neighborhoodModel1)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + 
##     YEAR_BUILT + HOME_STYLE + CITY + SCHOOL_DST + WhiteDense + 
##     fam_income, data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -4.767 -0.158  0.031  0.212  3.130 
## 
## Coefficients: (6 not defined because of singularities)
##                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                 -1.76e-01   4.38e-01   -0.40  0.68849    
## FIN_SQ_FT                    3.05e-04   7.13e-06   42.78  < 2e-16 ***
## ACRES_POLY                   4.71e-02   7.19e-03    6.56  5.7e-11 ***
## GARAGEsqft                   1.45e-04   2.06e-05    7.03  2.2e-12 ***
## YEAR_BUILT                   5.18e-03   2.00e-04   25.95  < 2e-16 ***
## HOME_STYLE1 1/2 STRY         5.56e-02   2.34e-01    0.24  0.81215    
## HOME_STYLE1-1/2 STRY         3.77e-01   2.24e-01    1.68  0.09298 .  
## HOME_STYLE1 1/4 STRY         2.47e-02   2.60e-01    0.10  0.92418    
## HOME_STYLE1-1/4 STRY         3.73e-01   2.23e-01    1.67  0.09443 .  
## HOME_STYLE1-2 STRY           9.78e-02   2.23e-01    0.44  0.66136    
## HOME_STYLE1 3/4 STRY         4.43e-01   2.49e-01    1.78  0.07535 .  
## HOME_STYLE1-3/4 STRY         4.68e-01   2.30e-01    2.04  0.04183 *  
## HOME_STYLE1 Story Brick      3.73e-01   4.36e-01    0.86  0.39232    
## HOME_STYLE1 Story Condo     -7.12e-01   1.67e-01   -4.26  2.0e-05 ***
## HOME_STYLE1 Story Frame      1.24e-01   1.56e-01    0.80  0.42600    
## HOME_STYLE1 Story Townhouse  1.72e-02   1.60e-01    0.11  0.91439    
## HOME_STYLE2 Story Condo     -6.42e-01   1.63e-01   -3.93  8.6e-05 ***
## HOME_STYLE2 Story Frame      5.80e-02   1.56e-01    0.37  0.70939    
## HOME_STYLE2 Story Townhouse -3.82e-01   1.56e-01   -2.44  0.01466 *  
## HOME_STYLE3-LVL SPLT         4.23e-02   2.26e-01    0.19  0.85147    
## HOME_STYLE4 LVL SPLT         2.54e-02   2.25e-01    0.11  0.90997    
## HOME_STYLEBungalow           2.20e-01   2.12e-01    1.04  0.29842    
## HOME_STYLECONDO             -9.63e-01   2.31e-01   -4.17  3.0e-05 ***
## HOME_STYLEDUP/TRI            4.83e-02   3.19e-01    0.15  0.87977    
## HOME_STYLEEARTH SHEL        -1.97e-01   4.57e-01   -0.43  0.66554    
## HOME_STYLELOG               -1.76e+00   4.73e-01   -3.72  0.00020 ***
## HOME_STYLEN/A                1.50e-01   3.19e-01    0.47  0.63833    
## HOME_STYLEOne And 3/4 Story  1.95e-01   2.12e-01    0.92  0.35711    
## HOME_STYLEOne Story          2.01e-01   2.12e-01    0.95  0.34266    
## HOME_STYLEONE STORY          2.91e-01   2.19e-01    1.33  0.18431    
## HOME_STYLEOther             -2.36e+00   4.51e-01   -5.24  1.6e-07 ***
## HOME_STYLERAMBLER            6.63e-03   2.22e-01    0.03  0.97616    
## HOME_STYLESalvage           -8.85e-01   4.28e-01   -2.06  0.03900 *  
## HOME_STYLESPLIT-ENT         -7.96e-03   2.22e-01   -0.04  0.97145    
## HOME_STYLESplit/entry        1.33e-01   2.12e-01    0.63  0.53063    
## HOME_STYLESPLIT-FOY          6.13e-03   2.26e-01    0.03  0.97832    
## HOME_STYLESplit Foyer Frame  1.08e-01   1.57e-01    0.69  0.49196    
## HOME_STYLESplit/level        2.22e-01   2.12e-01    1.04  0.29696    
## HOME_STYLESplit Level Frame  1.79e-01   1.57e-01    1.14  0.25361    
## HOME_STYLESPLIT LEVL         2.57e-01   2.20e-01    1.17  0.24174    
## HOME_STYLETOWNHOME          -3.13e-01   2.22e-01   -1.41  0.15828    
## HOME_STYLETWIN HOME         -9.64e-02   2.26e-01   -0.43  0.66966    
## HOME_STYLETwo Story          3.10e-01   2.12e-01    1.46  0.14318    
## HOME_STYLETWO STORY          2.23e-01   2.20e-01    1.02  0.30916    
## HOME_STYLETWO+ STORY         7.37e-02   2.97e-01    0.25  0.80402    
## CITYARDEN HILLS             -8.95e-02   9.63e-02   -0.93  0.35251    
## CITYBURNSVILLE               5.73e-02   3.72e-02    1.54  0.12367    
## CITYCASTLE ROCK TWP         -1.91e-02   4.06e-01   -0.05  0.96239    
## CITYCITY OF BIRCHWOOD        4.17e-01   2.62e-01    1.59  0.11103    
## CITYCITY OF COTTAGE GROVE    3.50e-01   1.88e-01    1.86  0.06276 .  
## CITYCITY OF DELLWOOD         1.22e-01   1.82e-01    0.67  0.50355    
## CITYCITY OF GRANT           -2.20e-01   2.04e-01   -1.08  0.28144    
## CITYCITY OF HUGO             2.56e-01   2.45e-01    1.04  0.29632    
## CITYCITY OF LAKE ELMO       -1.43e-01   8.42e-02   -1.70  0.08905 .  
## CITYCITY OF MAHTOMEDI        2.87e-01   1.68e-01    1.71  0.08696 .  
## CITYCITY OF OAKDALE         -1.96e-02   3.73e-02   -0.53  0.59893    
## CITYCITY OF PINE SPRINGS     2.32e-01   2.84e-01    0.82  0.41365    
## CITYCITY OF PRIOR LAKE       2.93e-01   5.69e-02    5.15  2.7e-07 ***
## CITYCITY OF SAVAGE           3.11e-01   5.15e-02    6.04  1.6e-09 ***
## CITYCITY OF SHAKOPEE         3.13e-01   7.25e-02    4.32  1.6e-05 ***
## CITYCITY OF WHITE BEAR LAKE  6.62e-02   2.23e-01    0.30  0.76684    
## CITYCITY OF WILLERNIE       -7.29e-02   2.43e-01   -0.30  0.76432    
## CITYCITY OF WOODBURY               NA         NA      NA       NA    
## CITYEAGAN                   -3.08e-02   2.70e-02   -1.14  0.25447    
## CITYEMPIRE TWP              -1.55e-01   1.06e-01   -1.47  0.14217    
## CITYFALCON HEIGHTS           2.42e-01   1.10e-01    2.21  0.02701 *  
## CITYFARMINGTON              -2.37e-01   7.09e-02   -3.35  0.00082 ***
## CITYGEM LAKE                 1.06e-01   1.67e-01    0.64  0.52450    
## CITYINVER GROVE HEIGHTS     -1.11e-01   6.26e-02   -1.77  0.07658 .  
## CITYLAKEVILLE               -1.01e-01   4.07e-02   -2.48  0.01306 *  
## CITYLAUDERDALE               3.34e-01   1.29e-01    2.60  0.00946 ** 
## CITYLITTLE CANADA            3.29e-02   1.01e-01    0.33  0.74470    
## CITYMAPLEWOOD                1.89e-01   1.03e-01    1.83  0.06778 .  
## CITYMENDOTA                 -1.47e-01   2.91e-01   -0.50  0.61433    
## CITYMENDOTA HEIGHTS         -1.16e-01   7.15e-02   -1.62  0.10531    
## CITYMOUNDS VIEW             -4.65e-02   9.32e-02   -0.50  0.61760    
## CITYNEW BRIGHTON             5.68e-02   9.06e-02    0.63  0.53040    
## CITYNORTH OAKS              -1.83e-01   9.36e-02   -1.96  0.05041 .  
## CITYNORTH SAINT PAUL         2.11e-01   1.09e-01    1.92  0.05444 .  
## CITYROSEMOUNT               -2.84e-02   3.39e-02   -0.84  0.40212    
## CITYROSEVILLE                1.21e-01   9.45e-02    1.28  0.20199    
## CITYSAINT ANTHONY            3.05e-01   2.51e-01    1.22  0.22358    
## CITYSAINT PAUL               2.35e-01   3.56e-02    6.61  4.1e-11 ***
## CITYSHOREVIEW               -8.65e-02   8.87e-02   -0.98  0.32937    
## CITYSOUTH ST PAUL            1.45e-01   7.30e-02    1.99  0.04644 *  
## CITYSPRING LAKE PARK        -7.31e-02   2.18e-01   -0.34  0.73712    
## CITYSUNFISH LAKE             5.88e-01   1.90e-01    3.09  0.00197 ** 
## CITYTOWN OF CREDIT RIVER     6.62e-01   1.37e-01    4.85  1.3e-06 ***
## CITYTOWN OF JACKSON          8.09e-01   4.06e-01    1.99  0.04609 *  
## CITYTOWN OF LOUISVILLE       5.83e-01   2.42e-01    2.41  0.01614 *  
## CITYTOWN OF SPRING LAKE      2.82e-01   9.42e-02    2.99  0.00278 ** 
## CITYVADNAIS HEIGHTS          4.00e-03   5.01e-02    0.08  0.93629    
## CITYWEST ST PAUL             1.62e-01   6.95e-02    2.34  0.01937 *  
## CITYWHITE BEAR LAKE          1.50e-01   4.02e-02    3.74  0.00019 ***
## CITYWHITE BEAR TOWNSHIP            NA         NA      NA       NA    
## SCHOOL_DST191                4.42e-02   5.42e-02    0.82  0.41491    
## SCHOOL_DST192                1.12e-01   8.84e-02    1.27  0.20532    
## SCHOOL_DST194               -8.81e-02   7.13e-02   -1.24  0.21634    
## SCHOOL_DST196               -7.00e-02   6.39e-02   -1.10  0.27315    
## SCHOOL_DST197                7.27e-02   8.42e-02    0.86  0.38780    
## SCHOOL_DST199                1.49e-01   9.37e-02    1.59  0.11222    
## SCHOOL_DST282                2.91e-01   1.98e-01    1.47  0.14087    
## SCHOOL_DST621                9.80e-02   7.96e-02    1.23  0.21822    
## SCHOOL_DST622               -9.96e-02   9.95e-02   -1.00  0.31709    
## SCHOOL_DST623                1.74e-01   8.81e-02    1.98  0.04816 *  
## SCHOOL_DST624                      NA         NA      NA       NA    
## SCHOOL_DST625                      NA         NA      NA       NA    
## SCHOOL_DST717               -9.65e-02   3.08e-01   -0.31  0.75388    
## SCHOOL_DST719                2.76e-02   5.22e-02    0.53  0.59645    
## SCHOOL_DST720                      NA         NA      NA       NA    
## SCHOOL_DSTISD622             2.18e-01   1.70e-01    1.28  0.19889    
## SCHOOL_DSTISD624            -1.43e-01   2.98e-01   -0.48  0.63268    
## SCHOOL_DSTISD831            -5.47e-01   3.21e-01   -1.70  0.08822 .  
## SCHOOL_DSTISD832            -1.38e-02   2.34e-01   -0.06  0.95282    
## SCHOOL_DSTISD833                   NA         NA      NA       NA    
## WhiteDense                   6.50e-01   2.18e-02   29.82  < 2e-16 ***
## fam_income                   8.02e-06   2.11e-07   38.03  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.4 on 14375 degrees of freedom
##   (4248 observations deleted due to missingness)
## Multiple R-squared: 0.626,	Adjusted R-squared: 0.624 
## F-statistic:  219 on 110 and 14375 DF,  p-value: <2e-16 
## 
```


Surprisingly, few of the city or school district fixed effects seem to statistically differ from zero. Let's try a smaller scale measure of location - the elementary school catchment basin. This model now describes about two-thirds of the variation in logged sale price.

```r
neighborhoodModel2 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income, data = HouseData)
summary(neighborhoodModel2)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + 
##     YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income, 
##     data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -4.897 -0.129  0.033  0.185  3.101 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                 -1.23e-01   3.73e-01   -0.33  0.74135    
## FIN_SQ_FT                                    2.96e-04   6.27e-06   47.26  < 2e-16 ***
## ACRES_POLY                                   4.45e-02   4.88e-03    9.12  < 2e-16 ***
## GARAGEsqft                                   1.79e-04   1.78e-05   10.05  < 2e-16 ***
## YEAR_BUILT                                   5.42e-03   1.86e-04   29.13  < 2e-16 ***
## HOME_STYLE1 1/2 STRY                         9.94e-02   1.20e-01    0.83  0.40648    
## HOME_STYLE1-1/2 STRY                         3.50e-01   1.04e-01    3.37  0.00074 ***
## HOME_STYLE1 1/4 STRY                         5.41e-02   1.61e-01    0.34  0.73656    
## HOME_STYLE1-1/4 STRY                         3.26e-01   9.94e-02    3.28  0.00104 ** 
## HOME_STYLE1-2 STRY                           1.52e-01   1.01e-01    1.51  0.13116    
## HOME_STYLE1 3/4 STRY                         4.68e-01   1.45e-01    3.22  0.00129 ** 
## HOME_STYLE1-3/4 STRY                         4.42e-01   1.13e-01    3.91  9.2e-05 ***
## HOME_STYLE1 Story Brick                      5.33e-01   3.85e-01    1.38  0.16623    
## HOME_STYLE1 Story Condo                     -5.20e-01   9.11e-02   -5.71  1.1e-08 ***
## HOME_STYLE1 Story Frame                      2.56e-01   7.71e-02    3.32  0.00091 ***
## HOME_STYLE1 Story Townhouse                  1.74e-01   7.97e-02    2.18  0.02924 *  
## HOME_STYLE2 Story Condo                     -3.44e-01   8.24e-02   -4.17  3.0e-05 ***
## HOME_STYLE2 Story Frame                      1.92e-01   7.73e-02    2.48  0.01299 *  
## HOME_STYLE2 Story Townhouse                 -2.30e-01   7.83e-02   -2.94  0.00332 ** 
## HOME_STYLE3-LVL SPLT                         5.13e-02   1.05e-01    0.49  0.62605    
## HOME_STYLE4 LVL SPLT                         5.43e-02   1.02e-01    0.53  0.59429    
## HOME_STYLEBungalow                           1.97e-01   8.57e-02    2.30  0.02170 *  
## HOME_STYLECONDO                             -9.27e-01   1.15e-01   -8.08  6.7e-16 ***
## HOME_STYLEDUP/TRI                            1.44e-01   2.38e-01    0.60  0.54704    
## HOME_STYLEEARTH SHEL                        -2.35e-01   3.89e-01   -0.60  0.54651    
## HOME_STYLELOG                               -1.40e+00   3.89e-01   -3.60  0.00032 ***
## HOME_STYLEMfd Home (Double)                 -2.25e-01   3.85e-01   -0.58  0.55922    
## HOME_STYLEN/A                                1.66e-01   2.38e-01    0.70  0.48599    
## HOME_STYLEOne And 3/4 Story                  1.90e-01   8.66e-02    2.19  0.02860 *  
## HOME_STYLEOne Story                          1.50e-01   8.54e-02    1.76  0.07878 .  
## HOME_STYLEONE STORY                          2.47e-01   9.41e-02    2.62  0.00875 ** 
## HOME_STYLEOther                             -2.44e+00   3.89e-01   -6.27  3.6e-10 ***
## HOME_STYLERAMBLER                            2.98e-02   9.78e-02    0.31  0.76032    
## HOME_STYLESalvage                           -3.97e-02   2.31e-01   -0.17  0.86349    
## HOME_STYLESPLIT-ENT                         -6.90e-03   9.79e-02   -0.07  0.94376    
## HOME_STYLESplit/entry                        8.31e-02   8.68e-02    0.96  0.33807    
## HOME_STYLESPLIT-FOY                          4.58e-02   1.05e-01    0.43  0.66382    
## HOME_STYLESplit Foyer Frame                  2.42e-01   7.80e-02    3.10  0.00191 ** 
## HOME_STYLESplit/level                        1.59e-01   8.74e-02    1.82  0.06944 .  
## HOME_STYLESplit Level Frame                  3.10e-01   7.87e-02    3.94  8.1e-05 ***
## HOME_STYLESPLIT LEVL                         2.21e-01   9.40e-02    2.35  0.01870 *  
## HOME_STYLETOWNHOME                          -3.06e-01   9.69e-02   -3.16  0.00158 ** 
## HOME_STYLETWIN HOME                         -1.24e-01   1.05e-01   -1.17  0.24104    
## HOME_STYLETwo Story                          2.39e-01   8.61e-02    2.78  0.00552 ** 
## HOME_STYLETWO STORY                          2.27e-01   9.44e-02    2.40  0.01639 *  
## HOME_STYLETWO+ STORY                         4.09e-02   2.12e-01    0.19  0.84711    
## ELEMENTARYAKIN ROAD                         -4.29e-02   7.53e-02   -0.57  0.56873    
## ELEMENTARYANDERSEN                           1.50e-01   8.42e-02    1.78  0.07559 .  
## ELEMENTARYANDERSON & WILDWOOD                2.20e-01   4.33e-02    5.09  3.5e-07 ***
## ELEMENTARYARMSTRONG                         -1.42e-02   4.65e-02   -0.30  0.76080    
## ELEMENTARYBAILEY                             1.49e-01   3.98e-02    3.73  0.00019 ***
## ELEMENTARYBATTLE CREEK                       3.35e-01   7.64e-02    4.39  1.1e-05 ***
## ELEMENTARYBEL AIR                            2.59e-01   6.15e-02    4.21  2.6e-05 ***
## ELEMENTARYBIRCH LAKE                         1.46e-01   6.83e-02    2.13  0.03288 *  
## ELEMENTARYBRIMHALL                           4.89e-01   6.15e-02    7.95  2.0e-15 ***
## ELEMENTARYBRUCE F. VENTO                    -2.36e-01   6.42e-02   -3.68  0.00024 ***
## ELEMENTARYCARVER                             4.30e-02   5.99e-02    0.72  0.47288    
## ELEMENTARYCASTLE                             1.09e-01   4.17e-02    2.61  0.00917 ** 
## ELEMENTARYCEDAR PARK                         1.25e-01   8.29e-02    1.51  0.13216    
## ELEMENTARYCENTRAL PARK                       3.05e-01   6.52e-02    4.68  2.8e-06 ***
## ELEMENTARYCHELSEA HEIGHTS                    3.28e-01   5.80e-02    5.66  1.5e-08 ***
## ELEMENTARYCHERRY VIEW                       -5.81e-02   8.17e-02   -0.71  0.47733    
## ELEMENTARYCHRISTINA HUDDLESTON              -3.85e-02   8.03e-02   -0.48  0.63173    
## ELEMENTARYCOMO PARK                          3.01e-01   6.17e-02    4.88  1.1e-06 ***
## ELEMENTARYCOTTAGE GROVE                      7.73e-02   4.55e-02    1.70  0.08954 .  
## ELEMENTARYCOWERN                             8.35e-02   5.35e-02    1.56  0.11870    
## ELEMENTARYCRESTVIEW                         -2.11e-02   4.91e-02   -0.43  0.66723    
## ELEMENTARYCRYSTAL LAKE                       4.03e-03   8.21e-02    0.05  0.96083    
## ELEMENTARYDAYTONS BLUFF                     -1.28e-01   6.04e-02   -2.12  0.03414 *  
## ELEMENTARYDEERWOOD                           6.37e-02   8.25e-02    0.77  0.43985    
## ELEMENTARYDIAMOND PATH                       9.49e-02   7.77e-02    1.22  0.22177    
## ELEMENTARYEAGLE CREEK                        4.12e-01   6.95e-02    5.93  3.0e-09 ***
## ELEMENTARYEAGLE POINT                        5.69e-02   4.76e-02    1.20  0.23146    
## ELEMENTARYEASTERN HEIGHTS                   -1.42e-03   5.91e-02   -0.02  0.98079    
## ELEMENTARYEASTVIEW                          -2.38e-03   8.74e-02   -0.03  0.97824    
## ELEMENTARYECHO PARK                          3.20e-02   7.63e-02    0.42  0.67494    
## ELEMENTARYEDGERTON                           3.21e-01   6.55e-02    4.90  9.6e-07 ***
## ELEMENTARYEDWARD NEILL                       7.98e-02   7.91e-02    1.01  0.31292    
## ELEMENTARYEMMET D. WILLIAMS                  3.21e-01   6.24e-02    5.14  2.8e-07 ***
## ELEMENTARYFALCON HEIGHTS                     3.87e-01   6.19e-02    6.25  4.2e-10 ***
## ELEMENTARYFARMINGTON                        -2.87e-02   7.88e-02   -0.36  0.71555    
## ELEMENTARYFARNSWORTH LOWER                   6.21e-04   6.13e-02    0.01  0.99191    
## ELEMENTARYFIVE HAWKS                         4.62e-01   7.25e-02    6.37  1.9e-10 ***
## ELEMENTARYFOREST VIEW & FOREST LAKE         -3.43e-01   1.48e-01   -2.32  0.02041 *  
## ELEMENTARYFRANKLIN MUSIC                     2.52e-01   1.63e-01    1.54  0.12368    
## ELEMENTARYFROST LAKE                         1.29e-01   6.62e-02    1.95  0.05167 .  
## ELEMENTARYGALTIER & MAXFIELD                 7.29e-02   5.87e-02    1.24  0.21450    
## ELEMENTARYGARLOUGH                           2.91e-01   8.36e-02    3.49  0.00049 ***
## ELEMENTARYGIDEON POND                        1.43e-01   8.58e-02    1.66  0.09612 .  
## ELEMENTARYGLACIER HILLS                      1.14e-01   8.76e-02    1.30  0.19196    
## ELEMENTARYGLENDALE                           4.15e-01   7.53e-02    5.51  3.5e-08 ***
## ELEMENTARYGRAINWOOD                          3.17e-01   7.48e-02    4.23  2.3e-05 ***
## ELEMENTARYGREENLEAF                         -1.70e-03   7.27e-02   -0.02  0.98131    
## ELEMENTARYGREY CLOUD                         5.00e-02   4.26e-02    1.17  0.24080    
## ELEMENTARYGROVELAND PARK                     6.59e-01   6.03e-02   10.93  < 2e-16 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  5.38e-01   5.98e-02    9.00  < 2e-16 ***
## ELEMENTARYHANCOCK                            3.28e-01   7.04e-02    4.66  3.2e-06 ***
## ELEMENTARYHARRIET BISHOP                     3.41e-01   7.87e-02    4.34  1.5e-05 ***
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -4.35e-03   5.72e-02   -0.08  0.93937    
## ELEMENTARYHIDDEN VALLEY                      4.05e-01   7.89e-02    5.13  2.9e-07 ***
## ELEMENTARYHIGHLAND                           5.66e-02   7.63e-02    0.74  0.45808    
## ELEMENTARYHIGHLAND PARK                      5.72e-01   5.96e-02    9.61  < 2e-16 ***
## ELEMENTARYHIGHWOOD HILLS                     1.66e-01   6.75e-02    2.47  0.01371 *  
## ELEMENTARYHILLSIDE                           5.59e-02   4.64e-02    1.20  0.22867    
## ELEMENTARYHILLTOP                            1.23e-01   7.70e-02    1.60  0.10926    
## ELEMENTARYHUGO & ONEKA                       2.66e-02   3.84e-02    0.69  0.48809    
## ELEMENTARYISLAND LAKE                        1.72e-01   6.13e-02    2.80  0.00511 ** 
## ELEMENTARYJACKSON                           -5.87e-01   7.29e-02   -8.06  8.0e-16 ***
## ELEMENTARYJEFFERS POND                       4.26e-01   7.25e-02    5.88  4.2e-09 ***
## ELEMENTARYJOHN F. KENNEDY                   -1.19e-02   1.14e-01   -0.10  0.91707    
## ELEMENTARYJOHNSON A+                        -2.69e-01   7.16e-02   -3.76  0.00017 ***
## ELEMENTARYJORDAN                             3.10e-01   2.86e-01    1.09  0.27725    
## ELEMENTARYKAPOSIA                            1.57e-01   7.49e-02    2.09  0.03659 *  
## ELEMENTARYLAKEAIRES                          3.07e-01   6.07e-02    5.05  4.4e-07 ***
## ELEMENTARYLAKE ELMO                          4.82e-02   3.84e-02    1.25  0.20974    
## ELEMENTARYLAKE MARION                        2.79e-02   9.51e-02    0.29  0.76905    
## ELEMENTARYLAKEVIEW                          -6.49e-02   7.67e-02   -0.85  0.39747    
## ELEMENTARYLIBERTY RIDGE                      1.58e-01   3.76e-02    4.20  2.7e-05 ***
## ELEMENTARYLINCOLN                            1.29e-01   6.26e-02    2.06  0.03941 *  
## ELEMENTARYLINO LAKES                        -4.10e-01   2.23e-01   -1.84  0.06590 .  
## ELEMENTARYLITTLE CANADA                      2.28e-01   6.82e-02    3.34  0.00084 ***
## ELEMENTARYMANN                               5.58e-01   5.83e-02    9.58  < 2e-16 ***
## ELEMENTARYMARION W. SAVAGE                   3.76e-01   7.47e-02    5.03  4.9e-07 ***
## ELEMENTARYMATOSKA INTERNATIONAL              2.81e-01   5.87e-02    4.79  1.7e-06 ***
## ELEMENTARYMEADOWVIEW                        -8.45e-02   7.95e-02   -1.06  0.28765    
## ELEMENTARYMENDOTA                            1.52e-01   7.91e-02    1.92  0.05488 .  
## ELEMENTARYMIDDLETON                          9.39e-02   4.11e-02    2.28  0.02247 *  
## ELEMENTARYMISSISSIPPI                        1.15e-01   7.48e-02    1.53  0.12487    
## ELEMENTARYMONROE                             7.86e-02   6.12e-02    1.28  0.19906    
## ELEMENTARYMORELAND                           2.14e-01   7.75e-02    2.75  0.00588 ** 
## ELEMENTARYNEWPORT                           -1.97e-02   4.95e-02   -0.40  0.69080    
## ELEMENTARYNORTH END                         -1.99e-01   6.14e-02   -3.24  0.00121 ** 
## ELEMENTARYNORTH TRAIL                        5.41e-02   8.29e-02    0.65  0.51446    
## ELEMENTARYNORTHVIEW                          1.70e-02   8.09e-02    0.21  0.83368    
## ELEMENTARYOAKDALE                            1.06e-02   4.27e-02    0.25  0.80411    
## ELEMENTARYOAK HILLS                         -8.73e-02   8.67e-02   -1.01  0.31399    
## ELEMENTARYOAK RIDGE                          1.41e-01   8.59e-02    1.64  0.10125    
## ELEMENTARYOBAMA                              6.49e-01   9.08e-02    7.14  9.4e-13 ***
## ELEMENTARYORCHARD LAKE                       1.46e-01   8.23e-02    1.77  0.07635 .  
## ELEMENTARYOTTER LAKE                         1.73e-01   7.05e-02    2.46  0.01388 *  
## ELEMENTARYPARKVIEW                           3.55e-02   8.04e-02    0.44  0.65880    
## ELEMENTARYPEARSON                            2.87e-01   7.30e-02    3.93  8.4e-05 ***
## ELEMENTARYPHALEN LAKE                       -1.52e-01   6.37e-02   -2.39  0.01684 *  
## ELEMENTARYPILOT KNOB                         1.63e-01   8.50e-02    1.92  0.05535 .  
## ELEMENTARYPINE BEND                          6.73e-02   8.62e-02    0.78  0.43523    
## ELEMENTARYPINE HILL                          4.21e-02   4.26e-02    0.99  0.32362    
## ELEMENTARYPINEWOOD                           3.46e-02   5.97e-02    0.58  0.56299    
## ELEMENTARYPULLMAN                           -5.33e-02   4.39e-02   -1.21  0.22493    
## ELEMENTARYRAHN                               1.74e-01   8.07e-02    2.15  0.03135 *  
## ELEMENTARYRANDOLPH HEIGHTS                   6.95e-01   5.90e-02   11.78  < 2e-16 ***
## ELEMENTARYRED OAK                            3.81e-01   7.30e-02    5.22  1.8e-07 ***
## ELEMENTARYRED PINE                           3.36e-02   7.76e-02    0.43  0.66522    
## ELEMENTARYRED ROCK                           7.28e-02   4.48e-02    1.63  0.10398    
## ELEMENTARYREDTAIL RIDGE                      4.41e-01   7.15e-02    6.18  6.7e-10 ***
## ELEMENTARYRICHARDSON                         1.93e-01   5.88e-02    3.28  0.00104 ** 
## ELEMENTARYRIVERVIEW                         -2.15e-02   7.72e-02   -0.28  0.78104    
## ELEMENTARYRIVERVIEW & CHEROKEE               1.47e-01   6.04e-02    2.44  0.01480 *  
## ELEMENTARYROSEMOUNT                          6.16e-02   8.15e-02    0.76  0.44959    
## ELEMENTARYROYAL OAKS                         8.49e-02   4.10e-02    2.07  0.03837 *  
## ELEMENTARYRUTHERFORD                        -2.30e-02   7.18e-02   -0.32  0.74825    
## ELEMENTARYSALEM HILLS                        6.84e-02   1.10e-01    0.62  0.53309    
## ELEMENTARYSHANNON PARK                      -2.53e-02   7.44e-02   -0.34  0.73406    
## ELEMENTARYSHERIDAN & AMES                    1.92e-02   5.77e-02    0.33  0.74000    
## ELEMENTARYSIOUX TRAIL                        1.20e-01   8.57e-02    1.40  0.16140    
## ELEMENTARYSKY OAKS                           7.91e-02   8.25e-02    0.96  0.33762    
## ELEMENTARYSKYVIEW                            7.02e-02   4.00e-02    1.76  0.07905 .  
## ELEMENTARYSOMERSET HEIGHTS                   2.15e-01   7.45e-02    2.88  0.00393 ** 
## ELEMENTARYSOUTHVIEW                          5.21e-02   7.63e-02    0.68  0.49493    
## ELEMENTARYST ANTHONY PARK                    7.60e-01   7.46e-02   10.19  < 2e-16 ***
## ELEMENTARYSUNNYSIDE                          1.61e-01   6.41e-02    2.52  0.01174 *  
## ELEMENTARYSUN PATH                           2.42e-01   7.04e-02    3.44  0.00058 ***
## ELEMENTARYSWEENEY                            2.43e-01   7.33e-02    3.32  0.00091 ***
## ELEMENTARYTHOMAS LAKE                        1.53e-02   8.14e-02    0.19  0.85068    
## ELEMENTARYTURTLE LAKE                        2.25e-01   5.75e-02    3.91  9.4e-05 ***
## ELEMENTARYVADNAIS HEIGHTS                    1.25e-01   6.54e-02    1.91  0.05607 .  
## ELEMENTARYVALENTINE HILLS                    2.75e-01   6.05e-02    4.54  5.7e-06 ***
## ELEMENTARYVISTA VIEW                         1.86e-01   7.99e-02    2.33  0.01989 *  
## ELEMENTARYWEAVER                             1.55e-01   5.90e-02    2.63  0.00857 ** 
## ELEMENTARYWEBSTER                            1.46e-01   6.71e-02    2.18  0.02939 *  
## ELEMENTARYWESTVIEW                           3.20e-02   7.83e-02    0.41  0.68295    
## ELEMENTARYWESTWOOD                           4.68e-01   7.52e-02    6.22  4.9e-10 ***
## ELEMENTARYWILLIAM BYRNE                      4.85e-02   8.19e-02    0.59  0.55362    
## ELEMENTARYWILLOW LANE                        1.22e-01   7.13e-02    1.71  0.08666 .  
## ELEMENTARYWILSHIRE PARK                      4.55e-01   1.21e-01    3.77  0.00016 ***
## ELEMENTARYWOODBURY                           1.44e-01   4.36e-02    3.31  0.00095 ***
## ELEMENTARYWOODLAND                           5.33e-02   8.07e-02    0.66  0.50881    
## WhiteDense                                   3.55e-01   2.09e-02   16.97  < 2e-16 ***
## fam_income                                   4.22e-06   2.20e-07   19.16  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.376 on 17818 degrees of freedom
##   (728 observations deleted due to missingness)
## Multiple R-squared: 0.654,	Adjusted R-squared: 0.651 
## F-statistic:  180 on 187 and 17818 DF,  p-value: <2e-16 
## 
```


Time
----
The years of 2009 - 2011 were different for the real estate market relative to the early years of the 2000s. We now incorporate fixed effects for the sale year and month of sale to limit the confounding effects of the changing real estate conditions.
* Here we should create a graph of sales price indices for the region (such as Case Schiller) and the nation.


```r
Model1 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH), 
    data = HouseData)
summary(Model1)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + 
##     YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + 
##     factor(SALE_YEAR) + factor(SALE_MONTH), data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -4.751 -0.129  0.031  0.183  3.160 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                 -3.17e-02   3.70e-01   -0.09  0.93159    
## FIN_SQ_FT                                    2.98e-04   6.21e-06   47.95  < 2e-16 ***
## ACRES_POLY                                   4.58e-02   4.83e-03    9.49  < 2e-16 ***
## GARAGEsqft                                   1.78e-04   1.76e-05   10.11  < 2e-16 ***
## YEAR_BUILT                                   5.38e-03   1.84e-04   29.17  < 2e-16 ***
## HOME_STYLE1 1/2 STRY                         9.14e-02   1.19e-01    0.77  0.44058    
## HOME_STYLE1-1/2 STRY                         3.34e-01   1.03e-01    3.25  0.00115 ** 
## HOME_STYLE1 1/4 STRY                         5.42e-02   1.59e-01    0.34  0.73356    
## HOME_STYLE1-1/4 STRY                         3.16e-01   9.84e-02    3.21  0.00133 ** 
## HOME_STYLE1-2 STRY                           1.44e-01   9.99e-02    1.44  0.14878    
## HOME_STYLE1 3/4 STRY                         4.66e-01   1.44e-01    3.24  0.00120 ** 
## HOME_STYLE1-3/4 STRY                         4.28e-01   1.12e-01    3.83  0.00013 ***
## HOME_STYLE1 Story Brick                      5.88e-01   3.81e-01    1.54  0.12295    
## HOME_STYLE1 Story Condo                     -5.26e-01   9.02e-02   -5.84  5.3e-09 ***
## HOME_STYLE1 Story Frame                      2.52e-01   7.63e-02    3.31  0.00095 ***
## HOME_STYLE1 Story Townhouse                  1.73e-01   7.89e-02    2.19  0.02865 *  
## HOME_STYLE2 Story Condo                     -3.45e-01   8.16e-02   -4.23  2.4e-05 ***
## HOME_STYLE2 Story Frame                      1.90e-01   7.65e-02    2.49  0.01295 *  
## HOME_STYLE2 Story Townhouse                 -2.23e-01   7.75e-02   -2.88  0.00404 ** 
## HOME_STYLE3-LVL SPLT                         4.12e-02   1.04e-01    0.40  0.69233    
## HOME_STYLE4 LVL SPLT                         4.17e-02   1.01e-01    0.41  0.67930    
## HOME_STYLEBungalow                           2.04e-01   8.48e-02    2.41  0.01610 *  
## HOME_STYLECONDO                             -9.28e-01   1.14e-01   -8.17  3.3e-16 ***
## HOME_STYLEDUP/TRI                            1.64e-01   2.36e-01    0.70  0.48612    
## HOME_STYLEEARTH SHEL                        -2.85e-01   3.85e-01   -0.74  0.45946    
## HOME_STYLELOG                               -1.38e+00   3.85e-01   -3.57  0.00035 ***
## HOME_STYLEMfd Home (Double)                 -2.31e-01   3.81e-01   -0.61  0.54340    
## HOME_STYLEN/A                                1.26e-01   2.36e-01    0.53  0.59315    
## HOME_STYLEOne And 3/4 Story                  1.98e-01   8.57e-02    2.31  0.02115 *  
## HOME_STYLEOne Story                          1.58e-01   8.46e-02    1.86  0.06238 .  
## HOME_STYLEONE STORY                          2.38e-01   9.32e-02    2.55  0.01084 *  
## HOME_STYLEOther                             -2.44e+00   3.85e-01   -6.34  2.4e-10 ***
## HOME_STYLERAMBLER                            2.18e-02   9.68e-02    0.23  0.82189    
## HOME_STYLESalvage                           -2.06e-02   2.28e-01   -0.09  0.92828    
## HOME_STYLESPLIT-ENT                         -1.45e-02   9.69e-02   -0.15  0.88133    
## HOME_STYLESplit/entry                        9.69e-02   8.59e-02    1.13  0.25914    
## HOME_STYLESPLIT-FOY                          4.03e-02   1.04e-01    0.39  0.69948    
## HOME_STYLESplit Foyer Frame                  2.43e-01   7.72e-02    3.15  0.00163 ** 
## HOME_STYLESplit/level                        1.68e-01   8.66e-02    1.94  0.05286 .  
## HOME_STYLESplit Level Frame                  3.12e-01   7.79e-02    4.01  6.1e-05 ***
## HOME_STYLESPLIT LEVL                         2.14e-01   9.31e-02    2.30  0.02166 *  
## HOME_STYLETOWNHOME                          -3.11e-01   9.60e-02   -3.24  0.00119 ** 
## HOME_STYLETWIN HOME                         -1.29e-01   1.04e-01   -1.24  0.21549    
## HOME_STYLETwo Story                          2.45e-01   8.52e-02    2.88  0.00397 ** 
## HOME_STYLETWO STORY                          2.21e-01   9.35e-02    2.37  0.01791 *  
## HOME_STYLETWO+ STORY                         2.43e-02   2.10e-01    0.12  0.90784    
## ELEMENTARYAKIN ROAD                         -4.88e-02   7.45e-02   -0.65  0.51281    
## ELEMENTARYANDERSEN                           1.24e-01   8.34e-02    1.49  0.13734    
## ELEMENTARYANDERSON & WILDWOOD                2.25e-01   4.28e-02    5.25  1.6e-07 ***
## ELEMENTARYARMSTRONG                         -1.83e-03   4.61e-02   -0.04  0.96841    
## ELEMENTARYBAILEY                             1.56e-01   3.95e-02    3.95  7.8e-05 ***
## ELEMENTARYBATTLE CREEK                       3.24e-01   7.56e-02    4.29  1.8e-05 ***
## ELEMENTARYBEL AIR                            2.65e-01   6.09e-02    4.36  1.3e-05 ***
## ELEMENTARYBIRCH LAKE                         1.43e-01   6.76e-02    2.12  0.03423 *  
## ELEMENTARYBRIMHALL                           4.77e-01   6.09e-02    7.84  4.7e-15 ***
## ELEMENTARYBRUCE F. VENTO                    -2.34e-01   6.36e-02   -3.68  0.00023 ***
## ELEMENTARYCARVER                             3.44e-02   5.93e-02    0.58  0.56213    
## ELEMENTARYCASTLE                             1.17e-01   4.14e-02    2.82  0.00485 ** 
## ELEMENTARYCEDAR PARK                         1.15e-01   8.21e-02    1.40  0.16163    
## ELEMENTARYCENTRAL PARK                       3.01e-01   6.45e-02    4.66  3.1e-06 ***
## ELEMENTARYCHELSEA HEIGHTS                    3.25e-01   5.74e-02    5.65  1.6e-08 ***
## ELEMENTARYCHERRY VIEW                       -7.13e-02   8.10e-02   -0.88  0.37819    
## ELEMENTARYCHRISTINA HUDDLESTON              -4.93e-02   7.95e-02   -0.62  0.53503    
## ELEMENTARYCOMO PARK                          2.84e-01   6.11e-02    4.64  3.5e-06 ***
## ELEMENTARYCOTTAGE GROVE                      7.73e-02   4.51e-02    1.72  0.08616 .  
## ELEMENTARYCOWERN                             8.14e-02   5.30e-02    1.54  0.12430    
## ELEMENTARYCRESTVIEW                         -1.29e-02   4.86e-02   -0.27  0.79040    
## ELEMENTARYCRYSTAL LAKE                      -6.21e-03   8.13e-02   -0.08  0.93912    
## ELEMENTARYDAYTONS BLUFF                     -1.43e-01   5.98e-02   -2.40  0.01649 *  
## ELEMENTARYDEERWOOD                           5.93e-02   8.17e-02    0.73  0.46745    
## ELEMENTARYDIAMOND PATH                       9.54e-02   7.69e-02    1.24  0.21482    
## ELEMENTARYEAGLE CREEK                        4.04e-01   6.88e-02    5.87  4.5e-09 ***
## ELEMENTARYEAGLE POINT                        5.73e-02   4.71e-02    1.22  0.22356    
## ELEMENTARYEASTERN HEIGHTS                    2.78e-03   5.85e-02    0.05  0.96211    
## ELEMENTARYEASTVIEW                           4.94e-03   8.65e-02    0.06  0.95440    
## ELEMENTARYECHO PARK                          2.75e-02   7.56e-02    0.36  0.71622    
## ELEMENTARYEDGERTON                           3.10e-01   6.48e-02    4.78  1.7e-06 ***
## ELEMENTARYEDWARD NEILL                       7.23e-02   7.83e-02    0.92  0.35615    
## ELEMENTARYEMMET D. WILLIAMS                  3.16e-01   6.18e-02    5.11  3.2e-07 ***
## ELEMENTARYFALCON HEIGHTS                     3.88e-01   6.13e-02    6.33  2.5e-10 ***
## ELEMENTARYFARMINGTON                        -3.17e-02   7.80e-02   -0.41  0.68412    
## ELEMENTARYFARNSWORTH LOWER                  -1.70e-03   6.07e-02   -0.03  0.97769    
## ELEMENTARYFIVE HAWKS                         4.53e-01   7.18e-02    6.31  2.9e-10 ***
## ELEMENTARYFOREST VIEW & FOREST LAKE         -3.87e-01   1.46e-01   -2.65  0.00816 ** 
## ELEMENTARYFRANKLIN MUSIC                     2.36e-01   1.62e-01    1.46  0.14402    
## ELEMENTARYFROST LAKE                         1.22e-01   6.56e-02    1.87  0.06180 .  
## ELEMENTARYGALTIER & MAXFIELD                 6.24e-02   5.81e-02    1.07  0.28354    
## ELEMENTARYGARLOUGH                           2.96e-01   8.28e-02    3.58  0.00034 ***
## ELEMENTARYGIDEON POND                        1.41e-01   8.49e-02    1.66  0.09755 .  
## ELEMENTARYGLACIER HILLS                      1.04e-01   8.67e-02    1.20  0.23056    
## ELEMENTARYGLENDALE                           4.00e-01   7.45e-02    5.37  8.1e-08 ***
## ELEMENTARYGRAINWOOD                          3.02e-01   7.41e-02    4.07  4.7e-05 ***
## ELEMENTARYGREENLEAF                         -1.21e-02   7.20e-02   -0.17  0.86654    
## ELEMENTARYGREY CLOUD                         5.40e-02   4.22e-02    1.28  0.20040    
## ELEMENTARYGROVELAND PARK                     6.51e-01   5.97e-02   10.91  < 2e-16 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  5.22e-01   5.93e-02    8.81  < 2e-16 ***
## ELEMENTARYHANCOCK                            3.05e-01   6.97e-02    4.38  1.2e-05 ***
## ELEMENTARYHARRIET BISHOP                     3.33e-01   7.79e-02    4.27  2.0e-05 ***
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -8.43e-03   5.66e-02   -0.15  0.88158    
## ELEMENTARYHIDDEN VALLEY                      3.96e-01   7.81e-02    5.06  4.1e-07 ***
## ELEMENTARYHIGHLAND                           4.85e-02   7.56e-02    0.64  0.52096    
## ELEMENTARYHIGHLAND PARK                      5.66e-01   5.90e-02    9.60  < 2e-16 ***
## ELEMENTARYHIGHWOOD HILLS                     1.86e-01   6.68e-02    2.78  0.00541 ** 
## ELEMENTARYHILLSIDE                           5.97e-02   4.60e-02    1.30  0.19424    
## ELEMENTARYHILLTOP                            1.23e-01   7.63e-02    1.61  0.10761    
## ELEMENTARYHUGO & ONEKA                       3.23e-02   3.80e-02    0.85  0.39516    
## ELEMENTARYISLAND LAKE                        1.59e-01   6.07e-02    2.62  0.00872 ** 
## ELEMENTARYJACKSON                           -6.06e-01   7.22e-02   -8.39  < 2e-16 ***
## ELEMENTARYJEFFERS POND                       4.17e-01   7.18e-02    5.82  6.1e-09 ***
## ELEMENTARYJOHN F. KENNEDY                   -2.44e-02   1.13e-01   -0.22  0.82900    
## ELEMENTARYJOHNSON A+                        -2.82e-01   7.09e-02   -3.98  6.8e-05 ***
## ELEMENTARYJORDAN                             2.75e-01   2.83e-01    0.97  0.33112    
## ELEMENTARYKAPOSIA                            1.50e-01   7.42e-02    2.02  0.04317 *  
## ELEMENTARYLAKEAIRES                          3.00e-01   6.01e-02    4.99  6.1e-07 ***
## ELEMENTARYLAKE ELMO                          5.64e-02   3.80e-02    1.48  0.13820    
## ELEMENTARYLAKE MARION                        1.79e-02   9.41e-02    0.19  0.84891    
## ELEMENTARYLAKEVIEW                          -6.30e-02   7.59e-02   -0.83  0.40678    
## ELEMENTARYLIBERTY RIDGE                      1.67e-01   3.73e-02    4.47  7.7e-06 ***
## ELEMENTARYLINCOLN                            1.25e-01   6.20e-02    2.02  0.04361 *  
## ELEMENTARYLINO LAKES                        -4.28e-01   2.20e-01   -1.94  0.05218 .  
## ELEMENTARYLITTLE CANADA                      2.25e-01   6.76e-02    3.33  0.00086 ***
## ELEMENTARYMANN                               5.47e-01   5.77e-02    9.47  < 2e-16 ***
## ELEMENTARYMARION W. SAVAGE                   3.62e-01   7.39e-02    4.90  9.5e-07 ***
## ELEMENTARYMATOSKA INTERNATIONAL              2.82e-01   5.81e-02    4.86  1.2e-06 ***
## ELEMENTARYMEADOWVIEW                        -8.57e-02   7.87e-02   -1.09  0.27616    
## ELEMENTARYMENDOTA                            1.40e-01   7.83e-02    1.79  0.07316 .  
## ELEMENTARYMIDDLETON                          1.02e-01   4.08e-02    2.49  0.01274 *  
## ELEMENTARYMISSISSIPPI                        1.09e-01   7.40e-02    1.47  0.14068    
## ELEMENTARYMONROE                             7.09e-02   6.06e-02    1.17  0.24219    
## ELEMENTARYMORELAND                           2.04e-01   7.68e-02    2.65  0.00797 ** 
## ELEMENTARYNEWPORT                           -2.61e-03   4.90e-02   -0.05  0.95762    
## ELEMENTARYNORTH END                         -2.03e-01   6.08e-02   -3.34  0.00083 ***
## ELEMENTARYNORTH TRAIL                        5.08e-02   8.21e-02    0.62  0.53649    
## ELEMENTARYNORTHVIEW                          7.97e-03   8.01e-02    0.10  0.92072    
## ELEMENTARYOAKDALE                            1.35e-02   4.23e-02    0.32  0.75011    
## ELEMENTARYOAK HILLS                         -8.67e-02   8.59e-02   -1.01  0.31278    
## ELEMENTARYOAK RIDGE                          1.33e-01   8.51e-02    1.56  0.11814    
## ELEMENTARYOBAMA                              6.55e-01   8.99e-02    7.29  3.2e-13 ***
## ELEMENTARYORCHARD LAKE                       1.39e-01   8.15e-02    1.70  0.08843 .  
## ELEMENTARYOTTER LAKE                         1.68e-01   6.98e-02    2.41  0.01605 *  
## ELEMENTARYPARKVIEW                           2.51e-02   7.96e-02    0.31  0.75282    
## ELEMENTARYPEARSON                            2.77e-01   7.22e-02    3.84  0.00012 ***
## ELEMENTARYPHALEN LAKE                       -1.60e-01   6.31e-02   -2.54  0.01104 *  
## ELEMENTARYPILOT KNOB                         1.59e-01   8.41e-02    1.89  0.05827 .  
## ELEMENTARYPINE BEND                          5.89e-02   8.53e-02    0.69  0.49022    
## ELEMENTARYPINE HILL                          4.56e-02   4.22e-02    1.08  0.28028    
## ELEMENTARYPINEWOOD                           3.84e-02   5.92e-02    0.65  0.51649    
## ELEMENTARYPULLMAN                           -4.69e-02   4.35e-02   -1.08  0.28042    
## ELEMENTARYRAHN                               1.61e-01   7.99e-02    2.02  0.04329 *  
## ELEMENTARYRANDOLPH HEIGHTS                   6.81e-01   5.84e-02   11.65  < 2e-16 ***
## ELEMENTARYRED OAK                            3.72e-01   7.23e-02    5.15  2.7e-07 ***
## ELEMENTARYRED PINE                           2.20e-02   7.68e-02    0.29  0.77468    
## ELEMENTARYRED ROCK                           8.19e-02   4.44e-02    1.85  0.06478 .  
## ELEMENTARYREDTAIL RIDGE                      4.32e-01   7.08e-02    6.10  1.1e-09 ***
## ELEMENTARYRICHARDSON                         1.92e-01   5.83e-02    3.29  0.00099 ***
## ELEMENTARYRIVERVIEW                         -3.01e-02   7.64e-02   -0.39  0.69351    
## ELEMENTARYRIVERVIEW & CHEROKEE               1.41e-01   5.98e-02    2.36  0.01820 *  
## ELEMENTARYROSEMOUNT                          4.49e-02   8.07e-02    0.56  0.57809    
## ELEMENTARYROYAL OAKS                         8.35e-02   4.06e-02    2.06  0.03979 *  
## ELEMENTARYRUTHERFORD                        -8.81e-03   7.11e-02   -0.12  0.90141    
## ELEMENTARYSALEM HILLS                        9.12e-02   1.09e-01    0.84  0.40117    
## ELEMENTARYSHANNON PARK                      -3.06e-02   7.36e-02   -0.42  0.67729    
## ELEMENTARYSHERIDAN & AMES                    1.78e-02   5.72e-02    0.31  0.75501    
## ELEMENTARYSIOUX TRAIL                        1.09e-01   8.48e-02    1.29  0.19799    
## ELEMENTARYSKY OAKS                           7.79e-02   8.16e-02    0.95  0.33984    
## ELEMENTARYSKYVIEW                            7.99e-02   3.96e-02    2.02  0.04386 *  
## ELEMENTARYSOMERSET HEIGHTS                   2.09e-01   7.38e-02    2.84  0.00456 ** 
## ELEMENTARYSOUTHVIEW                          4.14e-02   7.55e-02    0.55  0.58389    
## ELEMENTARYST ANTHONY PARK                    7.35e-01   7.39e-02    9.95  < 2e-16 ***
## ELEMENTARYSUNNYSIDE                          1.55e-01   6.35e-02    2.44  0.01483 *  
## ELEMENTARYSUN PATH                           2.32e-01   6.98e-02    3.33  0.00088 ***
## ELEMENTARYSWEENEY                            2.29e-01   7.26e-02    3.15  0.00161 ** 
## ELEMENTARYTHOMAS LAKE                        4.21e-03   8.06e-02    0.05  0.95832    
## ELEMENTARYTURTLE LAKE                        2.17e-01   5.70e-02    3.81  0.00014 ***
## ELEMENTARYVADNAIS HEIGHTS                    1.14e-01   6.47e-02    1.76  0.07833 .  
## ELEMENTARYVALENTINE HILLS                    2.66e-01   5.99e-02    4.44  9.1e-06 ***
## ELEMENTARYVISTA VIEW                         1.77e-01   7.91e-02    2.24  0.02515 *  
## ELEMENTARYWEAVER                             1.46e-01   5.84e-02    2.49  0.01272 *  
## ELEMENTARYWEBSTER                            1.46e-01   6.65e-02    2.20  0.02763 *  
## ELEMENTARYWESTVIEW                           3.76e-02   7.75e-02    0.49  0.62762    
## ELEMENTARYWESTWOOD                           4.55e-01   7.44e-02    6.11  1.0e-09 ***
## ELEMENTARYWILLIAM BYRNE                      4.29e-02   8.11e-02    0.53  0.59681    
## ELEMENTARYWILLOW LANE                        1.27e-01   7.07e-02    1.80  0.07265 .  
## ELEMENTARYWILSHIRE PARK                      4.27e-01   1.19e-01    3.58  0.00035 ***
## ELEMENTARYWOODBURY                           1.53e-01   4.32e-02    3.54  0.00040 ***
## ELEMENTARYWOODLAND                           4.89e-02   7.99e-02    0.61  0.54042    
## WhiteDense                                   3.56e-01   2.07e-02   17.18  < 2e-16 ***
## fam_income                                   4.21e-06   2.18e-07   19.32  < 2e-16 ***
## factor(SALE_YEAR)2010                       -2.42e-02   5.96e-03   -4.06  4.9e-05 ***
## factor(SALE_YEAR)2011                       -1.67e-01   1.19e-02  -14.07  < 2e-16 ***
## factor(SALE_MONTH)2                         -1.49e-02   1.57e-02   -0.95  0.34305    
## factor(SALE_MONTH)3                          8.19e-03   1.47e-02    0.56  0.57644    
## factor(SALE_MONTH)4                          6.23e-03   1.44e-02    0.43  0.66470    
## factor(SALE_MONTH)5                          5.63e-02   1.44e-02    3.90  9.5e-05 ***
## factor(SALE_MONTH)6                          5.35e-02   1.44e-02    3.71  0.00020 ***
## factor(SALE_MONTH)7                          4.53e-02   1.51e-02    3.01  0.00262 ** 
## factor(SALE_MONTH)8                          2.96e-02   1.52e-02    1.94  0.05202 .  
## factor(SALE_MONTH)9                          1.63e-02   1.54e-02    1.05  0.29232    
## factor(SALE_MONTH)10                         5.73e-02   1.52e-02    3.78  0.00016 ***
## factor(SALE_MONTH)11                         3.38e-02   1.56e-02    2.16  0.03058 *  
## factor(SALE_MONTH)12                        -3.75e-02   1.67e-02   -2.24  0.02502 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.372 on 17805 degrees of freedom
##   (728 observations deleted due to missingness)
## Multiple R-squared: 0.662,	Adjusted R-squared: 0.658 
## F-statistic:  174 on 200 and 17805 DF,  p-value: <2e-16 
## 
```


