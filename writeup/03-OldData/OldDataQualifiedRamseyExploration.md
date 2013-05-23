Old Data Qualified Ramsey Exploration
========================================================




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
## [1] "/home/hillisj/OSI-Hedonic Project/OSI-Hedonic/writeup/03-OldData"
```

```r
HouseData = read.dbf("~/OSI-Hedonic Project/Data/GIS2R/OldDataQualifiedRam.dbf")
```



```r
options(width = 160)
```


Let's start constructing our basic hedonic regression by formally creating the logged sale price variable, converting a couple variables from string to numeric, and creating some time related variables (year of sale, month of sale, etc.).

```r
HouseData$logPRICE = log(HouseData$PRICE)
HouseData$logSALE_VALUE = log(HouseData$SALE_VALUE)
HouseData$GARAGEsqft = as.numeric(as.character(HouseData$GARAGESQFT))
HouseData$SALE_YEAR = 1900 + as.POSIXlt(HouseData$SALE_DATE)$year
HouseData$SALE_MONTH = 1 + as.POSIXlt(HouseData$SALE_DATE)$mon
HouseData$YEARMON = 12 * (HouseData$SALE_YEAR - 2009) + HouseData$SALE_MONTH  # number of months since january 1, 2009
```


ORIGINAL


```r
OldDataExp = lm(logSALE_VALUE ~ FIN_SQ_FT + ACREAGE + YEAR_BUILT + HomeStyle + ELEMENTARY + WhiteDense + fam_income + factor(SALE_MONTH) + parkArea05 * factor(SALE_YEAR) + 
    OSV05KM * factor(SALE_YEAR), data = HouseData)
summary(OldDataExp)
```

```
## 
## Call:
## lm(formula = logSALE_VALUE ~ FIN_SQ_FT + ACREAGE + YEAR_BUILT + 
##     HomeStyle + ELEMENTARY + WhiteDense + fam_income + factor(SALE_MONTH) + 
##     parkArea05 * factor(SALE_YEAR) + OSV05KM * factor(SALE_YEAR), 
##     data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -4.833 -0.100  0.027  0.152  1.998 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                  7.04e+00   3.29e-01   21.37  < 2e-16 ***
## FIN_SQ_FT                                    2.97e-04   5.91e-06   50.19  < 2e-16 ***
## ACREAGE                                      7.70e-02   1.47e-02    5.25  1.6e-07 ***
## YEAR_BUILT                                   2.18e-03   1.68e-04   12.98  < 2e-16 ***
## HomeStyle2 Story                             1.04e-01   1.08e-02    9.56  < 2e-16 ***
## HomeStyle7/4 Story                           3.52e-02   1.31e-02    2.68  0.00731 ** 
## HomeStyleBungalow                            9.49e-03   8.56e-03    1.11  0.26797    
## HomeStyleOther                               6.56e-02   3.10e-01    0.21  0.83208    
## HomeStyleRow                                -9.82e-02   3.10e-01   -0.32  0.75118    
## HomeStyleSplit Entry                        -3.65e-02   1.26e-02   -2.89  0.00384 ** 
## HomeStyleSplit Level                         4.49e-02   1.38e-02    3.24  0.00119 ** 
## ELEMENTARYBATTLE CREEK                       3.97e-02   5.17e-02    0.77  0.44240    
## ELEMENTARYBEL AIR                           -2.60e-02   4.16e-02   -0.62  0.53217    
## ELEMENTARYBIRCH LAKE                        -8.30e-02   4.61e-02   -1.80  0.07212 .  
## ELEMENTARYBRIMHALL                           1.26e-01   4.21e-02    2.98  0.00286 ** 
## ELEMENTARYBRUCE F. VENTO                    -2.37e-01   4.63e-02   -5.12  3.1e-07 ***
## ELEMENTARYCARVER                            -1.58e-01   4.37e-02   -3.62  0.00030 ***
## ELEMENTARYCENTRAL PARK                       3.99e-02   4.28e-02    0.93  0.35164    
## ELEMENTARYCHELSEA HEIGHTS                    7.81e-02   3.92e-02    1.99  0.04666 *  
## ELEMENTARYCOMO PARK                          5.33e-02   4.13e-02    1.29  0.19659    
## ELEMENTARYCOWERN                            -8.13e-02   4.54e-02   -1.79  0.07312 .  
## ELEMENTARYDAYTONS BLUFF                     -2.23e-01   4.28e-02   -5.22  1.9e-07 ***
## ELEMENTARYEASTERN HEIGHTS                   -1.21e-01   4.05e-02   -2.99  0.00284 ** 
## ELEMENTARYEDGERTON                           5.10e-03   4.43e-02    0.12  0.90842    
## ELEMENTARYEMMET D. WILLIAMS                  5.33e-02   4.33e-02    1.23  0.21829    
## ELEMENTARYFALCON HEIGHTS                     8.38e-02   4.17e-02    2.01  0.04456 *  
## ELEMENTARYFARNSWORTH                         1.12e-02   4.43e-02    0.25  0.80010    
## ELEMENTARYFARNSWORTH LOWER                  -1.11e-01   4.73e-02   -2.35  0.01895 *  
## ELEMENTARYFRANKLIN                          -1.71e-01   2.21e-01   -0.77  0.43884    
## ELEMENTARYFRANKLIN MUSIC                    -8.33e-02   1.82e-01   -0.46  0.64739    
## ELEMENTARYFROST LAKE                        -3.32e-02   4.51e-02   -0.74  0.46126    
## ELEMENTARYGALTIER & MAXFIELD                -1.44e-02   3.94e-02   -0.37  0.71458    
## ELEMENTARYGROVELAND PARK                     2.88e-01   4.18e-02    6.88  6.5e-12 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  2.44e-01   4.55e-02    5.37  8.1e-08 ***
## ELEMENTARYHANCOCK                            9.90e-02   5.70e-02    1.74  0.08249 .  
## ELEMENTARYHANCOCK EL.                        6.50e-02   4.78e-02    1.36  0.17366    
## ELEMENTARYHAYDEN HEIGHTS                    -9.23e-02   4.55e-02   -2.03  0.04241 *  
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -1.32e-01   4.22e-02   -3.14  0.00171 ** 
## ELEMENTARYHIGHLAND PARK                      2.27e-01   4.11e-02    5.54  3.2e-08 ***
## ELEMENTARYHIGHWOOD HILLS                    -2.82e-02   4.64e-02   -0.61  0.54387    
## ELEMENTARYHOMECROFT                          1.02e-01   5.07e-02    2.00  0.04506 *  
## ELEMENTARYISLAND LAKE                       -3.44e-02   4.23e-02   -0.81  0.41654    
## ELEMENTARYJACKSON                           -3.11e-01   5.46e-02   -5.69  1.3e-08 ***
## ELEMENTARYJOHNSON A+                        -1.98e-01   5.06e-02   -3.93  8.7e-05 ***
## ELEMENTARYLAKEAIRES                          3.92e-02   4.18e-02    0.94  0.34855    
## ELEMENTARYLINCOLN                           -9.72e-02   4.44e-02   -2.19  0.02863 *  
## ELEMENTARYLITTLE CANADA                      5.13e-02   4.60e-02    1.11  0.26529    
## ELEMENTARYLONGFELLOW                         2.06e-01   4.21e-02    4.89  1.0e-06 ***
## ELEMENTARYMANN                               2.49e-01   4.06e-02    6.13  8.8e-10 ***
## ELEMENTARYMATOSKA INTERNATIONAL              7.98e-02   5.27e-02    1.51  0.12984    
## ELEMENTARYMISSISSIPPI                        7.33e-02   5.13e-02    1.43  0.15278    
## ELEMENTARYMONROE                            -4.99e-02   4.20e-02   -1.19  0.23485    
## ELEMENTARYNORTH END                         -1.73e-01   4.16e-02   -4.16  3.2e-05 ***
## ELEMENTARYOAKDALE                           -1.50e-01   6.37e-02   -2.35  0.01879 *  
## ELEMENTARYOBAMA                              3.79e-01   8.14e-02    4.66  3.2e-06 ***
## ELEMENTARYOTTER LAKE                        -1.17e-01   4.67e-02   -2.50  0.01243 *  
## ELEMENTARYPARKVIEW                          -1.25e-02   5.04e-02   -0.25  0.80405    
## ELEMENTARYPARKWAY                           -6.68e-03   4.60e-02   -0.15  0.88463    
## ELEMENTARYPHALEN LAKE                       -1.29e-01   4.36e-02   -2.96  0.00312 ** 
## ELEMENTARYPINEWOOD                          -1.25e-01   4.32e-02   -2.89  0.00388 ** 
## ELEMENTARYPROSPERITY HEIGHTS                 1.59e-02   5.71e-02    0.28  0.78046    
## ELEMENTARYRANDOLPH HEIGHTS                   2.59e-01   4.02e-02    6.45  1.2e-10 ***
## ELEMENTARYRICHARDSON                        -4.37e-02   4.19e-02   -1.04  0.29666    
## ELEMENTARYRIVERVIEW & CHEROKEE              -4.51e-02   4.51e-02   -1.00  0.31756    
## ELEMENTARYROOSEVELT & RIVERVIEW & CHEROKEE   3.58e-02   4.55e-02    0.79  0.43169    
## ELEMENTARYSHERIDAN                          -1.84e-02   5.00e-02   -0.37  0.71270    
## ELEMENTARYSHERIDAN & AMES                   -1.24e-01   4.22e-02   -2.94  0.00333 ** 
## ELEMENTARYST ANTHONY PARK                    3.03e-01   4.78e-02    6.34  2.4e-10 ***
## ELEMENTARYSUNNYSIDE                         -6.17e-02   4.33e-02   -1.42  0.15455    
## ELEMENTARYTURTLE LAKE                       -7.81e-02   4.24e-02   -1.84  0.06563 .  
## ELEMENTARYVADNAIS HEIGHTS                   -7.90e-02   4.60e-02   -1.72  0.08586 .  
## ELEMENTARYVALENTINE HILLS                    3.05e-02   4.16e-02    0.73  0.46411    
## ELEMENTARYWEAVER                            -2.07e-02   4.09e-02   -0.51  0.61248    
## ELEMENTARYWEBSTER                            3.38e-02   4.49e-02    0.75  0.45058    
## ELEMENTARYWILLOW LANE                       -4.36e-02   4.90e-02   -0.89  0.37328    
## ELEMENTARYWILSHIRE PARK                      1.41e-01   6.99e-02    2.02  0.04342 *  
## WhiteDense                                   3.13e-01   2.21e-02   14.14  < 2e-16 ***
## fam_income                                   4.91e-06   2.44e-07   20.16  < 2e-16 ***
## factor(SALE_MONTH)2                          4.05e-03   1.83e-02    0.22  0.82435    
## factor(SALE_MONTH)3                          2.62e-02   1.69e-02    1.54  0.12241    
## factor(SALE_MONTH)4                          2.35e-02   1.65e-02    1.42  0.15444    
## factor(SALE_MONTH)5                          6.80e-02   1.61e-02    4.22  2.4e-05 ***
## factor(SALE_MONTH)6                          5.53e-02   1.59e-02    3.48  0.00051 ***
## factor(SALE_MONTH)7                          5.91e-02   1.65e-02    3.59  0.00034 ***
## factor(SALE_MONTH)8                          3.63e-02   1.64e-02    2.21  0.02713 *  
## factor(SALE_MONTH)9                          2.79e-02   1.69e-02    1.65  0.09955 .  
## factor(SALE_MONTH)10                         4.28e-02   1.70e-02    2.51  0.01205 *  
## factor(SALE_MONTH)11                         4.36e-02   1.75e-02    2.49  0.01294 *  
## factor(SALE_MONTH)12                        -1.36e-02   1.85e-02   -0.74  0.46036    
## parkArea05                                   3.78e-08   8.61e-08    0.44  0.66064    
## factor(SALE_YEAR)2006                       -7.90e-03   1.49e-02   -0.53  0.59633    
## factor(SALE_YEAR)2009                       -3.92e-01   1.70e-02  -23.03  < 2e-16 ***
## factor(SALE_YEAR)2010                       -4.44e-01   1.75e-02  -25.33  < 2e-16 ***
## factor(SALE_YEAR)2011                       -6.55e-01   2.72e-02  -24.04  < 2e-16 ***
## OSV05KM                                     -3.60e-09   4.20e-09   -0.86  0.39119    
## parkArea05:factor(SALE_YEAR)2006            -3.13e-08   1.23e-07   -0.26  0.79829    
## parkArea05:factor(SALE_YEAR)2009            -3.17e-08   1.29e-07   -0.25  0.80593    
## parkArea05:factor(SALE_YEAR)2010            -1.18e-07   1.33e-07   -0.89  0.37452    
## parkArea05:factor(SALE_YEAR)2011             1.26e-08   2.13e-07    0.06  0.95299    
## factor(SALE_YEAR)2006:OSV05KM                5.70e-09   5.45e-09    1.05  0.29568    
## factor(SALE_YEAR)2009:OSV05KM                3.17e-08   5.82e-09    5.44  5.4e-08 ***
## factor(SALE_YEAR)2010:OSV05KM                3.55e-08   5.93e-09    5.97  2.4e-09 ***
## factor(SALE_YEAR)2011:OSV05KM                5.98e-08   9.01e-09    6.63  3.5e-11 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.309 on 10762 degrees of freedom
## Multiple R-squared: 0.69,	Adjusted R-squared: 0.687 
## F-statistic:  235 on 102 and 10762 DF,  p-value: <2e-16
```


ADDED STRUCTURAL CHARACTERISTICS

Interestingly, bedrooms and bathrooms are both very significant, but don't improve the model much.


```r
OldDataExp2 = lm(logSALE_VALUE ~ FIN_SQ_FT + BEDRMS + BATHRMS + ACREAGE + YEAR_BUILT + HomeStyle + ELEMENTARY + WhiteDense + fam_income + factor(SALE_MONTH) + parkArea05 * 
    factor(SALE_YEAR) + OSV05KM * factor(SALE_YEAR), data = HouseData)
summary(OldDataExp2)
```

```
## 
## Call:
## lm(formula = logSALE_VALUE ~ FIN_SQ_FT + BEDRMS + BATHRMS + ACREAGE + 
##     YEAR_BUILT + HomeStyle + ELEMENTARY + WhiteDense + fam_income + 
##     factor(SALE_MONTH) + parkArea05 * factor(SALE_YEAR) + OSV05KM * 
##     factor(SALE_YEAR), data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -4.835 -0.095  0.025  0.151  2.005 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                  7.32e+00   3.31e-01   22.13  < 2e-16 ***
## FIN_SQ_FT                                    2.54e-04   7.26e-06   35.01  < 2e-16 ***
## BEDRMS                                       2.25e-02   4.46e-03    5.04  4.7e-07 ***
## BATHRMS                                      4.45e-02   6.05e-03    7.36  1.9e-13 ***
## ACREAGE                                      8.63e-02   1.46e-02    5.89  3.9e-09 ***
## YEAR_BUILT                                   2.00e-03   1.69e-04   11.83  < 2e-16 ***
## HomeStyle2 Story                             9.33e-02   1.09e-02    8.59  < 2e-16 ***
## HomeStyle7/4 Story                           3.02e-02   1.31e-02    2.30  0.02119 *  
## HomeStyleBungalow                            2.92e-03   8.59e-03    0.34  0.73432    
## HomeStyleOther                               7.49e-02   3.08e-01    0.24  0.80799    
## HomeStyleRow                                -2.08e-02   3.08e-01   -0.07  0.94615    
## HomeStyleSplit Entry                        -4.47e-02   1.27e-02   -3.53  0.00042 ***
## HomeStyleSplit Level                         3.32e-02   1.38e-02    2.40  0.01661 *  
## ELEMENTARYBATTLE CREEK                       3.34e-02   5.15e-02    0.65  0.51674    
## ELEMENTARYBEL AIR                           -3.84e-02   4.14e-02   -0.93  0.35314    
## ELEMENTARYBIRCH LAKE                        -8.45e-02   4.59e-02   -1.84  0.06573 .  
## ELEMENTARYBRIMHALL                           1.13e-01   4.20e-02    2.69  0.00709 ** 
## ELEMENTARYBRUCE F. VENTO                    -2.40e-01   4.61e-02   -5.20  2.0e-07 ***
## ELEMENTARYCARVER                            -1.70e-01   4.36e-02   -3.90  9.7e-05 ***
## ELEMENTARYCENTRAL PARK                       2.73e-02   4.26e-02    0.64  0.52128    
## ELEMENTARYCHELSEA HEIGHTS                    7.98e-02   3.91e-02    2.04  0.04123 *  
## ELEMENTARYCOMO PARK                          5.56e-02   4.11e-02    1.35  0.17600    
## ELEMENTARYCOWERN                            -8.52e-02   4.52e-02   -1.89  0.05933 .  
## ELEMENTARYDAYTONS BLUFF                     -2.23e-01   4.26e-02   -5.23  1.7e-07 ***
## ELEMENTARYEASTERN HEIGHTS                   -1.20e-01   4.03e-02   -2.98  0.00291 ** 
## ELEMENTARYEDGERTON                          -3.12e-03   4.41e-02   -0.07  0.94364    
## ELEMENTARYEMMET D. WILLIAMS                  4.18e-02   4.31e-02    0.97  0.33243    
## ELEMENTARYFALCON HEIGHTS                     7.65e-02   4.15e-02    1.84  0.06543 .  
## ELEMENTARYFARNSWORTH                         6.02e-03   4.41e-02    0.14  0.89148    
## ELEMENTARYFARNSWORTH LOWER                  -1.13e-01   4.71e-02   -2.41  0.01611 *  
## ELEMENTARYFRANKLIN                          -1.74e-01   2.20e-01   -0.79  0.43101    
## ELEMENTARYFRANKLIN MUSIC                    -1.03e-01   1.81e-01   -0.57  0.56860    
## ELEMENTARYFROST LAKE                        -3.54e-02   4.49e-02   -0.79  0.43110    
## ELEMENTARYGALTIER & MAXFIELD                -1.11e-02   3.92e-02   -0.28  0.77726    
## ELEMENTARYGROVELAND PARK                     2.81e-01   4.16e-02    6.74  1.7e-11 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  2.42e-01   4.53e-02    5.33  9.8e-08 ***
## ELEMENTARYHANCOCK                            1.06e-01   5.68e-02    1.87  0.06113 .  
## ELEMENTARYHANCOCK EL.                        6.49e-02   4.76e-02    1.36  0.17249    
## ELEMENTARYHAYDEN HEIGHTS                    -8.86e-02   4.53e-02   -1.96  0.05023 .  
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -1.36e-01   4.20e-02   -3.24  0.00119 ** 
## ELEMENTARYHIGHLAND PARK                      2.27e-01   4.09e-02    5.55  3.0e-08 ***
## ELEMENTARYHIGHWOOD HILLS                    -3.32e-02   4.62e-02   -0.72  0.47282    
## ELEMENTARYHOMECROFT                          9.71e-02   5.05e-02    1.92  0.05460 .  
## ELEMENTARYISLAND LAKE                       -4.29e-02   4.21e-02   -1.02  0.30844    
## ELEMENTARYJACKSON                           -3.21e-01   5.44e-02   -5.89  4.0e-09 ***
## ELEMENTARYJOHNSON A+                        -1.98e-01   5.03e-02   -3.93  8.7e-05 ***
## ELEMENTARYLAKEAIRES                          3.16e-02   4.17e-02    0.76  0.44746    
## ELEMENTARYLINCOLN                           -9.92e-02   4.42e-02   -2.24  0.02493 *  
## ELEMENTARYLITTLE CANADA                      4.75e-02   4.58e-02    1.04  0.30007    
## ELEMENTARYLONGFELLOW                         2.01e-01   4.19e-02    4.79  1.7e-06 ***
## ELEMENTARYMANN                               2.43e-01   4.05e-02    5.99  2.1e-09 ***
## ELEMENTARYMATOSKA INTERNATIONAL              6.37e-02   5.25e-02    1.21  0.22466    
## ELEMENTARYMISSISSIPPI                        5.78e-02   5.11e-02    1.13  0.25834    
## ELEMENTARYMONROE                            -4.35e-02   4.19e-02   -1.04  0.29900    
## ELEMENTARYNORTH END                         -1.72e-01   4.14e-02   -4.14  3.5e-05 ***
## ELEMENTARYOAKDALE                           -1.44e-01   6.35e-02   -2.26  0.02357 *  
## ELEMENTARYOBAMA                              3.42e-01   8.11e-02    4.22  2.5e-05 ***
## ELEMENTARYOTTER LAKE                        -1.30e-01   4.66e-02   -2.79  0.00521 ** 
## ELEMENTARYPARKVIEW                          -2.31e-02   5.02e-02   -0.46  0.64607    
## ELEMENTARYPARKWAY                           -7.67e-03   4.58e-02   -0.17  0.86710    
## ELEMENTARYPHALEN LAKE                       -1.28e-01   4.34e-02   -2.94  0.00326 ** 
## ELEMENTARYPINEWOOD                          -1.35e-01   4.30e-02   -3.15  0.00166 ** 
## ELEMENTARYPROSPERITY HEIGHTS                 1.32e-02   5.68e-02    0.23  0.81587    
## ELEMENTARYRANDOLPH HEIGHTS                   2.58e-01   4.00e-02    6.45  1.1e-10 ***
## ELEMENTARYRICHARDSON                        -4.68e-02   4.17e-02   -1.12  0.26177    
## ELEMENTARYRIVERVIEW & CHEROKEE              -4.26e-02   4.49e-02   -0.95  0.34281    
## ELEMENTARYROOSEVELT & RIVERVIEW & CHEROKEE   4.12e-02   4.53e-02    0.91  0.36339    
## ELEMENTARYSHERIDAN                          -2.07e-02   4.98e-02   -0.42  0.67802    
## ELEMENTARYSHERIDAN & AMES                   -1.23e-01   4.20e-02   -2.93  0.00342 ** 
## ELEMENTARYST ANTHONY PARK                    2.99e-01   4.76e-02    6.28  3.5e-10 ***
## ELEMENTARYSUNNYSIDE                         -7.29e-02   4.31e-02   -1.69  0.09101 .  
## ELEMENTARYTURTLE LAKE                       -8.84e-02   4.23e-02   -2.09  0.03649 *  
## ELEMENTARYVADNAIS HEIGHTS                   -8.15e-02   4.58e-02   -1.78  0.07508 .  
## ELEMENTARYVALENTINE HILLS                    1.96e-02   4.14e-02    0.47  0.63612    
## ELEMENTARYWEAVER                            -2.87e-02   4.07e-02   -0.70  0.48194    
## ELEMENTARYWEBSTER                            2.91e-02   4.47e-02    0.65  0.51479    
## ELEMENTARYWILLOW LANE                       -5.69e-02   4.88e-02   -1.17  0.24381    
## ELEMENTARYWILSHIRE PARK                      1.28e-01   6.96e-02    1.83  0.06656 .  
## WhiteDense                                   3.18e-01   2.21e-02   14.43  < 2e-16 ***
## fam_income                                   4.87e-06   2.43e-07   20.09  < 2e-16 ***
## factor(SALE_MONTH)2                          5.70e-03   1.82e-02    0.31  0.75388    
## factor(SALE_MONTH)3                          2.64e-02   1.69e-02    1.57  0.11738    
## factor(SALE_MONTH)4                          2.38e-02   1.64e-02    1.45  0.14730    
## factor(SALE_MONTH)5                          6.86e-02   1.60e-02    4.28  1.9e-05 ***
## factor(SALE_MONTH)6                          5.62e-02   1.58e-02    3.55  0.00039 ***
## factor(SALE_MONTH)7                          5.97e-02   1.64e-02    3.64  0.00028 ***
## factor(SALE_MONTH)8                          3.77e-02   1.63e-02    2.31  0.02107 *  
## factor(SALE_MONTH)9                          2.82e-02   1.69e-02    1.67  0.09406 .  
## factor(SALE_MONTH)10                         4.32e-02   1.70e-02    2.55  0.01092 *  
## factor(SALE_MONTH)11                         4.65e-02   1.75e-02    2.66  0.00777 ** 
## factor(SALE_MONTH)12                        -1.07e-02   1.84e-02   -0.58  0.56224    
## parkArea05                                   4.03e-08   8.57e-08    0.47  0.63816    
## factor(SALE_YEAR)2006                       -8.79e-03   1.48e-02   -0.59  0.55369    
## factor(SALE_YEAR)2009                       -3.92e-01   1.70e-02  -23.11  < 2e-16 ***
## factor(SALE_YEAR)2010                       -4.45e-01   1.75e-02  -25.52  < 2e-16 ***
## factor(SALE_YEAR)2011                       -6.56e-01   2.71e-02  -24.20  < 2e-16 ***
## OSV05KM                                     -3.18e-09   4.19e-09   -0.76  0.44675    
## parkArea05:factor(SALE_YEAR)2006            -4.31e-08   1.22e-07   -0.35  0.72426    
## parkArea05:factor(SALE_YEAR)2009            -2.45e-08   1.29e-07   -0.19  0.84915    
## parkArea05:factor(SALE_YEAR)2010            -1.10e-07   1.32e-07   -0.83  0.40426    
## parkArea05:factor(SALE_YEAR)2011             4.96e-08   2.12e-07    0.23  0.81531    
## factor(SALE_YEAR)2006:OSV05KM                6.19e-09   5.42e-09    1.14  0.25346    
## factor(SALE_YEAR)2009:OSV05KM                3.09e-08   5.80e-09    5.32  1.0e-07 ***
## factor(SALE_YEAR)2010:OSV05KM                3.51e-08   5.91e-09    5.95  2.8e-09 ***
## factor(SALE_YEAR)2011:OSV05KM                5.79e-08   8.98e-09    6.45  1.2e-10 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.307 on 10760 degrees of freedom
## Multiple R-squared: 0.693,	Adjusted R-squared: 0.69 
## F-statistic:  233 on 104 and 10760 DF,  p-value: <2e-16
```


COMPARED TO NEW RAMSEY (MORE ACCURATE?) VERSIONS OF FIELDS

Wow. Huge R-squared improvement. 


```r
OldDataExp3 = lm(logPRICE ~ SFLA + BEDRMS + BATHRMS + LOTSIZE + YRBLT + HomeStyle + ELEMENTARY + WhiteDense + fam_income + factor(SALE_MONTH) + parkArea05 * factor(SALE_YEAR) + 
    OSV05KM * factor(SALE_YEAR), data = HouseData)
summary(OldDataExp3)
```

```
## 
## Call:
## lm(formula = logPRICE ~ SFLA + BEDRMS + BATHRMS + LOTSIZE + YRBLT + 
##     HomeStyle + ELEMENTARY + WhiteDense + fam_income + factor(SALE_MONTH) + 
##     parkArea05 * factor(SALE_YEAR) + OSV05KM * factor(SALE_YEAR), 
##     data = HouseData)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -2.5237 -0.1014  0.0051  0.1090  1.0421 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                  8.92e+00   2.16e-01   41.21  < 2e-16 ***
## SFLA                                         2.50e-04   4.75e-06   52.66  < 2e-16 ***
## BEDRMS                                       2.10e-02   2.95e-03    7.13  1.1e-12 ***
## BATHRMS                                      5.56e-02   4.03e-03   13.81  < 2e-16 ***
## LOTSIZE                                      2.67e-06   2.56e-07   10.42  < 2e-16 ***
## YRBLT                                        1.26e-03   1.11e-04   11.37  < 2e-16 ***
## HomeStyle2 Story                             9.80e-02   7.10e-03   13.79  < 2e-16 ***
## HomeStyle7/4 Story                           2.61e-02   8.59e-03    3.04  0.00234 ** 
## HomeStyleBungalow                            2.04e-03   5.65e-03    0.36  0.71806    
## HomeStyleOther                               1.33e-01   2.03e-01    0.66  0.51234    
## HomeStyleRow                                -2.08e-02   2.03e-01   -0.10  0.91855    
## HomeStyleSplit Entry                        -2.85e-02   8.34e-03   -3.41  0.00064 ***
## HomeStyleSplit Level                         3.22e-02   9.12e-03    3.53  0.00042 ***
## ELEMENTARYBATTLE CREEK                       6.59e-03   3.39e-02    0.19  0.84598    
## ELEMENTARYBEL AIR                            4.04e-02   2.72e-02    1.48  0.13842    
## ELEMENTARYBIRCH LAKE                         1.13e-02   3.02e-02    0.37  0.70899    
## ELEMENTARYBRIMHALL                           1.62e-01   2.76e-02    5.87  4.6e-09 ***
## ELEMENTARYBRUCE F. VENTO                    -4.22e-02   3.04e-02   -1.39  0.16421    
## ELEMENTARYCARVER                            -4.35e-02   2.87e-02   -1.52  0.12880    
## ELEMENTARYCENTRAL PARK                       9.55e-02   2.81e-02    3.40  0.00067 ***
## ELEMENTARYCHELSEA HEIGHTS                    1.42e-01   2.57e-02    5.54  3.1e-08 ***
## ELEMENTARYCOMO PARK                          8.63e-02   2.70e-02    3.19  0.00143 ** 
## ELEMENTARYCOWERN                             2.83e-02   2.97e-02    0.95  0.34096    
## ELEMENTARYDAYTONS BLUFF                     -3.47e-02   2.80e-02   -1.24  0.21620    
## ELEMENTARYEASTERN HEIGHTS                   -5.93e-03   2.65e-02   -0.22  0.82294    
## ELEMENTARYEDGERTON                           7.84e-02   2.90e-02    2.70  0.00697 ** 
## ELEMENTARYEMMET D. WILLIAMS                  1.20e-01   2.84e-02    4.21  2.5e-05 ***
## ELEMENTARYFALCON HEIGHTS                     1.30e-01   2.73e-02    4.77  1.9e-06 ***
## ELEMENTARYFARNSWORTH                         3.86e-02   2.90e-02    1.33  0.18377    
## ELEMENTARYFARNSWORTH LOWER                  -4.77e-03   3.10e-02   -0.15  0.87771    
## ELEMENTARYFRANKLIN                          -1.25e-01   1.45e-01   -0.86  0.39046    
## ELEMENTARYFRANKLIN MUSIC                     6.32e-02   1.19e-01    0.53  0.59670    
## ELEMENTARYFROST LAKE                         6.63e-03   2.96e-02    0.22  0.82238    
## ELEMENTARYGALTIER & MAXFIELD                 5.37e-02   2.58e-02    2.08  0.03738 *  
## ELEMENTARYGROVELAND PARK                     3.72e-01   2.74e-02   13.58  < 2e-16 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  3.01e-01   2.98e-02   10.09  < 2e-16 ***
## ELEMENTARYHANCOCK                            1.28e-01   3.74e-02    3.44  0.00059 ***
## ELEMENTARYHANCOCK EL.                        9.63e-02   3.13e-02    3.08  0.00210 ** 
## ELEMENTARYHAYDEN HEIGHTS                    -3.98e-02   2.98e-02   -1.34  0.18182    
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -3.25e-02   2.76e-02   -1.18  0.23896    
## ELEMENTARYHIGHLAND PARK                      3.11e-01   2.69e-02   11.56  < 2e-16 ***
## ELEMENTARYHIGHWOOD HILLS                     2.85e-03   3.04e-02    0.09  0.92525    
## ELEMENTARYHOMECROFT                          1.69e-01   3.33e-02    5.07  4.0e-07 ***
## ELEMENTARYISLAND LAKE                        7.60e-02   2.77e-02    2.74  0.00616 ** 
## ELEMENTARYJACKSON                           -6.15e-02   3.58e-02   -1.72  0.08622 .  
## ELEMENTARYJOHNSON A+                        -5.52e-02   3.31e-02   -1.67  0.09549 .  
## ELEMENTARYLAKEAIRES                          1.17e-01   2.74e-02    4.28  1.9e-05 ***
## ELEMENTARYLINCOLN                            2.89e-02   2.91e-02    0.99  0.32145    
## ELEMENTARYLITTLE CANADA                      9.15e-02   3.02e-02    3.03  0.00243 ** 
## ELEMENTARYLONGFELLOW                         2.68e-01   2.76e-02    9.70  < 2e-16 ***
## ELEMENTARYMANN                               3.11e-01   2.67e-02   11.68  < 2e-16 ***
## ELEMENTARYMATOSKA INTERNATIONAL              1.08e-01   3.45e-02    3.12  0.00184 ** 
## ELEMENTARYMISSISSIPPI                        8.22e-02   3.36e-02    2.45  0.01450 *  
## ELEMENTARYMONROE                             5.42e-02   2.76e-02    1.97  0.04921 *  
## ELEMENTARYNORTH END                         -5.37e-02   2.73e-02   -1.97  0.04889 *  
## ELEMENTARYOAKDALE                            1.76e-02   4.18e-02    0.42  0.67430    
## ELEMENTARYOBAMA                              3.99e-01   5.34e-02    7.48  7.9e-14 ***
## ELEMENTARYOTTER LAKE                        -2.35e-02   3.07e-02   -0.77  0.44385    
## ELEMENTARYPARKVIEW                           9.46e-02   3.31e-02    2.86  0.00427 ** 
## ELEMENTARYPARKWAY                           -2.38e-02   3.02e-02   -0.79  0.43016    
## ELEMENTARYPHALEN LAKE                       -5.18e-02   2.86e-02   -1.81  0.06962 .  
## ELEMENTARYPINEWOOD                          -4.32e-02   2.83e-02   -1.52  0.12737    
## ELEMENTARYPROSPERITY HEIGHTS                 3.88e-02   3.74e-02    1.04  0.29940    
## ELEMENTARYRANDOLPH HEIGHTS                   3.21e-01   2.64e-02   12.18  < 2e-16 ***
## ELEMENTARYRICHARDSON                         2.93e-02   2.75e-02    1.07  0.28665    
## ELEMENTARYRIVERVIEW & CHEROKEE               3.94e-02   2.96e-02    1.33  0.18254    
## ELEMENTARYROOSEVELT & RIVERVIEW & CHEROKEE   4.94e-02   2.98e-02    1.66  0.09719 .  
## ELEMENTARYSHERIDAN                          -5.60e-03   3.28e-02   -0.17  0.86435    
## ELEMENTARYSHERIDAN & AMES                    1.72e-02   2.76e-02    0.62  0.53412    
## ELEMENTARYST ANTHONY PARK                    3.52e-01   3.13e-02   11.26  < 2e-16 ***
## ELEMENTARYSUNNYSIDE                          1.63e-02   2.84e-02    0.57  0.56633    
## ELEMENTARYTURTLE LAKE                        1.80e-02   2.79e-02    0.65  0.51751    
## ELEMENTARYVADNAIS HEIGHTS                    1.43e-02   3.01e-02    0.47  0.63629    
## ELEMENTARYVALENTINE HILLS                    8.86e-02   2.73e-02    3.25  0.00116 ** 
## ELEMENTARYWEAVER                             3.09e-02   2.68e-02    1.15  0.24956    
## ELEMENTARYWEBSTER                            6.89e-02   2.94e-02    2.34  0.01918 *  
## ELEMENTARYWILLOW LANE                        1.23e-02   3.22e-02    0.38  0.70189    
## ELEMENTARYWILSHIRE PARK                      1.61e-01   4.58e-02    3.51  0.00044 ***
## WhiteDense                                   1.46e-01   1.45e-02   10.04  < 2e-16 ***
## fam_income                                   3.09e-06   1.60e-07   19.29  < 2e-16 ***
## factor(SALE_MONTH)2                         -1.33e-03   1.20e-02   -0.11  0.91115    
## factor(SALE_MONTH)3                          8.39e-03   1.11e-02    0.76  0.44972    
## factor(SALE_MONTH)4                          4.39e-03   1.08e-02    0.41  0.68473    
## factor(SALE_MONTH)5                          2.09e-02   1.05e-02    1.99  0.04686 *  
## factor(SALE_MONTH)6                          1.75e-02   1.04e-02    1.68  0.09257 .  
## factor(SALE_MONTH)7                          1.69e-02   1.08e-02    1.57  0.11688    
## factor(SALE_MONTH)8                          1.01e-02   1.08e-02    0.94  0.34571    
## factor(SALE_MONTH)9                          1.51e-02   1.11e-02    1.36  0.17250    
## factor(SALE_MONTH)10                        -6.69e-03   1.12e-02   -0.60  0.54914    
## factor(SALE_MONTH)11                        -1.91e-02   1.15e-02   -1.66  0.09650 .  
## factor(SALE_MONTH)12                        -1.80e-02   1.21e-02   -1.49  0.13710    
## parkArea05                                   5.46e-08   5.64e-08    0.97  0.33296    
## factor(SALE_YEAR)2006                        9.95e-04   9.77e-03    0.10  0.91887    
## factor(SALE_YEAR)2009                       -2.01e-01   1.12e-02  -18.01  < 2e-16 ***
## factor(SALE_YEAR)2010                       -2.40e-01   1.15e-02  -20.92  < 2e-16 ***
## factor(SALE_YEAR)2011                       -3.11e-01   1.79e-02  -17.44  < 2e-16 ***
## OSV05KM                                      1.08e-08   2.74e-09    3.93  8.5e-05 ***
## parkArea05:factor(SALE_YEAR)2006             7.71e-08   8.04e-08    0.96  0.33732    
## parkArea05:factor(SALE_YEAR)2009            -1.43e-07   8.46e-08   -1.69  0.09188 .  
## parkArea05:factor(SALE_YEAR)2010            -1.69e-08   8.69e-08   -0.19  0.84575    
## parkArea05:factor(SALE_YEAR)2011            -2.69e-07   1.40e-07   -1.92  0.05452 .  
## factor(SALE_YEAR)2006:OSV05KM                1.58e-10   3.57e-09    0.04  0.96478    
## factor(SALE_YEAR)2009:OSV05KM                1.26e-08   3.81e-09    3.30  0.00097 ***
## factor(SALE_YEAR)2010:OSV05KM                8.87e-09   3.89e-09    2.28  0.02259 *  
## factor(SALE_YEAR)2011:OSV05KM                2.21e-08   5.90e-09    3.75  0.00018 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.202 on 10760 degrees of freedom
## Multiple R-squared: 0.785,	Adjusted R-squared: 0.782 
## F-statistic:  377 on 104 and 10760 DF,  p-value: <2e-16
```


Hmm...let's isolate where that improvement is coming from.

SAME AS v3, BUT WITHOUT NEW PRICE DATA


```r
OldDataExp4 = lm(logSALE_VALUE ~ SFLA + BEDRMS + BATHRMS + LOTSIZE + YRBLT + HomeStyle + ELEMENTARY + WhiteDense + fam_income + factor(SALE_MONTH) + parkArea05 * 
    factor(SALE_YEAR) + OSV05KM * factor(SALE_YEAR), data = HouseData)
summary(OldDataExp4)
```

```
## 
## Call:
## lm(formula = logSALE_VALUE ~ SFLA + BEDRMS + BATHRMS + LOTSIZE + 
##     YRBLT + HomeStyle + ELEMENTARY + WhiteDense + fam_income + 
##     factor(SALE_MONTH) + parkArea05 * factor(SALE_YEAR) + OSV05KM * 
##     factor(SALE_YEAR), data = HouseData)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -4.897 -0.095  0.027  0.153  2.020 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                  7.42e+00   3.31e-01   22.43  < 2e-16 ***
## SFLA                                         2.42e-04   7.26e-06   33.29  < 2e-16 ***
## BEDRMS                                       2.15e-02   4.52e-03    4.75  2.1e-06 ***
## BATHRMS                                      4.42e-02   6.16e-03    7.17  8.3e-13 ***
## LOTSIZE                                      2.68e-06   3.92e-07    6.82  9.4e-12 ***
## YRBLT                                        1.94e-03   1.69e-04   11.50  < 2e-16 ***
## HomeStyle2 Story                             1.09e-01   1.09e-02   10.01  < 2e-16 ***
## HomeStyle7/4 Story                           3.63e-02   1.31e-02    2.77  0.00569 ** 
## HomeStyleBungalow                            6.82e-03   8.65e-03    0.79  0.43013    
## HomeStyleOther                               1.09e-01   3.10e-01    0.35  0.72542    
## HomeStyleRow                                 1.22e-02   3.11e-01    0.04  0.96878    
## HomeStyleSplit Entry                        -3.61e-02   1.28e-02   -2.83  0.00464 ** 
## HomeStyleSplit Level                         3.82e-02   1.40e-02    2.74  0.00614 ** 
## ELEMENTARYBATTLE CREEK                       3.89e-02   5.19e-02    0.75  0.45369    
## ELEMENTARYBEL AIR                           -2.12e-02   4.17e-02   -0.51  0.61119    
## ELEMENTARYBIRCH LAKE                        -6.78e-02   4.63e-02   -1.47  0.14289    
## ELEMENTARYBRIMHALL                           1.21e-01   4.23e-02    2.87  0.00411 ** 
## ELEMENTARYBRUCE F. VENTO                    -2.38e-01   4.64e-02   -5.11  3.2e-07 ***
## ELEMENTARYCARVER                            -1.72e-01   4.39e-02   -3.92  8.8e-05 ***
## ELEMENTARYCENTRAL PARK                       3.13e-02   4.29e-02    0.73  0.46589    
## ELEMENTARYCHELSEA HEIGHTS                    8.15e-02   3.94e-02    2.07  0.03840 *  
## ELEMENTARYCOMO PARK                          5.88e-02   4.14e-02    1.42  0.15535    
## ELEMENTARYCOWERN                            -7.99e-02   4.55e-02   -1.76  0.07895 .  
## ELEMENTARYDAYTONS BLUFF                     -2.20e-01   4.29e-02   -5.14  2.8e-07 ***
## ELEMENTARYEASTERN HEIGHTS                   -1.10e-01   4.06e-02   -2.71  0.00671 ** 
## ELEMENTARYEDGERTON                          -2.92e-03   4.44e-02   -0.07  0.94769    
## ELEMENTARYEMMET D. WILLIAMS                  5.03e-02   4.34e-02    1.16  0.24644    
## ELEMENTARYFALCON HEIGHTS                     8.33e-02   4.18e-02    1.99  0.04649 *  
## ELEMENTARYFARNSWORTH                         1.15e-02   4.44e-02    0.26  0.79536    
## ELEMENTARYFARNSWORTH LOWER                  -1.08e-01   4.74e-02   -2.28  0.02247 *  
## ELEMENTARYFRANKLIN                          -1.75e-01   2.22e-01   -0.79  0.43109    
## ELEMENTARYFRANKLIN MUSIC                    -9.70e-02   1.83e-01   -0.53  0.59538    
## ELEMENTARYFROST LAKE                        -2.95e-02   4.52e-02   -0.65  0.51415    
## ELEMENTARYGALTIER & MAXFIELD                -8.86e-03   3.95e-02   -0.22  0.82234    
## ELEMENTARYGROVELAND PARK                     2.77e-01   4.20e-02    6.60  4.4e-11 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  2.47e-01   4.56e-02    5.41  6.4e-08 ***
## ELEMENTARYHANCOCK                            1.13e-01   5.72e-02    1.97  0.04867 *  
## ELEMENTARYHANCOCK EL.                        6.61e-02   4.79e-02    1.38  0.16745    
## ELEMENTARYHAYDEN HEIGHTS                    -8.22e-02   4.56e-02   -1.80  0.07120 .  
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -1.34e-01   4.23e-02   -3.17  0.00151 ** 
## ELEMENTARYHIGHLAND PARK                      2.29e-01   4.12e-02    5.55  2.9e-08 ***
## ELEMENTARYHIGHWOOD HILLS                    -3.95e-02   4.66e-02   -0.85  0.39605    
## ELEMENTARYHOMECROFT                          1.00e-01   5.09e-02    1.97  0.04897 *  
## ELEMENTARYISLAND LAKE                       -3.58e-02   4.24e-02   -0.84  0.39847    
## ELEMENTARYJACKSON                           -3.32e-01   5.48e-02   -6.06  1.4e-09 ***
## ELEMENTARYJOHNSON A+                        -1.92e-01   5.07e-02   -3.79  0.00015 ***
## ELEMENTARYLAKEAIRES                          4.79e-02   4.20e-02    1.14  0.25396    
## ELEMENTARYLINCOLN                           -8.44e-02   4.45e-02   -1.90  0.05797 .  
## ELEMENTARYLITTLE CANADA                      5.28e-02   4.62e-02    1.14  0.25248    
## ELEMENTARYLONGFELLOW                         2.03e-01   4.22e-02    4.80  1.6e-06 ***
## ELEMENTARYMANN                               2.44e-01   4.08e-02    5.99  2.1e-09 ***
## ELEMENTARYMATOSKA INTERNATIONAL              8.10e-02   5.28e-02    1.53  0.12548    
## ELEMENTARYMISSISSIPPI                        6.43e-02   5.15e-02    1.25  0.21139    
## ELEMENTARYMONROE                            -3.68e-02   4.22e-02   -0.87  0.38313    
## ELEMENTARYNORTH END                         -1.67e-01   4.17e-02   -4.01  6.1e-05 ***
## ELEMENTARYOAKDALE                           -1.42e-01   6.39e-02   -2.23  0.02582 *  
## ELEMENTARYOBAMA                              3.50e-01   8.17e-02    4.28  1.9e-05 ***
## ELEMENTARYOTTER LAKE                        -1.27e-01   4.69e-02   -2.70  0.00691 ** 
## ELEMENTARYPARKVIEW                           3.62e-03   5.06e-02    0.07  0.94296    
## ELEMENTARYPARKWAY                           -8.24e-03   4.61e-02   -0.18  0.85824    
## ELEMENTARYPHALEN LAKE                       -1.23e-01   4.37e-02   -2.82  0.00477 ** 
## ELEMENTARYPINEWOOD                          -1.33e-01   4.34e-02   -3.06  0.00222 ** 
## ELEMENTARYPROSPERITY HEIGHTS                 1.27e-02   5.72e-02    0.22  0.82427    
## ELEMENTARYRANDOLPH HEIGHTS                   2.58e-01   4.03e-02    6.41  1.6e-10 ***
## ELEMENTARYRICHARDSON                        -4.16e-02   4.20e-02   -0.99  0.32241    
## ELEMENTARYRIVERVIEW & CHEROKEE              -3.93e-02   4.52e-02   -0.87  0.38485    
## ELEMENTARYROOSEVELT & RIVERVIEW & CHEROKEE   4.37e-02   4.56e-02    0.96  0.33767    
## ELEMENTARYSHERIDAN                          -1.49e-02   5.01e-02   -0.30  0.76571    
## ELEMENTARYSHERIDAN & AMES                   -1.19e-01   4.23e-02   -2.82  0.00487 ** 
## ELEMENTARYST ANTHONY PARK                    3.02e-01   4.79e-02    6.31  2.9e-10 ***
## ELEMENTARYSUNNYSIDE                         -5.71e-02   4.34e-02   -1.31  0.18855    
## ELEMENTARYTURTLE LAKE                       -9.76e-02   4.27e-02   -2.29  0.02219 *  
## ELEMENTARYVADNAIS HEIGHTS                   -8.19e-02   4.61e-02   -1.78  0.07576 .  
## ELEMENTARYVALENTINE HILLS                    2.79e-02   4.17e-02    0.67  0.50324    
## ELEMENTARYWEAVER                            -2.66e-02   4.10e-02   -0.65  0.51739    
## ELEMENTARYWEBSTER                            3.27e-02   4.50e-02    0.73  0.46738    
## ELEMENTARYWILLOW LANE                       -5.49e-02   4.92e-02   -1.12  0.26459    
## ELEMENTARYWILSHIRE PARK                      1.42e-01   7.01e-02    2.02  0.04299 *  
## WhiteDense                                   3.11e-01   2.22e-02   14.03  < 2e-16 ***
## fam_income                                   4.95e-06   2.45e-07   20.23  < 2e-16 ***
## factor(SALE_MONTH)2                          2.52e-03   1.83e-02    0.14  0.89070    
## factor(SALE_MONTH)3                          2.50e-02   1.70e-02    1.47  0.14176    
## factor(SALE_MONTH)4                          2.09e-02   1.65e-02    1.27  0.20583    
## factor(SALE_MONTH)5                          6.63e-02   1.61e-02    4.11  4.0e-05 ***
## factor(SALE_MONTH)6                          5.43e-02   1.60e-02    3.40  0.00067 ***
## factor(SALE_MONTH)7                          5.65e-02   1.65e-02    3.42  0.00063 ***
## factor(SALE_MONTH)8                          3.64e-02   1.64e-02    2.21  0.02688 *  
## factor(SALE_MONTH)9                          2.69e-02   1.70e-02    1.58  0.11337    
## factor(SALE_MONTH)10                         4.00e-02   1.71e-02    2.34  0.01907 *  
## factor(SALE_MONTH)11                         4.34e-02   1.76e-02    2.47  0.01367 *  
## factor(SALE_MONTH)12                        -1.05e-02   1.85e-02   -0.57  0.57043    
## parkArea05                                   5.04e-08   8.63e-08    0.58  0.55891    
## factor(SALE_YEAR)2006                       -7.44e-03   1.49e-02   -0.50  0.61872    
## factor(SALE_YEAR)2009                       -3.89e-01   1.71e-02  -22.80  < 2e-16 ***
## factor(SALE_YEAR)2010                       -4.49e-01   1.76e-02  -25.52  < 2e-16 ***
## factor(SALE_YEAR)2011                       -6.50e-01   2.73e-02  -23.81  < 2e-16 ***
## OSV05KM                                     -2.95e-09   4.20e-09   -0.70  0.48176    
## parkArea05:factor(SALE_YEAR)2006            -6.16e-08   1.23e-07   -0.50  0.61625    
## parkArea05:factor(SALE_YEAR)2009            -1.35e-09   1.29e-07   -0.01  0.99168    
## parkArea05:factor(SALE_YEAR)2010            -9.73e-08   1.33e-07   -0.73  0.46454    
## parkArea05:factor(SALE_YEAR)2011             1.31e-07   2.14e-07    0.61  0.53905    
## factor(SALE_YEAR)2006:OSV05KM                6.04e-09   5.46e-09    1.11  0.26853    
## factor(SALE_YEAR)2009:OSV05KM                2.86e-08   5.83e-09    4.90  9.9e-07 ***
## factor(SALE_YEAR)2010:OSV05KM                3.46e-08   5.95e-09    5.81  6.3e-09 ***
## factor(SALE_YEAR)2011:OSV05KM                4.93e-08   9.03e-09    5.46  4.8e-08 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.309 on 10760 degrees of freedom
## Multiple R-squared: 0.688,	Adjusted R-squared: 0.685 
## F-statistic:  228 on 104 and 10760 DF,  p-value: <2e-16
```


Yep, the new Price Data has huge effect. Others have pretty similar records (95% plus) and don't seem to matter much, but do help a little bit. 


