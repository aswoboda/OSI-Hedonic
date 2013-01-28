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



```r
options(width = 160)
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
##  COUNTY_ID                 PIN                           CITY           ZIP4            LOT         ACRES_POLY       ACRES_DEED    
##  003: 330   139-252310100    :    2   SAINT PAUL           :4255   1613   :   12   1      : 769   Min.   : 0.000   Min.   : 0.000  
##  037:3217   163-1202721230021:    2   CITY OF WOODBURY     :2255   2329   :   10   2      : 754   1st Qu.: 0.140   1st Qu.: 0.000  
##  123:7125   163-1802821340123:    2   CITY OF SHAKOPEE     :1314   3918   :   10   3      : 733   Median : 0.240   Median : 0.000  
##  139:2833   163-2003021320031:    2   CITY OF COTTAGE GROVE:1001   4820   :   10   4      : 647   Mean   : 0.375   Mean   : 0.155  
##  163:5229   163-2402722440001:    2   CITY OF OAKDALE      : 800   1409   :    9   5      : 601   3rd Qu.: 0.330   3rd Qu.: 0.150  
##             163-3003021240080:    2   CITY OF SAVAGE       : 767   (Other): 7350   (Other):9168   Max.   :29.460   Max.   :30.000  
##             (Other)          :18722   (Other)              :8342   NA's   :11333   NA's   :6062                                    
##                                USE1_DESC    HOMESTEAD    EMV_LAND          EMV_BLDG         EMV_TOTAL         TAX_CAPAC       TOTAL_TAX    
##  100 Res 1 unit                     :8062   N: 3019   Min.   :   9000   Min.   :      0   Min.   :      0   Min.   :    0   Min.   :    0  
##  RESIDENTIAL                        :3217   P:   51   1st Qu.:  43000   1st Qu.: 102000   1st Qu.: 155700   1st Qu.:    0   1st Qu.:    0  
##  RESIDENTIAL SINGLE FAMILY          : 330   Y:15664   Median :  67000   Median : 129600   Median : 197100   Median :    0   Median : 1722  
##  Single Family Dwelling, Platted Lot:7125             Mean   :  73619   Mean   : 154234   Mean   : 227850   Mean   :  466   Mean   : 1642  
##                                                       3rd Qu.:  86000   3rd Qu.: 182100   3rd Qu.: 265900   3rd Qu.:    0   3rd Qu.: 2618  
##                                                       Max.   :1750600   Max.   :1180100   Max.   :2600600   Max.   :17711   Max.   :35214  
##                                                                                                                                            
##                      XUSE1_DESC                             DWELL_TYPE           HOME_STYLE     FIN_SQ_FT      GARAGE         GARAGESQFT    BASEMENT    
##  Church-Other Res         :    1   SINGLE FAMILY DWELLING        :7125   One Story    :2640   Min.   :  424   N   :   10   440     : 1301   N   :   81  
##  Church-Residence         :    1   Single-Family / Owner Occupied:3713   Bungalow     :1795   1st Qu.: 1091   Y   :12674   484     :  774   Y   :12603  
##  Muni Srvc Other          :    4   S.FAM.RES                     :3217   2 Story Frame:1663   Median : 1425   NA's: 6050   528     :  748   NA's: 6050  
##  RESIDENTIAL SINGLE FAMILY:    2   Townhouse                     :1265   TWO STORY    :1499   Mean   : 1645                440.0000:  639               
##  Schools-Priv Res         :    1   RESIDENTIAL SINGLE FAMILY     : 330   SPLIT LEVL   :1294   3rd Qu.: 1976                576     :  564               
##  NA's                     :18725   (Other)                       : 251   Two Story    :1117   Max.   :13426                (Other) :13980               
##                                    NA's                          :2833   (Other)      :8726                                NA's    :  728               
##       HEATING                   COOLING       YEAR_BUILT   NUM_UNITS      SALE_DATE            SALE_VALUE        SCHOOL_DST                 WSHD_DIST   
##  FA Gas   :4030   CENTRAL           :2220   Min.   :1840   0   :  353   Min.   :2009-01-01   Min.   :   1000   625    :4255   WS SOUTH WASHINGTON:3100  
##  HOT AIR  :3276   CENTRAL W/AIR COND:4834   1st Qu.:1955   1   :15542   1st Qu.:2009-07-28   1st Qu.: 135502   720    :1368   Capital Region W/S :2931  
##  Yes      :1150   NON CENTRAL       :  66   Median :1981   2   :    6   Median :2010-01-07   Median : 191900   196    :1271   Metro Watershed    :2266  
##  HOT WATER: 830   NONE              :   2   Mean   :1972   NA's: 2833   Mean   :2010-01-29   Mean   : 218015   719    :1139   VERMILLION RIVER   :1347  
##  Oil F.A. :  32   Y                 :4999   3rd Qu.:1999                3rd Qu.:2010-07-11   3rd Qu.: 265000   ISD622 : 981   Rice Creek W/S     :1083  
##  (Other)  :  28   NA's              :6613   Max.   :2011                Max.   :2011-12-08   Max.   :5783200   (Other):6200   (Other)            :4322  
##  NA's     :9388                                                                                                NA's   :3520   NA's               :3685  
##      MYPIN          X_COORD          Y_COORD         REPLACEFID      CITY_DUMMY              GEOID10        tenthkmSUM         qtrkmSUM      
##  Min.   :    0   Min.   :453873   Min.   :453873   Min.   :    0   Min.   : 1.0   271390803011036:  125   Min.   :      0   Min.   :      0  
##  1st Qu.: 4689   1st Qu.:484039   1st Qu.:484039   1st Qu.: 4686   1st Qu.:21.0   271630710181000:   86   1st Qu.:  38184   1st Qu.: 416184  
##  Median : 9372   Median :492081   Median :492081   Median : 9370   Median :29.0   271630702031040:   59   Median :  81000   Median : 603698  
##  Mean   : 9371   Mean   :490259   Mean   :490259   Mean   : 9368   Mean   :35.4   271390809042006:   58   Mean   :  95827   Mean   : 732594  
##  3rd Qu.:14056   3rd Qu.:501074   3rd Qu.:501074   3rd Qu.:14053   3rd Qu.:56.0   271390807001019:   55   3rd Qu.: 119184   3rd Qu.: 869130  
##  Max.   :18739   Max.   :515822   Max.   :515822   Max.   :18733   Max.   :70.0   271390807001008:   52   Max.   :1347100   Max.   :7589400  
##                                                                                   (Other)        :18299                                      
##    halfkmSUM           onekmSUM           twokmSUM          Census_POP     WhiteDense      White_POP      Amind_POP      Asian_POP     Pacif_POP     
##  Min.   :       0   Min.   :0.00e+00   Min.   :0.00e+00   Min.   :   0   Min.   :0.000   Min.   :   0   Min.   : 0.0   Min.   :  0   Min.   : 0.000  
##  1st Qu.: 2156065   1st Qu.:1.12e+07   1st Qu.:5.74e+07   1st Qu.:  57   1st Qu.:0.701   1st Qu.:  39   1st Qu.: 0.0   1st Qu.:  1   1st Qu.: 0.000  
##  Median : 3054725   Median :1.58e+07   Median :8.44e+07   Median :  92   Median :0.840   Median :  70   Median : 0.0   Median :  6   Median : 0.000  
##  Mean   : 3661434   Mean   :1.90e+07   Mean   :9.83e+07   Mean   : 178   Mean   :0.779   Mean   : 138   Mean   : 0.8   Mean   : 17   Mean   : 0.057  
##  3rd Qu.: 4490825   3rd Qu.:2.41e+07   3rd Qu.:1.29e+08   3rd Qu.: 205   3rd Qu.:0.919   3rd Qu.: 165   3rd Qu.: 1.0   3rd Qu.: 18   3rd Qu.: 0.000  
##  Max.   :24899800   Max.   :1.21e+08   Max.   :4.81e+08   Max.   :1681   Max.   :1.000   Max.   :1394   Max.   :82.0   Max.   :484   Max.   :23.000  
##                                                                                                                                                      
##    Other_POP        Multi_POP        Hisp_POP       NotHis_POP       VACANT        POPUnder18     POPOver65         SDNUM    
##  Min.   : 0.000   Min.   : 0.00   Min.   :  0.0   Min.   :   0   Min.   : 0.00   Min.   :   0   Min.   :  0.0   Min.   :  6  
##  1st Qu.: 0.000   1st Qu.: 0.00   1st Qu.:  0.0   1st Qu.:  53   1st Qu.: 0.00   1st Qu.:  95   1st Qu.:  3.0   1st Qu.:621  
##  Median : 0.000   Median : 2.00   Median :  4.0   Median :  87   Median : 1.00   Median : 154   Median :  7.0   Median :625  
##  Mean   : 0.269   Mean   : 4.07   Mean   :  8.6   Mean   : 170   Mean   : 3.21   Mean   : 297   Mean   : 15.2   Mean   :585  
##  3rd Qu.: 0.000   3rd Qu.: 5.00   3rd Qu.:  9.0   3rd Qu.: 197   3rd Qu.: 3.00   3rd Qu.: 346   3rd Qu.: 16.0   3rd Qu.:720  
##  Max.   :12.000   Max.   :71.00   Max.   :504.0   Max.   :1645   Max.   :85.00   Max.   :2709   Max.   :438.0   Max.   :834  
##                                                                                                                              
##                           SDNAME               ELEMENTARY                   MIDDLE                 HIGH       STATEFP10  COUNTYFP10   TRACTCE10    
##  St. Paul                    :4255   LIBERTY RIDGE  :  500   SHAKOPEE          : 1367   SHAKOPEE     : 1367   27:18734   003: 330   071018 :  724  
##  South Washington County     :2969   HUGO & ONEKA   :  468   BATTLE CREEK      : 1343   PRIOR LAKE   : 1139              037:3217   080302 :  447  
##  North St. Paul-Maplewood    :1619   SUN PATH       :  386   TWIN & HIDDEN OAKS: 1139   NORTH & SOUTH: 1125              123:7125   080301 :  377  
##  Shakopee                    :1367   LAKE ELMO      :  382   LAKE              :  927   WOODBURY     : 1033              139:2833   071017 :  299  
##  Rosemount-Apple Valley-Eagan:1271   EAGLE CREEK    :  369   WOODBURY          :  755   EAST RIDGE   : 1005              163:5229   071206 :  299  
##  Prior Lake-Savage           :1139   SHERIDAN & AMES:  341   (Other)           :12970   NORTH        :  973                         070203 :  277  
##  (Other)                     :6114   (Other)        :16288   NA's              :  233   (Other)      :12092                         (Other):16311  
##         NAME10        Block_Area        POP_Dense          fam_income       income_err      StPaulDist      MinneaDist   
##  Block 2000:  407   Min.   :   1900   Min.   :0.000000   Min.   : 15625   7118   :  724   Min.   : NA     Min.   : NA    
##  Block 1000:  376   1st Qu.:  22000   1st Qu.:0.000889   1st Qu.: 70288   5610   :  447   1st Qu.: NA     1st Qu.: NA    
##  Block 2006:  344   Median :  51000   Median :0.001678   Median : 87969   6132   :  377   Median : NA     Median : NA    
##  Block 1008:  299   Mean   : 282176   Mean   :0.001921   Mean   : 86765   19338  :  299   Mean   :NaN     Mean   :NaN    
##  Block 2001:  279   3rd Qu.: 200000   3rd Qu.:0.002584   3rd Qu.:104881   5732   :  299   3rd Qu.: NA     3rd Qu.: NA    
##  Block 1001:  278   Max.   :6200000   Max.   :0.019298   Max.   :160025   5979   :  277   Max.   : NA     Max.   : NA    
##  (Other)   :16751                                                         (Other):16311   NA's   :18734   NA's   :18734  
```

```r
names(HouseData)
```

```
##  [1] "COUNTY_ID"  "PIN"        "CITY"       "ZIP4"       "LOT"        "ACRES_POLY" "ACRES_DEED" "USE1_DESC"  "HOMESTEAD"  "EMV_LAND"   "EMV_BLDG"   "EMV_TOTAL" 
## [13] "TAX_CAPAC"  "TOTAL_TAX"  "XUSE1_DESC" "DWELL_TYPE" "HOME_STYLE" "FIN_SQ_FT"  "GARAGE"     "GARAGESQFT" "BASEMENT"   "HEATING"    "COOLING"    "YEAR_BUILT"
## [25] "NUM_UNITS"  "SALE_DATE"  "SALE_VALUE" "SCHOOL_DST" "WSHD_DIST"  "MYPIN"      "X_COORD"    "Y_COORD"    "REPLACEFID" "CITY_DUMMY" "GEOID10"    "tenthkmSUM"
## [37] "qtrkmSUM"   "halfkmSUM"  "onekmSUM"   "twokmSUM"   "Census_POP" "WhiteDense" "White_POP"  "Amind_POP"  "Asian_POP"  "Pacif_POP"  "Other_POP"  "Multi_POP" 
## [49] "Hisp_POP"   "NotHis_POP" "VACANT"     "POPUnder18" "POPOver65"  "SDNUM"      "SDNAME"     "ELEMENTARY" "MIDDLE"     "HIGH"       "STATEFP10"  "COUNTYFP10"
## [61] "TRACTCE10"  "NAME10"     "Block_Area" "POP_Dense"  "fam_income" "income_err" "StPaulDist" "MinneaDist"
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
StructuralModel1 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + YEAR_BUILT, data = HouseData)
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
StructuralModel2 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + YEAR_BUILT + HOME_STYLE, data = HouseData)
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
TimeModel1 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH), 
    data = HouseData)
summary(TimeModel1)
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


Open Space Index
---------
Now we'll bring in the Open Space Index. First, let's just include all five different OSI measures and see what happens.


```r
osiModel1 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    tenthkmSUM + qtrkmSUM + halfkmSUM + onekmSUM + twokmSUM, data = HouseData)
summary(osiModel1)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + 
##     YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + 
##     factor(SALE_YEAR) + factor(SALE_MONTH) + tenthkmSUM + qtrkmSUM + 
##     halfkmSUM + onekmSUM + twokmSUM, data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -4.742 -0.128  0.030  0.183  3.162 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                 -2.40e-02   3.70e-01   -0.06  0.94824    
## FIN_SQ_FT                                    2.98e-04   6.21e-06   47.92  < 2e-16 ***
## ACRES_POLY                                   4.56e-02   4.84e-03    9.41  < 2e-16 ***
## GARAGEsqft                                   1.78e-04   1.76e-05   10.11  < 2e-16 ***
## YEAR_BUILT                                   5.37e-03   1.84e-04   29.10  < 2e-16 ***
## HOME_STYLE1 1/2 STRY                         8.87e-02   1.19e-01    0.75  0.45453    
## HOME_STYLE1-1/2 STRY                         3.29e-01   1.03e-01    3.20  0.00137 ** 
## HOME_STYLE1 1/4 STRY                         5.30e-02   1.59e-01    0.33  0.73955    
## HOME_STYLE1-1/4 STRY                         3.11e-01   9.86e-02    3.15  0.00162 ** 
## HOME_STYLE1-2 STRY                           1.42e-01   1.00e-01    1.42  0.15529    
## HOME_STYLE1 3/4 STRY                         4.66e-01   1.44e-01    3.24  0.00121 ** 
## HOME_STYLE1-3/4 STRY                         4.23e-01   1.12e-01    3.77  0.00016 ***
## HOME_STYLE1 Story Brick                      5.70e-01   3.82e-01    1.49  0.13545    
## HOME_STYLE1 Story Condo                     -5.27e-01   9.02e-02   -5.84  5.2e-09 ***
## HOME_STYLE1 Story Frame                      2.51e-01   7.64e-02    3.28  0.00104 ** 
## HOME_STYLE1 Story Townhouse                  1.72e-01   7.89e-02    2.18  0.02908 *  
## HOME_STYLE2 Story Condo                     -3.46e-01   8.17e-02   -4.24  2.2e-05 ***
## HOME_STYLE2 Story Frame                      1.88e-01   7.66e-02    2.46  0.01409 *  
## HOME_STYLE2 Story Townhouse                 -2.25e-01   7.75e-02   -2.90  0.00374 ** 
## HOME_STYLE3-LVL SPLT                         3.84e-02   1.04e-01    0.37  0.71321    
## HOME_STYLE4 LVL SPLT                         4.14e-02   1.01e-01    0.41  0.68233    
## HOME_STYLEBungalow                           2.03e-01   8.49e-02    2.39  0.01679 *  
## HOME_STYLECONDO                             -9.28e-01   1.14e-01   -8.16  3.4e-16 ***
## HOME_STYLEDUP/TRI                            1.66e-01   2.36e-01    0.70  0.48251    
## HOME_STYLEEARTH SHEL                        -2.85e-01   3.85e-01   -0.74  0.45891    
## HOME_STYLELOG                               -1.36e+00   3.85e-01   -3.54  0.00041 ***
## HOME_STYLEMfd Home (Double)                 -2.35e-01   3.81e-01   -0.62  0.53747    
## HOME_STYLEN/A                                1.26e-01   2.36e-01    0.53  0.59444    
## HOME_STYLEOne And 3/4 Story                  1.96e-01   8.58e-02    2.29  0.02221 *  
## HOME_STYLEOne Story                          1.57e-01   8.46e-02    1.85  0.06432 .  
## HOME_STYLEONE STORY                          2.33e-01   9.34e-02    2.49  0.01264 *  
## HOME_STYLEOther                             -2.43e+00   3.85e-01   -6.31  2.8e-10 ***
## HOME_STYLERAMBLER                            1.82e-02   9.70e-02    0.19  0.85108    
## HOME_STYLESalvage                           -2.66e-02   2.28e-01   -0.12  0.90720    
## HOME_STYLESPLIT-ENT                         -1.65e-02   9.71e-02   -0.17  0.86491    
## HOME_STYLESplit/entry                        9.59e-02   8.60e-02    1.11  0.26493    
## HOME_STYLESPLIT-FOY                          3.69e-02   1.04e-01    0.35  0.72373    
## HOME_STYLESplit Foyer Frame                  2.41e-01   7.73e-02    3.12  0.00179 ** 
## HOME_STYLESplit/level                        1.67e-01   8.66e-02    1.93  0.05344 .  
## HOME_STYLESplit Level Frame                  3.11e-01   7.79e-02    3.99  6.6e-05 ***
## HOME_STYLESPLIT LEVL                         2.10e-01   9.33e-02    2.25  0.02436 *  
## HOME_STYLETOWNHOME                          -3.14e-01   9.61e-02   -3.26  0.00111 ** 
## HOME_STYLETWIN HOME                         -1.31e-01   1.05e-01   -1.26  0.20866    
## HOME_STYLETwo Story                          2.44e-01   8.53e-02    2.86  0.00418 ** 
## HOME_STYLETWO STORY                          2.17e-01   9.37e-02    2.32  0.02029 *  
## HOME_STYLETWO+ STORY                         1.99e-02   2.10e-01    0.09  0.92474    
## ELEMENTARYAKIN ROAD                         -4.42e-02   7.54e-02   -0.59  0.55751    
## ELEMENTARYANDERSEN                           1.28e-01   8.34e-02    1.54  0.12406    
## ELEMENTARYANDERSON & WILDWOOD                2.28e-01   4.29e-02    5.31  1.1e-07 ***
## ELEMENTARYARMSTRONG                          1.77e-03   4.62e-02    0.04  0.96951    
## ELEMENTARYBAILEY                             1.61e-01   3.95e-02    4.07  4.8e-05 ***
## ELEMENTARYBATTLE CREEK                       3.32e-01   7.58e-02    4.38  1.2e-05 ***
## ELEMENTARYBEL AIR                            2.71e-01   6.10e-02    4.45  8.8e-06 ***
## ELEMENTARYBIRCH LAKE                         1.49e-01   6.77e-02    2.21  0.02722 *  
## ELEMENTARYBRIMHALL                           4.84e-01   6.10e-02    7.93  2.2e-15 ***
## ELEMENTARYBRUCE F. VENTO                    -2.27e-01   6.38e-02   -3.56  0.00037 ***
## ELEMENTARYCARVER                             3.97e-02   5.94e-02    0.67  0.50368    
## ELEMENTARYCASTLE                             1.22e-01   4.15e-02    2.95  0.00322 ** 
## ELEMENTARYCEDAR PARK                         1.23e-01   8.22e-02    1.50  0.13324    
## ELEMENTARYCENTRAL PARK                       3.08e-01   6.46e-02    4.77  1.8e-06 ***
## ELEMENTARYCHELSEA HEIGHTS                    3.32e-01   5.76e-02    5.77  8.2e-09 ***
## ELEMENTARYCHERRY VIEW                       -6.25e-02   8.10e-02   -0.77  0.44055    
## ELEMENTARYCHRISTINA HUDDLESTON              -4.08e-02   7.96e-02   -0.51  0.60793    
## ELEMENTARYCOMO PARK                          2.91e-01   6.13e-02    4.76  2.0e-06 ***
## ELEMENTARYCOTTAGE GROVE                      8.37e-02   4.52e-02    1.85  0.06438 .  
## ELEMENTARYCOWERN                             8.83e-02   5.31e-02    1.66  0.09620 .  
## ELEMENTARYCRESTVIEW                         -8.84e-03   4.88e-02   -0.18  0.85628    
## ELEMENTARYCRYSTAL LAKE                       9.80e-04   8.13e-02    0.01  0.99039    
## ELEMENTARYDAYTONS BLUFF                     -1.36e-01   6.00e-02   -2.27  0.02315 *  
## ELEMENTARYDEERWOOD                           6.72e-02   8.18e-02    0.82  0.41094    
## ELEMENTARYDIAMOND PATH                       1.04e-01   7.70e-02    1.35  0.17614    
## ELEMENTARYEAGLE CREEK                        4.08e-01   6.90e-02    5.92  3.3e-09 ***
## ELEMENTARYEAGLE POINT                        6.23e-02   4.72e-02    1.32  0.18727    
## ELEMENTARYEASTERN HEIGHTS                    9.94e-03   5.87e-02    0.17  0.86552    
## ELEMENTARYEASTVIEW                           1.14e-02   8.66e-02    0.13  0.89549    
## ELEMENTARYECHO PARK                          3.64e-02   7.57e-02    0.48  0.63061    
## ELEMENTARYEDGERTON                           3.16e-01   6.49e-02    4.87  1.2e-06 ***
## ELEMENTARYEDWARD NEILL                       8.05e-02   7.84e-02    1.03  0.30454    
## ELEMENTARYEMMET D. WILLIAMS                  3.21e-01   6.19e-02    5.18  2.2e-07 ***
## ELEMENTARYFALCON HEIGHTS                     3.95e-01   6.15e-02    6.43  1.3e-10 ***
## ELEMENTARYFARMINGTON                        -2.32e-02   7.84e-02   -0.30  0.76692    
## ELEMENTARYFARNSWORTH LOWER                   5.31e-03   6.09e-02    0.09  0.93056    
## ELEMENTARYFIVE HAWKS                         4.58e-01   7.19e-02    6.36  2.0e-10 ***
## ELEMENTARYFOREST VIEW & FOREST LAKE         -3.80e-01   1.46e-01   -2.60  0.00937 ** 
## ELEMENTARYFRANKLIN MUSIC                     2.43e-01   1.62e-01    1.50  0.13379    
## ELEMENTARYFROST LAKE                         1.30e-01   6.58e-02    1.98  0.04787 *  
## ELEMENTARYGALTIER & MAXFIELD                 6.95e-02   5.83e-02    1.19  0.23326    
## ELEMENTARYGARLOUGH                           3.05e-01   8.30e-02    3.68  0.00023 ***
## ELEMENTARYGIDEON POND                        1.50e-01   8.50e-02    1.76  0.07774 .  
## ELEMENTARYGLACIER HILLS                      1.07e-01   8.68e-02    1.23  0.21717    
## ELEMENTARYGLENDALE                           4.05e-01   7.46e-02    5.43  5.6e-08 ***
## ELEMENTARYGRAINWOOD                          3.08e-01   7.42e-02    4.15  3.4e-05 ***
## ELEMENTARYGREENLEAF                         -3.44e-03   7.21e-02   -0.05  0.96190    
## ELEMENTARYGREY CLOUD                         6.19e-02   4.24e-02    1.46  0.14409    
## ELEMENTARYGROVELAND PARK                     6.59e-01   5.99e-02   11.00  < 2e-16 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  5.30e-01   5.94e-02    8.91  < 2e-16 ***
## ELEMENTARYHANCOCK                            3.13e-01   6.98e-02    4.48  7.6e-06 ***
## ELEMENTARYHARRIET BISHOP                     3.39e-01   7.80e-02    4.35  1.4e-05 ***
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -1.81e-03   5.68e-02   -0.03  0.97454    
## ELEMENTARYHIDDEN VALLEY                      4.02e-01   7.82e-02    5.14  2.7e-07 ***
## ELEMENTARYHIGHLAND                           5.63e-02   7.57e-02    0.74  0.45655    
## ELEMENTARYHIGHLAND PARK                      5.74e-01   5.91e-02    9.71  < 2e-16 ***
## ELEMENTARYHIGHWOOD HILLS                     1.92e-01   6.69e-02    2.87  0.00409 ** 
## ELEMENTARYHILLSIDE                           6.68e-02   4.62e-02    1.45  0.14833    
## ELEMENTARYHILLTOP                            1.31e-01   7.64e-02    1.72  0.08575 .  
## ELEMENTARYHUGO & ONEKA                       3.54e-02   3.81e-02    0.93  0.35211    
## ELEMENTARYISLAND LAKE                        1.65e-01   6.08e-02    2.72  0.00663 ** 
## ELEMENTARYJACKSON                           -5.99e-01   7.23e-02   -8.28  < 2e-16 ***
## ELEMENTARYJEFFERS POND                       4.22e-01   7.19e-02    5.87  4.4e-09 ***
## ELEMENTARYJOHN F. KENNEDY                   -1.70e-02   1.13e-01   -0.15  0.88023    
## ELEMENTARYJOHNSON A+                        -2.75e-01   7.10e-02   -3.87  0.00011 ***
## ELEMENTARYJORDAN                             2.73e-01   2.83e-01    0.96  0.33532    
## ELEMENTARYKAPOSIA                            1.57e-01   7.42e-02    2.12  0.03429 *  
## ELEMENTARYLAKEAIRES                          3.06e-01   6.02e-02    5.08  3.8e-07 ***
## ELEMENTARYLAKE ELMO                          6.21e-02   3.82e-02    1.63  0.10365    
## ELEMENTARYLAKE MARION                        2.67e-02   9.42e-02    0.28  0.77695    
## ELEMENTARYLAKEVIEW                          -5.50e-02   7.60e-02   -0.72  0.46926    
## ELEMENTARYLIBERTY RIDGE                      1.69e-01   3.74e-02    4.51  6.4e-06 ***
## ELEMENTARYLINCOLN                            1.32e-01   6.21e-02    2.12  0.03383 *  
## ELEMENTARYLINO LAKES                        -4.10e-01   2.21e-01   -1.86  0.06315 .  
## ELEMENTARYLITTLE CANADA                      2.30e-01   6.76e-02    3.41  0.00066 ***
## ELEMENTARYMANN                               5.54e-01   5.79e-02    9.58  < 2e-16 ***
## ELEMENTARYMARION W. SAVAGE                   3.68e-01   7.40e-02    4.97  6.6e-07 ***
## ELEMENTARYMATOSKA INTERNATIONAL              2.87e-01   5.81e-02    4.94  7.8e-07 ***
## ELEMENTARYMEADOWVIEW                        -7.50e-02   7.90e-02   -0.95  0.34281    
## ELEMENTARYMENDOTA                            1.49e-01   7.85e-02    1.90  0.05753 .  
## ELEMENTARYMIDDLETON                          1.07e-01   4.09e-02    2.62  0.00886 ** 
## ELEMENTARYMISSISSIPPI                        1.16e-01   7.42e-02    1.57  0.11696    
## ELEMENTARYMONROE                             7.77e-02   6.07e-02    1.28  0.20106    
## ELEMENTARYMORELAND                           2.11e-01   7.69e-02    2.75  0.00603 ** 
## ELEMENTARYNEWPORT                            1.87e-03   4.91e-02    0.04  0.96956    
## ELEMENTARYNORTH END                         -1.96e-01   6.09e-02   -3.22  0.00130 ** 
## ELEMENTARYNORTH TRAIL                        5.66e-02   8.22e-02    0.69  0.49158    
## ELEMENTARYNORTHVIEW                          1.65e-02   8.02e-02    0.21  0.83650    
## ELEMENTARYOAKDALE                            1.80e-02   4.24e-02    0.42  0.67144    
## ELEMENTARYOAK HILLS                         -8.18e-02   8.60e-02   -0.95  0.34144    
## ELEMENTARYOAK RIDGE                          1.41e-01   8.52e-02    1.66  0.09696 .  
## ELEMENTARYOBAMA                              6.62e-01   9.00e-02    7.35  2.0e-13 ***
## ELEMENTARYORCHARD LAKE                       1.46e-01   8.16e-02    1.79  0.07366 .  
## ELEMENTARYOTTER LAKE                         1.74e-01   6.99e-02    2.50  0.01253 *  
## ELEMENTARYPARKVIEW                           2.91e-02   7.97e-02    0.36  0.71516    
## ELEMENTARYPEARSON                            2.82e-01   7.23e-02    3.90  9.6e-05 ***
## ELEMENTARYPHALEN LAKE                       -1.53e-01   6.32e-02   -2.43  0.01529 *  
## ELEMENTARYPILOT KNOB                         1.66e-01   8.42e-02    1.97  0.04915 *  
## ELEMENTARYPINE BEND                          6.53e-02   8.55e-02    0.76  0.44488    
## ELEMENTARYPINE HILL                          4.96e-02   4.24e-02    1.17  0.24208    
## ELEMENTARYPINEWOOD                           4.56e-02   5.92e-02    0.77  0.44161    
## ELEMENTARYPULLMAN                           -4.06e-02   4.36e-02   -0.93  0.35173    
## ELEMENTARYRAHN                               1.70e-01   8.00e-02    2.12  0.03395 *  
## ELEMENTARYRANDOLPH HEIGHTS                   6.89e-01   5.86e-02   11.75  < 2e-16 ***
## ELEMENTARYRED OAK                            3.76e-01   7.23e-02    5.21  2.0e-07 ***
## ELEMENTARYRED PINE                           2.89e-02   7.70e-02    0.38  0.70702    
## ELEMENTARYRED ROCK                           8.71e-02   4.44e-02    1.96  0.04999 *  
## ELEMENTARYREDTAIL RIDGE                      4.35e-01   7.09e-02    6.14  8.5e-10 ***
## ELEMENTARYRICHARDSON                         1.96e-01   5.83e-02    3.37  0.00076 ***
## ELEMENTARYRIVERVIEW                         -2.73e-02   7.69e-02   -0.36  0.72249    
## ELEMENTARYRIVERVIEW & CHEROKEE               1.48e-01   6.00e-02    2.47  0.01365 *  
## ELEMENTARYROSEMOUNT                          5.24e-02   8.09e-02    0.65  0.51697    
## ELEMENTARYROYAL OAKS                         9.01e-02   4.09e-02    2.21  0.02745 *  
## ELEMENTARYRUTHERFORD                        -2.68e-03   7.12e-02   -0.04  0.97004    
## ELEMENTARYSALEM HILLS                        9.97e-02   1.09e-01    0.92  0.35942    
## ELEMENTARYSHANNON PARK                      -2.21e-02   7.37e-02   -0.30  0.76465    
## ELEMENTARYSHERIDAN & AMES                    2.50e-02   5.74e-02    0.44  0.66275    
## ELEMENTARYSIOUX TRAIL                        1.20e-01   8.51e-02    1.41  0.15772    
## ELEMENTARYSKY OAKS                           8.68e-02   8.18e-02    1.06  0.28844    
## ELEMENTARYSKYVIEW                            8.46e-02   3.97e-02    2.13  0.03329 *  
## ELEMENTARYSOMERSET HEIGHTS                   2.19e-01   7.39e-02    2.96  0.00306 ** 
## ELEMENTARYSOUTHVIEW                          5.11e-02   7.57e-02    0.68  0.49904    
## ELEMENTARYST ANTHONY PARK                    7.43e-01   7.40e-02   10.04  < 2e-16 ***
## ELEMENTARYSUNNYSIDE                          1.61e-01   6.35e-02    2.54  0.01123 *  
## ELEMENTARYSUN PATH                           2.37e-01   6.98e-02    3.39  0.00070 ***
## ELEMENTARYSWEENEY                            2.33e-01   7.28e-02    3.20  0.00139 ** 
## ELEMENTARYTHOMAS LAKE                        9.64e-03   8.08e-02    0.12  0.90502    
## ELEMENTARYTURTLE LAKE                        2.23e-01   5.70e-02    3.91  9.4e-05 ***
## ELEMENTARYVADNAIS HEIGHTS                    1.17e-01   6.48e-02    1.81  0.06979 .  
## ELEMENTARYVALENTINE HILLS                    2.73e-01   6.00e-02    4.55  5.5e-06 ***
## ELEMENTARYVISTA VIEW                         1.85e-01   7.92e-02    2.34  0.01936 *  
## ELEMENTARYWEAVER                             1.52e-01   5.85e-02    2.60  0.00929 ** 
## ELEMENTARYWEBSTER                            1.52e-01   6.65e-02    2.28  0.02267 *  
## ELEMENTARYWESTVIEW                           4.59e-02   7.76e-02    0.59  0.55443    
## ELEMENTARYWESTWOOD                           4.64e-01   7.47e-02    6.21  5.3e-10 ***
## ELEMENTARYWILLIAM BYRNE                      5.20e-02   8.12e-02    0.64  0.52188    
## ELEMENTARYWILLOW LANE                        1.33e-01   7.07e-02    1.88  0.06059 .  
## ELEMENTARYWILSHIRE PARK                      4.34e-01   1.19e-01    3.63  0.00028 ***
## ELEMENTARYWOODBURY                           1.59e-01   4.34e-02    3.66  0.00025 ***
## ELEMENTARYWOODLAND                           6.03e-02   8.01e-02    0.75  0.45106    
## WhiteDense                                   3.56e-01   2.07e-02   17.16  < 2e-16 ***
## fam_income                                   4.20e-06   2.18e-07   19.28  < 2e-16 ***
## factor(SALE_YEAR)2010                       -2.41e-02   5.96e-03   -4.04  5.5e-05 ***
## factor(SALE_YEAR)2011                       -1.66e-01   1.19e-02  -14.02  < 2e-16 ***
## factor(SALE_MONTH)2                         -1.47e-02   1.57e-02   -0.93  0.34986    
## factor(SALE_MONTH)3                          8.24e-03   1.47e-02    0.56  0.57423    
## factor(SALE_MONTH)4                          6.31e-03   1.44e-02    0.44  0.66060    
## factor(SALE_MONTH)5                          5.65e-02   1.44e-02    3.92  9.0e-05 ***
## factor(SALE_MONTH)6                          5.39e-02   1.44e-02    3.74  0.00019 ***
## factor(SALE_MONTH)7                          4.55e-02   1.51e-02    3.02  0.00251 ** 
## factor(SALE_MONTH)8                          3.01e-02   1.52e-02    1.98  0.04822 *  
## factor(SALE_MONTH)9                          1.68e-02   1.54e-02    1.09  0.27749    
## factor(SALE_MONTH)10                         5.77e-02   1.52e-02    3.81  0.00014 ***
## factor(SALE_MONTH)11                         3.42e-02   1.56e-02    2.19  0.02848 *  
## factor(SALE_MONTH)12                        -3.68e-02   1.67e-02   -2.20  0.02757 *  
## tenthkmSUM                                  -5.51e-08   4.62e-08   -1.19  0.23328    
## qtrkmSUM                                     1.48e-08   1.24e-08    1.19  0.23289    
## halfkmSUM                                    2.98e-09   3.13e-09    0.95  0.34061    
## onekmSUM                                    -9.85e-10   6.02e-10   -1.63  0.10218    
## twokmSUM                                     8.33e-11   1.02e-10    0.82  0.41435    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.372 on 17800 degrees of freedom
##   (728 observations deleted due to missingness)
## Multiple R-squared: 0.662,	Adjusted R-squared: 0.658 
## F-statistic:  170 on 205 and 17800 DF,  p-value: <2e-16 
## 
```



```r
osiModel2 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    tenthkmSUM, data = HouseData)
summary(osiModel2)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + 
##     YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + 
##     factor(SALE_YEAR) + factor(SALE_MONTH) + tenthkmSUM, data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -4.750 -0.128  0.030  0.183  3.159 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                 -3.06e-02   3.70e-01   -0.08  0.93411    
## FIN_SQ_FT                                    2.98e-04   6.21e-06   47.93  < 2e-16 ***
## ACRES_POLY                                   4.57e-02   4.84e-03    9.43  < 2e-16 ***
## GARAGEsqft                                   1.78e-04   1.76e-05   10.11  < 2e-16 ***
## YEAR_BUILT                                   5.38e-03   1.84e-04   29.15  < 2e-16 ***
## HOME_STYLE1 1/2 STRY                         9.23e-02   1.19e-01    0.78  0.43651    
## HOME_STYLE1-1/2 STRY                         3.34e-01   1.03e-01    3.26  0.00113 ** 
## HOME_STYLE1 1/4 STRY                         5.55e-02   1.59e-01    0.35  0.72752    
## HOME_STYLE1-1/4 STRY                         3.16e-01   9.84e-02    3.21  0.00132 ** 
## HOME_STYLE1-2 STRY                           1.45e-01   9.99e-02    1.45  0.14679    
## HOME_STYLE1 3/4 STRY                         4.68e-01   1.44e-01    3.25  0.00116 ** 
## HOME_STYLE1-3/4 STRY                         4.28e-01   1.12e-01    3.83  0.00013 ***
## HOME_STYLE1 Story Brick                      5.87e-01   3.82e-01    1.54  0.12399    
## HOME_STYLE1 Story Condo                     -5.27e-01   9.02e-02   -5.84  5.3e-09 ***
## HOME_STYLE1 Story Frame                      2.52e-01   7.63e-02    3.30  0.00096 ***
## HOME_STYLE1 Story Townhouse                  1.73e-01   7.89e-02    2.19  0.02866 *  
## HOME_STYLE2 Story Condo                     -3.45e-01   8.16e-02   -4.23  2.3e-05 ***
## HOME_STYLE2 Story Frame                      1.90e-01   7.65e-02    2.48  0.01300 *  
## HOME_STYLE2 Story Townhouse                 -2.23e-01   7.75e-02   -2.88  0.00396 ** 
## HOME_STYLE3-LVL SPLT                         4.21e-02   1.04e-01    0.40  0.68587    
## HOME_STYLE4 LVL SPLT                         4.27e-02   1.01e-01    0.42  0.67218    
## HOME_STYLEBungalow                           2.05e-01   8.48e-02    2.41  0.01590 *  
## HOME_STYLECONDO                             -9.27e-01   1.14e-01   -8.16  3.4e-16 ***
## HOME_STYLEDUP/TRI                            1.66e-01   2.36e-01    0.70  0.48285    
## HOME_STYLEEARTH SHEL                        -2.83e-01   3.85e-01   -0.73  0.46290    
## HOME_STYLELOG                               -1.38e+00   3.85e-01   -3.57  0.00035 ***
## HOME_STYLEMfd Home (Double)                 -2.32e-01   3.81e-01   -0.61  0.54300    
## HOME_STYLEN/A                                1.23e-01   2.36e-01    0.52  0.60029    
## HOME_STYLEOne And 3/4 Story                  1.98e-01   8.57e-02    2.31  0.02089 *  
## HOME_STYLEOne Story                          1.58e-01   8.46e-02    1.87  0.06176 .  
## HOME_STYLEONE STORY                          2.38e-01   9.32e-02    2.55  0.01068 *  
## HOME_STYLEOther                             -2.44e+00   3.85e-01   -6.33  2.5e-10 ***
## HOME_STYLERAMBLER                            2.24e-02   9.68e-02    0.23  0.81684    
## HOME_STYLESalvage                           -1.99e-02   2.28e-01   -0.09  0.93064    
## HOME_STYLESPLIT-ENT                         -1.36e-02   9.69e-02   -0.14  0.88850    
## HOME_STYLESplit/entry                        9.73e-02   8.59e-02    1.13  0.25725    
## HOME_STYLESPLIT-FOY                          4.09e-02   1.04e-01    0.39  0.69475    
## HOME_STYLESplit Foyer Frame                  2.43e-01   7.72e-02    3.15  0.00163 ** 
## HOME_STYLESplit/level                        1.68e-01   8.66e-02    1.94  0.05227 .  
## HOME_STYLESplit Level Frame                  3.12e-01   7.79e-02    4.01  6.1e-05 ***
## HOME_STYLESPLIT LEVL                         2.14e-01   9.31e-02    2.30  0.02126 *  
## HOME_STYLETOWNHOME                          -3.10e-01   9.60e-02   -3.24  0.00122 ** 
## HOME_STYLETWIN HOME                         -1.29e-01   1.04e-01   -1.23  0.21821    
## HOME_STYLETwo Story                          2.46e-01   8.52e-02    2.89  0.00390 ** 
## HOME_STYLETWO STORY                          2.22e-01   9.35e-02    2.37  0.01773 *  
## HOME_STYLETWO+ STORY                         2.43e-02   2.10e-01    0.12  0.90812    
## ELEMENTARYAKIN ROAD                         -4.80e-02   7.45e-02   -0.64  0.51983    
## ELEMENTARYANDERSEN                           1.25e-01   8.34e-02    1.50  0.13471    
## ELEMENTARYANDERSON & WILDWOOD                2.25e-01   4.29e-02    5.26  1.5e-07 ***
## ELEMENTARYARMSTRONG                         -7.70e-04   4.62e-02   -0.02  0.98668    
## ELEMENTARYBAILEY                             1.57e-01   3.95e-02    3.97  7.1e-05 ***
## ELEMENTARYBATTLE CREEK                       3.26e-01   7.57e-02    4.30  1.7e-05 ***
## ELEMENTARYBEL AIR                            2.66e-01   6.09e-02    4.37  1.2e-05 ***
## ELEMENTARYBIRCH LAKE                         1.44e-01   6.76e-02    2.13  0.03313 *  
## ELEMENTARYBRIMHALL                           4.79e-01   6.09e-02    7.86  4.2e-15 ***
## ELEMENTARYBRUCE F. VENTO                    -2.33e-01   6.36e-02   -3.66  0.00025 ***
## ELEMENTARYCARVER                             3.56e-02   5.93e-02    0.60  0.54895    
## ELEMENTARYCASTLE                             1.17e-01   4.14e-02    2.83  0.00468 ** 
## ELEMENTARYCEDAR PARK                         1.16e-01   8.21e-02    1.41  0.15883    
## ELEMENTARYCENTRAL PARK                       3.02e-01   6.46e-02    4.68  2.9e-06 ***
## ELEMENTARYCHELSEA HEIGHTS                    3.26e-01   5.75e-02    5.67  1.4e-08 ***
## ELEMENTARYCHERRY VIEW                       -7.04e-02   8.10e-02   -0.87  0.38459    
## ELEMENTARYCHRISTINA HUDDLESTON              -4.87e-02   7.95e-02   -0.61  0.54022    
## ELEMENTARYCOMO PARK                          2.85e-01   6.11e-02    4.66  3.2e-06 ***
## ELEMENTARYCOTTAGE GROVE                      7.79e-02   4.51e-02    1.73  0.08386 .  
## ELEMENTARYCOWERN                             8.24e-02   5.30e-02    1.55  0.12014    
## ELEMENTARYCRESTVIEW                         -1.23e-02   4.87e-02   -0.25  0.80109    
## ELEMENTARYCRYSTAL LAKE                      -5.47e-03   8.13e-02   -0.07  0.94629    
## ELEMENTARYDAYTONS BLUFF                     -1.42e-01   5.99e-02   -2.38  0.01755 *  
## ELEMENTARYDEERWOOD                           5.98e-02   8.17e-02    0.73  0.46406    
## ELEMENTARYDIAMOND PATH                       9.62e-02   7.69e-02    1.25  0.21097    
## ELEMENTARYEAGLE CREEK                        4.04e-01   6.88e-02    5.87  4.6e-09 ***
## ELEMENTARYEAGLE POINT                        5.83e-02   4.72e-02    1.24  0.21607    
## ELEMENTARYEASTERN HEIGHTS                    4.05e-03   5.85e-02    0.07  0.94490    
## ELEMENTARYEASTVIEW                           5.69e-03   8.65e-02    0.07  0.94753    
## ELEMENTARYECHO PARK                          2.82e-02   7.56e-02    0.37  0.70948    
## ELEMENTARYEDGERTON                           3.11e-01   6.49e-02    4.80  1.6e-06 ***
## ELEMENTARYEDWARD NEILL                       7.32e-02   7.83e-02    0.93  0.35029    
## ELEMENTARYEMMET D. WILLIAMS                  3.17e-01   6.18e-02    5.12  3.0e-07 ***
## ELEMENTARYFALCON HEIGHTS                     3.89e-01   6.13e-02    6.34  2.3e-10 ***
## ELEMENTARYFARMINGTON                        -3.11e-02   7.80e-02   -0.40  0.69022    
## ELEMENTARYFARNSWORTH LOWER                  -3.83e-04   6.08e-02   -0.01  0.99497    
## ELEMENTARYFIVE HAWKS                         4.53e-01   7.18e-02    6.31  2.9e-10 ***
## ELEMENTARYFOREST VIEW & FOREST LAKE         -3.85e-01   1.46e-01   -2.63  0.00844 ** 
## ELEMENTARYFRANKLIN MUSIC                     2.38e-01   1.62e-01    1.47  0.14141    
## ELEMENTARYFROST LAKE                         1.24e-01   6.56e-02    1.89  0.05914 .  
## ELEMENTARYGALTIER & MAXFIELD                 6.35e-02   5.82e-02    1.09  0.27528    
## ELEMENTARYGARLOUGH                           2.97e-01   8.28e-02    3.59  0.00033 ***
## ELEMENTARYGIDEON POND                        1.41e-01   8.49e-02    1.66  0.09607 .  
## ELEMENTARYGLACIER HILLS                      1.05e-01   8.67e-02    1.21  0.22765    
## ELEMENTARYGLENDALE                           4.01e-01   7.45e-02    5.37  7.8e-08 ***
## ELEMENTARYGRAINWOOD                          3.02e-01   7.41e-02    4.07  4.7e-05 ***
## ELEMENTARYGREENLEAF                         -1.12e-02   7.20e-02   -0.16  0.87627    
## ELEMENTARYGREY CLOUD                         5.49e-02   4.22e-02    1.30  0.19381    
## ELEMENTARYGROVELAND PARK                     6.52e-01   5.98e-02   10.92  < 2e-16 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  5.23e-01   5.93e-02    8.82  < 2e-16 ***
## ELEMENTARYHANCOCK                            3.07e-01   6.97e-02    4.40  1.1e-05 ***
## ELEMENTARYHARRIET BISHOP                     3.33e-01   7.80e-02    4.28  1.9e-05 ***
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -7.08e-03   5.66e-02   -0.13  0.90050    
## ELEMENTARYHIDDEN VALLEY                      3.96e-01   7.82e-02    5.07  4.1e-07 ***
## ELEMENTARYHIGHLAND                           4.92e-02   7.56e-02    0.65  0.51471    
## ELEMENTARYHIGHLAND PARK                      5.68e-01   5.90e-02    9.62  < 2e-16 ***
## ELEMENTARYHIGHWOOD HILLS                     1.87e-01   6.68e-02    2.80  0.00516 ** 
## ELEMENTARYHILLSIDE                           6.07e-02   4.60e-02    1.32  0.18714    
## ELEMENTARYHILLTOP                            1.24e-01   7.63e-02    1.62  0.10475    
## ELEMENTARYHUGO & ONEKA                       3.26e-02   3.80e-02    0.86  0.39195    
## ELEMENTARYISLAND LAKE                        1.60e-01   6.07e-02    2.64  0.00839 ** 
## ELEMENTARYJACKSON                           -6.04e-01   7.22e-02   -8.37  < 2e-16 ***
## ELEMENTARYJEFFERS POND                       4.17e-01   7.18e-02    5.81  6.2e-09 ***
## ELEMENTARYJOHN F. KENNEDY                   -2.32e-02   1.13e-01   -0.21  0.83730    
## ELEMENTARYJOHNSON A+                        -2.81e-01   7.09e-02   -3.96  7.4e-05 ***
## ELEMENTARYJORDAN                             2.75e-01   2.83e-01    0.97  0.33081    
## ELEMENTARYKAPOSIA                            1.51e-01   7.42e-02    2.03  0.04218 *  
## ELEMENTARYLAKEAIRES                          3.01e-01   6.01e-02    5.00  5.7e-07 ***
## ELEMENTARYLAKE ELMO                          5.74e-02   3.81e-02    1.51  0.13178    
## ELEMENTARYLAKE MARION                        1.87e-02   9.41e-02    0.20  0.84275    
## ELEMENTARYLAKEVIEW                          -6.25e-02   7.59e-02   -0.82  0.41040    
## ELEMENTARYLIBERTY RIDGE                      1.68e-01   3.73e-02    4.49  7.0e-06 ***
## ELEMENTARYLINCOLN                            1.26e-01   6.20e-02    2.03  0.04212 *  
## ELEMENTARYLINO LAKES                        -4.27e-01   2.20e-01   -1.94  0.05296 .  
## ELEMENTARYLITTLE CANADA                      2.26e-01   6.76e-02    3.34  0.00083 ***
## ELEMENTARYMANN                               5.48e-01   5.78e-02    9.49  < 2e-16 ***
## ELEMENTARYMARION W. SAVAGE                   3.62e-01   7.39e-02    4.90  9.5e-07 ***
## ELEMENTARYMATOSKA INTERNATIONAL              2.83e-01   5.81e-02    4.88  1.1e-06 ***
## ELEMENTARYMEADOWVIEW                        -8.49e-02   7.87e-02   -1.08  0.28064    
## ELEMENTARYMENDOTA                            1.41e-01   7.83e-02    1.80  0.07182 .  
## ELEMENTARYMIDDLETON                          1.03e-01   4.08e-02    2.51  0.01194 *  
## ELEMENTARYMISSISSIPPI                        1.10e-01   7.41e-02    1.49  0.13612    
## ELEMENTARYMONROE                             7.20e-02   6.06e-02    1.19  0.23533    
## ELEMENTARYMORELAND                           2.05e-01   7.68e-02    2.67  0.00765 ** 
## ELEMENTARYNEWPORT                           -1.92e-03   4.91e-02   -0.04  0.96881    
## ELEMENTARYNORTH END                         -2.02e-01   6.08e-02   -3.32  0.00089 ***
## ELEMENTARYNORTH TRAIL                        5.10e-02   8.21e-02    0.62  0.53431    
## ELEMENTARYNORTHVIEW                          8.52e-03   8.01e-02    0.11  0.91527    
## ELEMENTARYOAKDALE                            1.41e-02   4.23e-02    0.33  0.73930    
## ELEMENTARYOAK HILLS                         -8.60e-02   8.59e-02   -1.00  0.31659    
## ELEMENTARYOAK RIDGE                          1.34e-01   8.51e-02    1.57  0.11658    
## ELEMENTARYOBAMA                              6.56e-01   8.99e-02    7.30  3.0e-13 ***
## ELEMENTARYORCHARD LAKE                       1.39e-01   8.15e-02    1.71  0.08762 .  
## ELEMENTARYOTTER LAKE                         1.69e-01   6.98e-02    2.42  0.01557 *  
## ELEMENTARYPARKVIEW                           2.48e-02   7.96e-02    0.31  0.75557    
## ELEMENTARYPEARSON                            2.78e-01   7.23e-02    3.85  0.00012 ***
## ELEMENTARYPHALEN LAKE                       -1.59e-01   6.31e-02   -2.52  0.01179 *  
## ELEMENTARYPILOT KNOB                         1.60e-01   8.41e-02    1.90  0.05734 .  
## ELEMENTARYPINE BEND                          5.89e-02   8.53e-02    0.69  0.48984    
## ELEMENTARYPINE HILL                          4.68e-02   4.23e-02    1.11  0.26852    
## ELEMENTARYPINEWOOD                           3.93e-02   5.92e-02    0.66  0.50706    
## ELEMENTARYPULLMAN                           -4.59e-02   4.35e-02   -1.06  0.29127    
## ELEMENTARYRAHN                               1.62e-01   7.99e-02    2.03  0.04235 *  
## ELEMENTARYRANDOLPH HEIGHTS                   6.82e-01   5.85e-02   11.66  < 2e-16 ***
## ELEMENTARYRED OAK                            3.72e-01   7.23e-02    5.14  2.7e-07 ***
## ELEMENTARYRED PINE                           2.25e-02   7.68e-02    0.29  0.76940    
## ELEMENTARYRED ROCK                           8.28e-02   4.44e-02    1.87  0.06202 .  
## ELEMENTARYREDTAIL RIDGE                      4.31e-01   7.08e-02    6.10  1.1e-09 ***
## ELEMENTARYRICHARDSON                         1.93e-01   5.83e-02    3.31  0.00095 ***
## ELEMENTARYRIVERVIEW                         -3.08e-02   7.64e-02   -0.40  0.68675    
## ELEMENTARYRIVERVIEW & CHEROKEE               1.43e-01   5.99e-02    2.38  0.01729 *  
## ELEMENTARYROSEMOUNT                          4.57e-02   8.07e-02    0.57  0.57119    
## ELEMENTARYROYAL OAKS                         8.47e-02   4.07e-02    2.08  0.03741 *  
## ELEMENTARYRUTHERFORD                        -7.41e-03   7.11e-02   -0.10  0.91707    
## ELEMENTARYSALEM HILLS                        9.17e-02   1.09e-01    0.84  0.39879    
## ELEMENTARYSHANNON PARK                      -3.03e-02   7.36e-02   -0.41  0.68082    
## ELEMENTARYSHERIDAN & AMES                    1.92e-02   5.72e-02    0.34  0.73697    
## ELEMENTARYSIOUX TRAIL                        1.10e-01   8.48e-02    1.29  0.19571    
## ELEMENTARYSKY OAKS                           7.88e-02   8.17e-02    0.97  0.33427    
## ELEMENTARYSKYVIEW                            8.07e-02   3.97e-02    2.04  0.04183 *  
## ELEMENTARYSOMERSET HEIGHTS                   2.10e-01   7.38e-02    2.85  0.00438 ** 
## ELEMENTARYSOUTHVIEW                          4.21e-02   7.55e-02    0.56  0.57687    
## ELEMENTARYST ANTHONY PARK                    7.37e-01   7.39e-02    9.97  < 2e-16 ***
## ELEMENTARYSUNNYSIDE                          1.56e-01   6.35e-02    2.45  0.01424 *  
## ELEMENTARYSUN PATH                           2.33e-01   6.98e-02    3.34  0.00085 ***
## ELEMENTARYSWEENEY                            2.29e-01   7.26e-02    3.15  0.00161 ** 
## ELEMENTARYTHOMAS LAKE                        5.08e-03   8.06e-02    0.06  0.94982    
## ELEMENTARYTURTLE LAKE                        2.18e-01   5.70e-02    3.83  0.00013 ***
## ELEMENTARYVADNAIS HEIGHTS                    1.15e-01   6.47e-02    1.77  0.07648 .  
## ELEMENTARYVALENTINE HILLS                    2.67e-01   6.00e-02    4.45  8.6e-06 ***
## ELEMENTARYVISTA VIEW                         1.78e-01   7.91e-02    2.25  0.02454 *  
## ELEMENTARYWEAVER                             1.47e-01   5.85e-02    2.51  0.01211 *  
## ELEMENTARYWEBSTER                            1.47e-01   6.65e-02    2.22  0.02668 *  
## ELEMENTARYWESTVIEW                           3.83e-02   7.75e-02    0.49  0.62124    
## ELEMENTARYWESTWOOD                           4.55e-01   7.44e-02    6.11  1.0e-09 ***
## ELEMENTARYWILLIAM BYRNE                      4.35e-02   8.11e-02    0.54  0.59125    
## ELEMENTARYWILLOW LANE                        1.28e-01   7.07e-02    1.81  0.07078 .  
## ELEMENTARYWILSHIRE PARK                      4.28e-01   1.19e-01    3.58  0.00034 ***
## ELEMENTARYWOODBURY                           1.54e-01   4.32e-02    3.56  0.00037 ***
## ELEMENTARYWOODLAND                           4.98e-02   7.99e-02    0.62  0.53343    
## WhiteDense                                   3.56e-01   2.07e-02   17.19  < 2e-16 ***
## fam_income                                   4.21e-06   2.18e-07   19.31  < 2e-16 ***
## factor(SALE_YEAR)2010                       -2.42e-02   5.96e-03   -4.06  5.0e-05 ***
## factor(SALE_YEAR)2011                       -1.67e-01   1.19e-02  -14.05  < 2e-16 ***
## factor(SALE_MONTH)2                         -1.47e-02   1.57e-02   -0.94  0.34738    
## factor(SALE_MONTH)3                          8.28e-03   1.47e-02    0.56  0.57258    
## factor(SALE_MONTH)4                          6.34e-03   1.44e-02    0.44  0.65941    
## factor(SALE_MONTH)5                          5.64e-02   1.44e-02    3.92  9.1e-05 ***
## factor(SALE_MONTH)6                          5.37e-02   1.44e-02    3.73  0.00020 ***
## factor(SALE_MONTH)7                          4.55e-02   1.51e-02    3.02  0.00252 ** 
## factor(SALE_MONTH)8                          2.97e-02   1.52e-02    1.95  0.05096 .  
## factor(SALE_MONTH)9                          1.64e-02   1.54e-02    1.06  0.28785    
## factor(SALE_MONTH)10                         5.75e-02   1.52e-02    3.79  0.00015 ***
## factor(SALE_MONTH)11                         3.40e-02   1.56e-02    2.18  0.02960 *  
## factor(SALE_MONTH)12                        -3.73e-02   1.67e-02   -2.23  0.02580 *  
## tenthkmSUM                                   1.56e-08   2.98e-08    0.52  0.60135    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.372 on 17804 degrees of freedom
##   (728 observations deleted due to missingness)
## Multiple R-squared: 0.662,	Adjusted R-squared: 0.658 
## F-statistic:  173 on 201 and 17804 DF,  p-value: <2e-16 
## 
```



```r
osiModel3 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    qtrkmSUM, data = HouseData)
summary(osiModel3)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + 
##     YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + 
##     factor(SALE_YEAR) + factor(SALE_MONTH) + qtrkmSUM, data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -4.747 -0.128  0.031  0.183  3.162 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                 -2.66e-02   3.70e-01   -0.07  0.94259    
## FIN_SQ_FT                                    2.98e-04   6.21e-06   47.90  < 2e-16 ***
## ACRES_POLY                                   4.53e-02   4.84e-03    9.38  < 2e-16 ***
## GARAGEsqft                                   1.78e-04   1.76e-05   10.13  < 2e-16 ***
## YEAR_BUILT                                   5.37e-03   1.84e-04   29.12  < 2e-16 ***
## HOME_STYLE1 1/2 STRY                         9.48e-02   1.19e-01    0.80  0.42406    
## HOME_STYLE1-1/2 STRY                         3.37e-01   1.03e-01    3.28  0.00105 ** 
## HOME_STYLE1 1/4 STRY                         5.93e-02   1.59e-01    0.37  0.70967    
## HOME_STYLE1-1/4 STRY                         3.18e-01   9.84e-02    3.24  0.00121 ** 
## HOME_STYLE1-2 STRY                           1.48e-01   9.99e-02    1.48  0.13959    
## HOME_STYLE1 3/4 STRY                         4.72e-01   1.44e-01    3.28  0.00104 ** 
## HOME_STYLE1-3/4 STRY                         4.31e-01   1.12e-01    3.85  0.00012 ***
## HOME_STYLE1 Story Brick                      5.83e-01   3.81e-01    1.53  0.12631    
## HOME_STYLE1 Story Condo                     -5.27e-01   9.01e-02   -5.85  5.1e-09 ***
## HOME_STYLE1 Story Frame                      2.52e-01   7.63e-02    3.30  0.00098 ***
## HOME_STYLE1 Story Townhouse                  1.73e-01   7.89e-02    2.19  0.02826 *  
## HOME_STYLE2 Story Condo                     -3.45e-01   8.16e-02   -4.23  2.4e-05 ***
## HOME_STYLE2 Story Frame                      1.90e-01   7.65e-02    2.48  0.01328 *  
## HOME_STYLE2 Story Townhouse                 -2.24e-01   7.75e-02   -2.89  0.00383 ** 
## HOME_STYLE3-LVL SPLT                         4.54e-02   1.04e-01    0.44  0.66276    
## HOME_STYLE4 LVL SPLT                         4.68e-02   1.01e-01    0.46  0.64308    
## HOME_STYLEBungalow                           2.06e-01   8.48e-02    2.43  0.01514 *  
## HOME_STYLECONDO                             -9.24e-01   1.14e-01   -8.14  4.3e-16 ***
## HOME_STYLEDUP/TRI                            1.70e-01   2.36e-01    0.72  0.47044    
## HOME_STYLEEARTH SHEL                        -2.75e-01   3.85e-01   -0.71  0.47565    
## HOME_STYLELOG                               -1.37e+00   3.85e-01   -3.57  0.00036 ***
## HOME_STYLEMfd Home (Double)                 -2.32e-01   3.81e-01   -0.61  0.54302    
## HOME_STYLEN/A                                1.24e-01   2.36e-01    0.52  0.59998    
## HOME_STYLEOne And 3/4 Story                  2.00e-01   8.57e-02    2.33  0.01998 *  
## HOME_STYLEOne Story                          1.59e-01   8.46e-02    1.89  0.05937 .  
## HOME_STYLEONE STORY                          2.40e-01   9.32e-02    2.58  0.00989 ** 
## HOME_STYLEOther                             -2.44e+00   3.85e-01   -6.32  2.6e-10 ***
## HOME_STYLERAMBLER                            2.49e-02   9.68e-02    0.26  0.79717    
## HOME_STYLESalvage                           -2.18e-02   2.28e-01   -0.10  0.92396    
## HOME_STYLESPLIT-ENT                         -1.03e-02   9.69e-02   -0.11  0.91520    
## HOME_STYLESplit/entry                        9.86e-02   8.59e-02    1.15  0.25090    
## HOME_STYLESPLIT-FOY                          4.34e-02   1.04e-01    0.42  0.67764    
## HOME_STYLESplit Foyer Frame                  2.43e-01   7.72e-02    3.15  0.00165 ** 
## HOME_STYLESplit/level                        1.70e-01   8.66e-02    1.96  0.04987 *  
## HOME_STYLESplit Level Frame                  3.12e-01   7.79e-02    4.01  6.0e-05 ***
## HOME_STYLESPLIT LEVL                         2.17e-01   9.31e-02    2.33  0.01957 *  
## HOME_STYLETOWNHOME                          -3.08e-01   9.60e-02   -3.21  0.00133 ** 
## HOME_STYLETWIN HOME                         -1.26e-01   1.04e-01   -1.20  0.22872    
## HOME_STYLETwo Story                          2.48e-01   8.52e-02    2.91  0.00367 ** 
## HOME_STYLETWO STORY                          2.24e-01   9.35e-02    2.39  0.01674 *  
## HOME_STYLETWO+ STORY                         2.76e-02   2.10e-01    0.13  0.89562    
## ELEMENTARYAKIN ROAD                         -4.61e-02   7.45e-02   -0.62  0.53633    
## ELEMENTARYANDERSEN                           1.28e-01   8.34e-02    1.54  0.12446    
## ELEMENTARYANDERSON & WILDWOOD                2.27e-01   4.29e-02    5.29  1.2e-07 ***
## ELEMENTARYARMSTRONG                          3.06e-03   4.62e-02    0.07  0.94711    
## ELEMENTARYBAILEY                             1.60e-01   3.95e-02    4.05  5.1e-05 ***
## ELEMENTARYBATTLE CREEK                       3.30e-01   7.57e-02    4.36  1.3e-05 ***
## ELEMENTARYBEL AIR                            2.70e-01   6.10e-02    4.43  9.7e-06 ***
## ELEMENTARYBIRCH LAKE                         1.47e-01   6.76e-02    2.17  0.02994 *  
## ELEMENTARYBRIMHALL                           4.83e-01   6.10e-02    7.92  2.5e-15 ***
## ELEMENTARYBRUCE F. VENTO                    -2.28e-01   6.36e-02   -3.59  0.00033 ***
## ELEMENTARYCARVER                             3.95e-02   5.94e-02    0.66  0.50632    
## ELEMENTARYCASTLE                             1.20e-01   4.14e-02    2.91  0.00367 ** 
## ELEMENTARYCEDAR PARK                         1.18e-01   8.21e-02    1.44  0.14992    
## ELEMENTARYCENTRAL PARK                       3.06e-01   6.46e-02    4.74  2.2e-06 ***
## ELEMENTARYCHELSEA HEIGHTS                    3.31e-01   5.75e-02    5.75  9.1e-09 ***
## ELEMENTARYCHERRY VIEW                       -6.69e-02   8.10e-02   -0.83  0.40866    
## ELEMENTARYCHRISTINA HUDDLESTON              -4.59e-02   7.95e-02   -0.58  0.56335    
## ELEMENTARYCOMO PARK                          2.90e-01   6.12e-02    4.73  2.2e-06 ***
## ELEMENTARYCOTTAGE GROVE                      8.17e-02   4.51e-02    1.81  0.07019 .  
## ELEMENTARYCOWERN                             8.59e-02   5.30e-02    1.62  0.10516    
## ELEMENTARYCRESTVIEW                         -8.63e-03   4.87e-02   -0.18  0.85932    
## ELEMENTARYCRYSTAL LAKE                      -3.72e-03   8.13e-02   -0.05  0.96354    
## ELEMENTARYDAYTONS BLUFF                     -1.38e-01   5.99e-02   -2.30  0.02154 *  
## ELEMENTARYDEERWOOD                           6.18e-02   8.17e-02    0.76  0.44897    
## ELEMENTARYDIAMOND PATH                       9.80e-02   7.69e-02    1.27  0.20290    
## ELEMENTARYEAGLE CREEK                        4.03e-01   6.88e-02    5.86  4.8e-09 ***
## ELEMENTARYEAGLE POINT                        6.19e-02   4.72e-02    1.31  0.18970    
## ELEMENTARYEASTERN HEIGHTS                    8.48e-03   5.86e-02    0.14  0.88487    
## ELEMENTARYEASTVIEW                           6.70e-03   8.65e-02    0.08  0.93822    
## ELEMENTARYECHO PARK                          3.06e-02   7.56e-02    0.40  0.68603    
## ELEMENTARYEDGERTON                           3.15e-01   6.49e-02    4.85  1.2e-06 ***
## ELEMENTARYEDWARD NEILL                       7.61e-02   7.83e-02    0.97  0.33148    
## ELEMENTARYEMMET D. WILLIAMS                  3.20e-01   6.19e-02    5.17  2.4e-07 ***
## ELEMENTARYFALCON HEIGHTS                     3.93e-01   6.14e-02    6.41  1.5e-10 ***
## ELEMENTARYFARMINGTON                        -2.96e-02   7.80e-02   -0.38  0.70400    
## ELEMENTARYFARNSWORTH LOWER                   4.14e-03   6.08e-02    0.07  0.94566    
## ELEMENTARYFIVE HAWKS                         4.52e-01   7.18e-02    6.30  3.1e-10 ***
## ELEMENTARYFOREST VIEW & FOREST LAKE         -3.81e-01   1.46e-01   -2.60  0.00931 ** 
## ELEMENTARYFRANKLIN MUSIC                     2.43e-01   1.62e-01    1.50  0.13316    
## ELEMENTARYFROST LAKE                         1.29e-01   6.57e-02    1.96  0.05012 .  
## ELEMENTARYGALTIER & MAXFIELD                 6.79e-02   5.82e-02    1.17  0.24371    
## ELEMENTARYGARLOUGH                           2.98e-01   8.28e-02    3.61  0.00031 ***
## ELEMENTARYGIDEON POND                        1.44e-01   8.49e-02    1.70  0.08972 .  
## ELEMENTARYGLACIER HILLS                      1.04e-01   8.67e-02    1.20  0.22986    
## ELEMENTARYGLENDALE                           4.01e-01   7.45e-02    5.38  7.4e-08 ***
## ELEMENTARYGRAINWOOD                          3.01e-01   7.41e-02    4.07  4.8e-05 ***
## ELEMENTARYGREENLEAF                         -8.34e-03   7.20e-02   -0.12  0.90775    
## ELEMENTARYGREY CLOUD                         5.91e-02   4.23e-02    1.40  0.16238    
## ELEMENTARYGROVELAND PARK                     6.57e-01   5.98e-02   10.99  < 2e-16 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  5.28e-01   5.94e-02    8.90  < 2e-16 ***
## ELEMENTARYHANCOCK                            3.11e-01   6.98e-02    4.46  8.3e-06 ***
## ELEMENTARYHARRIET BISHOP                     3.35e-01   7.80e-02    4.30  1.7e-05 ***
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -2.79e-03   5.67e-02   -0.05  0.96071    
## ELEMENTARYHIDDEN VALLEY                      3.97e-01   7.81e-02    5.08  3.8e-07 ***
## ELEMENTARYHIGHLAND                           5.12e-02   7.56e-02    0.68  0.49851    
## ELEMENTARYHIGHLAND PARK                      5.73e-01   5.91e-02    9.70  < 2e-16 ***
## ELEMENTARYHIGHWOOD HILLS                     1.91e-01   6.69e-02    2.85  0.00432 ** 
## ELEMENTARYHILLSIDE                           6.53e-02   4.61e-02    1.42  0.15678    
## ELEMENTARYHILLTOP                            1.26e-01   7.63e-02    1.66  0.09752 .  
## ELEMENTARYHUGO & ONEKA                       3.31e-02   3.80e-02    0.87  0.38386    
## ELEMENTARYISLAND LAKE                        1.63e-01   6.08e-02    2.68  0.00726 ** 
## ELEMENTARYJACKSON                           -6.00e-01   7.22e-02   -8.31  < 2e-16 ***
## ELEMENTARYJEFFERS POND                       4.17e-01   7.18e-02    5.81  6.3e-09 ***
## ELEMENTARYJOHN F. KENNEDY                   -1.94e-02   1.13e-01   -0.17  0.86329    
## ELEMENTARYJOHNSON A+                        -2.77e-01   7.09e-02   -3.90  9.5e-05 ***
## ELEMENTARYJORDAN                             2.69e-01   2.83e-01    0.95  0.34061    
## ELEMENTARYKAPOSIA                            1.53e-01   7.42e-02    2.07  0.03869 *  
## ELEMENTARYLAKEAIRES                          3.04e-01   6.01e-02    5.05  4.4e-07 ***
## ELEMENTARYLAKE ELMO                          6.15e-02   3.82e-02    1.61  0.10720    
## ELEMENTARYLAKE MARION                        2.08e-02   9.41e-02    0.22  0.82501    
## ELEMENTARYLAKEVIEW                          -6.06e-02   7.59e-02   -0.80  0.42457    
## ELEMENTARYLIBERTY RIDGE                      1.71e-01   3.73e-02    4.57  4.8e-06 ***
## ELEMENTARYLINCOLN                            1.29e-01   6.20e-02    2.08  0.03776 *  
## ELEMENTARYLINO LAKES                        -4.20e-01   2.20e-01   -1.90  0.05689 .  
## ELEMENTARYLITTLE CANADA                      2.28e-01   6.76e-02    3.37  0.00075 ***
## ELEMENTARYMANN                               5.53e-01   5.78e-02    9.56  < 2e-16 ***
## ELEMENTARYMARION W. SAVAGE                   3.62e-01   7.39e-02    4.90  9.6e-07 ***
## ELEMENTARYMATOSKA INTERNATIONAL              2.86e-01   5.81e-02    4.93  8.5e-07 ***
## ELEMENTARYMEADOWVIEW                        -8.29e-02   7.87e-02   -1.05  0.29212    
## ELEMENTARYMENDOTA                            1.42e-01   7.83e-02    1.82  0.06952 .  
## ELEMENTARYMIDDLETON                          1.07e-01   4.09e-02    2.61  0.00907 ** 
## ELEMENTARYMISSISSIPPI                        1.15e-01   7.41e-02    1.55  0.12213    
## ELEMENTARYMONROE                             7.63e-02   6.07e-02    1.26  0.20844    
## ELEMENTARYMORELAND                           2.08e-01   7.68e-02    2.70  0.00684 ** 
## ELEMENTARYNEWPORT                            2.40e-05   4.91e-02    0.00  0.99961    
## ELEMENTARYNORTH END                         -1.98e-01   6.08e-02   -3.25  0.00116 ** 
## ELEMENTARYNORTH TRAIL                        5.08e-02   8.21e-02    0.62  0.53585    
## ELEMENTARYNORTHVIEW                          1.01e-02   8.01e-02    0.13  0.89989    
## ELEMENTARYOAKDALE                            1.69e-02   4.23e-02    0.40  0.68890    
## ELEMENTARYOAK HILLS                         -8.54e-02   8.59e-02   -0.99  0.31994    
## ELEMENTARYOAK RIDGE                          1.36e-01   8.51e-02    1.60  0.11047    
## ELEMENTARYOBAMA                              6.61e-01   8.99e-02    7.35  2.0e-13 ***
## ELEMENTARYORCHARD LAKE                       1.40e-01   8.15e-02    1.71  0.08669 .  
## ELEMENTARYOTTER LAKE                         1.71e-01   6.98e-02    2.45  0.01413 *  
## ELEMENTARYPARKVIEW                           2.31e-02   7.96e-02    0.29  0.77207    
## ELEMENTARYPEARSON                            2.79e-01   7.22e-02    3.86  0.00012 ***
## ELEMENTARYPHALEN LAKE                       -1.54e-01   6.31e-02   -2.44  0.01450 *  
## ELEMENTARYPILOT KNOB                         1.61e-01   8.41e-02    1.91  0.05629 .  
## ELEMENTARYPINE BEND                          5.83e-02   8.53e-02    0.68  0.49468    
## ELEMENTARYPINE HILL                          4.98e-02   4.23e-02    1.18  0.23946    
## ELEMENTARYPINEWOOD                           4.22e-02   5.92e-02    0.71  0.47625    
## ELEMENTARYPULLMAN                           -4.21e-02   4.36e-02   -0.97  0.33345    
## ELEMENTARYRAHN                               1.65e-01   7.99e-02    2.06  0.03925 *  
## ELEMENTARYRANDOLPH HEIGHTS                   6.87e-01   5.86e-02   11.74  < 2e-16 ***
## ELEMENTARYRED OAK                            3.72e-01   7.23e-02    5.15  2.7e-07 ***
## ELEMENTARYRED PINE                           2.36e-02   7.68e-02    0.31  0.75900    
## ELEMENTARYRED ROCK                           8.66e-02   4.44e-02    1.95  0.05131 .  
## ELEMENTARYREDTAIL RIDGE                      4.30e-01   7.08e-02    6.08  1.3e-09 ***
## ELEMENTARYRICHARDSON                         1.95e-01   5.83e-02    3.35  0.00082 ***
## ELEMENTARYRIVERVIEW                         -3.49e-02   7.65e-02   -0.46  0.64790    
## ELEMENTARYRIVERVIEW & CHEROKEE               1.47e-01   5.99e-02    2.45  0.01422 *  
## ELEMENTARYROSEMOUNT                          4.82e-02   8.07e-02    0.60  0.55059    
## ELEMENTARYROYAL OAKS                         8.90e-02   4.07e-02    2.18  0.02892 *  
## ELEMENTARYRUTHERFORD                        -2.52e-03   7.12e-02   -0.04  0.97175    
## ELEMENTARYSALEM HILLS                        9.17e-02   1.09e-01    0.84  0.39875    
## ELEMENTARYSHANNON PARK                      -2.89e-02   7.36e-02   -0.39  0.69520    
## ELEMENTARYSHERIDAN & AMES                    2.40e-02   5.73e-02    0.42  0.67529    
## ELEMENTARYSIOUX TRAIL                        1.12e-01   8.48e-02    1.32  0.18723    
## ELEMENTARYSKY OAKS                           8.13e-02   8.17e-02    1.00  0.31921    
## ELEMENTARYSKYVIEW                            8.37e-02   3.97e-02    2.11  0.03489 *  
## ELEMENTARYSOMERSET HEIGHTS                   2.13e-01   7.38e-02    2.89  0.00386 ** 
## ELEMENTARYSOUTHVIEW                          4.54e-02   7.56e-02    0.60  0.54829    
## ELEMENTARYST ANTHONY PARK                    7.41e-01   7.39e-02   10.02  < 2e-16 ***
## ELEMENTARYSUNNYSIDE                          1.60e-01   6.35e-02    2.51  0.01203 *  
## ELEMENTARYSUN PATH                           2.34e-01   6.98e-02    3.35  0.00081 ***
## ELEMENTARYSWEENEY                            2.30e-01   7.26e-02    3.17  0.00154 ** 
## ELEMENTARYTHOMAS LAKE                        5.09e-03   8.06e-02    0.06  0.94963    
## ELEMENTARYTURTLE LAKE                        2.21e-01   5.70e-02    3.88  0.00011 ***
## ELEMENTARYVADNAIS HEIGHTS                    1.16e-01   6.47e-02    1.80  0.07229 .  
## ELEMENTARYVALENTINE HILLS                    2.70e-01   6.00e-02    4.51  6.7e-06 ***
## ELEMENTARYVISTA VIEW                         1.80e-01   7.91e-02    2.28  0.02258 *  
## ELEMENTARYWEAVER                             1.51e-01   5.85e-02    2.58  0.00997 ** 
## ELEMENTARYWEBSTER                            1.50e-01   6.65e-02    2.26  0.02373 *  
## ELEMENTARYWESTVIEW                           4.05e-02   7.75e-02    0.52  0.60114    
## ELEMENTARYWESTWOOD                           4.55e-01   7.44e-02    6.12  9.6e-10 ***
## ELEMENTARYWILLIAM BYRNE                      4.61e-02   8.11e-02    0.57  0.56997    
## ELEMENTARYWILLOW LANE                        1.31e-01   7.07e-02    1.85  0.06406 .  
## ELEMENTARYWILSHIRE PARK                      4.32e-01   1.19e-01    3.62  0.00030 ***
## ELEMENTARYWOODBURY                           1.58e-01   4.33e-02    3.66  0.00026 ***
## ELEMENTARYWOODLAND                           5.27e-02   7.99e-02    0.66  0.50986    
## WhiteDense                                   3.56e-01   2.07e-02   17.19  < 2e-16 ***
## fam_income                                   4.20e-06   2.18e-07   19.26  < 2e-16 ***
## factor(SALE_YEAR)2010                       -2.41e-02   5.96e-03   -4.05  5.2e-05 ***
## factor(SALE_YEAR)2011                       -1.66e-01   1.19e-02  -14.02  < 2e-16 ***
## factor(SALE_MONTH)2                         -1.44e-02   1.57e-02   -0.92  0.35810    
## factor(SALE_MONTH)3                          8.51e-03   1.47e-02    0.58  0.56201    
## factor(SALE_MONTH)4                          6.59e-03   1.44e-02    0.46  0.64667    
## factor(SALE_MONTH)5                          5.68e-02   1.44e-02    3.94  8.1e-05 ***
## factor(SALE_MONTH)6                          5.41e-02   1.44e-02    3.75  0.00018 ***
## factor(SALE_MONTH)7                          4.58e-02   1.51e-02    3.04  0.00237 ** 
## factor(SALE_MONTH)8                          3.01e-02   1.52e-02    1.98  0.04818 *  
## factor(SALE_MONTH)9                          1.69e-02   1.54e-02    1.10  0.27345    
## factor(SALE_MONTH)10                         5.78e-02   1.52e-02    3.81  0.00014 ***
## factor(SALE_MONTH)11                         3.44e-02   1.56e-02    2.20  0.02759 *  
## factor(SALE_MONTH)12                        -3.67e-02   1.67e-02   -2.20  0.02814 *  
## qtrkmSUM                                     9.74e-09   5.68e-09    1.72  0.08613 .  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.372 on 17804 degrees of freedom
##   (728 observations deleted due to missingness)
## Multiple R-squared: 0.662,	Adjusted R-squared: 0.658 
## F-statistic:  173 on 201 and 17804 DF,  p-value: <2e-16 
## 
```



```r
osiModel4 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    halfkmSUM, data = HouseData)
summary(osiModel4)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + 
##     YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + 
##     factor(SALE_YEAR) + factor(SALE_MONTH) + halfkmSUM, data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -4.747 -0.128  0.031  0.183  3.160 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                 -2.32e-02   3.70e-01   -0.06  0.95003    
## FIN_SQ_FT                                    2.98e-04   6.21e-06   47.90  < 2e-16 ***
## ACRES_POLY                                   4.54e-02   4.84e-03    9.40  < 2e-16 ***
## GARAGEsqft                                   1.79e-04   1.76e-05   10.14  < 2e-16 ***
## YEAR_BUILT                                   5.37e-03   1.84e-04   29.10  < 2e-16 ***
## HOME_STYLE1 1/2 STRY                         9.51e-02   1.19e-01    0.80  0.42268    
## HOME_STYLE1-1/2 STRY                         3.38e-01   1.03e-01    3.29  0.00101 ** 
## HOME_STYLE1 1/4 STRY                         5.94e-02   1.59e-01    0.37  0.70945    
## HOME_STYLE1-1/4 STRY                         3.20e-01   9.84e-02    3.25  0.00115 ** 
## HOME_STYLE1-2 STRY                           1.48e-01   9.99e-02    1.48  0.13770    
## HOME_STYLE1 3/4 STRY                         4.72e-01   1.44e-01    3.28  0.00105 ** 
## HOME_STYLE1-3/4 STRY                         4.32e-01   1.12e-01    3.86  0.00011 ***
## HOME_STYLE1 Story Brick                      5.82e-01   3.82e-01    1.53  0.12719    
## HOME_STYLE1 Story Condo                     -5.26e-01   9.02e-02   -5.84  5.4e-09 ***
## HOME_STYLE1 Story Frame                      2.52e-01   7.63e-02    3.30  0.00097 ***
## HOME_STYLE1 Story Townhouse                  1.73e-01   7.89e-02    2.19  0.02820 *  
## HOME_STYLE2 Story Condo                     -3.44e-01   8.16e-02   -4.22  2.5e-05 ***
## HOME_STYLE2 Story Frame                      1.90e-01   7.65e-02    2.48  0.01326 *  
## HOME_STYLE2 Story Townhouse                 -2.23e-01   7.75e-02   -2.88  0.00399 ** 
## HOME_STYLE3-LVL SPLT                         4.68e-02   1.04e-01    0.45  0.65346    
## HOME_STYLE4 LVL SPLT                         4.75e-02   1.01e-01    0.47  0.63829    
## HOME_STYLEBungalow                           2.06e-01   8.48e-02    2.43  0.01503 *  
## HOME_STYLECONDO                             -9.23e-01   1.14e-01   -8.13  4.7e-16 ***
## HOME_STYLEDUP/TRI                            1.71e-01   2.36e-01    0.73  0.46756    
## HOME_STYLEEARTH SHEL                        -2.74e-01   3.85e-01   -0.71  0.47786    
## HOME_STYLELOG                               -1.37e+00   3.85e-01   -3.56  0.00037 ***
## HOME_STYLEMfd Home (Double)                 -2.29e-01   3.81e-01   -0.60  0.54719    
## HOME_STYLEN/A                                1.27e-01   2.36e-01    0.54  0.58850    
## HOME_STYLEOne And 3/4 Story                  2.00e-01   8.57e-02    2.33  0.01990 *  
## HOME_STYLEOne Story                          1.60e-01   8.46e-02    1.89  0.05903 .  
## HOME_STYLEONE STORY                          2.42e-01   9.33e-02    2.59  0.00959 ** 
## HOME_STYLEOther                             -2.44e+00   3.85e-01   -6.33  2.5e-10 ***
## HOME_STYLERAMBLER                            2.56e-02   9.69e-02    0.26  0.79134    
## HOME_STYLESalvage                           -2.35e-02   2.28e-01   -0.10  0.91813    
## HOME_STYLESPLIT-ENT                         -9.55e-03   9.70e-02   -0.10  0.92155    
## HOME_STYLESplit/entry                        9.91e-02   8.59e-02    1.15  0.24895    
## HOME_STYLESPLIT-FOY                          4.45e-02   1.04e-01    0.43  0.66986    
## HOME_STYLESplit Foyer Frame                  2.43e-01   7.72e-02    3.15  0.00165 ** 
## HOME_STYLESplit/level                        1.70e-01   8.66e-02    1.96  0.05003 .  
## HOME_STYLESplit Level Frame                  3.13e-01   7.79e-02    4.01  6.0e-05 ***
## HOME_STYLESPLIT LEVL                         2.18e-01   9.31e-02    2.34  0.01910 *  
## HOME_STYLETOWNHOME                          -3.07e-01   9.60e-02   -3.19  0.00140 ** 
## HOME_STYLETWIN HOME                         -1.24e-01   1.04e-01   -1.19  0.23363    
## HOME_STYLETwo Story                          2.48e-01   8.52e-02    2.91  0.00364 ** 
## HOME_STYLETWO STORY                          2.25e-01   9.35e-02    2.41  0.01616 *  
## HOME_STYLETWO+ STORY                         2.96e-02   2.10e-01    0.14  0.88812    
## ELEMENTARYAKIN ROAD                         -4.86e-02   7.45e-02   -0.65  0.51406    
## ELEMENTARYANDERSEN                           1.27e-01   8.34e-02    1.53  0.12656    
## ELEMENTARYANDERSON & WILDWOOD                2.25e-01   4.29e-02    5.26  1.4e-07 ***
## ELEMENTARYARMSTRONG                          2.45e-03   4.62e-02    0.05  0.95780    
## ELEMENTARYBAILEY                             1.59e-01   3.95e-02    4.03  5.7e-05 ***
## ELEMENTARYBATTLE CREEK                       3.29e-01   7.57e-02    4.34  1.4e-05 ***
## ELEMENTARYBEL AIR                            2.68e-01   6.10e-02    4.40  1.1e-05 ***
## ELEMENTARYBIRCH LAKE                         1.45e-01   6.76e-02    2.15  0.03187 *  
## ELEMENTARYBRIMHALL                           4.81e-01   6.09e-02    7.90  3.1e-15 ***
## ELEMENTARYBRUCE F. VENTO                    -2.30e-01   6.36e-02   -3.61  0.00031 ***
## ELEMENTARYCARVER                             3.82e-02   5.94e-02    0.64  0.51968    
## ELEMENTARYCASTLE                             1.20e-01   4.14e-02    2.89  0.00390 ** 
## ELEMENTARYCEDAR PARK                         1.17e-01   8.21e-02    1.42  0.15556    
## ELEMENTARYCENTRAL PARK                       3.04e-01   6.46e-02    4.71  2.5e-06 ***
## ELEMENTARYCHELSEA HEIGHTS                    3.29e-01   5.75e-02    5.73  1.0e-08 ***
## ELEMENTARYCHERRY VIEW                       -6.92e-02   8.10e-02   -0.85  0.39283    
## ELEMENTARYCHRISTINA HUDDLESTON              -4.71e-02   7.95e-02   -0.59  0.55353    
## ELEMENTARYCOMO PARK                          2.88e-01   6.12e-02    4.71  2.5e-06 ***
## ELEMENTARYCOTTAGE GROVE                      8.05e-02   4.51e-02    1.78  0.07448 .  
## ELEMENTARYCOWERN                             8.41e-02   5.30e-02    1.59  0.11266    
## ELEMENTARYCRESTVIEW                         -9.31e-03   4.87e-02   -0.19  0.84849    
## ELEMENTARYCRYSTAL LAKE                      -6.26e-03   8.13e-02   -0.08  0.93862    
## ELEMENTARYDAYTONS BLUFF                     -1.39e-01   5.99e-02   -2.32  0.02021 *  
## ELEMENTARYDEERWOOD                           5.97e-02   8.17e-02    0.73  0.46467    
## ELEMENTARYDIAMOND PATH                       9.62e-02   7.69e-02    1.25  0.21112    
## ELEMENTARYEAGLE CREEK                        4.00e-01   6.89e-02    5.81  6.2e-09 ***
## ELEMENTARYEAGLE POINT                        6.12e-02   4.72e-02    1.30  0.19509    
## ELEMENTARYEASTERN HEIGHTS                    7.22e-03   5.86e-02    0.12  0.90189    
## ELEMENTARYEASTVIEW                           3.95e-03   8.65e-02    0.05  0.96357    
## ELEMENTARYECHO PARK                          2.86e-02   7.56e-02    0.38  0.70486    
## ELEMENTARYEDGERTON                           3.13e-01   6.48e-02    4.83  1.4e-06 ***
## ELEMENTARYEDWARD NEILL                       7.39e-02   7.83e-02    0.94  0.34520    
## ELEMENTARYEMMET D. WILLIAMS                  3.18e-01   6.18e-02    5.14  2.7e-07 ***
## ELEMENTARYFALCON HEIGHTS                     3.92e-01   6.14e-02    6.39  1.7e-10 ***
## ELEMENTARYFARMINGTON                        -3.29e-02   7.80e-02   -0.42  0.67312    
## ELEMENTARYFARNSWORTH LOWER                   2.67e-03   6.08e-02    0.04  0.96502    
## ELEMENTARYFIVE HAWKS                         4.49e-01   7.18e-02    6.25  4.1e-10 ***
## ELEMENTARYFOREST VIEW & FOREST LAKE         -3.83e-01   1.46e-01   -2.62  0.00884 ** 
## ELEMENTARYFRANKLIN MUSIC                     2.41e-01   1.62e-01    1.49  0.13566    
## ELEMENTARYFROST LAKE                         1.27e-01   6.57e-02    1.94  0.05246 .  
## ELEMENTARYGALTIER & MAXFIELD                 6.65e-02   5.82e-02    1.14  0.25368    
## ELEMENTARYGARLOUGH                           2.96e-01   8.28e-02    3.58  0.00035 ***
## ELEMENTARYGIDEON POND                        1.43e-01   8.49e-02    1.68  0.09311 .  
## ELEMENTARYGLACIER HILLS                      1.02e-01   8.67e-02    1.18  0.23846    
## ELEMENTARYGLENDALE                           3.99e-01   7.45e-02    5.35  8.8e-08 ***
## ELEMENTARYGRAINWOOD                          2.99e-01   7.41e-02    4.04  5.4e-05 ***
## ELEMENTARYGREENLEAF                         -9.95e-03   7.20e-02   -0.14  0.89007    
## ELEMENTARYGREY CLOUD                         5.80e-02   4.23e-02    1.37  0.17054    
## ELEMENTARYGROVELAND PARK                     6.56e-01   5.98e-02   10.97  < 2e-16 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  5.27e-01   5.94e-02    8.87  < 2e-16 ***
## ELEMENTARYHANCOCK                            3.09e-01   6.97e-02    4.43  9.5e-06 ***
## ELEMENTARYHARRIET BISHOP                     3.33e-01   7.79e-02    4.28  1.9e-05 ***
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -4.21e-03   5.67e-02   -0.07  0.94080    
## ELEMENTARYHIDDEN VALLEY                      3.95e-01   7.81e-02    5.05  4.4e-07 ***
## ELEMENTARYHIGHLAND                           4.80e-02   7.56e-02    0.63  0.52544    
## ELEMENTARYHIGHLAND PARK                      5.72e-01   5.91e-02    9.67  < 2e-16 ***
## ELEMENTARYHIGHWOOD HILLS                     1.89e-01   6.68e-02    2.83  0.00461 ** 
## ELEMENTARYHILLSIDE                           6.43e-02   4.61e-02    1.40  0.16300    
## ELEMENTARYHILLTOP                            1.24e-01   7.63e-02    1.63  0.10351    
## ELEMENTARYHUGO & ONEKA                       3.19e-02   3.80e-02    0.84  0.40094    
## ELEMENTARYISLAND LAKE                        1.62e-01   6.07e-02    2.66  0.00776 ** 
## ELEMENTARYJACKSON                           -6.01e-01   7.22e-02   -8.32  < 2e-16 ***
## ELEMENTARYJEFFERS POND                       4.15e-01   7.18e-02    5.78  7.7e-09 ***
## ELEMENTARYJOHN F. KENNEDY                   -2.18e-02   1.13e-01   -0.19  0.84715    
## ELEMENTARYJOHNSON A+                        -2.79e-01   7.09e-02   -3.93  8.6e-05 ***
## ELEMENTARYJORDAN                             2.66e-01   2.83e-01    0.94  0.34732    
## ELEMENTARYKAPOSIA                            1.52e-01   7.42e-02    2.05  0.04062 *  
## ELEMENTARYLAKEAIRES                          3.03e-01   6.01e-02    5.03  4.9e-07 ***
## ELEMENTARYLAKE ELMO                          6.01e-02   3.81e-02    1.58  0.11498    
## ELEMENTARYLAKE MARION                        1.82e-02   9.41e-02    0.19  0.84632    
## ELEMENTARYLAKEVIEW                          -6.26e-02   7.59e-02   -0.82  0.40960    
## ELEMENTARYLIBERTY RIDGE                      1.70e-01   3.73e-02    4.55  5.4e-06 ***
## ELEMENTARYLINCOLN                            1.27e-01   6.20e-02    2.05  0.04054 *  
## ELEMENTARYLINO LAKES                        -4.22e-01   2.20e-01   -1.92  0.05531 .  
## ELEMENTARYLITTLE CANADA                      2.26e-01   6.76e-02    3.35  0.00081 ***
## ELEMENTARYMANN                               5.52e-01   5.78e-02    9.54  < 2e-16 ***
## ELEMENTARYMARION W. SAVAGE                   3.61e-01   7.39e-02    4.88  1.1e-06 ***
## ELEMENTARYMATOSKA INTERNATIONAL              2.85e-01   5.81e-02    4.91  9.4e-07 ***
## ELEMENTARYMEADOWVIEW                        -8.65e-02   7.87e-02   -1.10  0.27190    
## ELEMENTARYMENDOTA                            1.40e-01   7.83e-02    1.78  0.07445 .  
## ELEMENTARYMIDDLETON                          1.06e-01   4.09e-02    2.59  0.00966 ** 
## ELEMENTARYMISSISSIPPI                        1.13e-01   7.41e-02    1.53  0.12602    
## ELEMENTARYMONROE                             7.52e-02   6.07e-02    1.24  0.21506    
## ELEMENTARYMORELAND                           2.06e-01   7.68e-02    2.69  0.00722 ** 
## ELEMENTARYNEWPORT                           -1.52e-03   4.90e-02   -0.03  0.97529    
## ELEMENTARYNORTH END                         -1.99e-01   6.08e-02   -3.27  0.00107 ** 
## ELEMENTARYNORTH TRAIL                        5.04e-02   8.21e-02    0.61  0.53932    
## ELEMENTARYNORTHVIEW                          8.50e-03   8.01e-02    0.11  0.91549    
## ELEMENTARYOAKDALE                            1.57e-02   4.23e-02    0.37  0.70974    
## ELEMENTARYOAK HILLS                         -8.62e-02   8.59e-02   -1.00  0.31531    
## ELEMENTARYOAK RIDGE                          1.34e-01   8.51e-02    1.58  0.11490    
## ELEMENTARYOBAMA                              6.60e-01   8.99e-02    7.34  2.2e-13 ***
## ELEMENTARYORCHARD LAKE                       1.37e-01   8.15e-02    1.68  0.09257 .  
## ELEMENTARYOTTER LAKE                         1.69e-01   6.98e-02    2.42  0.01557 *  
## ELEMENTARYPARKVIEW                           2.30e-02   7.96e-02    0.29  0.77278    
## ELEMENTARYPEARSON                            2.77e-01   7.22e-02    3.84  0.00013 ***
## ELEMENTARYPHALEN LAKE                       -1.56e-01   6.31e-02   -2.46  0.01374 *  
## ELEMENTARYPILOT KNOB                         1.59e-01   8.41e-02    1.89  0.05910 .  
## ELEMENTARYPINE BEND                          5.70e-02   8.53e-02    0.67  0.50419    
## ELEMENTARYPINE HILL                          4.68e-02   4.22e-02    1.11  0.26765    
## ELEMENTARYPINEWOOD                           4.03e-02   5.92e-02    0.68  0.49554    
## ELEMENTARYPULLMAN                           -4.40e-02   4.35e-02   -1.01  0.31232    
## ELEMENTARYRAHN                               1.63e-01   7.99e-02    2.04  0.04134 *  
## ELEMENTARYRANDOLPH HEIGHTS                   6.86e-01   5.86e-02   11.72  < 2e-16 ***
## ELEMENTARYRED OAK                            3.71e-01   7.23e-02    5.14  2.8e-07 ***
## ELEMENTARYRED PINE                           2.11e-02   7.68e-02    0.28  0.78315    
## ELEMENTARYRED ROCK                           8.55e-02   4.44e-02    1.92  0.05425 .  
## ELEMENTARYREDTAIL RIDGE                      4.29e-01   7.08e-02    6.06  1.4e-09 ***
## ELEMENTARYRICHARDSON                         1.94e-01   5.83e-02    3.32  0.00089 ***
## ELEMENTARYRIVERVIEW                         -3.60e-02   7.65e-02   -0.47  0.63825    
## ELEMENTARYRIVERVIEW & CHEROKEE               1.46e-01   5.99e-02    2.43  0.01507 *  
## ELEMENTARYROSEMOUNT                          4.60e-02   8.07e-02    0.57  0.56862    
## ELEMENTARYROYAL OAKS                         8.78e-02   4.07e-02    2.16  0.03115 *  
## ELEMENTARYRUTHERFORD                        -2.99e-03   7.12e-02   -0.04  0.96647    
## ELEMENTARYSALEM HILLS                        8.88e-02   1.09e-01    0.82  0.41402    
## ELEMENTARYSHANNON PARK                      -3.06e-02   7.36e-02   -0.42  0.67746    
## ELEMENTARYSHERIDAN & AMES                    2.27e-02   5.73e-02    0.40  0.69176    
## ELEMENTARYSIOUX TRAIL                        1.08e-01   8.48e-02    1.28  0.20171    
## ELEMENTARYSKY OAKS                           7.95e-02   8.16e-02    0.97  0.32991    
## ELEMENTARYSKYVIEW                            8.23e-02   3.97e-02    2.08  0.03791 *  
## ELEMENTARYSOMERSET HEIGHTS                   2.11e-01   7.38e-02    2.86  0.00424 ** 
## ELEMENTARYSOUTHVIEW                          4.37e-02   7.55e-02    0.58  0.56285    
## ELEMENTARYST ANTHONY PARK                    7.40e-01   7.39e-02   10.01  < 2e-16 ***
## ELEMENTARYSUNNYSIDE                          1.58e-01   6.35e-02    2.49  0.01274 *  
## ELEMENTARYSUN PATH                           2.31e-01   6.98e-02    3.32  0.00091 ***
## ELEMENTARYSWEENEY                            2.29e-01   7.26e-02    3.15  0.00164 ** 
## ELEMENTARYTHOMAS LAKE                        3.62e-03   8.06e-02    0.04  0.96419    
## ELEMENTARYTURTLE LAKE                        2.19e-01   5.70e-02    3.85  0.00012 ***
## ELEMENTARYVADNAIS HEIGHTS                    1.15e-01   6.47e-02    1.78  0.07549 .  
## ELEMENTARYVALENTINE HILLS                    2.69e-01   6.00e-02    4.48  7.5e-06 ***
## ELEMENTARYVISTA VIEW                         1.78e-01   7.91e-02    2.25  0.02417 *  
## ELEMENTARYWEAVER                             1.49e-01   5.85e-02    2.55  0.01086 *  
## ELEMENTARYWEBSTER                            1.49e-01   6.65e-02    2.24  0.02495 *  
## ELEMENTARYWESTVIEW                           3.87e-02   7.75e-02    0.50  0.61744    
## ELEMENTARYWESTWOOD                           4.52e-01   7.44e-02    6.08  1.3e-09 ***
## ELEMENTARYWILLIAM BYRNE                      4.45e-02   8.11e-02    0.55  0.58327    
## ELEMENTARYWILLOW LANE                        1.30e-01   7.07e-02    1.83  0.06654 .  
## ELEMENTARYWILSHIRE PARK                      4.31e-01   1.19e-01    3.61  0.00031 ***
## ELEMENTARYWOODBURY                           1.57e-01   4.33e-02    3.63  0.00028 ***
## ELEMENTARYWOODLAND                           4.98e-02   7.99e-02    0.62  0.53277    
## WhiteDense                                   3.56e-01   2.07e-02   17.18  < 2e-16 ***
## fam_income                                   4.20e-06   2.18e-07   19.26  < 2e-16 ***
## factor(SALE_YEAR)2010                       -2.41e-02   5.96e-03   -4.05  5.2e-05 ***
## factor(SALE_YEAR)2011                       -1.66e-01   1.19e-02  -14.04  < 2e-16 ***
## factor(SALE_MONTH)2                         -1.45e-02   1.57e-02   -0.93  0.35427    
## factor(SALE_MONTH)3                          8.42e-03   1.47e-02    0.57  0.56611    
## factor(SALE_MONTH)4                          6.54e-03   1.44e-02    0.45  0.64913    
## factor(SALE_MONTH)5                          5.66e-02   1.44e-02    3.93  8.6e-05 ***
## factor(SALE_MONTH)6                          5.40e-02   1.44e-02    3.75  0.00018 ***
## factor(SALE_MONTH)7                          4.56e-02   1.51e-02    3.03  0.00246 ** 
## factor(SALE_MONTH)8                          2.99e-02   1.52e-02    1.97  0.04933 *  
## factor(SALE_MONTH)9                          1.67e-02   1.54e-02    1.08  0.28033    
## factor(SALE_MONTH)10                         5.76e-02   1.52e-02    3.80  0.00015 ***
## factor(SALE_MONTH)11                         3.42e-02   1.56e-02    2.19  0.02870 *  
## factor(SALE_MONTH)12                        -3.69e-02   1.67e-02   -2.20  0.02748 *  
## halfkmSUM                                    1.94e-09   1.41e-09    1.37  0.16999    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.372 on 17804 degrees of freedom
##   (728 observations deleted due to missingness)
## Multiple R-squared: 0.662,	Adjusted R-squared: 0.658 
## F-statistic:  173 on 201 and 17804 DF,  p-value: <2e-16 
## 
```



```r
osiModel5 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    onekmSUM, data = HouseData)
summary(osiModel5)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + 
##     YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + 
##     factor(SALE_YEAR) + factor(SALE_MONTH) + onekmSUM, data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -4.751 -0.129  0.031  0.183  3.160 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                 -3.19e-02   3.70e-01   -0.09  0.93134    
## FIN_SQ_FT                                    2.98e-04   6.21e-06   47.94  < 2e-16 ***
## ACRES_POLY                                   4.58e-02   4.83e-03    9.49  < 2e-16 ***
## GARAGEsqft                                   1.78e-04   1.76e-05   10.11  < 2e-16 ***
## YEAR_BUILT                                   5.38e-03   1.84e-04   29.16  < 2e-16 ***
## HOME_STYLE1 1/2 STRY                         9.08e-02   1.19e-01    0.77  0.44421    
## HOME_STYLE1-1/2 STRY                         3.33e-01   1.03e-01    3.24  0.00120 ** 
## HOME_STYLE1 1/4 STRY                         5.35e-02   1.59e-01    0.34  0.73712    
## HOME_STYLE1-1/4 STRY                         3.15e-01   9.86e-02    3.19  0.00141 ** 
## HOME_STYLE1-2 STRY                           1.43e-01   1.00e-01    1.43  0.15137    
## HOME_STYLE1 3/4 STRY                         4.65e-01   1.44e-01    3.23  0.00123 ** 
## HOME_STYLE1-3/4 STRY                         4.27e-01   1.12e-01    3.81  0.00014 ***
## HOME_STYLE1 Story Brick                      5.88e-01   3.82e-01    1.54  0.12311    
## HOME_STYLE1 Story Condo                     -5.27e-01   9.02e-02   -5.84  5.3e-09 ***
## HOME_STYLE1 Story Frame                      2.52e-01   7.63e-02    3.30  0.00096 ***
## HOME_STYLE1 Story Townhouse                  1.72e-01   7.89e-02    2.19  0.02883 *  
## HOME_STYLE2 Story Condo                     -3.45e-01   8.16e-02   -4.23  2.4e-05 ***
## HOME_STYLE2 Story Frame                      1.90e-01   7.65e-02    2.48  0.01300 *  
## HOME_STYLE2 Story Townhouse                 -2.23e-01   7.75e-02   -2.88  0.00402 ** 
## HOME_STYLE3-LVL SPLT                         4.03e-02   1.04e-01    0.39  0.69962    
## HOME_STYLE4 LVL SPLT                         4.09e-02   1.01e-01    0.40  0.68607    
## HOME_STYLEBungalow                           2.04e-01   8.49e-02    2.40  0.01642 *  
## HOME_STYLECONDO                             -9.28e-01   1.14e-01   -8.17  3.4e-16 ***
## HOME_STYLEDUP/TRI                            1.63e-01   2.36e-01    0.69  0.48886    
## HOME_STYLEEARTH SHEL                        -2.87e-01   3.85e-01   -0.74  0.45719    
## HOME_STYLELOG                               -1.38e+00   3.85e-01   -3.57  0.00035 ***
## HOME_STYLEMfd Home (Double)                 -2.32e-01   3.81e-01   -0.61  0.54255    
## HOME_STYLEN/A                                1.25e-01   2.36e-01    0.53  0.59478    
## HOME_STYLEOne And 3/4 Story                  1.97e-01   8.58e-02    2.30  0.02155 *  
## HOME_STYLEOne Story                          1.57e-01   8.46e-02    1.86  0.06333 .  
## HOME_STYLEONE STORY                          2.37e-01   9.34e-02    2.53  0.01132 *  
## HOME_STYLEOther                             -2.44e+00   3.85e-01   -6.33  2.4e-10 ***
## HOME_STYLERAMBLER                            2.10e-02   9.70e-02    0.22  0.82824    
## HOME_STYLESalvage                           -2.04e-02   2.28e-01   -0.09  0.92872    
## HOME_STYLESPLIT-ENT                         -1.53e-02   9.71e-02   -0.16  0.87486    
## HOME_STYLESplit/entry                        9.65e-02   8.60e-02    1.12  0.26168    
## HOME_STYLESPLIT-FOY                          3.94e-02   1.04e-01    0.38  0.70577    
## HOME_STYLESplit Foyer Frame                  2.43e-01   7.73e-02    3.15  0.00164 ** 
## HOME_STYLESplit/level                        1.67e-01   8.66e-02    1.93  0.05359 .  
## HOME_STYLESplit Level Frame                  3.12e-01   7.79e-02    4.01  6.2e-05 ***
## HOME_STYLESPLIT LEVL                         2.13e-01   9.33e-02    2.28  0.02252 *  
## HOME_STYLETOWNHOME                          -3.12e-01   9.61e-02   -3.24  0.00118 ** 
## HOME_STYLETWIN HOME                         -1.30e-01   1.05e-01   -1.24  0.21320    
## HOME_STYLETwo Story                          2.45e-01   8.53e-02    2.87  0.00407 ** 
## HOME_STYLETWO STORY                          2.21e-01   9.36e-02    2.36  0.01850 *  
## HOME_STYLETWO+ STORY                         2.33e-02   2.10e-01    0.11  0.91185    
## ELEMENTARYAKIN ROAD                         -4.81e-02   7.47e-02   -0.64  0.51942    
## ELEMENTARYANDERSEN                           1.24e-01   8.34e-02    1.48  0.13837    
## ELEMENTARYANDERSON & WILDWOOD                2.25e-01   4.29e-02    5.25  1.6e-07 ***
## ELEMENTARYARMSTRONG                         -2.26e-03   4.62e-02   -0.05  0.96103    
## ELEMENTARYBAILEY                             1.56e-01   3.95e-02    3.95  7.9e-05 ***
## ELEMENTARYBATTLE CREEK                       3.24e-01   7.57e-02    4.28  1.9e-05 ***
## ELEMENTARYBEL AIR                            2.65e-01   6.09e-02    4.35  1.4e-05 ***
## ELEMENTARYBIRCH LAKE                         1.43e-01   6.76e-02    2.12  0.03415 *  
## ELEMENTARYBRIMHALL                           4.77e-01   6.09e-02    7.83  5.1e-15 ***
## ELEMENTARYBRUCE F. VENTO                    -2.34e-01   6.36e-02   -3.68  0.00023 ***
## ELEMENTARYCARVER                             3.40e-02   5.93e-02    0.57  0.56626    
## ELEMENTARYCASTLE                             1.16e-01   4.14e-02    2.81  0.00500 ** 
## ELEMENTARYCEDAR PARK                         1.15e-01   8.21e-02    1.40  0.16151    
## ELEMENTARYCENTRAL PARK                       3.01e-01   6.45e-02    4.66  3.2e-06 ***
## ELEMENTARYCHELSEA HEIGHTS                    3.24e-01   5.75e-02    5.64  1.7e-08 ***
## ELEMENTARYCHERRY VIEW                       -7.12e-02   8.10e-02   -0.88  0.37941    
## ELEMENTARYCHRISTINA HUDDLESTON              -4.93e-02   7.95e-02   -0.62  0.53519    
## ELEMENTARYCOMO PARK                          2.83e-01   6.11e-02    4.63  3.6e-06 ***
## ELEMENTARYCOTTAGE GROVE                      7.70e-02   4.51e-02    1.71  0.08771 .  
## ELEMENTARYCOWERN                             8.13e-02   5.30e-02    1.53  0.12497    
## ELEMENTARYCRESTVIEW                         -1.34e-02   4.87e-02   -0.27  0.78397    
## ELEMENTARYCRYSTAL LAKE                      -5.88e-03   8.13e-02   -0.07  0.94235    
## ELEMENTARYDAYTONS BLUFF                     -1.44e-01   5.99e-02   -2.40  0.01631 *  
## ELEMENTARYDEERWOOD                           5.95e-02   8.17e-02    0.73  0.46635    
## ELEMENTARYDIAMOND PATH                       9.57e-02   7.70e-02    1.24  0.21348    
## ELEMENTARYEAGLE CREEK                        4.04e-01   6.90e-02    5.86  4.6e-09 ***
## ELEMENTARYEAGLE POINT                        5.71e-02   4.72e-02    1.21  0.22642    
## ELEMENTARYEASTERN HEIGHTS                    2.40e-03   5.85e-02    0.04  0.96724    
## ELEMENTARYEASTVIEW                           5.35e-03   8.65e-02    0.06  0.95073    
## ELEMENTARYECHO PARK                          2.76e-02   7.56e-02    0.37  0.71496    
## ELEMENTARYEDGERTON                           3.10e-01   6.48e-02    4.78  1.8e-06 ***
## ELEMENTARYEDWARD NEILL                       7.24e-02   7.83e-02    0.92  0.35550    
## ELEMENTARYEMMET D. WILLIAMS                  3.16e-01   6.18e-02    5.11  3.3e-07 ***
## ELEMENTARYFALCON HEIGHTS                     3.88e-01   6.13e-02    6.32  2.7e-10 ***
## ELEMENTARYFARMINGTON                        -3.10e-02   7.82e-02   -0.40  0.69179    
## ELEMENTARYFARNSWORTH LOWER                  -2.08e-03   6.08e-02   -0.03  0.97274    
## ELEMENTARYFIVE HAWKS                         4.53e-01   7.19e-02    6.30  3.0e-10 ***
## ELEMENTARYFOREST VIEW & FOREST LAKE         -3.87e-01   1.46e-01   -2.65  0.00811 ** 
## ELEMENTARYFRANKLIN MUSIC                     2.36e-01   1.62e-01    1.46  0.14489    
## ELEMENTARYFROST LAKE                         1.22e-01   6.56e-02    1.86  0.06289 .  
## ELEMENTARYGALTIER & MAXFIELD                 6.20e-02   5.82e-02    1.07  0.28686    
## ELEMENTARYGARLOUGH                           2.97e-01   8.28e-02    3.58  0.00034 ***
## ELEMENTARYGIDEON POND                        1.41e-01   8.49e-02    1.66  0.09748 .  
## ELEMENTARYGLACIER HILLS                      1.04e-01   8.68e-02    1.20  0.22916    
## ELEMENTARYGLENDALE                           4.00e-01   7.46e-02    5.37  8.0e-08 ***
## ELEMENTARYGRAINWOOD                          3.02e-01   7.42e-02    4.08  4.6e-05 ***
## ELEMENTARYGREENLEAF                         -1.20e-02   7.20e-02   -0.17  0.86730    
## ELEMENTARYGREY CLOUD                         5.38e-02   4.22e-02    1.27  0.20296    
## ELEMENTARYGROVELAND PARK                     6.51e-01   5.97e-02   10.89  < 2e-16 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  5.22e-01   5.93e-02    8.79  < 2e-16 ***
## ELEMENTARYHANCOCK                            3.05e-01   6.97e-02    4.38  1.2e-05 ***
## ELEMENTARYHARRIET BISHOP                     3.33e-01   7.80e-02    4.27  1.9e-05 ***
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -8.79e-03   5.66e-02   -0.16  0.87670    
## ELEMENTARYHIDDEN VALLEY                      3.96e-01   7.82e-02    5.07  4.1e-07 ***
## ELEMENTARYHIGHLAND                           4.89e-02   7.56e-02    0.65  0.51794    
## ELEMENTARYHIGHLAND PARK                      5.66e-01   5.90e-02    9.58  < 2e-16 ***
## ELEMENTARYHIGHWOOD HILLS                     1.86e-01   6.68e-02    2.78  0.00549 ** 
## ELEMENTARYHILLSIDE                           5.93e-02   4.61e-02    1.29  0.19839    
## ELEMENTARYHILLTOP                            1.23e-01   7.63e-02    1.61  0.10720    
## ELEMENTARYHUGO & ONEKA                       3.25e-02   3.80e-02    0.85  0.39293    
## ELEMENTARYISLAND LAKE                        1.59e-01   6.07e-02    2.62  0.00877 ** 
## ELEMENTARYJACKSON                           -6.06e-01   7.22e-02   -8.39  < 2e-16 ***
## ELEMENTARYJEFFERS POND                       4.18e-01   7.19e-02    5.81  6.2e-09 ***
## ELEMENTARYJOHN F. KENNEDY                   -2.42e-02   1.13e-01   -0.21  0.82992    
## ELEMENTARYJOHNSON A+                        -2.83e-01   7.09e-02   -3.99  6.8e-05 ***
## ELEMENTARYJORDAN                             2.76e-01   2.83e-01    0.98  0.32950    
## ELEMENTARYKAPOSIA                            1.50e-01   7.42e-02    2.02  0.04306 *  
## ELEMENTARYLAKEAIRES                          3.00e-01   6.01e-02    4.99  6.2e-07 ***
## ELEMENTARYLAKE ELMO                          5.61e-02   3.81e-02    1.47  0.14078    
## ELEMENTARYLAKE MARION                        1.83e-02   9.41e-02    0.19  0.84599    
## ELEMENTARYLAKEVIEW                          -6.26e-02   7.59e-02   -0.82  0.40999    
## ELEMENTARYLIBERTY RIDGE                      1.67e-01   3.73e-02    4.46  8.2e-06 ***
## ELEMENTARYLINCOLN                            1.25e-01   6.20e-02    2.02  0.04339 *  
## ELEMENTARYLINO LAKES                        -4.28e-01   2.20e-01   -1.94  0.05214 .  
## ELEMENTARYLITTLE CANADA                      2.25e-01   6.76e-02    3.33  0.00086 ***
## ELEMENTARYMANN                               5.46e-01   5.78e-02    9.46  < 2e-16 ***
## ELEMENTARYMARION W. SAVAGE                   3.63e-01   7.40e-02    4.90  9.4e-07 ***
## ELEMENTARYMATOSKA INTERNATIONAL              2.82e-01   5.81e-02    4.86  1.2e-06 ***
## ELEMENTARYMEADOWVIEW                        -8.50e-02   7.89e-02   -1.08  0.28130    
## ELEMENTARYMENDOTA                            1.41e-01   7.84e-02    1.80  0.07242 .  
## ELEMENTARYMIDDLETON                          1.01e-01   4.08e-02    2.48  0.01322 *  
## ELEMENTARYMISSISSIPPI                        1.09e-01   7.41e-02    1.47  0.14215    
## ELEMENTARYMONROE                             7.05e-02   6.07e-02    1.16  0.24510    
## ELEMENTARYMORELAND                           2.04e-01   7.68e-02    2.65  0.00799 ** 
## ELEMENTARYNEWPORT                           -2.57e-03   4.90e-02   -0.05  0.95820    
## ELEMENTARYNORTH END                         -2.04e-01   6.08e-02   -3.35  0.00082 ***
## ELEMENTARYNORTH TRAIL                        5.12e-02   8.22e-02    0.62  0.53311    
## ELEMENTARYNORTHVIEW                          8.30e-03   8.01e-02    0.10  0.91752    
## ELEMENTARYOAKDALE                            1.32e-02   4.23e-02    0.31  0.75472    
## ELEMENTARYOAK HILLS                         -8.66e-02   8.59e-02   -1.01  0.31335    
## ELEMENTARYOAK RIDGE                          1.33e-01   8.51e-02    1.56  0.11790    
## ELEMENTARYOBAMA                              6.55e-01   8.99e-02    7.28  3.4e-13 ***
## ELEMENTARYORCHARD LAKE                       1.39e-01   8.15e-02    1.71  0.08759 .  
## ELEMENTARYOTTER LAKE                         1.68e-01   6.98e-02    2.41  0.01596 *  
## ELEMENTARYPARKVIEW                           2.56e-02   7.97e-02    0.32  0.74799    
## ELEMENTARYPEARSON                            2.78e-01   7.23e-02    3.84  0.00012 ***
## ELEMENTARYPHALEN LAKE                       -1.61e-01   6.31e-02   -2.55  0.01092 *  
## ELEMENTARYPILOT KNOB                         1.60e-01   8.42e-02    1.90  0.05775 .  
## ELEMENTARYPINE BEND                          5.94e-02   8.54e-02    0.70  0.48661    
## ELEMENTARYPINE HILL                          4.57e-02   4.22e-02    1.08  0.27965    
## ELEMENTARYPINEWOOD                           3.85e-02   5.92e-02    0.65  0.51562    
## ELEMENTARYPULLMAN                           -4.71e-02   4.35e-02   -1.08  0.27864    
## ELEMENTARYRAHN                               1.62e-01   7.99e-02    2.02  0.04317 *  
## ELEMENTARYRANDOLPH HEIGHTS                   6.81e-01   5.85e-02   11.63  < 2e-16 ***
## ELEMENTARYRED OAK                            3.72e-01   7.23e-02    5.15  2.6e-07 ***
## ELEMENTARYRED PINE                           2.25e-02   7.69e-02    0.29  0.76981    
## ELEMENTARYRED ROCK                           8.17e-02   4.44e-02    1.84  0.06588 .  
## ELEMENTARYREDTAIL RIDGE                      4.32e-01   7.08e-02    6.10  1.1e-09 ***
## ELEMENTARYRICHARDSON                         1.92e-01   5.83e-02    3.29  0.00100 ** 
## ELEMENTARYRIVERVIEW                         -2.90e-02   7.69e-02   -0.38  0.70614    
## ELEMENTARYRIVERVIEW & CHEROKEE               1.41e-01   5.99e-02    2.35  0.01860 *  
## ELEMENTARYROSEMOUNT                          4.53e-02   8.08e-02    0.56  0.57522    
## ELEMENTARYROYAL OAKS                         8.31e-02   4.07e-02    2.04  0.04113 *  
## ELEMENTARYRUTHERFORD                        -9.29e-03   7.12e-02   -0.13  0.89621    
## ELEMENTARYSALEM HILLS                        9.19e-02   1.09e-01    0.84  0.39824    
## ELEMENTARYSHANNON PARK                      -3.03e-02   7.37e-02   -0.41  0.68087    
## ELEMENTARYSHERIDAN & AMES                    1.74e-02   5.73e-02    0.30  0.76122    
## ELEMENTARYSIOUX TRAIL                        1.10e-01   8.49e-02    1.29  0.19597    
## ELEMENTARYSKY OAKS                           7.80e-02   8.16e-02    0.96  0.33944    
## ELEMENTARYSKYVIEW                            7.97e-02   3.96e-02    2.01  0.04450 *  
## ELEMENTARYSOMERSET HEIGHTS                   2.09e-01   7.38e-02    2.84  0.00453 ** 
## ELEMENTARYSOUTHVIEW                          4.14e-02   7.55e-02    0.55  0.58375    
## ELEMENTARYST ANTHONY PARK                    7.35e-01   7.39e-02    9.95  < 2e-16 ***
## ELEMENTARYSUNNYSIDE                          1.54e-01   6.35e-02    2.43  0.01501 *  
## ELEMENTARYSUN PATH                           2.32e-01   6.98e-02    3.33  0.00087 ***
## ELEMENTARYSWEENEY                            2.29e-01   7.27e-02    3.16  0.00159 ** 
## ELEMENTARYTHOMAS LAKE                        4.69e-03   8.07e-02    0.06  0.95365    
## ELEMENTARYTURTLE LAKE                        2.17e-01   5.70e-02    3.81  0.00014 ***
## ELEMENTARYVADNAIS HEIGHTS                    1.14e-01   6.47e-02    1.76  0.07832 .  
## ELEMENTARYVALENTINE HILLS                    2.66e-01   5.99e-02    4.44  9.2e-06 ***
## ELEMENTARYVISTA VIEW                         1.77e-01   7.91e-02    2.24  0.02508 *  
## ELEMENTARYWEAVER                             1.45e-01   5.84e-02    2.49  0.01290 *  
## ELEMENTARYWEBSTER                            1.46e-01   6.65e-02    2.20  0.02788 *  
## ELEMENTARYWESTVIEW                           3.77e-02   7.75e-02    0.49  0.62682    
## ELEMENTARYWESTWOOD                           4.55e-01   7.46e-02    6.11  1.0e-09 ***
## ELEMENTARYWILLIAM BYRNE                      4.30e-02   8.11e-02    0.53  0.59609    
## ELEMENTARYWILLOW LANE                        1.27e-01   7.07e-02    1.79  0.07302 .  
## ELEMENTARYWILSHIRE PARK                      4.27e-01   1.19e-01    3.57  0.00035 ***
## ELEMENTARYWOODBURY                           1.53e-01   4.33e-02    3.53  0.00042 ***
## ELEMENTARYWOODLAND                           4.92e-02   7.99e-02    0.62  0.53787    
## WhiteDense                                   3.56e-01   2.07e-02   17.18  < 2e-16 ***
## fam_income                                   4.21e-06   2.18e-07   19.32  < 2e-16 ***
## factor(SALE_YEAR)2010                       -2.42e-02   5.96e-03   -4.06  4.9e-05 ***
## factor(SALE_YEAR)2011                       -1.67e-01   1.19e-02  -14.07  < 2e-16 ***
## factor(SALE_MONTH)2                         -1.49e-02   1.57e-02   -0.95  0.34179    
## factor(SALE_MONTH)3                          8.16e-03   1.47e-02    0.56  0.57812    
## factor(SALE_MONTH)4                          6.19e-03   1.44e-02    0.43  0.66657    
## factor(SALE_MONTH)5                          5.62e-02   1.44e-02    3.90  9.6e-05 ***
## factor(SALE_MONTH)6                          5.35e-02   1.44e-02    3.71  0.00021 ***
## factor(SALE_MONTH)7                          4.53e-02   1.51e-02    3.01  0.00264 ** 
## factor(SALE_MONTH)8                          2.95e-02   1.52e-02    1.94  0.05225 .  
## factor(SALE_MONTH)9                          1.62e-02   1.54e-02    1.05  0.29358    
## factor(SALE_MONTH)10                         5.73e-02   1.52e-02    3.78  0.00016 ***
## factor(SALE_MONTH)11                         3.37e-02   1.56e-02    2.16  0.03073 *  
## factor(SALE_MONTH)12                        -3.75e-02   1.67e-02   -2.24  0.02488 *  
## onekmSUM                                    -4.27e-11   2.98e-10   -0.14  0.88601    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.372 on 17804 degrees of freedom
##   (728 observations deleted due to missingness)
## Multiple R-squared: 0.662,	Adjusted R-squared: 0.658 
## F-statistic:  173 on 201 and 17804 DF,  p-value: <2e-16 
## 
```



```r
osiModel6 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    twokmSUM, data = HouseData)
summary(osiModel6)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACRES_POLY + GARAGEsqft + 
##     YEAR_BUILT + HOME_STYLE + ELEMENTARY + WhiteDense + fam_income + 
##     factor(SALE_YEAR) + factor(SALE_MONTH) + twokmSUM, data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -4.752 -0.129  0.031  0.183  3.158 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                 -3.28e-02   3.70e-01   -0.09  0.92928    
## FIN_SQ_FT                                    2.98e-04   6.21e-06   47.95  < 2e-16 ***
## ACRES_POLY                                   4.58e-02   4.83e-03    9.48  < 2e-16 ***
## GARAGEsqft                                   1.78e-04   1.76e-05   10.11  < 2e-16 ***
## YEAR_BUILT                                   5.38e-03   1.84e-04   29.16  < 2e-16 ***
## HOME_STYLE1 1/2 STRY                         9.22e-02   1.19e-01    0.78  0.43697    
## HOME_STYLE1-1/2 STRY                         3.35e-01   1.03e-01    3.26  0.00112 ** 
## HOME_STYLE1 1/4 STRY                         5.50e-02   1.59e-01    0.34  0.73020    
## HOME_STYLE1-1/4 STRY                         3.17e-01   9.85e-02    3.22  0.00130 ** 
## HOME_STYLE1-2 STRY                           1.45e-01   1.00e-01    1.45  0.14652    
## HOME_STYLE1 3/4 STRY                         4.67e-01   1.44e-01    3.24  0.00118 ** 
## HOME_STYLE1-3/4 STRY                         4.29e-01   1.12e-01    3.83  0.00013 ***
## HOME_STYLE1 Story Brick                      5.88e-01   3.81e-01    1.54  0.12309    
## HOME_STYLE1 Story Condo                     -5.26e-01   9.02e-02   -5.83  5.5e-09 ***
## HOME_STYLE1 Story Frame                      2.53e-01   7.64e-02    3.31  0.00094 ***
## HOME_STYLE1 Story Townhouse                  1.73e-01   7.89e-02    2.19  0.02837 *  
## HOME_STYLE2 Story Condo                     -3.44e-01   8.17e-02   -4.22  2.5e-05 ***
## HOME_STYLE2 Story Frame                      1.91e-01   7.65e-02    2.49  0.01282 *  
## HOME_STYLE2 Story Townhouse                 -2.23e-01   7.75e-02   -2.87  0.00411 ** 
## HOME_STYLE3-LVL SPLT                         4.24e-02   1.04e-01    0.41  0.68429    
## HOME_STYLE4 LVL SPLT                         4.28e-02   1.01e-01    0.42  0.67196    
## HOME_STYLEBungalow                           2.05e-01   8.49e-02    2.41  0.01579 *  
## HOME_STYLECONDO                             -9.27e-01   1.14e-01   -8.15  3.8e-16 ***
## HOME_STYLEDUP/TRI                            1.66e-01   2.36e-01    0.70  0.48273    
## HOME_STYLEEARTH SHEL                        -2.83e-01   3.85e-01   -0.74  0.46225    
## HOME_STYLELOG                               -1.38e+00   3.85e-01   -3.58  0.00035 ***
## HOME_STYLEMfd Home (Double)                 -2.31e-01   3.81e-01   -0.61  0.54468    
## HOME_STYLEN/A                                1.27e-01   2.36e-01    0.54  0.59097    
## HOME_STYLEOne And 3/4 Story                  1.98e-01   8.58e-02    2.31  0.02075 *  
## HOME_STYLEOne Story                          1.58e-01   8.47e-02    1.87  0.06133 .  
## HOME_STYLEONE STORY                          2.39e-01   9.34e-02    2.56  0.01060 *  
## HOME_STYLEOther                             -2.44e+00   3.85e-01   -6.34  2.4e-10 ***
## HOME_STYLERAMBLER                            2.27e-02   9.69e-02    0.23  0.81469    
## HOME_STYLESalvage                           -2.06e-02   2.28e-01   -0.09  0.92815    
## HOME_STYLESPLIT-ENT                         -1.34e-02   9.70e-02   -0.14  0.88981    
## HOME_STYLESplit/entry                        9.78e-02   8.60e-02    1.14  0.25570    
## HOME_STYLESPLIT-FOY                          4.14e-02   1.04e-01    0.40  0.69181    
## HOME_STYLESplit Foyer Frame                  2.44e-01   7.73e-02    3.15  0.00161 ** 
## HOME_STYLESplit/level                        1.68e-01   8.67e-02    1.94  0.05203 .  
## HOME_STYLESplit Level Frame                  3.13e-01   7.79e-02    4.01  6.0e-05 ***
## HOME_STYLESPLIT LEVL                         2.15e-01   9.32e-02    2.30  0.02120 *  
## HOME_STYLETOWNHOME                          -3.10e-01   9.61e-02   -3.23  0.00125 ** 
## HOME_STYLETWIN HOME                         -1.28e-01   1.05e-01   -1.22  0.22070    
## HOME_STYLETwo Story                          2.46e-01   8.53e-02    2.89  0.00389 ** 
## HOME_STYLETWO STORY                          2.22e-01   9.36e-02    2.38  0.01755 *  
## HOME_STYLETWO+ STORY                         2.54e-02   2.10e-01    0.12  0.90378    
## ELEMENTARYAKIN ROAD                         -5.08e-02   7.52e-02   -0.68  0.49893    
## ELEMENTARYANDERSEN                           1.24e-01   8.34e-02    1.49  0.13635    
## ELEMENTARYANDERSON & WILDWOOD                2.25e-01   4.29e-02    5.25  1.5e-07 ***
## ELEMENTARYARMSTRONG                         -1.28e-03   4.62e-02   -0.03  0.97790    
## ELEMENTARYBAILEY                             1.56e-01   3.95e-02    3.96  7.7e-05 ***
## ELEMENTARYBATTLE CREEK                       3.25e-01   7.57e-02    4.29  1.8e-05 ***
## ELEMENTARYBEL AIR                            2.66e-01   6.10e-02    4.36  1.3e-05 ***
## ELEMENTARYBIRCH LAKE                         1.43e-01   6.76e-02    2.12  0.03436 *  
## ELEMENTARYBRIMHALL                           4.78e-01   6.10e-02    7.84  4.7e-15 ***
## ELEMENTARYBRUCE F. VENTO                    -2.33e-01   6.37e-02   -3.66  0.00025 ***
## ELEMENTARYCARVER                             3.50e-02   5.94e-02    0.59  0.55568    
## ELEMENTARYCASTLE                             1.17e-01   4.15e-02    2.82  0.00474 ** 
## ELEMENTARYCEDAR PARK                         1.15e-01   8.21e-02    1.40  0.16006    
## ELEMENTARYCENTRAL PARK                       3.01e-01   6.46e-02    4.67  3.1e-06 ***
## ELEMENTARYCHELSEA HEIGHTS                    3.25e-01   5.75e-02    5.65  1.6e-08 ***
## ELEMENTARYCHERRY VIEW                       -7.17e-02   8.10e-02   -0.88  0.37619    
## ELEMENTARYCHRISTINA HUDDLESTON              -4.90e-02   7.95e-02   -0.62  0.53752    
## ELEMENTARYCOMO PARK                          2.84e-01   6.12e-02    4.65  3.4e-06 ***
## ELEMENTARYCOTTAGE GROVE                      7.80e-02   4.52e-02    1.73  0.08436 .  
## ELEMENTARYCOWERN                             8.18e-02   5.30e-02    1.54  0.12275    
## ELEMENTARYCRESTVIEW                         -1.22e-02   4.88e-02   -0.25  0.80240    
## ELEMENTARYCRYSTAL LAKE                      -6.45e-03   8.13e-02   -0.08  0.93670    
## ELEMENTARYDAYTONS BLUFF                     -1.43e-01   5.99e-02   -2.38  0.01729 *  
## ELEMENTARYDEERWOOD                           5.96e-02   8.17e-02    0.73  0.46548    
## ELEMENTARYDIAMOND PATH                       9.53e-02   7.69e-02    1.24  0.21550    
## ELEMENTARYEAGLE CREEK                        4.03e-01   6.89e-02    5.85  4.9e-09 ***
## ELEMENTARYEAGLE POINT                        5.78e-02   4.72e-02    1.22  0.22066    
## ELEMENTARYEASTERN HEIGHTS                    3.57e-03   5.86e-02    0.06  0.95138    
## ELEMENTARYEASTVIEW                           4.72e-03   8.65e-02    0.05  0.95646    
## ELEMENTARYECHO PARK                          2.78e-02   7.56e-02    0.37  0.71313    
## ELEMENTARYEDGERTON                           3.11e-01   6.49e-02    4.79  1.7e-06 ***
## ELEMENTARYEDWARD NEILL                       7.24e-02   7.83e-02    0.92  0.35539    
## ELEMENTARYEMMET D. WILLIAMS                  3.16e-01   6.19e-02    5.11  3.2e-07 ***
## ELEMENTARYFALCON HEIGHTS                     3.89e-01   6.14e-02    6.33  2.5e-10 ***
## ELEMENTARYFARMINGTON                        -3.30e-02   7.83e-02   -0.42  0.67291    
## ELEMENTARYFARNSWORTH LOWER                  -8.96e-04   6.08e-02   -0.01  0.98824    
## ELEMENTARYFIVE HAWKS                         4.52e-01   7.18e-02    6.30  3.1e-10 ***
## ELEMENTARYFOREST VIEW & FOREST LAKE         -3.86e-01   1.46e-01   -2.64  0.00831 ** 
## ELEMENTARYFRANKLIN MUSIC                     2.37e-01   1.62e-01    1.47  0.14287    
## ELEMENTARYFROST LAKE                         1.23e-01   6.57e-02    1.88  0.06057 .  
## ELEMENTARYGALTIER & MAXFIELD                 6.32e-02   5.83e-02    1.08  0.27838    
## ELEMENTARYGARLOUGH                           2.97e-01   8.28e-02    3.59  0.00034 ***
## ELEMENTARYGIDEON POND                        1.41e-01   8.49e-02    1.66  0.09660 .  
## ELEMENTARYGLACIER HILLS                      1.04e-01   8.67e-02    1.20  0.23078    
## ELEMENTARYGLENDALE                           4.00e-01   7.45e-02    5.37  8.2e-08 ***
## ELEMENTARYGRAINWOOD                          3.01e-01   7.41e-02    4.07  4.8e-05 ***
## ELEMENTARYGREENLEAF                         -1.19e-02   7.20e-02   -0.17  0.86874    
## ELEMENTARYGREY CLOUD                         5.45e-02   4.23e-02    1.29  0.19702    
## ELEMENTARYGROVELAND PARK                     6.52e-01   5.98e-02   10.90  < 2e-16 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  5.23e-01   5.94e-02    8.81  < 2e-16 ***
## ELEMENTARYHANCOCK                            3.06e-01   6.98e-02    4.39  1.2e-05 ***
## ELEMENTARYHARRIET BISHOP                     3.33e-01   7.80e-02    4.27  2.0e-05 ***
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -7.66e-03   5.67e-02   -0.14  0.89256    
## ELEMENTARYHIDDEN VALLEY                      3.96e-01   7.82e-02    5.07  4.1e-07 ***
## ELEMENTARYHIGHLAND                           4.82e-02   7.56e-02    0.64  0.52334    
## ELEMENTARYHIGHLAND PARK                      5.67e-01   5.91e-02    9.60  < 2e-16 ***
## ELEMENTARYHIGHWOOD HILLS                     1.86e-01   6.68e-02    2.79  0.00531 ** 
## ELEMENTARYHILLSIDE                           6.05e-02   4.62e-02    1.31  0.18980    
## ELEMENTARYHILLTOP                            1.23e-01   7.63e-02    1.61  0.10727    
## ELEMENTARYHUGO & ONEKA                       3.22e-02   3.80e-02    0.85  0.39671    
## ELEMENTARYISLAND LAKE                        1.60e-01   6.07e-02    2.63  0.00862 ** 
## ELEMENTARYJACKSON                           -6.05e-01   7.23e-02   -8.37  < 2e-16 ***
## ELEMENTARYJEFFERS POND                       4.17e-01   7.18e-02    5.80  6.6e-09 ***
## ELEMENTARYJOHN F. KENNEDY                   -2.49e-02   1.13e-01   -0.22  0.82560    
## ELEMENTARYJOHNSON A+                        -2.82e-01   7.10e-02   -3.97  7.3e-05 ***
## ELEMENTARYJORDAN                             2.74e-01   2.83e-01    0.97  0.33204    
## ELEMENTARYKAPOSIA                            1.50e-01   7.42e-02    2.02  0.04327 *  
## ELEMENTARYLAKEAIRES                          3.00e-01   6.01e-02    4.99  6.1e-07 ***
## ELEMENTARYLAKE ELMO                          5.68e-02   3.81e-02    1.49  0.13585    
## ELEMENTARYLAKE MARION                        1.76e-02   9.41e-02    0.19  0.85134    
## ELEMENTARYLAKEVIEW                          -6.35e-02   7.60e-02   -0.84  0.40279    
## ELEMENTARYLIBERTY RIDGE                      1.67e-01   3.73e-02    4.47  7.7e-06 ***
## ELEMENTARYLINCOLN                            1.25e-01   6.20e-02    2.01  0.04428 *  
## ELEMENTARYLINO LAKES                        -4.27e-01   2.20e-01   -1.94  0.05255 .  
## ELEMENTARYLITTLE CANADA                      2.25e-01   6.76e-02    3.34  0.00085 ***
## ELEMENTARYMANN                               5.47e-01   5.78e-02    9.47  < 2e-16 ***
## ELEMENTARYMARION W. SAVAGE                   3.62e-01   7.39e-02    4.90  9.8e-07 ***
## ELEMENTARYMATOSKA INTERNATIONAL              2.83e-01   5.81e-02    4.87  1.2e-06 ***
## ELEMENTARYMEADOWVIEW                        -8.68e-02   7.89e-02   -1.10  0.27124    
## ELEMENTARYMENDOTA                            1.40e-01   7.83e-02    1.79  0.07413 .  
## ELEMENTARYMIDDLETON                          1.02e-01   4.08e-02    2.50  0.01246 *  
## ELEMENTARYMISSISSIPPI                        1.10e-01   7.41e-02    1.48  0.13828    
## ELEMENTARYMONROE                             7.16e-02   6.07e-02    1.18  0.23832    
## ELEMENTARYMORELAND                           2.04e-01   7.68e-02    2.66  0.00786 ** 
## ELEMENTARYNEWPORT                           -2.54e-03   4.90e-02   -0.05  0.95877    
## ELEMENTARYNORTH END                         -2.02e-01   6.09e-02   -3.32  0.00089 ***
## ELEMENTARYNORTH TRAIL                        5.02e-02   8.22e-02    0.61  0.54143    
## ELEMENTARYNORTHVIEW                          7.80e-03   8.01e-02    0.10  0.92239    
## ELEMENTARYOAKDALE                            1.41e-02   4.24e-02    0.33  0.74007    
## ELEMENTARYOAK HILLS                         -8.63e-02   8.59e-02   -1.00  0.31518    
## ELEMENTARYOAK RIDGE                          1.33e-01   8.51e-02    1.57  0.11726    
## ELEMENTARYOBAMA                              6.56e-01   9.00e-02    7.29  3.1e-13 ***
## ELEMENTARYORCHARD LAKE                       1.39e-01   8.15e-02    1.70  0.08901 .  
## ELEMENTARYOTTER LAKE                         1.68e-01   6.98e-02    2.41  0.01618 *  
## ELEMENTARYPARKVIEW                           2.46e-02   7.97e-02    0.31  0.75787    
## ELEMENTARYPEARSON                            2.77e-01   7.23e-02    3.84  0.00012 ***
## ELEMENTARYPHALEN LAKE                       -1.59e-01   6.32e-02   -2.52  0.01158 *  
## ELEMENTARYPILOT KNOB                         1.59e-01   8.42e-02    1.89  0.05913 .  
## ELEMENTARYPINE BEND                          5.85e-02   8.54e-02    0.69  0.49323    
## ELEMENTARYPINE HILL                          4.54e-02   4.23e-02    1.07  0.28311    
## ELEMENTARYPINEWOOD                           3.83e-02   5.92e-02    0.65  0.51713    
## ELEMENTARYPULLMAN                           -4.65e-02   4.35e-02   -1.07  0.28559    
## ELEMENTARYRAHN                               1.62e-01   7.99e-02    2.02  0.04309 *  
## ELEMENTARYRANDOLPH HEIGHTS                   6.82e-01   5.85e-02   11.64  < 2e-16 ***
## ELEMENTARYRED OAK                            3.72e-01   7.23e-02    5.14  2.7e-07 ***
## ELEMENTARYRED PINE                           2.13e-02   7.69e-02    0.28  0.78176    
## ELEMENTARYRED ROCK                           8.22e-02   4.44e-02    1.85  0.06392 .  
## ELEMENTARYREDTAIL RIDGE                      4.31e-01   7.08e-02    6.10  1.1e-09 ***
## ELEMENTARYRICHARDSON                         1.92e-01   5.83e-02    3.30  0.00098 ***
## ELEMENTARYRIVERVIEW                         -3.18e-02   7.68e-02   -0.41  0.67939    
## ELEMENTARYRIVERVIEW & CHEROKEE               1.42e-01   5.99e-02    2.37  0.01782 *  
## ELEMENTARYROSEMOUNT                          4.41e-02   8.08e-02    0.55  0.58514    
## ELEMENTARYROYAL OAKS                         8.43e-02   4.08e-02    2.07  0.03881 *  
## ELEMENTARYRUTHERFORD                        -8.21e-03   7.12e-02   -0.12  0.90817    
## ELEMENTARYSALEM HILLS                        9.09e-02   1.09e-01    0.84  0.40277    
## ELEMENTARYSHANNON PARK                      -3.08e-02   7.36e-02   -0.42  0.67594    
## ELEMENTARYSHERIDAN & AMES                    1.87e-02   5.73e-02    0.33  0.74374    
## ELEMENTARYSIOUX TRAIL                        1.08e-01   8.49e-02    1.28  0.20189    
## ELEMENTARYSKY OAKS                           7.84e-02   8.17e-02    0.96  0.33703    
## ELEMENTARYSKYVIEW                            8.03e-02   3.97e-02    2.02  0.04305 *  
## ELEMENTARYSOMERSET HEIGHTS                   2.09e-01   7.38e-02    2.84  0.00453 ** 
## ELEMENTARYSOUTHVIEW                          4.18e-02   7.56e-02    0.55  0.58027    
## ELEMENTARYST ANTHONY PARK                    7.36e-01   7.39e-02    9.95  < 2e-16 ***
## ELEMENTARYSUNNYSIDE                          1.55e-01   6.35e-02    2.44  0.01463 *  
## ELEMENTARYSUN PATH                           2.32e-01   6.98e-02    3.32  0.00089 ***
## ELEMENTARYSWEENEY                            2.28e-01   7.28e-02    3.13  0.00173 ** 
## ELEMENTARYTHOMAS LAKE                        3.72e-03   8.07e-02    0.05  0.96320    
## ELEMENTARYTURTLE LAKE                        2.17e-01   5.70e-02    3.81  0.00014 ***
## ELEMENTARYVADNAIS HEIGHTS                    1.14e-01   6.47e-02    1.76  0.07810 .  
## ELEMENTARYVALENTINE HILLS                    2.66e-01   6.00e-02    4.44  9.0e-06 ***
## ELEMENTARYVISTA VIEW                         1.77e-01   7.91e-02    2.24  0.02498 *  
## ELEMENTARYWEAVER                             1.46e-01   5.85e-02    2.50  0.01251 *  
## ELEMENTARYWEBSTER                            1.47e-01   6.65e-02    2.21  0.02721 *  
## ELEMENTARYWESTVIEW                           3.80e-02   7.75e-02    0.49  0.62385    
## ELEMENTARYWESTWOOD                           4.54e-01   7.45e-02    6.10  1.1e-09 ***
## ELEMENTARYWILLIAM BYRNE                      4.32e-02   8.11e-02    0.53  0.59384    
## ELEMENTARYWILLOW LANE                        1.27e-01   7.07e-02    1.80  0.07206 .  
## ELEMENTARYWILSHIRE PARK                      4.28e-01   1.19e-01    3.58  0.00034 ***
## ELEMENTARYWOODBURY                           1.54e-01   4.33e-02    3.55  0.00039 ***
## ELEMENTARYWOODLAND                           4.89e-02   7.99e-02    0.61  0.54081    
## WhiteDense                                   3.56e-01   2.07e-02   17.19  < 2e-16 ***
## fam_income                                   4.21e-06   2.18e-07   19.32  < 2e-16 ***
## factor(SALE_YEAR)2010                       -2.42e-02   5.96e-03   -4.06  4.9e-05 ***
## factor(SALE_YEAR)2011                       -1.67e-01   1.19e-02  -14.07  < 2e-16 ***
## factor(SALE_MONTH)2                         -1.48e-02   1.57e-02   -0.94  0.34541    
## factor(SALE_MONTH)3                          8.25e-03   1.47e-02    0.56  0.57398    
## factor(SALE_MONTH)4                          6.27e-03   1.44e-02    0.44  0.66257    
## factor(SALE_MONTH)5                          5.63e-02   1.44e-02    3.91  9.4e-05 ***
## factor(SALE_MONTH)6                          5.36e-02   1.44e-02    3.72  0.00020 ***
## factor(SALE_MONTH)7                          4.54e-02   1.51e-02    3.01  0.00260 ** 
## factor(SALE_MONTH)8                          2.96e-02   1.52e-02    1.95  0.05168 .  
## factor(SALE_MONTH)9                          1.63e-02   1.54e-02    1.06  0.29074    
## factor(SALE_MONTH)10                         5.74e-02   1.52e-02    3.78  0.00016 ***
## factor(SALE_MONTH)11                         3.38e-02   1.56e-02    2.17  0.03040 *  
## factor(SALE_MONTH)12                        -3.74e-02   1.67e-02   -2.24  0.02520 *  
## twokmSUM                                     1.40e-11   6.76e-11    0.21  0.83582    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.372 on 17804 degrees of freedom
##   (728 observations deleted due to missingness)
## Multiple R-squared: 0.662,	Adjusted R-squared: 0.658 
## F-statistic:  173 on 201 and 17804 DF,  p-value: <2e-16 
## 
```

