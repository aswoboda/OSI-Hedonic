Data Cleaning, Error Detection, etc. in R
========================================================

Here's an original vanilla model:


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
## [1] "/home/newmangr/OSI-Hedonic Project/OSI-Hedonic/writeup/01-DataCleaning"
```

```r
HouseData = read.dbf("~/OSI-Hedonic Project/Data/GIS2R/allData.dbf")
```



```r
options(width = 160)
```


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
StructuralModel1 = lm(logPRICE ~ FIN_SQ_FT + ACREAGE + YEAR_BUILT, data = HouseData)
summary(StructuralModel1)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACREAGE + YEAR_BUILT, data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -6.312 -0.159  0.051  0.228  3.353 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 3.64e+00   1.35e-01    27.0   <2e-16 ***
## FIN_SQ_FT   3.54e-04   2.70e-06   131.1   <2e-16 ***
## ACREAGE     4.93e-02   2.26e-03    21.8   <2e-16 ***
## YEAR_BUILT  4.09e-03   6.86e-05    59.6   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.437 on 51390 degrees of freedom
## Multiple R-squared: 0.363,	Adjusted R-squared: 0.363 
## F-statistic: 9.76e+03 on 3 and 51390 DF,  p-value: <2e-16
```


We now add fixed effects for the home's construction style to our regression equation in order to further explain another five percent of the variation in our logged sale price variable.

```r
StructuralModel2 = lm(logPRICE ~ FIN_SQ_FT + ACREAGE + YEAR_BUILT + HomeStyle, data = HouseData)
summary(StructuralModel2)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACREAGE + YEAR_BUILT + HomeStyle, 
##     data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -6.333 -0.138  0.048  0.203  3.356 
## 
## Coefficients:
##                                          Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                              3.49e+00   1.91e-01   18.32  < 2e-16 ***
## FIN_SQ_FT                                3.28e-04   3.17e-06  103.37  < 2e-16 ***
## ACREAGE                                  4.52e-02   2.21e-03   20.41  < 2e-16 ***
## YEAR_BUILT                               4.38e-03   9.53e-05   45.95  < 2e-16 ***
## HomeStyle1 Story                        -3.89e-01   2.25e-02  -17.29  < 2e-16 ***
## HomeStyle1 Story Brick                  -1.27e-01   2.44e-01   -0.52   0.6032    
## HomeStyle1 Story Condo                  -9.35e-01   4.16e-02  -22.46  < 2e-16 ***
## HomeStyle1 Story Frame                  -3.23e-01   2.39e-02  -13.53  < 2e-16 ***
## HomeStyle1 Story Townhouse              -3.78e-01   2.67e-02  -14.14  < 2e-16 ***
## HomeStyle2 1/2 Story Finished           -7.79e-01   4.21e-01   -1.85   0.0641 .  
## HomeStyle2 Story                        -3.16e-01   2.25e-02  -14.02  < 2e-16 ***
## HomeStyle2 Story Brick                  -1.52e-01   4.21e-01   -0.36   0.7186    
## HomeStyle2 Story Condo                  -8.37e-01   3.01e-02  -27.86  < 2e-16 ***
## HomeStyle2 Story Frame                  -3.48e-01   2.32e-02  -14.98  < 2e-16 ***
## HomeStyle2 Story Townhouse              -7.63e-01   2.40e-02  -31.87  < 2e-16 ***
## HomeStyle3/2 Story                      -3.42e-01   3.09e-02  -11.08  < 2e-16 ***
## HomeStyle3-LVL SPLT                     -2.33e-01   3.76e-02   -6.19  6.0e-10 ***
## HomeStyle4 LVL SPLT                     -1.67e-01   3.35e-02   -5.00  5.8e-07 ***
## HomeStyle5/4 Story                      -3.13e-01   2.72e-02  -11.53  < 2e-16 ***
## HomeStyle7/4 Story                      -4.65e-01   2.56e-02  -18.14  < 2e-16 ***
## HomeStyleBi-level                       -2.68e-01   2.43e-02  -11.06  < 2e-16 ***
## HomeStyleBungalow                       -3.89e-01   2.37e-02  -16.40  < 2e-16 ***
## HomeStyleCabin                          -5.26e-01   4.21e-01   -1.25   0.2109    
## HomeStyleCondo                          -8.92e-01   4.01e-02  -22.23  < 2e-16 ***
## HomeStyleDetached Townhome - 1 story    -7.59e-02   3.68e-02   -2.07   0.0389 *  
## HomeStyleDetached Townhome - 2 story    -3.93e-01   5.94e-02   -6.63  3.4e-11 ***
## HomeStyleDetached Townhome - Split Foy*  2.90e-02   2.44e-01    0.12   0.9051    
## HomeStyleDetached Townhome - Split lev* -2.05e-01   1.11e-01   -1.85   0.0640 .  
## HomeStyleDouble bungalow - split foyer  -1.60e-01   4.21e-01   -0.38   0.7029    
## HomeStyleDUP/TRI                        -3.07e-01   1.89e-01   -1.63   0.1041    
## HomeStyleEarth                          -3.81e-01   2.98e-01   -1.28   0.2004    
## HomeStyleLOG                            -1.49e-02   2.44e-01   -0.06   0.9516    
## HomeStyleMfd Home (Double)              -1.11e+00   4.21e-01   -2.63   0.0086 ** 
## HomeStyleMini-Warehouse - Condo         -2.82e+00   1.60e-01  -17.58  < 2e-16 ***
## HomeStyleModified two story             -2.57e-01   2.86e-02   -8.99  < 2e-16 ***
## HomeStyleModular                        -1.98e+00   2.98e-01   -6.64  3.3e-11 ***
## HomeStyleN/A                             6.98e-02   1.73e-01    0.40   0.6867    
## HomeStyleOther                          -1.32e+00   2.11e-01   -6.25  4.1e-10 ***
## HomeStyleQuad - one story               -5.38e-01   1.89e-01   -2.84   0.0045 ** 
## HomeStyleQuad - split level/foyer       -4.99e-01   4.02e-02  -12.39  < 2e-16 ***
## HomeStyleQuad - Two story               -5.35e-01   2.98e-01   -1.80   0.0724 .  
## HomeStyleRAMBLER                        -1.81e-01   2.63e-02   -6.90  5.2e-12 ***
## HomeStyleRow                            -4.03e-01   4.21e-01   -0.96   0.3386    
## HomeStyleSalvage                        -4.97e-01   2.11e-01   -2.35   0.0187 *  
## HomeStyleSplit Entry                    -4.33e-01   2.40e-02  -18.06  < 2e-16 ***
## HomeStyleSPLIT-FOY                      -2.53e-01   3.65e-02   -6.93  4.2e-12 ***
## HomeStyleSplit Foyer Frame              -3.52e-01   2.43e-02  -14.48  < 2e-16 ***
## HomeStyleSplit Level                    -3.73e-01   2.26e-02  -16.53  < 2e-16 ***
## HomeStyleSplit Level Frame              -2.71e-01   2.57e-02  -10.58  < 2e-16 ***
## HomeStyleThree Story                    -6.95e-01   7.98e-02   -8.71  < 2e-16 ***
## HomeStyleTOWNHOME                       -4.97e-01   2.35e-02  -21.20  < 2e-16 ***
## HomeStyleTWIN HOME                      -3.52e-01   3.81e-02   -9.23  < 2e-16 ***
## HomeStyleTwin home - one story          -7.38e-01   9.22e-02   -8.00  1.2e-15 ***
## HomeStyleTwin home - spit level/ split* -7.22e-01   5.45e-02  -13.25  < 2e-16 ***
## HomeStyleTwin home - two story          -1.05e+00   1.42e-01   -7.38  1.5e-13 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.42 on 51339 degrees of freedom
## Multiple R-squared: 0.412,	Adjusted R-squared: 0.412 
## F-statistic:  667 on 54 and 51339 DF,  p-value: <2e-16
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
neighborhoodModel1 = lm(logPRICE ~ FIN_SQ_FT + ACREAGE + YEAR_BUILT + HomeStyle + CITY + SCHOOL_DST + WhiteDense + fam_income, data = HouseData)
summary(neighborhoodModel1)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACREAGE + YEAR_BUILT + HomeStyle + 
##     CITY + SCHOOL_DST + WhiteDense + fam_income, data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -6.548 -0.121  0.036  0.178  3.246 
## 
## Coefficients: (4 not defined because of singularities)
##                                          Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                              4.61e+00   2.38e-01   19.34  < 2e-16 ***
## FIN_SQ_FT                                3.46e-04   3.88e-06   89.12  < 2e-16 ***
## ACREAGE                                  3.63e-02   2.56e-03   14.16  < 2e-16 ***
## YEAR_BUILT                               3.22e-03   1.16e-04   27.67  < 2e-16 ***
## HomeStyle1 Story                        -8.51e-03   2.31e-02   -0.37  0.71229    
## HomeStyle1 Story Brick                   8.72e-01   4.12e-01    2.11  0.03459 *  
## HomeStyle1 Story Condo                  -3.46e-02   1.30e-01   -0.27  0.79025    
## HomeStyle1 Story Frame                   5.50e-01   1.23e-01    4.46  8.3e-06 ***
## HomeStyle1 Story Townhouse               4.92e-01   1.25e-01    3.93  8.6e-05 ***
## HomeStyle2 1/2 Story Finished           -3.75e-01   4.00e-01   -0.94  0.34860    
## HomeStyle2 Story                         5.85e-03   2.23e-02    0.26  0.79306    
## HomeStyle2 Story Condo                  -3.43e-02   1.28e-01   -0.27  0.78857    
## HomeStyle2 Story Frame                   4.89e-01   1.23e-01    3.97  7.3e-05 ***
## HomeStyle2 Story Townhouse               1.63e-01   1.23e-01    1.32  0.18815    
## HomeStyle3/2 Story                      -2.97e-02   3.11e-02   -0.96  0.33865    
## HomeStyle3-LVL SPLT                     -2.32e-01   3.50e-02   -6.64  3.3e-11 ***
## HomeStyle4 LVL SPLT                     -1.53e-01   3.13e-02   -4.89  1.0e-06 ***
## HomeStyle5/4 Story                       9.34e-04   2.78e-02    0.03  0.97319    
## HomeStyle7/4 Story                      -4.46e-02   2.54e-02   -1.75  0.07934 .  
## HomeStyleBi-level                        1.19e-01   2.52e-02    4.72  2.4e-06 ***
## HomeStyleBungalow                       -1.24e-02   2.40e-02   -0.52  0.60597    
## HomeStyleCabin                          -2.31e-01   3.91e-01   -0.59  0.55483    
## HomeStyleCondo                          -9.14e-01   3.80e-02  -24.09  < 2e-16 ***
## HomeStyleDetached Townhome - 1 story     2.63e-01   3.60e-02    7.31  2.7e-13 ***
## HomeStyleDetached Townhome - 2 story    -4.60e-02   5.92e-02   -0.78  0.43749    
## HomeStyleDetached Townhome - Split Foy*  3.69e-01   2.27e-01    1.63  0.10310    
## HomeStyleDetached Townhome - Split lev*  1.79e-01   1.04e-01    1.72  0.08504 .  
## HomeStyleDouble bungalow - split foyer   1.78e-01   3.92e-01    0.45  0.65018    
## HomeStyleDUP/TRI                        -3.64e-01   1.76e-01   -2.07  0.03819 *  
## HomeStyleEarth                          -4.50e-01   2.76e-01   -1.63  0.10358    
## HomeStyleLOG                             3.44e-01   2.30e-01    1.49  0.13496    
## HomeStyleMini-Warehouse - Condo         -2.41e+00   1.50e-01  -16.15  < 2e-16 ***
## HomeStyleModified two story              1.09e-01   2.87e-02    3.81  0.00014 ***
## HomeStyleModular                        -1.67e+00   2.77e-01   -6.01  1.8e-09 ***
## HomeStyleN/A                             4.36e-03   1.60e-01    0.03  0.97834    
## HomeStyleOther                          -1.01e+00   1.96e-01   -5.13  2.9e-07 ***
## HomeStyleQuad - one story               -1.99e-01   1.76e-01   -1.13  0.25804    
## HomeStyleQuad - split level/foyer       -1.72e-01   3.94e-02   -4.36  1.3e-05 ***
## HomeStyleQuad - Two story               -1.56e-01   2.77e-01   -0.56  0.57309    
## HomeStyleRAMBLER                        -2.12e-01   2.46e-02   -8.63  < 2e-16 ***
## HomeStyleRow                            -1.13e-01   3.91e-01   -0.29  0.77318    
## HomeStyleSalvage                        -6.87e-01   4.09e-01   -1.68  0.09277 .  
## HomeStyleSplit Entry                    -1.73e-01   2.32e-02   -7.47  8.2e-14 ***
## HomeStyleSPLIT-FOY                      -2.35e-01   3.42e-02   -6.88  5.9e-12 ***
## HomeStyleSplit Foyer Frame               5.90e-01   1.24e-01    4.77  1.9e-06 ***
## HomeStyleSplit Level                     4.21e-02   2.34e-02    1.80  0.07185 .  
## HomeStyleSplit Level Frame               6.40e-01   1.24e-01    5.16  2.5e-07 ***
## HomeStyleThree Story                    -1.62e-01   7.56e-02   -2.14  0.03207 *  
## HomeStyleTOWNHOME                       -4.57e-01   2.19e-02  -20.84  < 2e-16 ***
## HomeStyleTWIN HOME                      -3.22e-01   3.55e-02   -9.07  < 2e-16 ***
## HomeStyleTwin home - one story          -3.65e-01   8.65e-02   -4.22  2.4e-05 ***
## HomeStyleTwin home - spit level/ split* -3.62e-01   5.20e-02   -6.96  3.4e-12 ***
## HomeStyleTwin home - two story          -6.71e-01   1.32e-01   -5.07  3.9e-07 ***
## CITYANOKA                               -4.63e-02   2.28e-02   -2.03  0.04216 *  
## CITYAPPLE VALLEY                         6.45e-02   6.46e-02    1.00  0.31806    
## CITYARDEN HILLS                         -4.38e-01   8.20e-02   -5.34  9.3e-08 ***
## CITYBLAINE                              -4.40e-02   1.69e-02   -2.61  0.00901 ** 
## CITYBURNSVILLE                           6.74e-02   6.20e-02    1.09  0.27653    
## CITYCASTLE ROCK TWP                      2.37e-01   2.07e-01    1.14  0.25273    
## CITYCENTERVILLE                         -1.54e-01   4.77e-02   -3.24  0.00121 ** 
## CITYCIRCLE PINES                        -6.02e-02   4.63e-02   -1.30  0.19313    
## CITYCITY OF BIRCHWOOD                   -1.34e-01   2.38e-01   -0.56  0.57434    
## CITYCITY OF COTTAGE GROVE               -5.03e-01   1.52e-01   -3.30  0.00097 ***
## CITYCITY OF DELLWOOD                    -2.19e-01   2.09e-01   -1.05  0.29382    
## CITYCITY OF GRANT                       -4.99e-01   2.12e-01   -2.35  0.01867 *  
## CITYCITY OF HUGO                        -4.70e-01   2.31e-01   -2.04  0.04175 *  
## CITYCITY OF LAKE ELMO                   -4.41e-01   1.71e-01   -2.59  0.00971 ** 
## CITYCITY OF MAHTOMEDI                   -3.97e-01   2.01e-01   -1.97  0.04842 *  
## CITYCITY OF OAKDALE                     -5.51e-01   1.63e-01   -3.38  0.00074 ***
## CITYCITY OF PINE SPRINGS                -3.91e-01   2.56e-01   -1.52  0.12740    
## CITYCITY OF PRIOR LAKE                   4.12e-01   6.04e-02    6.83  8.8e-12 ***
## CITYCITY OF SAVAGE                       4.72e-01   5.95e-02    7.94  2.1e-15 ***
## CITYCITY OF SHAKOPEE                     2.84e-01   5.22e-02    5.45  5.2e-08 ***
## CITYCITY OF WHITE BEAR LAKE             -5.57e-01   2.30e-01   -2.42  0.01550 *  
## CITYCITY OF WILLERNIE                   -6.91e-01   2.26e-01   -3.05  0.00225 ** 
## CITYCITY OF WOODBURY                    -4.14e-01   1.61e-01   -2.56  0.01035 *  
## CITYCOLUMBIA HEIGHTS                     6.71e-02   5.75e-02    1.17  0.24322    
## CITYCOLUMBUS                            -2.58e-01   1.41e-01   -1.84  0.06632 .  
## CITYCOON RAPIDS                         -2.49e-02   1.58e-02   -1.58  0.11357    
## CITYEAGAN                                1.21e-01   6.37e-02    1.90  0.05752 .  
## CITYEAST BETHEL                          2.88e-02   7.43e-02    0.39  0.69782    
## CITYEMPIRE TWP                          -1.38e-03   8.43e-02   -0.02  0.98697    
## CITYFALCON HEIGHTS                      -2.82e-01   8.90e-02   -3.16  0.00155 ** 
## CITYFARMINGTON                           3.20e-03   7.19e-02    0.04  0.96452    
## CITYFRIDLEY                              2.23e-02   4.02e-02    0.55  0.58014    
## CITYGEM LAKE                            -6.27e-01   1.15e-01   -5.45  5.2e-08 ***
## CITYHAM LAKE                            -4.14e-02   2.25e-02   -1.84  0.06549 .  
## CITYHILLTOP                             -4.42e-01   2.81e-01   -1.57  0.11598    
## CITYINVER GROVE HEIGHTS                  1.65e-01   7.34e-02    2.25  0.02469 *  
## CITYLAKEVILLE                            3.73e-02   6.56e-02    0.57  0.56928    
## CITYLAUDERDALE                          -4.01e-01   9.82e-02   -4.08  4.4e-05 ***
## CITYLEXINGTON                           -8.82e-02   6.79e-02   -1.30  0.19395    
## CITYLINO LAKES                          -7.18e-02   3.71e-02   -1.94  0.05294 .  
## CITYLITTLE CANADA                       -4.20e-01   8.45e-02   -4.97  6.8e-07 ***
## CITYMAPLEWOOD                           -4.82e-01   8.55e-02   -5.63  1.8e-08 ***
## CITYMENDOTA                              2.31e-01   2.07e-01    1.11  0.26540    
## CITYMENDOTA HEIGHTS                      1.55e-01   7.45e-02    2.08  0.03787 *  
## CITYMOUNDS VIEW                         -5.65e-01   8.06e-02   -7.01  2.4e-12 ***
## CITYNEW BRIGHTON                        -4.64e-01   7.93e-02   -5.85  4.9e-09 ***
## CITYNORTH OAKS                          -3.73e-01   8.09e-02   -4.62  3.9e-06 ***
## CITYNORTH SAINT PAUL                    -5.63e-01   8.89e-02   -6.34  2.3e-10 ***
## CITYNOWTHEN                             -1.19e-01   8.79e-02   -1.35  0.17763    
## CITYOAK GROVE                            5.66e-02   1.15e-01    0.49  0.62129    
## CITYRAMSEY                              -2.15e-01   1.76e-02  -12.17  < 2e-16 ***
## CITYROSEMOUNT                            6.25e-02   6.55e-02    0.95  0.33982    
## CITYROSEVILLE                           -4.15e-01   8.11e-02   -5.12  3.1e-07 ***
## CITYSAINT ANTHONY                       -3.25e-01   1.59e-01   -2.05  0.04025 *  
## CITYSAINT PAUL                           6.59e-03   5.17e-02    0.13  0.89852    
## CITYSHOREVIEW                           -4.12e-01   7.85e-02   -5.25  1.5e-07 ***
## CITYSOUTH ST PAUL                       -1.01e-01   5.34e-02   -1.90  0.05767 .  
## CITYSPRING LAKE PARK                    -1.74e-01   3.87e-02   -4.48  7.3e-06 ***
## CITYSUNFISH LAKE                         3.97e-01   1.26e-01    3.15  0.00166 ** 
## CITYTOWN OF CREDIT RIVER                 1.50e-02   1.35e-01    0.11  0.91176    
## CITYTOWN OF JACKSON                      4.94e-01   3.93e-01    1.26  0.20851    
## CITYTOWN OF LOUISVILLE                   8.61e-02   2.31e-01    0.37  0.70924    
## CITYTOWN OF SPRING LAKE                  4.55e-01   7.77e-02    5.85  4.8e-09 ***
## CITYVADNAIS HEIGHTS                     -3.50e-01   6.94e-02   -5.05  4.5e-07 ***
## CITYWEST ST PAUL                         1.65e-01   7.28e-02    2.27  0.02294 *  
## CITYWHITE BEAR LAKE                     -3.38e-01   6.72e-02   -5.03  5.0e-07 ***
## CITYWHITE BEAR TOWNSHIP                 -3.54e-01   6.89e-02   -5.14  2.8e-07 ***
## SCHOOL_DST11                            -5.70e-02   4.91e-02   -1.16  0.24508    
## SCHOOL_DST12                             1.01e-02   4.10e-02    0.25  0.80573    
## SCHOOL_DST13                            -3.27e-02   7.14e-02   -0.46  0.64729    
## SCHOOL_DST14                             1.69e-02   6.46e-02    0.26  0.79384    
## SCHOOL_DST15                            -2.07e-01   7.43e-02   -2.79  0.00531 ** 
## SCHOOL_DST16                             6.67e-02   4.97e-02    1.34  0.17952    
## SCHOOL_DST191                           -2.08e-01   3.31e-02   -6.29  3.2e-10 ***
## SCHOOL_DST192                           -2.11e-01   4.91e-02   -4.29  1.8e-05 ***
## SCHOOL_DST194                           -2.30e-01   4.17e-02   -5.51  3.6e-08 ***
## SCHOOL_DST196                           -2.25e-01   3.80e-02   -5.92  3.3e-09 ***
## SCHOOL_DST197                           -1.96e-01   4.88e-02   -4.02  5.9e-05 ***
## SCHOOL_DST199                           -2.69e-01   5.59e-02   -4.82  1.5e-06 ***
## SCHOOL_DST282                            4.41e-01   1.32e-01    3.33  0.00085 ***
## SCHOOL_DST621                            4.22e-01   7.96e-02    5.30  1.2e-07 ***
## SCHOOL_DST622                            4.09e-01   8.84e-02    4.63  3.7e-06 ***
## SCHOOL_DST623                            4.64e-01   8.32e-02    5.58  2.4e-08 ***
## SCHOOL_DST624                            2.85e-01   6.72e-02    4.24  2.3e-05 ***
## SCHOOL_DST625                                  NA         NA      NA       NA    
## SCHOOL_DST717                           -2.10e-01   1.58e-01   -1.33  0.18469    
## SCHOOL_DST719                           -5.60e-02   3.10e-02   -1.80  0.07126 .  
## SCHOOL_DST720                                  NA         NA      NA       NA    
## SCHOOL_DST728                           -3.85e-02   8.82e-02   -0.44  0.66277    
## SCHOOL_DST831                                  NA         NA      NA       NA    
## SCHOOL_DSTISD622                        -5.74e-02   1.07e-01   -0.53  0.59293    
## SCHOOL_DSTISD624                        -1.73e-01   1.91e-01   -0.91  0.36541    
## SCHOOL_DSTISD831                        -5.08e-01   2.10e-01   -2.42  0.01541 *  
## SCHOOL_DSTISD832                        -3.32e-02   1.53e-01   -0.22  0.82819    
## SCHOOL_DSTISD833                               NA         NA      NA       NA    
## WhiteDense                               8.49e-01   1.22e-02   69.76  < 2e-16 ***
## fam_income                               1.13e-06   1.25e-07    9.05  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.39 on 43710 degrees of freedom
##   (7538 observations deleted due to missingness)
## Multiple R-squared: 0.501,	Adjusted R-squared: 0.499 
## F-statistic:  303 on 145 and 43710 DF,  p-value: <2e-16
```


Surprisingly, few of the city or school district fixed effects seem to statistically differ from zero. Let's try a smaller scale measure of location - the elementary school catchment basin. This model now describes about two-thirds of the variation in logged sale price.

```r
neighborhoodModel2 = lm(logPRICE ~ FIN_SQ_FT + ACREAGE + YEAR_BUILT + HomeStyle + ELEMENTARY + WhiteDense + fam_income, data = HouseData)
summary(neighborhoodModel2)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACREAGE + YEAR_BUILT + HomeStyle + 
##     ELEMENTARY + WhiteDense + fam_income, data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -6.834 -0.108  0.034  0.169  3.191 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                  3.48e+00   2.20e-01   15.82  < 2e-16 ***
## FIN_SQ_FT                                    3.29e-04   3.45e-06   95.13  < 2e-16 ***
## ACREAGE                                      3.98e-02   2.09e-03   19.07  < 2e-16 ***
## YEAR_BUILT                                   4.00e-03   1.10e-04   36.48  < 2e-16 ***
## HomeStyle1 Story                            -1.23e-02   2.17e-02   -0.57  0.57120    
## HomeStyle1 Story Brick                       3.63e-01   2.14e-01    1.70  0.08956 .  
## HomeStyle1 Story Condo                      -4.61e-01   4.36e-02  -10.58  < 2e-16 ***
## HomeStyle1 Story Frame                       1.57e-01   3.10e-02    5.07  4.1e-07 ***
## HomeStyle1 Story Townhouse                   8.80e-02   3.32e-02    2.65  0.00797 ** 
## HomeStyle2 1/2 Story Finished               -3.59e-01   3.67e-01   -0.98  0.32846    
## HomeStyle2 Story                            -1.53e-02   2.10e-02   -0.73  0.46687    
## HomeStyle2 Story Brick                       1.72e-01   3.68e-01    0.47  0.64088    
## HomeStyle2 Story Condo                      -3.45e-01   3.59e-02   -9.62  < 2e-16 ***
## HomeStyle2 Story Frame                       8.49e-02   3.08e-02    2.75  0.00590 ** 
## HomeStyle2 Story Townhouse                  -2.58e-01   3.12e-02   -8.26  < 2e-16 ***
## HomeStyle3/2 Story                          -3.86e-02   2.85e-02   -1.35  0.17564    
## HomeStyle3-LVL SPLT                         -2.26e-01   3.30e-02   -6.86  7.1e-12 ***
## HomeStyle4 LVL SPLT                         -1.36e-01   2.95e-02   -4.62  3.9e-06 ***
## HomeStyle5/4 Story                          -4.35e-03   2.61e-02   -0.17  0.86753    
## HomeStyle7/4 Story                           7.60e-03   2.39e-02    0.32  0.75085    
## HomeStyleBi-level                            8.83e-02   2.37e-02    3.72  0.00020 ***
## HomeStyleBungalow                            6.35e-03   2.27e-02    0.28  0.77940    
## HomeStyleCabin                              -2.44e-01   3.67e-01   -0.66  0.50728    
## HomeStyleCondo                              -8.96e-01   3.67e-02  -24.39  < 2e-16 ***
## HomeStyleDetached Townhome - 1 story         2.48e-01   3.45e-02    7.19  6.5e-13 ***
## HomeStyleDetached Townhome - 2 story        -2.61e-02   5.46e-02   -0.48  0.63273    
## HomeStyleDetached Townhome - Split Foy*      3.39e-01   2.13e-01    1.59  0.11190    
## HomeStyleDetached Townhome - Split lev*      1.81e-01   9.88e-02    1.83  0.06705 .  
## HomeStyleDouble bungalow - split foyer       1.95e-01   3.68e-01    0.53  0.59549    
## HomeStyleDUP/TRI                            -2.44e-01   1.65e-01   -1.48  0.13904    
## HomeStyleEarth                              -4.58e-01   2.60e-01   -1.76  0.07765 .  
## HomeStyleLOG                                 9.89e-02   2.13e-01    0.46  0.64289    
## HomeStyleMfd Home (Double)                  -4.33e-01   3.68e-01   -1.18  0.23845    
## HomeStyleMini-Warehouse - Condo             -2.49e+00   1.42e-01  -17.55  < 2e-16 ***
## HomeStyleModified two story                  9.14e-02   2.71e-02    3.38  0.00073 ***
## HomeStyleModular                            -1.63e+00   2.60e-01   -6.27  3.7e-10 ***
## HomeStyleN/A                                 7.72e-03   1.51e-01    0.05  0.95922    
## HomeStyleOther                              -1.06e+00   1.85e-01   -5.74  9.8e-09 ***
## HomeStyleQuad - one story                   -1.90e-01   1.66e-01   -1.14  0.25233    
## HomeStyleQuad - split level/foyer           -1.65e-01   3.76e-02   -4.39  1.1e-05 ***
## HomeStyleQuad - Two story                   -1.85e-01   2.60e-01   -0.71  0.47810    
## HomeStyleRAMBLER                            -1.85e-01   2.34e-02   -7.91  2.5e-15 ***
## HomeStyleRow                                -1.69e-01   3.67e-01   -0.46  0.64522    
## HomeStyleSalvage                             6.12e-02   1.86e-01    0.33  0.74167    
## HomeStyleSplit Entry                        -1.56e-01   2.20e-02   -7.09  1.4e-12 ***
## HomeStyleSPLIT-FOY                          -2.10e-01   3.24e-02   -6.50  8.4e-11 ***
## HomeStyleSplit Foyer Frame                   1.55e-01   3.17e-02    4.89  1.0e-06 ***
## HomeStyleSplit Level                         1.35e-02   2.20e-02    0.62  0.53794    
## HomeStyleSplit Level Frame                   2.16e-01   3.23e-02    6.68  2.5e-11 ***
## HomeStyleThree Story                        -2.24e-01   7.13e-02   -3.14  0.00168 ** 
## HomeStyleTOWNHOME                           -5.00e-01   2.08e-02  -24.02  < 2e-16 ***
## HomeStyleTWIN HOME                          -3.49e-01   3.38e-02  -10.32  < 2e-16 ***
## HomeStyleTwin home - one story              -3.84e-01   8.20e-02   -4.68  2.9e-06 ***
## HomeStyleTwin home - spit level/ split*     -3.73e-01   4.93e-02   -7.56  4.1e-14 ***
## HomeStyleTwin home - two story              -6.95e-01   1.25e-01   -5.57  2.6e-08 ***
## ELEMENTARYAFTON-LAKELAND                    -8.88e-02   4.34e-02   -2.04  0.04103 *  
## ELEMENTARYAKIN ROAD                         -7.75e-02   3.20e-02   -2.43  0.01528 *  
## ELEMENTARYAMES                               1.05e-01   4.52e-02    2.31  0.02078 *  
## ELEMENTARYANDERSEN                           1.65e-01   6.54e-02    2.52  0.01158 *  
## ELEMENTARYANDERSON & WILDWOOD                1.45e-01   3.66e-02    3.96  7.4e-05 ***
## ELEMENTARYANDOVER                            1.01e-01   2.93e-02    3.44  0.00059 ***
## ELEMENTARYARMSTRONG                         -1.37e-01   3.80e-02   -3.60  0.00032 ***
## ELEMENTARYBAILEY                             4.16e-02   3.45e-02    1.21  0.22798    
## ELEMENTARYBATTLE CREEK                       2.12e-02   4.41e-02    0.48  0.63134    
## ELEMENTARYBEL AIR                            1.00e-01   3.14e-02    3.19  0.00145 ** 
## ELEMENTARYBIRCH LAKE                         6.00e-04   3.70e-02    0.02  0.98705    
## ELEMENTARYBLUE HERON                        -7.49e-03   3.35e-02   -0.22  0.82283    
## ELEMENTARYBRIMHALL                           2.37e-01   3.25e-02    7.29  3.0e-13 ***
## ELEMENTARYBRUCE F. VENTO                    -3.88e-01   3.64e-02  -10.66  < 2e-16 ***
## ELEMENTARYCARVER                            -1.50e-02   3.30e-02   -0.45  0.65058    
## ELEMENTARYCASTLE                            -8.81e-02   3.66e-02   -2.41  0.01609 *  
## ELEMENTARYCEDAR CREEK                       -3.34e-01   7.12e-02   -4.69  2.7e-06 ***
## ELEMENTARYCEDAR PARK                        -1.94e-02   3.95e-02   -0.49  0.62432    
## ELEMENTARYCENTENNIAL                         5.65e-02   3.67e-02    1.54  0.12384    
## ELEMENTARYCENTERVILLE                        4.04e-02   3.45e-02    1.17  0.24137    
## ELEMENTARYCENTRAL PARK                       1.23e-01   3.36e-02    3.67  0.00025 ***
## ELEMENTARYCHELSEA HEIGHTS                    1.50e-01   2.93e-02    5.13  3.0e-07 ***
## ELEMENTARYCHERRY VIEW                       -3.94e-02   3.78e-02   -1.04  0.29723    
## ELEMENTARYCHRISTINA HUDDLESTON              -2.61e-02   3.84e-02   -0.68  0.49757    
## ELEMENTARYCOMO PARK                          5.49e-02   3.22e-02    1.71  0.08810 .  
## ELEMENTARYCOTTAGE GROVE                     -6.94e-02   3.61e-02   -1.92  0.05463 .  
## ELEMENTARYCOWERN                            -1.15e-01   3.34e-02   -3.43  0.00061 ***
## ELEMENTARYCRESTVIEW                         -1.46e-01   4.00e-02   -3.65  0.00027 ***
## ELEMENTARYCROOKED LAKE                       5.23e-02   3.46e-02    1.51  0.13014    
## ELEMENTARYCRYSTAL LAKE                       9.59e-03   3.73e-02    0.26  0.79727    
## ELEMENTARYDAYTONS BLUFF                     -3.86e-01   3.27e-02  -11.80  < 2e-16 ***
## ELEMENTARYDEERWOOD                           7.08e-02   4.05e-02    1.75  0.08037 .  
## ELEMENTARYDIAMOND PATH                       1.01e-02   3.26e-02    0.31  0.75719    
## ELEMENTARYEAGLE CREEK                        3.67e-01   3.16e-02   11.62  < 2e-16 ***
## ELEMENTARYEAGLE POINT                       -6.61e-02   4.02e-02   -1.64  0.10013    
## ELEMENTARYEAST BETHEL & CEDAR CREEK          3.32e-02   4.43e-02    0.75  0.45284    
## ELEMENTARYEASTERN HEIGHTS                   -2.36e-01   3.06e-02   -7.70  1.4e-14 ***
## ELEMENTARYEASTVIEW                           3.62e-02   3.84e-02    0.94  0.34504    
## ELEMENTARYECHO PARK                         -2.55e-02   3.35e-02   -0.76  0.44646    
## ELEMENTARYEDGERTON                           2.64e-02   3.54e-02    0.75  0.45574    
## ELEMENTARYEDWARD NEILL                      -4.03e-02   3.57e-02   -1.13  0.26000    
## ELEMENTARYEISENHOWER                         4.72e-02   4.14e-02    1.14  0.25349    
## ELEMENTARYEMMET D. WILLIAMS                  1.73e-01   3.30e-02    5.23  1.7e-07 ***
## ELEMENTARYFALCON HEIGHTS                     1.76e-01   3.22e-02    5.46  4.8e-08 ***
## ELEMENTARYFARMINGTON                        -6.75e-02   3.11e-02   -2.17  0.03008 *  
## ELEMENTARYFARNSWORTH                         1.78e-01   3.85e-02    4.63  3.6e-06 ***
## ELEMENTARYFARNSWORTH LOWER                  -3.46e-01   3.81e-02   -9.09  < 2e-16 ***
## ELEMENTARYFIVE HAWKS                         5.76e-01   2.84e-02   20.29  < 2e-16 ***
## ELEMENTARYFOREST VIEW                       -3.96e-01   1.27e-01   -3.13  0.00177 ** 
## ELEMENTARYFOREST VIEW & FOREST LAKE         -6.02e-01   1.42e-01   -4.23  2.3e-05 ***
## ELEMENTARYFRANKLIN                          -1.09e-01   3.19e-02   -3.41  0.00066 ***
## ELEMENTARYFRANKLIN MUSIC                    -2.91e-01   1.52e-01   -1.92  0.05513 .  
## ELEMENTARYFROST LAKE                        -5.62e-02   3.74e-02   -1.50  0.13248    
## ELEMENTARYGALTIER & MAXFIELD                -6.31e-02   2.97e-02   -2.12  0.03366 *  
## ELEMENTARYGARLOUGH                           3.85e-02   3.77e-02    1.02  0.30749    
## ELEMENTARYGIDEON POND                       -2.05e-02   4.07e-02   -0.50  0.61550    
## ELEMENTARYGLACIER HILLS                      1.07e-01   3.92e-02    2.74  0.00615 ** 
## ELEMENTARYGLENDALE                           5.20e-01   3.20e-02   16.29  < 2e-16 ***
## ELEMENTARYGOLDEN LAKE                        1.49e-01   4.23e-02    3.51  0.00044 ***
## ELEMENTARYGRAINWOOD                          1.15e-01   3.85e-02    2.98  0.00291 ** 
## ELEMENTARYGREENLEAF                          1.11e-02   3.22e-02    0.34  0.73094    
## ELEMENTARYGREY CLOUD                        -1.21e-01   3.81e-02   -3.17  0.00152 ** 
## ELEMENTARYGROVELAND PARK                     5.71e-01   3.17e-02   17.99  < 2e-16 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  2.53e-01   3.63e-02    6.97  3.1e-12 ***
## ELEMENTARYHAMILTON                           7.83e-03   3.52e-02    0.22  0.82414    
## ELEMENTARYHANCOCK                           -1.02e-01   5.05e-02   -2.02  0.04320 *  
## ELEMENTARYHANCOCK EL.                        2.86e-01   4.33e-02    6.60  4.0e-11 ***
## ELEMENTARYHARRIET BISHOP                     4.06e-01   3.44e-02   11.79  < 2e-16 ***
## ELEMENTARYHAYDEN HEIGHTS                     5.91e-02   3.84e-02    1.54  0.12386    
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -3.63e-01   3.22e-02  -11.30  < 2e-16 ***
## ELEMENTARYHAYES                              1.28e-01   3.52e-02    3.65  0.00026 ***
## ELEMENTARYHIDDEN VALLEY                      2.82e-01   3.56e-02    7.92  2.4e-15 ***
## ELEMENTARYHIGHLAND                           7.61e-02   2.97e-02    2.56  0.01045 *  
## ELEMENTARYHIGHLAND PARK                      4.29e-01   3.10e-02   13.83  < 2e-16 ***
## ELEMENTARYHIGHWOOD HILLS                    -7.36e-02   3.72e-02   -1.98  0.04801 *  
## ELEMENTARYHILLSIDE                          -1.68e-01   3.92e-02   -4.28  1.9e-05 ***
## ELEMENTARYHILLTOP                           -1.93e-02   3.68e-02   -0.52  0.60111    
## ELEMENTARYHOMECROFT                          3.00e-01   4.65e-02    6.45  1.2e-10 ***
## ELEMENTARYHOOVER                             8.11e-02   4.01e-02    2.02  0.04300 *  
## ELEMENTARYHUGO                              -4.73e-02   3.52e-02   -1.34  0.17915    
## ELEMENTARYHUGO & ONEKA                      -2.70e-01   3.63e-02   -7.42  1.2e-13 ***
## ELEMENTARYISLAND LAKE                        1.67e-01   3.13e-02    5.33  1.0e-07 ***
## ELEMENTARYJACKSON                           -5.93e-01   4.27e-02  -13.88  < 2e-16 ***
## ELEMENTARYJEFFERSON                          4.08e-02   3.32e-02    1.23  0.21904    
## ELEMENTARYJEFFERS POND                       4.28e-01   3.66e-02   11.70  < 2e-16 ***
## ELEMENTARYJOHN F. KENNEDY                   -9.13e-04   5.29e-02   -0.02  0.98625    
## ELEMENTARYJOHNSON A+                        -3.16e-01   4.12e-02   -7.66  1.9e-14 ***
## ELEMENTARYJOHNSVILLE                         7.09e-02   2.99e-02    2.37  0.01762 *  
## ELEMENTARYJORDAN                             3.96e-01   1.32e-01    3.00  0.00272 ** 
## ELEMENTARYKAPOSIA                            5.75e-04   3.07e-02    0.02  0.98503    
## ELEMENTARYKENNETH HALL                       7.06e-03   3.41e-02    0.21  0.83603    
## ELEMENTARYLAKEAIRES                          1.40e-01   3.16e-02    4.43  9.4e-06 ***
## ELEMENTARYLAKE ELMO                          6.19e-02   3.46e-02    1.79  0.07366 .  
## ELEMENTARYLAKE MARION                       -1.59e-02   4.23e-02   -0.38  0.70723    
## ELEMENTARYLAKEVIEW                          -2.57e-02   3.50e-02   -0.73  0.46308    
## ELEMENTARYLiberty Ridge                      1.28e-01   3.74e-02    3.44  0.00059 ***
## ELEMENTARYLIBERTY RIDGE                      4.37e-02   3.68e-02    1.19  0.23516    
## ELEMENTARYLINCOLN                            1.40e-02   2.76e-02    0.51  0.61309    
## ELEMENTARYLINO LAKES                         1.04e-02   4.12e-02    0.25  0.80066    
## ELEMENTARYLITTLE CANADA                      1.32e-01   3.66e-02    3.61  0.00030 ***
## ELEMENTARYL.O. JACOB                         8.18e-02   4.37e-02    1.87  0.06095 .  
## ELEMENTARYLONGFELLOW                         5.41e-01   3.42e-02   15.79  < 2e-16 ***
## ELEMENTARYMADISON                            8.79e-02   3.56e-02    2.47  0.01360 *  
## ELEMENTARYMANN                               4.18e-01   3.07e-02   13.62  < 2e-16 ***
## ELEMENTARYMARION W. SAVAGE                   3.30e-01   3.14e-02   10.52  < 2e-16 ***
## ELEMENTARYMATOSKA INTERNATIONAL             -1.87e-02   4.10e-02   -0.46  0.64851    
## ELEMENTARYMCKINLEY                           5.50e-02   3.12e-02    1.76  0.07773 .  
## ELEMENTARYMEADOWVIEW                        -8.76e-02   3.36e-02   -2.61  0.00904 ** 
## ELEMENTARYMENDOTA                            1.45e-01   3.66e-02    3.95  7.9e-05 ***
## ELEMENTARYMIDDLETON                          1.15e-01   3.67e-02    3.12  0.00181 ** 
## ELEMENTARYMISSISSIPPI                       -9.52e-03   3.26e-02   -0.29  0.77036    
## ELEMENTARYMONROE                            -1.26e-01   3.28e-02   -3.86  0.00012 ***
## ELEMENTARYMORELAND                           6.07e-02   3.24e-02    1.87  0.06093 .  
## ELEMENTARYMORRIS BYE                        -1.51e-02   3.31e-02   -0.46  0.64728    
## ELEMENTARYNEWPORT                           -1.85e-01   3.72e-02   -4.98  6.3e-07 ***
## ELEMENTARYNORTH END                         -3.86e-01   3.22e-02  -12.00  < 2e-16 ***
## ELEMENTARYNORTH PARK                         3.80e-02   3.43e-02    1.11  0.26835    
## ELEMENTARYNORTH TRAIL                       -5.87e-02   3.29e-02   -1.79  0.07423 .  
## ELEMENTARYNORTHVIEW                          5.44e-02   3.64e-02    1.49  0.13525    
## ELEMENTARYOAKDALE                           -1.83e-01   3.51e-02   -5.23  1.7e-07 ***
## ELEMENTARYOAK HILLS                         -3.15e-02   4.05e-02   -0.78  0.43675    
## ELEMENTARYOAKRIDGE                           6.57e-01   3.12e-02   21.02  < 2e-16 ***
## ELEMENTARYOAK RIDGE                          6.71e-02   3.64e-02    1.84  0.06505 .  
## ELEMENTARYOBAMA                              4.31e-01   7.52e-02    5.73  1.0e-08 ***
## ELEMENTARYORCHARD LAKE                       4.68e-02   3.89e-02    1.21  0.22808    
## ELEMENTARYOTTER LAKE                         1.38e-01   3.24e-02    4.27  1.9e-05 ***
## ELEMENTARYPARKER                            -9.11e-03   8.16e-02   -0.11  0.91110    
## ELEMENTARYPARK TERRACE                       1.10e-01   3.47e-02    3.17  0.00152 ** 
## ELEMENTARYPARK TERRACE & WESTWOOD           -3.33e-01   2.60e-01   -1.28  0.20054    
## ELEMENTARYPARKVIEW                           4.94e-02   3.12e-02    1.58  0.11370    
## ELEMENTARYPARKWAY                            8.64e-02   3.92e-02    2.21  0.02742 *  
## ELEMENTARYPEARSON                            4.02e-01   2.79e-02   14.41  < 2e-16 ***
## ELEMENTARYPHALEN LAKE                       -3.11e-01   3.49e-02   -8.93  < 2e-16 ***
## ELEMENTARYPILOT KNOB                         8.26e-02   3.95e-02    2.09  0.03662 *  
## ELEMENTARYPINE BEND                          6.22e-02   3.66e-02    1.70  0.08884 .  
## ELEMENTARYPINE HILL                         -2.09e-01   3.68e-02   -5.69  1.3e-08 ***
## ELEMENTARYPINEWOOD                          -1.24e-02   2.91e-02   -0.42  0.67148    
## ELEMENTARYPROSPERITY HEIGHTS                 1.60e-01   5.41e-02    2.97  0.00302 ** 
## ELEMENTARYPULLMAN                           -2.89e-01   3.64e-02   -7.92  2.4e-15 ***
## ELEMENTARYRAHN                               2.37e-02   3.58e-02    0.66  0.50937    
## ELEMENTARYRAMSEY                            -1.07e-01   2.71e-02   -3.95  7.8e-05 ***
## ELEMENTARYRANDOLPH HEIGHTS                   4.95e-01   3.02e-02   16.41  < 2e-16 ***
## ELEMENTARYRED OAK                            5.33e-01   2.76e-02   19.32  < 2e-16 ***
## ELEMENTARYRED PINE                           7.87e-02   3.38e-02    2.33  0.01984 *  
## ELEMENTARYRED ROCK                           1.15e-01   3.80e-02    3.03  0.00245 ** 
## ELEMENTARYREDTAIL RIDGE                      3.49e-01   3.35e-02   10.42  < 2e-16 ***
## ELEMENTARYRICE LAKE                          1.34e-01   3.33e-02    4.02  5.8e-05 ***
## ELEMENTARYRICHARDSON                        -5.25e-03   3.20e-02   -0.16  0.86967    
## ELEMENTARYRIVERVIEW                         -1.85e-01   4.74e-02   -3.90  9.7e-05 ***
## ELEMENTARYRIVERVIEW & CHEROKEE              -3.05e-01   3.60e-02   -8.48  < 2e-16 ***
## ELEMENTARYROOSEVELT & RIVERVIEW & CHEROKEE   1.94e-01   3.82e-02    5.09  3.5e-07 ***
## ELEMENTARYROSEMOUNT                         -3.97e-02   3.43e-02   -1.16  0.24630    
## ELEMENTARYROYAL OAKS                        -2.19e-02   3.71e-02   -0.59  0.55488    
## ELEMENTARYRUM RIVER                         -9.75e-03   3.14e-02   -0.31  0.75614    
## ELEMENTARYRUTHERFORD                         1.75e-01   5.21e-02    3.36  0.00077 ***
## ELEMENTARYSALEM HILLS                        3.69e-02   5.22e-02    0.71  0.47917    
## ELEMENTARYSAND CREEK                         3.85e-02   3.03e-02    1.27  0.20430    
## ELEMENTARYSHANNON PARK                      -2.69e-02   3.33e-02   -0.81  0.41959    
## ELEMENTARYSHERIDAN                           1.29e-01   4.51e-02    2.85  0.00438 ** 
## ELEMENTARYSHERIDAN & AMES                   -4.15e-01   3.17e-02  -13.09  < 2e-16 ***
## ELEMENTARYSIOUX TRAIL                        1.61e-02   3.85e-02    0.42  0.67575    
## ELEMENTARYSKY OAKS                          -5.54e-02   3.68e-02   -1.50  0.13247    
## ELEMENTARYSKYVIEW                           -2.07e-01   3.83e-02   -5.41  6.2e-08 ***
## ELEMENTARYSKYVIEW COMMUNITY SCHOOL           1.00e-01   3.70e-02    2.72  0.00661 ** 
## ELEMENTARYSOMERSET HEIGHTS                   1.63e-01   3.34e-02    4.89  1.0e-06 ***
## ELEMENTARYSORTEBERG                         -8.26e-03   3.51e-02   -0.24  0.81386    
## ELEMENTARYSOUTH GROVE                        2.53e-02   5.03e-02    0.50  0.61435    
## ELEMENTARYSOUTHVIEW                         -1.84e-02   3.30e-02   -0.56  0.57761    
## ELEMENTARYST ANTHONY PARK                    5.28e-01   4.11e-02   12.85  < 2e-16 ***
## ELEMENTARYSTEVENSON                          9.83e-02   3.70e-02    2.66  0.00792 ** 
## ELEMENTARYSUNNYSIDE                          3.18e-02   3.39e-02    0.94  0.34875    
## ELEMENTARYSUN PATH                           8.13e-02   3.10e-02    2.62  0.00873 ** 
## ELEMENTARYSWEENEY                            2.51e-01   2.98e-02    8.41  < 2e-16 ***
## ELEMENTARYTHOMAS LAKE                        5.05e-02   3.84e-02    1.32  0.18778    
## ELEMENTARYTURTLE LAKE                        2.49e-01   2.96e-02    8.41  < 2e-16 ***
## ELEMENTARYTWIN LAKES                        -7.22e-01   1.67e-01   -4.32  1.6e-05 ***
## ELEMENTARYUNIVERSITY                        -1.09e-01   2.91e-02   -3.75  0.00018 ***
## ELEMENTARYVADNAIS HEIGHTS                    2.25e-02   3.59e-02    0.63  0.53036    
## ELEMENTARYVALENTINE HILLS                    1.18e-01   3.12e-02    3.76  0.00017 ***
## ELEMENTARYVALLEY VIEW                        1.17e-01   3.53e-02    3.30  0.00096 ***
## ELEMENTARYVISTA VIEW                        -1.97e-02   3.53e-02   -0.56  0.57604    
## ELEMENTARYWASHINGTON                         4.08e-02   3.82e-02    1.07  0.28593    
## ELEMENTARYWEAVER                             2.40e-02   3.05e-02    0.79  0.43142    
## ELEMENTARYWEBSTER                            7.63e-02   3.63e-02    2.10  0.03568 *  
## ELEMENTARYWESTVIEW                          -1.59e-04   3.36e-02    0.00  0.99623    
## ELEMENTARYWESTWOOD                           2.80e-01   3.73e-02    7.52  5.8e-14 ***
## ELEMENTARYWESTWOOD & GRAINWOOD               5.13e-01   3.06e-02   16.79  < 2e-16 ***
## ELEMENTARYWILLIAM BYRNE                     -5.40e-02   3.81e-02   -1.42  0.15630    
## ELEMENTARYWILLOW LANE                       -1.99e-02   3.96e-02   -0.50  0.61648    
## ELEMENTARYWILSHIRE PARK                      1.15e-01   6.81e-02    1.69  0.09090 .  
## ELEMENTARYWILSON                            -5.85e-02   3.57e-02   -1.64  0.10100    
## ELEMENTARYWOODBURY                          -1.04e-02   3.66e-02   -0.28  0.77750    
## ELEMENTARYWOODCREST                          1.74e-01   2.71e-02    6.42  1.4e-10 ***
## ELEMENTARYWOODCREST & WESTWOOD              -7.51e-02   2.60e-01   -0.29  0.77256    
## ELEMENTARYWOODLAND                           7.69e-02   3.80e-02    2.02  0.04294 *  
## WhiteDense                                   4.97e-01   1.20e-02   41.26  < 2e-16 ***
## fam_income                                  -1.08e-06   1.24e-07   -8.70  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.366 on 51142 degrees of freedom
## Multiple R-squared: 0.556,	Adjusted R-squared: 0.553 
## F-statistic:  255 on 251 and 51142 DF,  p-value: <2e-16
```


Time
----
The years of 2005 - 2011 were different for the real estate market relative to the early years of the 2000s. We now incorporate fixed effects for the sale year and month of sale to limit the confounding effects of the changing real estate conditions.
* Here we should create a graph of sales price indices for the region (such as Case Schiller) and the nation.


```r
TimeModel1 = lm(logPRICE ~ FIN_SQ_FT + ACREAGE + YEAR_BUILT + HomeStyle + ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH), data = HouseData)
summary(TimeModel1)
```

```
## 
## Call:
## lm(formula = logPRICE ~ FIN_SQ_FT + ACREAGE + YEAR_BUILT + HomeStyle + 
##     ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + 
##     factor(SALE_MONTH), data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -7.011 -0.101  0.023  0.153  3.187 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                  4.68e+00   2.08e-01   22.54  < 2e-16 ***
## FIN_SQ_FT                                    3.10e-04   3.26e-06   95.05  < 2e-16 ***
## ACREAGE                                      4.04e-02   1.97e-03   20.54  < 2e-16 ***
## YEAR_BUILT                                   3.35e-03   1.04e-04   32.33  < 2e-16 ***
## HomeStyle1 Story                             5.73e-03   2.05e-02    0.28  0.77957    
## HomeStyle1 Story Brick                       2.38e-01   2.01e-01    1.18  0.23801    
## HomeStyle1 Story Condo                      -5.01e-01   4.11e-02  -12.18  < 2e-16 ***
## HomeStyle1 Story Frame                       1.32e-01   2.92e-02    4.53  5.8e-06 ***
## HomeStyle1 Story Townhouse                   6.37e-02   3.12e-02    2.04  0.04154 *  
## HomeStyle2 1/2 Story Finished               -1.85e-01   3.46e-01   -0.53  0.59367    
## HomeStyle2 Story                            -1.30e-02   1.98e-02   -0.66  0.51121    
## HomeStyle2 Story Brick                       1.50e-01   3.46e-01    0.43  0.66516    
## HomeStyle2 Story Condo                      -4.45e-01   3.38e-02  -13.16  < 2e-16 ***
## HomeStyle2 Story Frame                       6.46e-02   2.90e-02    2.23  0.02605 *  
## HomeStyle2 Story Townhouse                  -3.16e-01   2.94e-02  -10.75  < 2e-16 ***
## HomeStyle3/2 Story                          -2.13e-02   2.69e-02   -0.79  0.42877    
## HomeStyle3-LVL SPLT                         -1.88e-01   3.11e-02   -6.03  1.6e-09 ***
## HomeStyle4 LVL SPLT                         -1.15e-01   2.77e-02   -4.14  3.5e-05 ***
## HomeStyle5/4 Story                           1.68e-02   2.45e-02    0.68  0.49343    
## HomeStyle7/4 Story                           1.45e-02   2.26e-02    0.64  0.52105    
## HomeStyleBi-level                            9.08e-02   2.23e-02    4.07  4.8e-05 ***
## HomeStyleBungalow                            1.83e-02   2.13e-02    0.86  0.39018    
## HomeStyleCabin                              -3.34e-01   3.46e-01   -0.96  0.33496    
## HomeStyleCondo                              -8.38e-01   3.46e-02  -24.20  < 2e-16 ***
## HomeStyleDetached Townhome - 1 story         2.24e-01   3.25e-02    6.89  5.7e-12 ***
## HomeStyleDetached Townhome - 2 story        -1.79e-02   5.14e-02   -0.35  0.72804    
## HomeStyleDetached Townhome - Split Foy*      3.95e-01   2.01e-01    1.96  0.04945 *  
## HomeStyleDetached Townhome - Split lev*      1.98e-01   9.31e-02    2.13  0.03344 *  
## HomeStyleDouble bungalow - split foyer       1.45e-01   3.47e-01    0.42  0.67609    
## HomeStyleDUP/TRI                            -1.35e-01   1.56e-01   -0.87  0.38659    
## HomeStyleEarth                              -4.17e-01   2.45e-01   -1.70  0.08851 .  
## HomeStyleLOG                                 2.68e-02   2.01e-01    0.13  0.89391    
## HomeStyleMfd Home (Double)                  -2.59e-01   3.46e-01   -0.75  0.45389    
## HomeStyleMini-Warehouse - Condo             -2.47e+00   1.34e-01  -18.47  < 2e-16 ***
## HomeStyleModified two story                  7.82e-02   2.55e-02    3.07  0.00216 ** 
## HomeStyleModular                            -1.65e+00   2.45e-01   -6.72  1.8e-11 ***
## HomeStyleN/A                                 1.51e-02   1.42e-01    0.11  0.91528    
## HomeStyleOther                              -1.10e+00   1.74e-01   -6.32  2.7e-10 ***
## HomeStyleQuad - one story                   -1.61e-01   1.57e-01   -1.03  0.30382    
## HomeStyleQuad - split level/foyer           -1.69e-01   3.54e-02   -4.76  1.9e-06 ***
## HomeStyleQuad - Two story                   -1.94e-01   2.45e-01   -0.79  0.42954    
## HomeStyleRAMBLER                            -1.54e-01   2.20e-02   -7.01  2.4e-12 ***
## HomeStyleRow                                -1.87e-01   3.46e-01   -0.54  0.58950    
## HomeStyleSalvage                             2.66e-02   1.75e-01    0.15  0.87919    
## HomeStyleSplit Entry                        -1.18e-01   2.07e-02   -5.68  1.3e-08 ***
## HomeStyleSPLIT-FOY                          -1.85e-01   3.05e-02   -6.07  1.3e-09 ***
## HomeStyleSplit Foyer Frame                   1.32e-01   2.98e-02    4.42  1.0e-05 ***
## HomeStyleSplit Level                         1.52e-02   2.07e-02    0.73  0.46365    
## HomeStyleSplit Level Frame                   1.82e-01   3.04e-02    6.00  2.0e-09 ***
## HomeStyleThree Story                        -2.30e-01   6.72e-02   -3.42  0.00063 ***
## HomeStyleTOWNHOME                           -4.88e-01   1.96e-02  -24.91  < 2e-16 ***
## HomeStyleTWIN HOME                          -2.93e-01   3.18e-02   -9.21  < 2e-16 ***
## HomeStyleTwin home - one story              -3.70e-01   7.72e-02   -4.79  1.7e-06 ***
## HomeStyleTwin home - spit level/ split*     -3.46e-01   4.64e-02   -7.46  9.1e-14 ***
## HomeStyleTwin home - two story              -6.01e-01   1.18e-01   -5.11  3.2e-07 ***
## ELEMENTARYAFTON-LAKELAND                    -7.28e-02   4.09e-02   -1.78  0.07536 .  
## ELEMENTARYAKIN ROAD                         -2.30e-03   3.01e-02   -0.08  0.93911    
## ELEMENTARYAMES                               1.38e-01   4.26e-02    3.24  0.00120 ** 
## ELEMENTARYANDERSEN                           1.36e-01   6.16e-02    2.21  0.02686 *  
## ELEMENTARYANDERSON & WILDWOOD                1.54e-01   3.45e-02    4.46  8.1e-06 ***
## ELEMENTARYANDOVER                            4.01e-02   2.76e-02    1.45  0.14619    
## ELEMENTARYARMSTRONG                         -6.33e-02   3.58e-02   -1.77  0.07724 .  
## ELEMENTARYBAILEY                            -2.82e-03   3.25e-02   -0.09  0.93087    
## ELEMENTARYBATTLE CREEK                       1.65e-01   4.16e-02    3.97  7.2e-05 ***
## ELEMENTARYBEL AIR                            1.66e-01   2.96e-02    5.58  2.4e-08 ***
## ELEMENTARYBIRCH LAKE                         9.44e-02   3.48e-02    2.71  0.00677 ** 
## ELEMENTARYBLUE HERON                        -2.92e-02   3.15e-02   -0.93  0.35368    
## ELEMENTARYBRIMHALL                           3.15e-01   3.06e-02   10.30  < 2e-16 ***
## ELEMENTARYBRUCE F. VENTO                    -2.15e-01   3.44e-02   -6.26  3.9e-10 ***
## ELEMENTARYCARVER                             5.21e-02   3.11e-02    1.67  0.09399 .  
## ELEMENTARYCASTLE                             5.42e-02   3.45e-02    1.57  0.11655    
## ELEMENTARYCEDAR CREEK                       -7.30e-02   6.72e-02   -1.09  0.27704    
## ELEMENTARYCEDAR PARK                         5.45e-02   3.72e-02    1.46  0.14323    
## ELEMENTARYCENTENNIAL                         1.58e-02   3.46e-02    0.46  0.64871    
## ELEMENTARYCENTERVILLE                       -4.46e-04   3.25e-02   -0.01  0.98907    
## ELEMENTARYCENTRAL PARK                       2.01e-01   3.16e-02    6.36  2.1e-10 ***
## ELEMENTARYCHELSEA HEIGHTS                    2.36e-01   2.76e-02    8.54  < 2e-16 ***
## ELEMENTARYCHERRY VIEW                       -5.15e-02   3.56e-02   -1.44  0.14879    
## ELEMENTARYCHRISTINA HUDDLESTON              -9.99e-03   3.62e-02   -0.28  0.78264    
## ELEMENTARYCOMO PARK                          1.58e-01   3.04e-02    5.20  2.0e-07 ***
## ELEMENTARYCOTTAGE GROVE                      1.90e-02   3.40e-02    0.56  0.57763    
## ELEMENTARYCOWERN                             4.61e-02   3.15e-02    1.46  0.14358    
## ELEMENTARYCRESTVIEW                         -5.84e-02   3.77e-02   -1.55  0.12191    
## ELEMENTARYCROOKED LAKE                       4.29e-02   3.26e-02    1.32  0.18765    
## ELEMENTARYCRYSTAL LAKE                      -2.36e-02   3.52e-02   -0.67  0.50222    
## ELEMENTARYDAYTONS BLUFF                     -1.90e-01   3.09e-02   -6.14  8.5e-10 ***
## ELEMENTARYDEERWOOD                           2.96e-02   3.82e-02    0.77  0.43851    
## ELEMENTARYDIAMOND PATH                       5.12e-02   3.07e-02    1.67  0.09585 .  
## ELEMENTARYEAGLE CREEK                        4.39e-01   2.98e-02   14.76  < 2e-16 ***
## ELEMENTARYEAGLE POINT                        1.15e-02   3.79e-02    0.30  0.76165    
## ELEMENTARYEAST BETHEL & CEDAR CREEK          1.21e-03   4.17e-02    0.03  0.97688    
## ELEMENTARYEASTERN HEIGHTS                   -4.68e-02   2.90e-02   -1.61  0.10639    
## ELEMENTARYEASTVIEW                          -2.17e-02   3.61e-02   -0.60  0.54842    
## ELEMENTARYECHO PARK                         -2.72e-02   3.15e-02   -0.86  0.38782    
## ELEMENTARYEDGERTON                           1.55e-01   3.34e-02    4.65  3.4e-06 ***
## ELEMENTARYEDWARD NEILL                       5.00e-04   3.37e-02    0.01  0.98815    
## ELEMENTARYEISENHOWER                         6.61e-02   3.90e-02    1.70  0.08976 .  
## ELEMENTARYEMMET D. WILLIAMS                  2.33e-01   3.11e-02    7.47  7.9e-14 ***
## ELEMENTARYFALCON HEIGHTS                     2.49e-01   3.03e-02    8.20  2.5e-16 ***
## ELEMENTARYFARMINGTON                        -1.21e-02   2.93e-02   -0.41  0.67902    
## ELEMENTARYFARNSWORTH                         1.92e-01   3.62e-02    5.29  1.2e-07 ***
## ELEMENTARYFARNSWORTH LOWER                  -1.16e-01   3.60e-02   -3.24  0.00121 ** 
## ELEMENTARYFIVE HAWKS                         5.30e-01   2.68e-02   19.80  < 2e-16 ***
## ELEMENTARYFOREST VIEW                       -3.28e-01   1.19e-01   -2.75  0.00605 ** 
## ELEMENTARYFOREST VIEW & FOREST LAKE         -3.74e-01   1.34e-01   -2.79  0.00533 ** 
## ELEMENTARYFRANKLIN                          -9.47e-02   3.01e-02   -3.15  0.00163 ** 
## ELEMENTARYFRANKLIN MUSIC                     1.01e-01   1.43e-01    0.70  0.48121    
## ELEMENTARYFROST LAKE                         6.22e-02   3.52e-02    1.76  0.07767 .  
## ELEMENTARYGALTIER & MAXFIELD                 2.65e-02   2.80e-02    0.95  0.34373    
## ELEMENTARYGARLOUGH                           1.63e-01   3.55e-02    4.57  4.8e-06 ***
## ELEMENTARYGIDEON POND                        7.06e-02   3.84e-02    1.84  0.06598 .  
## ELEMENTARYGLACIER HILLS                      6.60e-02   3.69e-02    1.79  0.07404 .  
## ELEMENTARYGLENDALE                           4.40e-01   3.01e-02   14.60  < 2e-16 ***
## ELEMENTARYGOLDEN LAKE                        1.47e-01   3.98e-02    3.69  0.00022 ***
## ELEMENTARYGRAINWOOD                          2.60e-01   3.64e-02    7.15  8.8e-13 ***
## ELEMENTARYGREENLEAF                         -2.27e-02   3.03e-02   -0.75  0.45526    
## ELEMENTARYGREY CLOUD                        -1.14e-02   3.59e-02   -0.32  0.75189    
## ELEMENTARYGROVELAND PARK                     5.10e-01   2.99e-02   17.06  < 2e-16 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  4.15e-01   3.43e-02   12.09  < 2e-16 ***
## ELEMENTARYHAMILTON                           3.88e-02   3.32e-02    1.17  0.24259    
## ELEMENTARYHANCOCK                            1.89e-01   4.77e-02    3.97  7.3e-05 ***
## ELEMENTARYHANCOCK EL.                        2.91e-01   4.08e-02    7.14  9.7e-13 ***
## ELEMENTARYHARRIET BISHOP                     3.17e-01   3.25e-02    9.77  < 2e-16 ***
## ELEMENTARYHAYDEN HEIGHTS                     4.73e-02   3.62e-02    1.31  0.19111    
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -1.27e-01   3.04e-02   -4.17  3.0e-05 ***
## ELEMENTARYHAYES                              1.36e-01   3.32e-02    4.09  4.4e-05 ***
## ELEMENTARYHIDDEN VALLEY                      2.81e-01   3.35e-02    8.38  < 2e-16 ***
## ELEMENTARYHIGHLAND                           6.60e-02   2.80e-02    2.36  0.01841 *  
## ELEMENTARYHIGHLAND PARK                      4.25e-01   2.92e-02   14.56  < 2e-16 ***
## ELEMENTARYHIGHWOOD HILLS                     1.04e-01   3.51e-02    2.96  0.00306 ** 
## ELEMENTARYHILLSIDE                          -2.94e-02   3.70e-02   -0.80  0.42585    
## ELEMENTARYHILLTOP                            1.01e-01   3.47e-02    2.90  0.00372 ** 
## ELEMENTARYHOMECROFT                          2.82e-01   4.38e-02    6.45  1.1e-10 ***
## ELEMENTARYHOOVER                             9.40e-02   3.77e-02    2.49  0.01270 *  
## ELEMENTARYHUGO                               1.75e-02   3.32e-02    0.53  0.59882    
## ELEMENTARYHUGO & ONEKA                       2.15e-02   3.44e-02    0.62  0.53255    
## ELEMENTARYISLAND LAKE                        1.63e-01   2.95e-02    5.52  3.5e-08 ***
## ELEMENTARYJACKSON                           -4.61e-01   4.03e-02  -11.46  < 2e-16 ***
## ELEMENTARYJEFFERSON                          4.47e-02   3.13e-02    1.43  0.15258    
## ELEMENTARYJEFFERS POND                       4.75e-01   3.45e-02   13.78  < 2e-16 ***
## ELEMENTARYJOHN F. KENNEDY                    3.55e-02   4.99e-02    0.71  0.47608    
## ELEMENTARYJOHNSON A+                        -1.90e-01   3.88e-02   -4.90  9.5e-07 ***
## ELEMENTARYJOHNSVILLE                         5.03e-02   2.82e-02    1.79  0.07380 .  
## ELEMENTARYJORDAN                             3.15e-01   1.24e-01    2.53  0.01137 *  
## ELEMENTARYKAPOSIA                            1.09e-01   2.89e-02    3.76  0.00017 ***
## ELEMENTARYKENNETH HALL                       1.95e-02   3.21e-02    0.61  0.54283    
## ELEMENTARYLAKEAIRES                          2.26e-01   2.98e-02    7.58  3.4e-14 ***
## ELEMENTARYLAKE ELMO                          4.93e-02   3.26e-02    1.51  0.13090    
## ELEMENTARYLAKE MARION                       -1.02e-02   3.98e-02   -0.26  0.79713    
## ELEMENTARYLAKEVIEW                          -6.45e-02   3.29e-02   -1.96  0.05037 .  
## ELEMENTARYLiberty Ridge                     -6.33e-02   3.53e-02   -1.79  0.07300 .  
## ELEMENTARYLIBERTY RIDGE                      1.32e-01   3.47e-02    3.81  0.00014 ***
## ELEMENTARYLINCOLN                            8.49e-02   2.61e-02    3.26  0.00112 ** 
## ELEMENTARYLINO LAKES                         1.00e-02   3.88e-02    0.26  0.79643    
## ELEMENTARYLITTLE CANADA                      2.14e-01   3.45e-02    6.22  5.1e-10 ***
## ELEMENTARYL.O. JACOB                         8.02e-02   4.11e-02    1.95  0.05129 .  
## ELEMENTARYLONGFELLOW                         4.54e-01   3.23e-02   14.08  < 2e-16 ***
## ELEMENTARYMADISON                            8.78e-02   3.36e-02    2.61  0.00893 ** 
## ELEMENTARYMANN                               4.44e-01   2.89e-02   15.36  < 2e-16 ***
## ELEMENTARYMARION W. SAVAGE                   3.80e-01   2.96e-02   12.85  < 2e-16 ***
## ELEMENTARYMATOSKA INTERNATIONAL              2.22e-01   3.88e-02    5.73  1.0e-08 ***
## ELEMENTARYMCKINLEY                           4.38e-02   2.93e-02    1.49  0.13589    
## ELEMENTARYMEADOWVIEW                        -2.21e-02   3.16e-02   -0.70  0.48388    
## ELEMENTARYMENDOTA                            9.28e-02   3.45e-02    2.69  0.00712 ** 
## ELEMENTARYMIDDLETON                          6.10e-02   3.46e-02    1.76  0.07777 .  
## ELEMENTARYMISSISSIPPI                        6.32e-02   3.07e-02    2.06  0.03979 *  
## ELEMENTARYMONROE                             4.15e-02   3.10e-02    1.34  0.18076    
## ELEMENTARYMORELAND                           1.16e-01   3.05e-02    3.82  0.00014 ***
## ELEMENTARYMORRIS BYE                        -6.44e-02   3.12e-02   -2.07  0.03880 *  
## ELEMENTARYNEWPORT                            2.85e-03   3.51e-02    0.08  0.93529    
## ELEMENTARYNORTH END                         -1.88e-01   3.04e-02   -6.19  5.9e-10 ***
## ELEMENTARYNORTH PARK                         5.91e-02   3.23e-02    1.83  0.06763 .  
## ELEMENTARYNORTH TRAIL                       -7.81e-03   3.10e-02   -0.25  0.80074    
## ELEMENTARYNORTHVIEW                         -4.16e-02   3.43e-02   -1.21  0.22570    
## ELEMENTARYOAKDALE                           -5.36e-03   3.31e-02   -0.16  0.87137    
## ELEMENTARYOAK HILLS                         -7.20e-02   3.82e-02   -1.89  0.05930 .  
## ELEMENTARYOAKRIDGE                           5.18e-01   2.95e-02   17.55  < 2e-16 ***
## ELEMENTARYOAK RIDGE                          5.71e-02   3.43e-02    1.67  0.09539 .  
## ELEMENTARYOBAMA                              5.31e-01   7.09e-02    7.49  6.9e-14 ***
## ELEMENTARYORCHARD LAKE                       8.59e-02   3.66e-02    2.35  0.01891 *  
## ELEMENTARYOTTER LAKE                         9.74e-02   3.05e-02    3.19  0.00140 ** 
## ELEMENTARYPARKER                            -4.64e-02   7.68e-02   -0.60  0.54632    
## ELEMENTARYPARK TERRACE                       1.06e-01   3.26e-02    3.26  0.00111 ** 
## ELEMENTARYPARK TERRACE & WESTWOOD           -1.16e-01   2.45e-01   -0.47  0.63513    
## ELEMENTARYPARKVIEW                           7.18e-02   2.94e-02    2.44  0.01467 *  
## ELEMENTARYPARKWAY                            6.56e-02   3.69e-02    1.78  0.07527 .  
## ELEMENTARYPEARSON                            3.82e-01   2.63e-02   14.53  < 2e-16 ***
## ELEMENTARYPHALEN LAKE                       -1.52e-01   3.29e-02   -4.63  3.6e-06 ***
## ELEMENTARYPILOT KNOB                         7.66e-02   3.72e-02    2.06  0.03960 *  
## ELEMENTARYPINE BEND                          7.87e-02   3.45e-02    2.28  0.02239 *  
## ELEMENTARYPINE HILL                         -1.78e-02   3.47e-02   -0.51  0.60761    
## ELEMENTARYPINEWOOD                           1.06e-02   2.74e-02    0.39  0.69959    
## ELEMENTARYPROSPERITY HEIGHTS                 1.53e-01   5.10e-02    2.99  0.00275 ** 
## ELEMENTARYPULLMAN                           -8.01e-02   3.44e-02   -2.33  0.01994 *  
## ELEMENTARYRAHN                               7.34e-02   3.38e-02    2.17  0.02975 *  
## ELEMENTARYRAMSEY                            -1.09e-01   2.55e-02   -4.26  2.0e-05 ***
## ELEMENTARYRANDOLPH HEIGHTS                   4.93e-01   2.84e-02   17.37  < 2e-16 ***
## ELEMENTARYRED OAK                            4.72e-01   2.60e-02   18.17  < 2e-16 ***
## ELEMENTARYRED PINE                           6.03e-02   3.18e-02    1.90  0.05799 .  
## ELEMENTARYRED ROCK                           3.22e-02   3.58e-02    0.90  0.36923    
## ELEMENTARYREDTAIL RIDGE                      4.57e-01   3.16e-02   14.47  < 2e-16 ***
## ELEMENTARYRICE LAKE                          2.26e-02   3.14e-02    0.72  0.47071    
## ELEMENTARYRICHARDSON                         1.24e-01   3.02e-02    4.09  4.3e-05 ***
## ELEMENTARYRIVERVIEW                          5.51e-02   4.48e-02    1.23  0.21871    
## ELEMENTARYRIVERVIEW & CHEROKEE              -2.23e-02   3.41e-02   -0.65  0.51381    
## ELEMENTARYROOSEVELT & RIVERVIEW & CHEROKEE   1.67e-01   3.59e-02    4.66  3.2e-06 ***
## ELEMENTARYROSEMOUNT                          2.90e-02   3.23e-02    0.90  0.37011    
## ELEMENTARYROYAL OAKS                         1.97e-02   3.49e-02    0.56  0.57257    
## ELEMENTARYRUM RIVER                         -4.00e-02   2.96e-02   -1.35  0.17677    
## ELEMENTARYRUTHERFORD                         1.16e-01   4.91e-02    2.35  0.01859 *  
## ELEMENTARYSALEM HILLS                        7.31e-02   4.92e-02    1.49  0.13720    
## ELEMENTARYSAND CREEK                        -6.64e-03   2.85e-02   -0.23  0.81590    
## ELEMENTARYSHANNON PARK                      -2.96e-02   3.14e-02   -0.94  0.34509    
## ELEMENTARYSHERIDAN                           1.49e-01   4.25e-02    3.50  0.00047 ***
## ELEMENTARYSHERIDAN & AMES                   -1.17e-01   3.01e-02   -3.88  0.00010 ***
## ELEMENTARYSIOUX TRAIL                        8.38e-02   3.63e-02    2.31  0.02077 *  
## ELEMENTARYSKY OAKS                           3.91e-02   3.47e-02    1.13  0.25963    
## ELEMENTARYSKYVIEW                           -5.92e-04   3.61e-02   -0.02  0.98694    
## ELEMENTARYSKYVIEW COMMUNITY SCHOOL           6.37e-02   3.49e-02    1.83  0.06749 .  
## ELEMENTARYSOMERSET HEIGHTS                   1.52e-01   3.15e-02    4.81  1.5e-06 ***
## ELEMENTARYSORTEBERG                         -6.83e-04   3.31e-02   -0.02  0.98351    
## ELEMENTARYSOUTH GROVE                        5.62e-02   4.74e-02    1.19  0.23512    
## ELEMENTARYSOUTHVIEW                          8.93e-03   3.11e-02    0.29  0.77422    
## ELEMENTARYST ANTHONY PARK                    5.44e-01   3.87e-02   14.05  < 2e-16 ***
## ELEMENTARYSTEVENSON                          1.47e-01   3.49e-02    4.20  2.6e-05 ***
## ELEMENTARYSUNNYSIDE                          1.18e-01   3.19e-02    3.68  0.00023 ***
## ELEMENTARYSUN PATH                           2.53e-01   2.93e-02    8.62  < 2e-16 ***
## ELEMENTARYSWEENEY                            3.06e-01   2.81e-02   10.88  < 2e-16 ***
## ELEMENTARYTHOMAS LAKE                        1.40e-02   3.61e-02    0.39  0.69756    
## ELEMENTARYTURTLE LAKE                        1.68e-01   2.79e-02    6.04  1.6e-09 ***
## ELEMENTARYTWIN LAKES                        -5.02e-01   1.57e-01   -3.19  0.00143 ** 
## ELEMENTARYUNIVERSITY                        -1.58e-01   2.74e-02   -5.77  8.2e-09 ***
## ELEMENTARYVADNAIS HEIGHTS                    9.91e-02   3.38e-02    2.93  0.00340 ** 
## ELEMENTARYVALENTINE HILLS                    1.99e-01   2.94e-02    6.75  1.5e-11 ***
## ELEMENTARYVALLEY VIEW                        1.55e-01   3.33e-02    4.66  3.2e-06 ***
## ELEMENTARYVISTA VIEW                         7.12e-02   3.33e-02    2.14  0.03222 *  
## ELEMENTARYWASHINGTON                         3.05e-02   3.60e-02    0.85  0.39708    
## ELEMENTARYWEAVER                             1.29e-01   2.88e-02    4.49  7.0e-06 ***
## ELEMENTARYWEBSTER                            2.07e-01   3.43e-02    6.05  1.4e-09 ***
## ELEMENTARYWESTVIEW                          -7.33e-03   3.16e-02   -0.23  0.81651    
## ELEMENTARYWESTWOOD                           3.52e-01   3.51e-02   10.02  < 2e-16 ***
## ELEMENTARYWESTWOOD & GRAINWOOD               4.07e-01   2.88e-02   14.11  < 2e-16 ***
## ELEMENTARYWILLIAM BYRNE                     -2.54e-02   3.59e-02   -0.71  0.47921    
## ELEMENTARYWILLOW LANE                        1.04e-01   3.74e-02    2.77  0.00558 ** 
## ELEMENTARYWILSHIRE PARK                      2.74e-01   6.42e-02    4.26  2.0e-05 ***
## ELEMENTARYWILSON                            -5.26e-02   3.36e-02   -1.56  0.11791    
## ELEMENTARYWOODBURY                           6.37e-02   3.45e-02    1.85  0.06483 .  
## ELEMENTARYWOODCREST                          1.42e-01   2.55e-02    5.54  3.0e-08 ***
## ELEMENTARYWOODCREST & WESTWOOD               2.57e-01   2.45e-01    1.05  0.29372    
## ELEMENTARYWOODLAND                           5.86e-04   3.58e-02    0.02  0.98693    
## WhiteDense                                   1.95e-01   1.20e-02   16.29  < 2e-16 ***
## fam_income                                   4.62e-06   1.38e-07   33.35  < 2e-16 ***
## factor(SALE_YEAR)2006                        6.24e-03   3.86e-03    1.62  0.10548    
## factor(SALE_YEAR)2009                       -3.41e-01   5.68e-03  -60.01  < 2e-16 ***
## factor(SALE_YEAR)2010                       -3.59e-01   5.85e-03  -61.33  < 2e-16 ***
## factor(SALE_YEAR)2011                       -5.14e-01   1.02e-02  -50.13  < 2e-16 ***
## factor(SALE_MONTH)2                         -1.36e-02   9.11e-03   -1.50  0.13408    
## factor(SALE_MONTH)3                          1.35e-02   8.47e-03    1.60  0.11014    
## factor(SALE_MONTH)4                          8.35e-03   8.30e-03    1.01  0.31484    
## factor(SALE_MONTH)5                          3.92e-02   8.19e-03    4.78  1.7e-06 ***
## factor(SALE_MONTH)6                          4.46e-02   8.02e-03    5.56  2.7e-08 ***
## factor(SALE_MONTH)7                          4.40e-02   8.31e-03    5.29  1.2e-07 ***
## factor(SALE_MONTH)8                          4.49e-02   8.24e-03    5.45  5.1e-08 ***
## factor(SALE_MONTH)9                          2.68e-02   8.49e-03    3.15  0.00161 ** 
## factor(SALE_MONTH)10                         3.99e-02   8.55e-03    4.67  3.0e-06 ***
## factor(SALE_MONTH)11                         5.92e-03   8.83e-03    0.67  0.50218    
## factor(SALE_MONTH)12                        -6.03e-03   9.13e-03   -0.66  0.50870    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.345 on 51127 degrees of freedom
## Multiple R-squared: 0.606,	Adjusted R-squared: 0.604 
## F-statistic:  295 on 266 and 51127 DF,  p-value: <2e-16
```


Open Space
---------
Now we'll bring in the open space measures, both Open Space Index and park area.


```r
osiModel05int = lm(logPRICE ~ FIN_SQ_FT + ACREAGE + YEAR_BUILT + HomeStyle + ELEMENTARY + WhiteDense + fam_income + factor(SALE_MONTH) + parkArea05 * factor(SALE_YEAR) + 
    OSV05KM * factor(SALE_YEAR), data = HouseData)
coef(summary(osiModel05int))[-(5:250), ]
```

```
##                                    Estimate Std. Error   t value   Pr(>|t|)
## (Intercept)                       4.751e+00  2.080e-01  22.84507 6.175e-115
## FIN_SQ_FT                         3.093e-04  3.271e-06  94.56074  0.000e+00
## ACREAGE                           4.014e-02  2.012e-03  19.94810  3.377e-88
## YEAR_BUILT                        3.314e-03  1.038e-04  31.91130 2.805e-221
## WhiteDense                        1.926e-01  1.199e-02  16.05827  6.936e-58
## fam_income                        4.589e-06  1.385e-07  33.11811 5.448e-238
## factor(SALE_MONTH)2              -1.321e-02  9.098e-03  -1.45236  1.464e-01
## factor(SALE_MONTH)3               1.397e-02  8.466e-03   1.65070  9.881e-02
## factor(SALE_MONTH)4               9.585e-03  8.298e-03   1.15512  2.480e-01
## factor(SALE_MONTH)5               4.048e-02  8.186e-03   4.94549  7.619e-07
## factor(SALE_MONTH)6               4.593e-02  8.014e-03   5.73101  1.004e-08
## factor(SALE_MONTH)7               4.518e-02  8.302e-03   5.44165  5.303e-08
## factor(SALE_MONTH)8               4.596e-02  8.236e-03   5.58074  2.407e-08
## factor(SALE_MONTH)9               2.804e-02  8.480e-03   3.30668  9.447e-04
## factor(SALE_MONTH)10              4.093e-02  8.546e-03   4.78908  1.680e-06
## factor(SALE_MONTH)11              7.525e-03  8.823e-03   0.85296  3.937e-01
## factor(SALE_MONTH)12             -4.339e-03  9.120e-03  -0.47583  6.342e-01
## parkArea05                        2.854e-08  3.860e-08   0.73953  4.596e-01
## factor(SALE_YEAR)2006            -2.434e-04  8.118e-03  -0.02998  9.761e-01
## factor(SALE_YEAR)2009            -3.600e-01  9.734e-03 -36.98296 1.748e-295
## factor(SALE_YEAR)2010            -3.853e-01  1.033e-02 -37.29364 2.289e-300
## factor(SALE_YEAR)2011            -6.047e-01  1.907e-02 -31.71045 1.484e-218
## OSV05KM                           4.224e-10  1.370e-09   0.30834  7.578e-01
## parkArea05:factor(SALE_YEAR)2006 -5.083e-08  5.434e-08  -0.93541  3.496e-01
## parkArea05:factor(SALE_YEAR)2009  2.717e-07  6.251e-08   4.34636  1.387e-05
## parkArea05:factor(SALE_YEAR)2010  4.573e-08  6.517e-08   0.70178  4.828e-01
## parkArea05:factor(SALE_YEAR)2011  7.107e-07  1.254e-07   5.66981  1.437e-08
## factor(SALE_YEAR)2006:OSV05KM     2.647e-09  1.817e-09   1.45663  1.452e-01
## factor(SALE_YEAR)2009:OSV05KM     7.241e-11  2.034e-09   0.03560  9.716e-01
## factor(SALE_YEAR)2010:OSV05KM     6.317e-09  2.141e-09   2.95043  3.175e-03
## factor(SALE_YEAR)2011:OSV05KM     1.233e-08  4.238e-09   2.90967  3.620e-03
```


Now I want to try running a model without any outliers in it, classified in the Outliers column.  


```r
HouseDataClean = subset(HouseData, Outliers == 0)
osiModel05intClean = lm(logPRICE ~ FIN_SQ_FT + ACREAGE + YEAR_BUILT + HomeStyle + ELEMENTARY + WhiteDense + fam_income + factor(SALE_MONTH) + parkArea05 * factor(SALE_YEAR) + 
    OSV05KM * factor(SALE_YEAR), data = HouseDataClean)
coef(summary(osiModel05intClean))[-(5:250), ]
```

```
##                                    Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)                       4.785e+00  2.070e-01  23.1128 1.383e-117
## FIN_SQ_FT                         3.095e-04  3.259e-06  94.9824  0.000e+00
## ACREAGE                           3.762e-02  2.052e-03  18.3329  7.865e-75
## YEAR_BUILT                        3.296e-03  1.034e-04  31.8839 6.620e-221
## WhiteDense                        1.974e-01  1.194e-02  16.5246  3.520e-61
## fam_income                        4.574e-06  1.379e-07  33.1599 1.403e-238
## factor(SALE_MONTH)2              -1.272e-02  9.057e-03  -1.4046  1.601e-01
## factor(SALE_MONTH)3               1.446e-02  8.427e-03   1.7159  8.618e-02
## factor(SALE_MONTH)4               1.006e-02  8.260e-03   1.2181  2.232e-01
## factor(SALE_MONTH)5               4.047e-02  8.149e-03   4.9668  6.827e-07
## factor(SALE_MONTH)6               4.636e-02  7.977e-03   5.8120  6.211e-09
## factor(SALE_MONTH)7               4.563e-02  8.265e-03   5.5210  3.388e-08
## factor(SALE_MONTH)8               4.485e-02  8.200e-03   5.4694  4.537e-08
## factor(SALE_MONTH)9               2.783e-02  8.441e-03   3.2969  9.782e-04
## factor(SALE_MONTH)10              4.139e-02  8.507e-03   4.8653  1.146e-06
## factor(SALE_MONTH)11              7.311e-03  8.783e-03   0.8324  4.052e-01
## factor(SALE_MONTH)12             -4.800e-03  9.079e-03  -0.5287  5.970e-01
## parkArea05                        2.343e-08  3.842e-08   0.6098  5.420e-01
## factor(SALE_YEAR)2006             2.175e-03  8.084e-03   0.2690  7.879e-01
## factor(SALE_YEAR)2009            -3.593e-01  9.690e-03 -37.0819 4.926e-297
## factor(SALE_YEAR)2010            -3.839e-01  1.028e-02 -37.3309 5.914e-301
## factor(SALE_YEAR)2011            -6.035e-01  1.898e-02 -31.7931 1.129e-219
## OSV05KM                           7.174e-10  1.364e-09   0.5258  5.990e-01
## parkArea05:factor(SALE_YEAR)2006 -5.429e-08  5.410e-08  -1.0034  3.157e-01
## parkArea05:factor(SALE_YEAR)2009  2.823e-07  6.222e-08   4.5371  5.717e-06
## parkArea05:factor(SALE_YEAR)2010  4.784e-08  6.487e-08   0.7375  4.608e-01
## parkArea05:factor(SALE_YEAR)2011  7.141e-07  1.248e-07   5.7231  1.052e-08
## factor(SALE_YEAR)2006:OSV05KM     1.993e-09  1.809e-09   1.1017  2.706e-01
## factor(SALE_YEAR)2009:OSV05KM    -2.594e-10  2.025e-09  -0.1281  8.981e-01
## factor(SALE_YEAR)2010:OSV05KM     6.104e-09  2.131e-09   2.8640  4.185e-03
## factor(SALE_YEAR)2011:OSV05KM     1.205e-08  4.218e-09   2.8568  4.280e-03
```


Now I want to look at points where the sale price is under the land value and see what removing those does, call those homes that are not under water.


```r
HouseDataClean$SaleLandDiff = HouseDataClean$EMV_LAND - HouseDataClean$SALE_VALUE
HouseDataNotUnderwater = subset(HouseDataClean, SaleLandDiff > 0)
osiModel05intNotUnderwater = lm(logPRICE ~ FIN_SQ_FT + ACREAGE + YEAR_BUILT + HomeStyle + ELEMENTARY + WhiteDense + fam_income + factor(SALE_MONTH) + parkArea05 * 
    factor(SALE_YEAR) + OSV05KM * factor(SALE_YEAR), data = HouseDataNotUnderwater)
coef(summary(osiModel05intNotUnderwater))
```

```
##                                               Estimate Std. Error  t value  Pr(>|t|)
## (Intercept)                                  7.735e+00  2.785e+00  2.77738 5.640e-03
## FIN_SQ_FT                                    1.641e-04  6.445e-05  2.54542 1.115e-02
## ACREAGE                                      5.924e-02  2.649e-02  2.23604 2.569e-02
## YEAR_BUILT                                  -4.981e-04  1.339e-03 -0.37206 7.100e-01
## HomeStyle1 Story                             3.866e-01  5.495e-01  0.70351 4.820e-01
## HomeStyle1 Story Condo                      -5.814e-01  9.009e-01 -0.64535 5.189e-01
## HomeStyle1 Story Frame                       6.648e-01  6.160e-01  1.07933 2.808e-01
## HomeStyle1 Story Townhouse                   4.333e-01  1.408e+00  0.30770 7.584e-01
## HomeStyle2 Story                             3.318e-01  5.436e-01  0.61046 5.418e-01
## HomeStyle2 Story Frame                       4.930e-01  6.184e-01  0.79729 4.256e-01
## HomeStyle2 Story Townhouse                  -6.146e-01  7.867e-01 -0.78123 4.350e-01
## HomeStyle3/2 Story                          -2.829e-02  6.105e-01 -0.04634 9.631e-01
## HomeStyle5/4 Story                          -6.758e-01  7.708e-01 -0.87668 3.810e-01
## HomeStyle7/4 Story                           4.172e-01  5.529e-01  0.75456 4.508e-01
## HomeStyleBi-level                            2.212e-01  6.429e-01  0.34411 7.309e-01
## HomeStyleBungalow                            4.591e-01  5.524e-01  0.83105 4.063e-01
## HomeStyleDetached Townhome - 1 story         2.091e-01  1.073e+00  0.19479 8.456e-01
## HomeStyleDUP/TRI                             7.148e-01  1.021e+00  0.69976 4.843e-01
## HomeStyleLOG                                -4.455e-02  1.275e+00 -0.03494 9.721e-01
## HomeStyleModular                             8.048e-01  1.025e+00  0.78530 4.326e-01
## HomeStyleOther                              -1.633e+00  1.011e+00 -1.61539 1.067e-01
## HomeStyleRAMBLER                             4.712e-01  5.420e-01  0.86936 3.850e-01
## HomeStyleSalvage                             9.550e-01  8.171e-01  1.16877 2.429e-01
## HomeStyleSplit Entry                         2.626e-01  5.505e-01  0.47702 6.335e-01
## HomeStyleSPLIT-FOY                           4.538e-01  1.010e+00  0.44939 6.533e-01
## HomeStyleSplit Foyer Frame                   1.064e+00  7.412e-01  1.43591 1.515e-01
## HomeStyleSplit Level                         1.484e-01  5.720e-01  0.25949 7.953e-01
## HomeStyleSplit Level Frame                  -5.078e-02  7.884e-01 -0.06441 9.487e-01
## HomeStyleTOWNHOME                           -2.428e+00  7.553e-01 -3.21433 1.373e-03
## ELEMENTARYAFTON-LAKELAND                    -1.231e-01  1.045e+00 -0.11779 9.063e-01
## ELEMENTARYAMES                               1.822e+00  9.858e-01  1.84839 6.501e-02
## ELEMENTARYANDERSON & WILDWOOD                1.625e+00  6.700e-01  2.42547 1.556e-02
## ELEMENTARYANDOVER                            8.594e-01  8.115e-01  1.05893 2.900e-01
## ELEMENTARYBAILEY                             1.516e+00  1.183e+00  1.28170 2.004e-01
## ELEMENTARYBATTLE CREEK                      -2.038e+00  9.748e-01 -2.09093 3.693e-02
## ELEMENTARYBEL AIR                            2.269e+00  6.580e-01  3.44798 6.017e-04
## ELEMENTARYBIRCH LAKE                         2.136e+00  6.370e-01  3.35276 8.471e-04
## ELEMENTARYBLUE HERON                         1.334e+00  8.367e-01  1.59377 1.115e-01
## ELEMENTARYBRIMHALL                           2.120e+00  6.712e-01  3.15781 1.664e-03
## ELEMENTARYBRUCE F. VENTO                     1.328e+00  6.263e-01  2.11970 3.441e-02
## ELEMENTARYCARVER                             2.234e+00  6.386e-01  3.49876 4.997e-04
## ELEMENTARYCASTLE                             2.012e+00  7.239e-01  2.77992 5.597e-03
## ELEMENTARYCENTENNIAL                         2.248e+00  8.197e-01  2.74230 6.271e-03
## ELEMENTARYCENTERVILLE                        4.443e-01  7.477e-01  0.59424 5.526e-01
## ELEMENTARYCENTRAL PARK                       2.382e+00  6.202e-01  3.84119 1.346e-04
## ELEMENTARYCHELSEA HEIGHTS                    1.831e+00  6.152e-01  2.97622 3.028e-03
## ELEMENTARYCOMO PARK                          1.492e+00  6.090e-01  2.44973 1.456e-02
## ELEMENTARYCOTTAGE GROVE                      1.609e+00  8.615e-01  1.86801 6.222e-02
## ELEMENTARYCOWERN                             1.926e+00  6.048e-01  3.18522 1.516e-03
## ELEMENTARYCRESTVIEW                          3.004e+00  8.225e-01  3.65302 2.803e-04
## ELEMENTARYDAYTONS BLUFF                      8.558e-01  6.525e-01  1.31152 1.902e-01
## ELEMENTARYEAGLE CREEK                        1.929e+00  7.583e-01  2.54307 1.122e-02
## ELEMENTARYEAGLE POINT                        1.898e+00  8.068e-01  2.35225 1.896e-02
## ELEMENTARYEAST BETHEL & CEDAR CREEK          1.800e+00  9.830e-01  1.83092 6.758e-02
## ELEMENTARYEASTERN HEIGHTS                    1.463e+00  6.032e-01  2.42616 1.553e-02
## ELEMENTARYEDGERTON                           1.457e+00  6.709e-01  2.17153 3.026e-02
## ELEMENTARYEISENHOWER                         1.564e+00  7.340e-01  2.13040 3.352e-02
## ELEMENTARYEMMET D. WILLIAMS                  2.486e+00  6.713e-01  3.70286 2.315e-04
## ELEMENTARYFALCON HEIGHTS                     2.824e+00  8.007e-01  3.52764 4.492e-04
## ELEMENTARYFARNSWORTH LOWER                   1.336e+00  6.313e-01  2.11560 3.476e-02
## ELEMENTARYFIVE HAWKS                         2.654e+00  6.731e-01  3.94291 8.935e-05
## ELEMENTARYFOREST VIEW & FOREST LAKE          1.095e+00  8.532e-01  1.28352 1.998e-01
## ELEMENTARYFRANKLIN                           2.405e+00  7.289e-01  3.29999 1.020e-03
## ELEMENTARYFROST LAKE                         2.431e+00  6.968e-01  3.48912 5.178e-04
## ELEMENTARYGALTIER & MAXFIELD                 1.296e+00  6.155e-01  2.10583 3.561e-02
## ELEMENTARYGOLDEN LAKE                        2.405e+00  9.798e-01  2.45446 1.437e-02
## ELEMENTARYGRAINWOOD                          2.881e+00  1.140e+00  2.52787 1.171e-02
## ELEMENTARYGREY CLOUD                         7.308e-01  8.603e-01  0.84945 3.959e-01
## ELEMENTARYGROVELAND PARK                     2.089e+00  6.157e-01  3.39310 7.336e-04
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  1.547e+00  6.205e-01  2.49281 1.292e-02
## ELEMENTARYHANCOCK                            1.385e+00  8.040e-01  1.72201 8.555e-02
## ELEMENTARYHAYDEN HEIGHTS                     1.894e+00  9.875e-01  1.91763 5.560e-02
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.      7.630e-01  6.275e-01  1.21592 2.245e-01
## ELEMENTARYHAYES                              2.066e+00  7.469e-01  2.76688 5.822e-03
## ELEMENTARYHIDDEN VALLEY                      1.573e+00  9.930e-01  1.58389 1.137e-01
## ELEMENTARYHIGHLAND                           2.725e+00  8.471e-01  3.21695 1.361e-03
## ELEMENTARYHIGHLAND PARK                      2.132e+00  6.180e-01  3.44974 5.979e-04
## ELEMENTARYHIGHWOOD HILLS                     2.428e+00  6.277e-01  3.86832 1.208e-04
## ELEMENTARYHILLSIDE                           1.203e+00  8.512e-01  1.41322 1.581e-01
## ELEMENTARYHOMECROFT                          2.200e+00  9.814e-01  2.24117 2.536e-02
## ELEMENTARYHOOVER                             1.541e+00  9.818e-01  1.56938 1.171e-01
## ELEMENTARYHUGO                               1.147e+00  8.031e-01  1.42822 1.537e-01
## ELEMENTARYHUGO & ONEKA                       1.615e+00  7.184e-01  2.24801 2.491e-02
## ELEMENTARYISLAND LAKE                        2.381e+00  6.494e-01  3.66704 2.657e-04
## ELEMENTARYJACKSON                            1.084e+00  6.387e-01  1.69679 9.022e-02
## ELEMENTARYJEFFERSON                          2.891e+00  1.127e+00  2.56445 1.056e-02
## ELEMENTARYJEFFERS POND                       2.143e+00  7.704e-01  2.78199 5.561e-03
## ELEMENTARYJOHNSON A+                         1.190e+00  6.701e-01  1.77653 7.612e-02
## ELEMENTARYJOHNSVILLE                         1.695e+00  6.782e-01  2.49916 1.270e-02
## ELEMENTARYKENNETH HALL                       1.612e+00  9.741e-01  1.65505 9.840e-02
## ELEMENTARYLAKEAIRES                          2.585e+00  6.171e-01  4.18916 3.192e-05
## ELEMENTARYLAKE ELMO                          1.218e+00  6.782e-01  1.79580 7.300e-02
## ELEMENTARYLIBERTY RIDGE                      1.502e+00  7.144e-01  2.10209 3.593e-02
## ELEMENTARYLINCOLN                            1.866e+00  6.269e-01  2.97673 3.023e-03
## ELEMENTARYLINO LAKES                         1.323e+00  1.261e+00  1.04845 2.948e-01
## ELEMENTARYLITTLE CANADA                      2.079e+00  6.779e-01  3.06649 2.257e-03
## ELEMENTARYLONGFELLOW                         2.975e+00  7.456e-01  3.99039 7.357e-05
## ELEMENTARYMADISON                            2.312e+00  8.006e-01  2.88794 4.008e-03
## ELEMENTARYMANN                               1.734e+00  6.589e-01  2.63144 8.707e-03
## ELEMENTARYMARION W. SAVAGE                  -1.165e-02  8.806e-01 -0.01322 9.895e-01
## ELEMENTARYMATOSKA INTERNATIONAL              4.009e+00  1.139e+00  3.51871 4.643e-04
## ELEMENTARYMCKINLEY                           1.941e+00  6.463e-01  3.00307 2.777e-03
## ELEMENTARYMISSISSIPPI                        1.556e+00  6.662e-01  2.33588 1.980e-02
## ELEMENTARYMONROE                             1.312e+00  6.020e-01  2.17949 2.966e-02
## ELEMENTARYNEWPORT                            1.424e+00  6.829e-01  2.08538 3.743e-02
## ELEMENTARYNORTH END                          1.298e+00  6.097e-01  2.12878 3.365e-02
## ELEMENTARYNORTH PARK                         1.613e+00  7.973e-01  2.02262 4.353e-02
## ELEMENTARYOAKDALE                            1.532e+00  6.635e-01  2.30824 2.130e-02
## ELEMENTARYOAKRIDGE                           1.816e+00  1.015e+00  1.78871 7.413e-02
## ELEMENTARYOBAMA                              2.109e+00  7.117e-01  2.96340 3.155e-03
## ELEMENTARYOTTER LAKE                         2.117e+00  6.576e-01  3.21991 1.347e-03
## ELEMENTARYPARKVIEW                           2.865e+00  8.388e-01  3.41577 6.761e-04
## ELEMENTARYPARKWAY                            1.432e+00  8.173e-01  1.75271 8.013e-02
## ELEMENTARYPEARSON                            1.710e+00  7.676e-01  2.22755 2.626e-02
## ELEMENTARYPHALEN LAKE                        1.201e+00  6.623e-01  1.81385 7.017e-02
## ELEMENTARYPINE HILL                          1.129e+00  7.608e-01  1.48402 1.383e-01
## ELEMENTARYPINEWOOD                           1.976e+00  6.058e-01  3.26200 1.165e-03
## ELEMENTARYPROSPERITY HEIGHTS                 2.741e+00  9.735e-01  2.81527 5.023e-03
## ELEMENTARYPULLMAN                            1.195e+00  6.717e-01  1.77936 7.565e-02
## ELEMENTARYRAMSEY                             1.230e+00  6.910e-01  1.78043 7.548e-02
## ELEMENTARYRANDOLPH HEIGHTS                   2.586e+00  6.362e-01  4.06414 5.419e-05
## ELEMENTARYRED OAK                            1.164e+00  8.083e-01  1.43997 1.504e-01
## ELEMENTARYREDTAIL RIDGE                      1.791e+00  9.846e-01  1.81850 6.945e-02
## ELEMENTARYRICE LAKE                          1.251e+00  9.867e-01  1.26840 2.051e-01
## ELEMENTARYRICHARDSON                         1.804e+00  6.331e-01  2.84898 4.526e-03
## ELEMENTARYRIVERVIEW & CHEROKEE               1.498e+00  6.098e-01  2.45667 1.429e-02
## ELEMENTARYROOSEVELT & RIVERVIEW & CHEROKEE   2.619e+00  6.715e-01  3.90056 1.061e-04
## ELEMENTARYROYAL OAKS                         1.422e+00  1.033e+00  1.37602 1.693e-01
## ELEMENTARYRUM RIVER                         -1.092e+00  6.746e-01 -1.61859 1.060e-01
## ELEMENTARYRUTHERFORD                         7.125e-01  7.807e-01  0.91260 3.618e-01
## ELEMENTARYSHERIDAN                           2.365e+00  9.855e-01  2.40039 1.666e-02
## ELEMENTARYSHERIDAN & AMES                    1.883e+00  5.983e-01  3.14664 1.728e-03
## ELEMENTARYSKYVIEW                            1.783e+00  1.024e+00  1.74251 8.190e-02
## ELEMENTARYSORTEBERG                         -8.002e-01  9.739e-01 -0.82162 4.116e-01
## ELEMENTARYST ANTHONY PARK                    2.287e+00  6.583e-01  3.47373 5.478e-04
## ELEMENTARYSTEVENSON                          2.071e+00  9.733e-01  2.12822 3.370e-02
## ELEMENTARYSUNNYSIDE                          1.997e+00  6.361e-01  3.13987 1.768e-03
## ELEMENTARYSUN PATH                           1.921e+00  6.108e-01  3.14507 1.737e-03
## ELEMENTARYSWEENEY                            2.109e+00  6.919e-01  3.04816 2.397e-03
## ELEMENTARYTURTLE LAKE                        2.794e+00  6.092e-01  4.58584 5.437e-06
## ELEMENTARYTWIN LAKES                         1.887e+00  1.072e+00  1.75936 7.899e-02
## ELEMENTARYUNIVERSITY                        -4.599e-01  1.023e+00 -0.44969 6.531e-01
## ELEMENTARYVADNAIS HEIGHTS                    2.335e+00  6.111e-01  3.82145 1.456e-04
## ELEMENTARYVALENTINE HILLS                    2.210e+00  6.018e-01  3.67237 2.603e-04
## ELEMENTARYVALLEY VIEW                        2.436e+00  9.803e-01  2.48468 1.322e-02
## ELEMENTARYWEAVER                             2.082e+00  5.993e-01  3.47493 5.454e-04
## ELEMENTARYWEBSTER                            2.414e+00  6.726e-01  3.58921 3.570e-04
## ELEMENTARYWESTWOOD                           2.031e+00  7.355e-01  2.76192 5.911e-03
## ELEMENTARYWESTWOOD & GRAINWOOD               3.541e+00  7.557e-01  4.68553 3.411e-06
## ELEMENTARYWILLOW LANE                        2.332e+00  6.552e-01  3.55886 4.000e-04
## ELEMENTARYWILSHIRE PARK                      1.950e+00  8.070e-01  2.41598 1.597e-02
## ELEMENTARYWILSON                             1.783e+00  7.569e-01  2.35505 1.882e-02
## ELEMENTARYWOODBURY                           1.761e+00  9.138e-01  1.92669 5.446e-02
## ELEMENTARYWOODCREST                          2.477e+00  7.379e-01  3.35757 8.328e-04
## WhiteDense                                   7.666e-01  2.137e-01  3.58795 3.587e-04
## fam_income                                   7.356e-06  2.537e-06  2.89878 3.874e-03
## factor(SALE_MONTH)2                         -5.114e-02  1.475e-01 -0.34678 7.289e-01
## factor(SALE_MONTH)3                         -6.701e-02  1.518e-01 -0.44153 6.590e-01
## factor(SALE_MONTH)4                         -1.522e-01  1.460e-01 -1.04263 2.975e-01
## factor(SALE_MONTH)5                         -1.191e-01  1.551e-01 -0.76782 4.429e-01
## factor(SALE_MONTH)6                         -3.313e-02  1.575e-01 -0.21036 8.335e-01
## factor(SALE_MONTH)7                          4.895e-02  1.652e-01  0.29629 7.671e-01
## factor(SALE_MONTH)8                          1.136e-01  1.624e-01  0.69956 4.845e-01
## factor(SALE_MONTH)9                         -1.649e-01  1.639e-01 -1.00589 3.148e-01
## factor(SALE_MONTH)10                        -3.616e-01  1.734e-01 -2.08551 3.742e-02
## factor(SALE_MONTH)11                        -3.020e-01  1.663e-01 -1.81556 6.990e-02
## factor(SALE_MONTH)12                        -3.491e-01  1.659e-01 -2.10404 3.576e-02
## parkArea05                                   1.344e-07  1.416e-06  0.09495 9.244e-01
## factor(SALE_YEAR)2006                       -7.418e-03  2.496e-01 -0.02971 9.763e-01
## factor(SALE_YEAR)2009                        7.539e-01  2.073e-01  3.63682 2.982e-04
## factor(SALE_YEAR)2010                        5.653e-01  2.090e-01  2.70503 7.011e-03
## factor(SALE_YEAR)2011                        5.983e-01  2.427e-01  2.46552 1.394e-02
## OSV05KM                                      4.874e-08  2.868e-08  1.69923 8.976e-02
## parkArea05:factor(SALE_YEAR)2006            -4.226e-06  2.043e-06 -2.06868 3.898e-02
## parkArea05:factor(SALE_YEAR)2009            -7.003e-07  1.513e-06 -0.46271 6.437e-01
## parkArea05:factor(SALE_YEAR)2010             7.353e-07  1.650e-06  0.44579 6.559e-01
## parkArea05:factor(SALE_YEAR)2011            -2.121e-07  1.825e-06 -0.11622 9.075e-01
## factor(SALE_YEAR)2006:OSV05KM                4.306e-08  4.143e-08  1.03927 2.991e-01
## factor(SALE_YEAR)2009:OSV05KM               -7.890e-08  3.485e-08 -2.26376 2.392e-02
## factor(SALE_YEAR)2010:OSV05KM               -4.961e-08  3.934e-08 -1.26085 2.078e-01
## factor(SALE_YEAR)2011:OSV05KM               -5.247e-08  5.218e-08 -1.00551 3.150e-01
```

I'm now going to be looking at a comparison between very clean data of only qualified sales versus our general data.


```r
HouseDataQualified = subset(HouseDataClean, RamValid == "V" | RamValid == "Q")
osiModel05intQualified = lm(logPRICE ~ FIN_SQ_FT + ACREAGE + YEAR_BUILT + HomeStyle + ELEMENTARY + WhiteDense + fam_income + factor(SALE_MONTH) + rounPark05 * factor(SALE_YEAR) + 
    OSV05KM * factor(SALE_YEAR), data = HouseDataQualified)
coef(summary(osiModel05intQualified))
```

```
##                                               Estimate Std. Error   t value   Pr(>|t|)
## (Intercept)                                  7.749e+00  3.185e-01  24.33057 9.088e-127
## FIN_SQ_FT                                    3.038e-04  5.355e-06  56.73935  0.000e+00
## ACREAGE                                      8.861e-02  1.317e-02   6.72659  1.841e-11
## YEAR_BUILT                                   1.857e-03  1.624e-04  11.43604  4.413e-30
## HomeStyle2 Story                             1.020e-01  9.952e-03  10.25074  1.592e-24
## HomeStyle7/4 Story                           3.590e-02  1.228e-02   2.92383  3.466e-03
## HomeStyleBungalow                            5.586e-03  8.003e-03   0.69795  4.852e-01
## HomeStyleOther                               5.800e-02  2.657e-01   0.21831  8.272e-01
## HomeStyleRow                                -1.373e-01  2.657e-01  -0.51691  6.052e-01
## HomeStyleSplit Entry                        -3.185e-02  1.189e-02  -2.67947  7.387e-03
## HomeStyleSplit Level                         4.072e-02  1.267e-02   3.21317  1.317e-03
## ELEMENTARYBATTLE CREEK                       1.906e-02  4.958e-02   0.38434  7.007e-01
## ELEMENTARYBEL AIR                           -1.612e-02  4.071e-02  -0.39588  6.922e-01
## ELEMENTARYBIRCH LAKE                        -5.656e-02  4.494e-02  -1.25845  2.083e-01
## ELEMENTARYBRIMHALL                           1.453e-01  4.117e-02   3.53043  4.169e-04
## ELEMENTARYBRUCE F. VENTO                    -1.884e-01  4.740e-02  -3.97515  7.088e-05
## ELEMENTARYCARVER                            -1.014e-01  4.306e-02  -2.35426  1.858e-02
## ELEMENTARYCENTRAL PARK                       3.933e-02  4.197e-02   0.93711  3.487e-01
## ELEMENTARYCHELSEA HEIGHTS                    9.083e-02  3.894e-02   2.33234  1.970e-02
## ELEMENTARYCOMO PARK                          6.379e-02  4.087e-02   1.56104  1.185e-01
## ELEMENTARYCOWERN                            -8.156e-02  4.424e-02  -1.84340  6.530e-02
## ELEMENTARYDAYTONS BLUFF                     -2.040e-01  4.311e-02  -4.73077  2.270e-06
## ELEMENTARYEASTERN HEIGHTS                   -1.140e-01  4.080e-02  -2.79339  5.227e-03
## ELEMENTARYEDGERTON                           4.260e-03  4.334e-02   0.09831  9.217e-01
## ELEMENTARYEMMET D. WILLIAMS                  8.216e-02  4.195e-02   1.95835  5.022e-02
## ELEMENTARYFALCON HEIGHTS                     7.317e-02  4.069e-02   1.79840  7.215e-02
## ELEMENTARYFARNSWORTH                         6.879e-03  4.316e-02   0.15937  8.734e-01
## ELEMENTARYFARNSWORTH LOWER                  -9.737e-02  4.698e-02  -2.07262  3.824e-02
## ELEMENTARYFRANKLIN                          -1.749e-01  1.908e-01  -0.91642  3.595e-01
## ELEMENTARYFRANKLIN MUSIC                     9.818e-02  1.911e-01   0.51384  6.074e-01
## ELEMENTARYFROST LAKE                        -6.139e-02  4.446e-02  -1.38065  1.674e-01
## ELEMENTARYGALTIER & MAXFIELD                -2.518e-02  3.932e-02  -0.64033  5.220e-01
## ELEMENTARYGROVELAND PARK                     2.856e-01  4.105e-02   6.95754  3.700e-12
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  2.391e-01  4.423e-02   5.40548  6.626e-08
## ELEMENTARYHANCOCK                            6.619e-02  5.501e-02   1.20314  2.290e-01
## ELEMENTARYHANCOCK EL.                        6.013e-02  4.600e-02   1.30732  1.911e-01
## ELEMENTARYHAYDEN HEIGHTS                    -9.614e-02  4.531e-02  -2.12168  3.389e-02
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -1.590e-01  4.225e-02  -3.76345  1.686e-04
## ELEMENTARYHIGHLAND PARK                      2.194e-01  4.027e-02   5.44844  5.213e-08
## ELEMENTARYHIGHWOOD HILLS                    -1.226e-02  4.623e-02  -0.26522  7.908e-01
## ELEMENTARYHOMECROFT                          1.156e-01  4.789e-02   2.41319  1.583e-02
## ELEMENTARYISLAND LAKE                        4.613e-03  4.141e-02   0.11139  9.113e-01
## ELEMENTARYJACKSON                           -4.044e-01  5.748e-02  -7.03447  2.143e-12
## ELEMENTARYJOHNSON A+                        -2.223e-01  5.197e-02  -4.27747  1.909e-05
## ELEMENTARYLAKEAIRES                          7.725e-02  4.100e-02   1.88398  5.960e-02
## ELEMENTARYLINCOLN                           -5.723e-02  4.334e-02  -1.32042  1.867e-01
## ELEMENTARYLITTLE CANADA                      7.690e-02  4.520e-02   1.70144  8.889e-02
## ELEMENTARYLONGFELLOW                         1.987e-01  4.102e-02   4.84241  1.304e-06
## ELEMENTARYMANN                               2.481e-01  3.996e-02   6.20842  5.584e-10
## ELEMENTARYMATOSKA INTERNATIONAL              7.106e-02  5.081e-02   1.39858  1.620e-01
## ELEMENTARYMISSISSIPPI                        6.844e-02  5.200e-02   1.31632  1.881e-01
## ELEMENTARYMONROE                            -2.972e-02  4.157e-02  -0.71508  4.746e-01
## ELEMENTARYNORTH END                         -1.645e-01  4.177e-02  -3.93782  8.283e-05
## ELEMENTARYOAKDALE                           -1.341e-01  6.360e-02  -2.10816  3.504e-02
## ELEMENTARYOBAMA                              4.098e-01  7.551e-02   5.42762  5.857e-08
## ELEMENTARYOTTER LAKE                        -7.365e-02  4.509e-02  -1.63330  1.024e-01
## ELEMENTARYPARKVIEW                           9.053e-03  4.848e-02   0.18672  8.519e-01
## ELEMENTARYPARKWAY                           -2.977e-02  4.721e-02  -0.63046  5.284e-01
## ELEMENTARYPHALEN LAKE                       -1.749e-01  4.408e-02  -3.96851  7.287e-05
## ELEMENTARYPINEWOOD                          -1.076e-01  4.224e-02  -2.54636  1.090e-02
## ELEMENTARYPROSPERITY HEIGHTS                -6.791e-03  5.558e-02  -0.12219  9.028e-01
## ELEMENTARYRANDOLPH HEIGHTS                   2.373e-01  3.958e-02   5.99513  2.110e-09
## ELEMENTARYRICHARDSON                        -4.845e-02  4.145e-02  -1.16877  2.425e-01
## ELEMENTARYRIVERVIEW & CHEROKEE              -2.220e-02  4.497e-02  -0.49367  6.216e-01
## ELEMENTARYROOSEVELT & RIVERVIEW & CHEROKEE   4.294e-02  4.484e-02   0.95761  3.383e-01
## ELEMENTARYSHERIDAN                          -2.907e-02  4.841e-02  -0.60061  5.481e-01
## ELEMENTARYSHERIDAN & AMES                   -1.595e-01  4.289e-02  -3.71982  2.006e-04
## ELEMENTARYST ANTHONY PARK                    2.863e-01  4.555e-02   6.28452  3.438e-10
## ELEMENTARYSUNNYSIDE                         -5.487e-02  4.220e-02  -1.30005  1.936e-01
## ELEMENTARYTURTLE LAKE                       -3.525e-02  4.150e-02  -0.84949  3.956e-01
## ELEMENTARYVADNAIS HEIGHTS                   -3.020e-02  4.491e-02  -0.67256  5.012e-01
## ELEMENTARYVALENTINE HILLS                    4.265e-02  4.078e-02   1.04565  2.957e-01
## ELEMENTARYWEAVER                            -8.560e-03  4.037e-02  -0.21204  8.321e-01
## ELEMENTARYWEBSTER                            2.705e-02  4.365e-02   0.61974  5.354e-01
## ELEMENTARYWILLOW LANE                        4.510e-03  4.753e-02   0.09488  9.244e-01
## ELEMENTARYWILSHIRE PARK                      1.002e-01  6.543e-02   1.53214  1.255e-01
## WhiteDense                                   2.400e-01  2.138e-02  11.22958  4.514e-29
## fam_income                                   4.224e-06  2.247e-07  18.79820  2.195e-77
## factor(SALE_MONTH)2                          1.221e-02  1.748e-02   0.69822  4.851e-01
## factor(SALE_MONTH)3                          3.370e-02  1.621e-02   2.07890  3.765e-02
## factor(SALE_MONTH)4                          4.118e-02  1.574e-02   2.61586  8.915e-03
## factor(SALE_MONTH)5                          6.740e-02  1.532e-02   4.39980  1.096e-05
## factor(SALE_MONTH)6                          6.035e-02  1.511e-02   3.99566  6.502e-05
## factor(SALE_MONTH)7                          6.203e-02  1.557e-02   3.98459  6.812e-05
## factor(SALE_MONTH)8                          5.266e-02  1.549e-02   3.39916  6.788e-04
## factor(SALE_MONTH)9                          4.240e-02  1.612e-02   2.63042  8.542e-03
## factor(SALE_MONTH)10                         4.831e-02  1.613e-02   2.99471  2.754e-03
## factor(SALE_MONTH)11                         3.902e-02  1.652e-02   2.36184  1.821e-02
## factor(SALE_MONTH)12                        -1.029e-02  1.759e-02  -0.58515  5.585e-01
## rounPark05                                   9.412e-09  7.800e-08   0.12067  9.040e-01
## factor(SALE_YEAR)2006                        2.285e-03  1.373e-02   0.16651  8.678e-01
## factor(SALE_YEAR)2009                       -2.799e-01  1.590e-02 -17.60341  3.046e-68
## factor(SALE_YEAR)2010                       -3.073e-01  1.718e-02 -17.88686  2.318e-70
## factor(SALE_YEAR)2011                       -4.055e-01  2.992e-02 -13.55542  1.842e-41
## OSV05KM                                     -2.016e-09  3.873e-09  -0.52051  6.027e-01
## rounPark05:factor(SALE_YEAR)2006             3.495e-08  1.112e-07   0.31442  7.532e-01
## rounPark05:factor(SALE_YEAR)2009             1.342e-07  1.105e-07   1.21494  2.244e-01
## rounPark05:factor(SALE_YEAR)2010             8.567e-08  1.169e-07   0.73282  4.637e-01
## rounPark05:factor(SALE_YEAR)2011             3.657e-07  1.910e-07   1.91475  5.556e-02
## factor(SALE_YEAR)2006:OSV05KM                1.619e-09  5.001e-09   0.32378  7.461e-01
## factor(SALE_YEAR)2009:OSV05KM                1.890e-09  5.046e-09   0.37451  7.080e-01
## factor(SALE_YEAR)2010:OSV05KM                6.053e-09  5.464e-09   1.10790  2.679e-01
## factor(SALE_YEAR)2011:OSV05KM                3.460e-09  9.726e-09   0.35574  7.220e-01
```



