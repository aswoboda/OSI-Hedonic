

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


Base Model From ODQR Exploration


```r
ODQR1 = lm(logPRICE ~ SFLA + BEDRMS + BATHRMS + LOTSIZE + YRBLT + HomeStyle + ELEMENTARY + WhiteDense + fam_income + factor(SALE_MONTH) + parkArea05 * factor(SALE_YEAR) + 
    OSV05KM * factor(SALE_YEAR), data = HouseData)
summary(ODQR1)
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


JUST OSV


```r
ODQR2 = lm(logPRICE ~ SFLA + BEDRMS + BATHRMS + LOTSIZE + YRBLT + HomeStyle + ELEMENTARY + WhiteDense + fam_income + factor(SALE_MONTH) + OSV05KM * factor(SALE_YEAR), 
    data = HouseData)
summary(ODQR2)
```

```
## 
## Call:
## lm(formula = logPRICE ~ SFLA + BEDRMS + BATHRMS + LOTSIZE + YRBLT + 
##     HomeStyle + ELEMENTARY + WhiteDense + fam_income + factor(SALE_MONTH) + 
##     OSV05KM * factor(SALE_YEAR), data = HouseData)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -2.5333 -0.1015  0.0048  0.1088  1.0365 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                  8.90e+00   2.16e-01   41.15  < 2e-16 ***
## SFLA                                         2.50e-04   4.75e-06   52.59  < 2e-16 ***
## BEDRMS                                       2.13e-02   2.95e-03    7.20  6.4e-13 ***
## BATHRMS                                      5.57e-02   4.03e-03   13.81  < 2e-16 ***
## LOTSIZE                                      2.63e-06   2.54e-07   10.35  < 2e-16 ***
## YRBLT                                        1.26e-03   1.11e-04   11.43  < 2e-16 ***
## HomeStyle2 Story                             9.84e-02   7.10e-03   13.86  < 2e-16 ***
## HomeStyle7/4 Story                           2.66e-02   8.59e-03    3.10  0.00196 ** 
## HomeStyleBungalow                            2.11e-03   5.65e-03    0.37  0.70894    
## HomeStyleOther                               1.42e-01   2.03e-01    0.70  0.48301    
## HomeStyleRow                                -2.03e-02   2.03e-01   -0.10  0.92030    
## HomeStyleSplit Entry                        -2.84e-02   8.34e-03   -3.41  0.00066 ***
## HomeStyleSplit Level                         3.18e-02   9.11e-03    3.49  0.00049 ***
## ELEMENTARYBATTLE CREEK                       9.22e-03   3.32e-02    0.28  0.78107    
## ELEMENTARYBEL AIR                            4.08e-02   2.72e-02    1.50  0.13425    
## ELEMENTARYBIRCH LAKE                         1.16e-02   3.02e-02    0.38  0.70089    
## ELEMENTARYBRIMHALL                           1.62e-01   2.76e-02    5.86  4.8e-09 ***
## ELEMENTARYBRUCE F. VENTO                    -4.13e-02   3.04e-02   -1.36  0.17365    
## ELEMENTARYCARVER                            -4.37e-02   2.87e-02   -1.52  0.12769    
## ELEMENTARYCENTRAL PARK                       9.78e-02   2.80e-02    3.49  0.00049 ***
## ELEMENTARYCHELSEA HEIGHTS                    1.43e-01   2.57e-02    5.55  3.0e-08 ***
## ELEMENTARYCOMO PARK                          8.73e-02   2.70e-02    3.23  0.00124 ** 
## ELEMENTARYCOWERN                             2.86e-02   2.97e-02    0.96  0.33588    
## ELEMENTARYDAYTONS BLUFF                     -3.36e-02   2.80e-02   -1.20  0.23012    
## ELEMENTARYEASTERN HEIGHTS                   -5.67e-03   2.65e-02   -0.21  0.83079    
## ELEMENTARYEDGERTON                           7.82e-02   2.90e-02    2.69  0.00713 ** 
## ELEMENTARYEMMET D. WILLIAMS                  1.21e-01   2.84e-02    4.25  2.1e-05 ***
## ELEMENTARYFALCON HEIGHTS                     1.30e-01   2.73e-02    4.77  1.9e-06 ***
## ELEMENTARYFARNSWORTH                         4.18e-02   2.90e-02    1.44  0.14910    
## ELEMENTARYFARNSWORTH LOWER                  -4.78e-03   3.10e-02   -0.15  0.87724    
## ELEMENTARYFRANKLIN                          -1.24e-01   1.45e-01   -0.85  0.39357    
## ELEMENTARYFRANKLIN MUSIC                     6.37e-02   1.19e-01    0.53  0.59353    
## ELEMENTARYFROST LAKE                         7.35e-03   2.96e-02    0.25  0.80359    
## ELEMENTARYGALTIER & MAXFIELD                 5.37e-02   2.58e-02    2.08  0.03731 *  
## ELEMENTARYGROVELAND PARK                     3.72e-01   2.74e-02   13.57  < 2e-16 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  3.01e-01   2.98e-02   10.10  < 2e-16 ***
## ELEMENTARYHANCOCK                            1.30e-01   3.74e-02    3.47  0.00052 ***
## ELEMENTARYHANCOCK EL.                        9.58e-02   3.13e-02    3.06  0.00221 ** 
## ELEMENTARYHAYDEN HEIGHTS                    -3.93e-02   2.98e-02   -1.32  0.18705    
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -3.24e-02   2.76e-02   -1.17  0.24063    
## ELEMENTARYHIGHLAND PARK                      3.11e-01   2.69e-02   11.55  < 2e-16 ***
## ELEMENTARYHIGHWOOD HILLS                     3.89e-03   3.03e-02    0.13  0.89771    
## ELEMENTARYHOMECROFT                          1.73e-01   3.32e-02    5.21  2.0e-07 ***
## ELEMENTARYISLAND LAKE                        7.78e-02   2.77e-02    2.81  0.00497 ** 
## ELEMENTARYJACKSON                           -6.09e-02   3.58e-02   -1.70  0.08895 .  
## ELEMENTARYJOHNSON A+                        -5.41e-02   3.31e-02   -1.63  0.10260    
## ELEMENTARYLAKEAIRES                          1.17e-01   2.74e-02    4.29  1.8e-05 ***
## ELEMENTARYLINCOLN                            2.88e-02   2.91e-02    0.99  0.32309    
## ELEMENTARYLITTLE CANADA                      9.14e-02   3.02e-02    3.03  0.00246 ** 
## ELEMENTARYLONGFELLOW                         2.67e-01   2.76e-02    9.69  < 2e-16 ***
## ELEMENTARYMANN                               3.10e-01   2.67e-02   11.64  < 2e-16 ***
## ELEMENTARYMATOSKA INTERNATIONAL              1.10e-01   3.45e-02    3.18  0.00149 ** 
## ELEMENTARYMISSISSIPPI                        8.42e-02   3.36e-02    2.51  0.01225 *  
## ELEMENTARYMONROE                             5.45e-02   2.76e-02    1.98  0.04810 *  
## ELEMENTARYNORTH END                         -5.31e-02   2.73e-02   -1.95  0.05167 .  
## ELEMENTARYOAKDALE                            1.90e-02   4.18e-02    0.45  0.65000    
## ELEMENTARYOBAMA                              4.01e-01   5.34e-02    7.50  6.7e-14 ***
## ELEMENTARYOTTER LAKE                        -2.10e-02   3.06e-02   -0.69  0.49207    
## ELEMENTARYPARKVIEW                           9.26e-02   3.31e-02    2.80  0.00510 ** 
## ELEMENTARYPARKWAY                           -2.15e-02   3.01e-02   -0.71  0.47570    
## ELEMENTARYPHALEN LAKE                       -4.92e-02   2.85e-02   -1.73  0.08454 .  
## ELEMENTARYPINEWOOD                          -4.29e-02   2.83e-02   -1.51  0.12983    
## ELEMENTARYPROSPERITY HEIGHTS                 4.29e-02   3.74e-02    1.15  0.25130    
## ELEMENTARYRANDOLPH HEIGHTS                   3.21e-01   2.64e-02   12.18  < 2e-16 ***
## ELEMENTARYRICHARDSON                         3.08e-02   2.74e-02    1.12  0.26232    
## ELEMENTARYRIVERVIEW & CHEROKEE               4.04e-02   2.96e-02    1.37  0.17146    
## ELEMENTARYROOSEVELT & RIVERVIEW & CHEROKEE   5.18e-02   2.98e-02    1.74  0.08209 .  
## ELEMENTARYSHERIDAN                          -6.36e-03   3.28e-02   -0.19  0.84609    
## ELEMENTARYSHERIDAN & AMES                    1.88e-02   2.76e-02    0.68  0.49711    
## ELEMENTARYST ANTHONY PARK                    3.53e-01   3.13e-02   11.26  < 2e-16 ***
## ELEMENTARYSUNNYSIDE                          1.64e-02   2.84e-02    0.58  0.56285    
## ELEMENTARYTURTLE LAKE                        1.93e-02   2.78e-02    0.69  0.48759    
## ELEMENTARYVADNAIS HEIGHTS                    1.67e-02   3.01e-02    0.55  0.57958    
## ELEMENTARYVALENTINE HILLS                    8.91e-02   2.73e-02    3.27  0.00109 ** 
## ELEMENTARYWEAVER                             3.15e-02   2.68e-02    1.18  0.23981    
## ELEMENTARYWEBSTER                            6.88e-02   2.94e-02    2.34  0.01923 *  
## ELEMENTARYWILLOW LANE                        1.24e-02   3.22e-02    0.39  0.69902    
## ELEMENTARYWILSHIRE PARK                      1.59e-01   4.58e-02    3.47  0.00053 ***
## WhiteDense                                   1.46e-01   1.45e-02   10.11  < 2e-16 ***
## fam_income                                   3.10e-06   1.60e-07   19.39  < 2e-16 ***
## factor(SALE_MONTH)2                         -1.05e-03   1.20e-02   -0.09  0.93016    
## factor(SALE_MONTH)3                          8.31e-03   1.11e-02    0.75  0.45390    
## factor(SALE_MONTH)4                          4.72e-03   1.08e-02    0.44  0.66231    
## factor(SALE_MONTH)5                          2.12e-02   1.05e-02    2.01  0.04421 *  
## factor(SALE_MONTH)6                          1.74e-02   1.04e-02    1.67  0.09560 .  
## factor(SALE_MONTH)7                          1.74e-02   1.08e-02    1.62  0.10624    
## factor(SALE_MONTH)8                          1.02e-02   1.07e-02    0.94  0.34481    
## factor(SALE_MONTH)9                          1.54e-02   1.11e-02    1.39  0.16482    
## factor(SALE_MONTH)10                        -6.39e-03   1.12e-02   -0.57  0.56727    
## factor(SALE_MONTH)11                        -1.87e-02   1.15e-02   -1.63  0.10310    
## factor(SALE_MONTH)12                        -1.79e-02   1.21e-02   -1.48  0.13937    
## OSV05KM                                      1.19e-08   2.54e-09    4.68  3.0e-06 ***
## factor(SALE_YEAR)2006                        1.72e-03   9.73e-03    0.18  0.85935    
## factor(SALE_YEAR)2009                       -2.02e-01   1.11e-02  -18.19  < 2e-16 ***
## factor(SALE_YEAR)2010                       -2.40e-01   1.14e-02  -21.04  < 2e-16 ***
## factor(SALE_YEAR)2011                       -3.16e-01   1.77e-02  -17.82  < 2e-16 ***
## OSV05KM:factor(SALE_YEAR)2006                1.65e-09   3.22e-09    0.51  0.60929    
## OSV05KM:factor(SALE_YEAR)2009                9.71e-09   3.42e-09    2.84  0.00454 ** 
## OSV05KM:factor(SALE_YEAR)2010                8.49e-09   3.51e-09    2.41  0.01576 *  
## OSV05KM:factor(SALE_YEAR)2011                1.73e-08   5.33e-09    3.24  0.00122 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.202 on 10765 degrees of freedom
## Multiple R-squared: 0.784,	Adjusted R-squared: 0.782 
## F-statistic:  395 on 99 and 10765 DF,  p-value: <2e-16
```


JUST PARKS


```r
ODQR3 = lm(logPRICE ~ SFLA + BEDRMS + BATHRMS + LOTSIZE + YRBLT + HomeStyle + ELEMENTARY + WhiteDense + fam_income + factor(SALE_MONTH) + parkArea05 * factor(SALE_YEAR), 
    data = HouseData)
summary(ODQR3)
```

```
## 
## Call:
## lm(formula = logPRICE ~ SFLA + BEDRMS + BATHRMS + LOTSIZE + YRBLT + 
##     HomeStyle + ELEMENTARY + WhiteDense + fam_income + factor(SALE_MONTH) + 
##     parkArea05 * factor(SALE_YEAR), data = HouseData)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -2.6408 -0.1024  0.0043  0.1091  1.0685 
## 
## Coefficients:
##                                              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                                  8.83e+00   2.17e-01   40.64  < 2e-16 ***
## SFLA                                         2.54e-04   4.74e-06   53.60  < 2e-16 ***
## BEDRMS                                       2.01e-02   2.97e-03    6.78  1.3e-11 ***
## BATHRMS                                      5.60e-02   4.05e-03   13.83  < 2e-16 ***
## LOTSIZE                                      3.13e-06   2.52e-07   12.41  < 2e-16 ***
## YRBLT                                        1.31e-03   1.11e-04   11.77  < 2e-16 ***
## HomeStyle2 Story                             9.51e-02   7.14e-03   13.33  < 2e-16 ***
## HomeStyle7/4 Story                           2.53e-02   8.63e-03    2.93  0.00335 ** 
## HomeStyleBungalow                            1.38e-03   5.68e-03    0.24  0.80857    
## HomeStyleOther                               1.13e-01   2.04e-01    0.55  0.58069    
## HomeStyleRow                                -4.04e-02   2.04e-01   -0.20  0.84301    
## HomeStyleSplit Entry                        -2.92e-02   8.38e-03   -3.49  0.00049 ***
## HomeStyleSplit Level                         3.08e-02   9.17e-03    3.36  0.00078 ***
## ELEMENTARYBATTLE CREEK                       7.87e-03   3.40e-02    0.23  0.81718    
## ELEMENTARYBEL AIR                            4.61e-02   2.73e-02    1.69  0.09153 .  
## ELEMENTARYBIRCH LAKE                         2.17e-02   3.03e-02    0.71  0.47522    
## ELEMENTARYBRIMHALL                           1.80e-01   2.77e-02    6.51  7.8e-11 ***
## ELEMENTARYBRUCE F. VENTO                    -4.86e-02   3.05e-02   -1.59  0.11104    
## ELEMENTARYCARVER                            -2.66e-02   2.87e-02   -0.93  0.35345    
## ELEMENTARYCENTRAL PARK                       9.60e-02   2.82e-02    3.40  0.00066 ***
## ELEMENTARYCHELSEA HEIGHTS                    1.43e-01   2.58e-02    5.53  3.3e-08 ***
## ELEMENTARYCOMO PARK                          8.77e-02   2.72e-02    3.23  0.00124 ** 
## ELEMENTARYCOWERN                             2.42e-02   2.99e-02    0.81  0.41691    
## ELEMENTARYDAYTONS BLUFF                     -5.19e-02   2.81e-02   -1.85  0.06459 .  
## ELEMENTARYEASTERN HEIGHTS                   -2.70e-04   2.66e-02   -0.01  0.99190    
## ELEMENTARYEDGERTON                           9.15e-02   2.91e-02    3.14  0.00167 ** 
## ELEMENTARYEMMET D. WILLIAMS                  1.38e-01   2.84e-02    4.86  1.2e-06 ***
## ELEMENTARYFALCON HEIGHTS                     1.28e-01   2.75e-02    4.66  3.2e-06 ***
## ELEMENTARYFARNSWORTH                         3.24e-02   2.92e-02    1.11  0.26707    
## ELEMENTARYFARNSWORTH LOWER                  -2.44e-02   3.10e-02   -0.78  0.43252    
## ELEMENTARYFRANKLIN                          -1.21e-01   1.46e-01   -0.83  0.40673    
## ELEMENTARYFRANKLIN MUSIC                     6.91e-02   1.20e-01    0.58  0.56469    
## ELEMENTARYFROST LAKE                        -5.08e-03   2.97e-02   -0.17  0.86411    
## ELEMENTARYGALTIER & MAXFIELD                 5.07e-02   2.59e-02    1.96  0.05036 .  
## ELEMENTARYGROVELAND PARK                     3.56e-01   2.75e-02   12.94  < 2e-16 ***
## ELEMENTARYGROVELAND PARK & ST. ANTHONY PARK  2.92e-01   2.99e-02    9.78  < 2e-16 ***
## ELEMENTARYHANCOCK                            1.31e-01   3.75e-02    3.50  0.00046 ***
## ELEMENTARYHANCOCK EL.                        9.95e-02   3.15e-02    3.16  0.00158 ** 
## ELEMENTARYHAYDEN HEIGHTS                    -4.36e-02   2.99e-02   -1.46  0.14541    
## ELEMENTARYHAYDEN HTS. & PROSPERITY HTS.     -4.80e-02   2.77e-02   -1.73  0.08300 .  
## ELEMENTARYHIGHLAND PARK                      2.97e-01   2.70e-02   11.00  < 2e-16 ***
## ELEMENTARYHIGHWOOD HILLS                     1.06e-02   3.05e-02    0.35  0.72854    
## ELEMENTARYHOMECROFT                          1.72e-01   3.34e-02    5.14  2.8e-07 ***
## ELEMENTARYISLAND LAKE                        8.82e-02   2.78e-02    3.17  0.00151 ** 
## ELEMENTARYJACKSON                           -6.46e-02   3.60e-02   -1.79  0.07293 .  
## ELEMENTARYJOHNSON A+                        -6.67e-02   3.33e-02   -2.00  0.04503 *  
## ELEMENTARYLAKEAIRES                          1.37e-01   2.75e-02    4.99  6.1e-07 ***
## ELEMENTARYLINCOLN                            5.06e-02   2.91e-02    1.74  0.08194 .  
## ELEMENTARYLITTLE CANADA                      1.08e-01   3.02e-02    3.56  0.00038 ***
## ELEMENTARYLONGFELLOW                         2.67e-01   2.77e-02    9.62  < 2e-16 ***
## ELEMENTARYMANN                               3.09e-01   2.68e-02   11.55  < 2e-16 ***
## ELEMENTARYMATOSKA INTERNATIONAL              1.12e-01   3.47e-02    3.24  0.00120 ** 
## ELEMENTARYMISSISSIPPI                        7.87e-02   3.38e-02    2.33  0.01987 *  
## ELEMENTARYMONROE                             5.17e-02   2.77e-02    1.87  0.06192 .  
## ELEMENTARYNORTH END                         -5.10e-02   2.74e-02   -1.86  0.06265 .  
## ELEMENTARYOAKDALE                            3.51e-02   4.19e-02    0.84  0.40268    
## ELEMENTARYOBAMA                              3.85e-01   5.36e-02    7.18  7.3e-13 ***
## ELEMENTARYOTTER LAKE                        -8.00e-03   3.07e-02   -0.26  0.79465    
## ELEMENTARYPARKVIEW                           9.96e-02   3.32e-02    3.00  0.00270 ** 
## ELEMENTARYPARKWAY                           -3.01e-02   3.03e-02   -0.99  0.32105    
## ELEMENTARYPHALEN LAKE                       -7.06e-02   2.87e-02   -2.46  0.01378 *  
## ELEMENTARYPINEWOOD                          -2.97e-02   2.84e-02   -1.05  0.29515    
## ELEMENTARYPROSPERITY HEIGHTS                 3.35e-02   3.76e-02    0.89  0.37343    
## ELEMENTARYRANDOLPH HEIGHTS                   3.07e-01   2.65e-02   11.58  < 2e-16 ***
## ELEMENTARYRICHARDSON                         2.65e-02   2.76e-02    0.96  0.33599    
## ELEMENTARYRIVERVIEW & CHEROKEE               3.04e-02   2.97e-02    1.03  0.30484    
## ELEMENTARYROOSEVELT & RIVERVIEW & CHEROKEE   4.82e-02   3.00e-02    1.61  0.10795    
## ELEMENTARYSHERIDAN                          -9.38e-03   3.29e-02   -0.28  0.77568    
## ELEMENTARYSHERIDAN & AMES                    5.99e-03   2.77e-02    0.22  0.82886    
## ELEMENTARYST ANTHONY PARK                    3.54e-01   3.15e-02   11.25  < 2e-16 ***
## ELEMENTARYSUNNYSIDE                          2.59e-02   2.85e-02    0.91  0.36253    
## ELEMENTARYTURTLE LAKE                        3.38e-02   2.79e-02    1.21  0.22575    
## ELEMENTARYVADNAIS HEIGHTS                    3.19e-02   3.02e-02    1.06  0.28999    
## ELEMENTARYVALENTINE HILLS                    1.01e-01   2.73e-02    3.69  0.00022 ***
## ELEMENTARYWEAVER                             4.40e-02   2.69e-02    1.64  0.10135    
## ELEMENTARYWEBSTER                            8.14e-02   2.95e-02    2.76  0.00574 ** 
## ELEMENTARYWILLOW LANE                        4.68e-02   3.20e-02    1.46  0.14318    
## ELEMENTARYWILSHIRE PARK                      1.79e-01   4.59e-02    3.89  0.00010 ***
## WhiteDense                                   1.43e-01   1.46e-02    9.84  < 2e-16 ***
## fam_income                                   3.15e-06   1.61e-07   19.56  < 2e-16 ***
## factor(SALE_MONTH)2                          9.13e-04   1.20e-02    0.08  0.93949    
## factor(SALE_MONTH)3                          7.75e-03   1.12e-02    0.69  0.48745    
## factor(SALE_MONTH)4                          4.80e-03   1.09e-02    0.44  0.65888    
## factor(SALE_MONTH)5                          2.15e-02   1.06e-02    2.03  0.04248 *  
## factor(SALE_MONTH)6                          1.78e-02   1.05e-02    1.70  0.09005 .  
## factor(SALE_MONTH)7                          1.60e-02   1.09e-02    1.47  0.14126    
## factor(SALE_MONTH)8                          1.07e-02   1.08e-02    0.99  0.32223    
## factor(SALE_MONTH)9                          1.60e-02   1.12e-02    1.44  0.15059    
## factor(SALE_MONTH)10                        -7.01e-03   1.12e-02   -0.62  0.53208    
## factor(SALE_MONTH)11                        -1.97e-02   1.16e-02   -1.70  0.08864 .  
## factor(SALE_MONTH)12                        -1.76e-02   1.22e-02   -1.44  0.14926    
## parkArea05                                   9.81e-08   5.23e-08    1.88  0.06041 .  
## factor(SALE_YEAR)2006                        1.38e-03   6.89e-03    0.20  0.84187    
## factor(SALE_YEAR)2009                       -1.76e-01   8.18e-03  -21.57  < 2e-16 ***
## factor(SALE_YEAR)2010                       -2.22e-01   8.47e-03  -26.24  < 2e-16 ***
## factor(SALE_YEAR)2011                       -2.67e-01   1.35e-02  -19.77  < 2e-16 ***
## parkArea05:factor(SALE_YEAR)2006             8.26e-08   7.29e-08    1.13  0.25687    
## parkArea05:factor(SALE_YEAR)2009            -5.75e-09   7.63e-08   -0.08  0.93995    
## parkArea05:factor(SALE_YEAR)2010             6.60e-08   7.90e-08    0.84  0.40295    
## parkArea05:factor(SALE_YEAR)2011            -4.98e-08   1.27e-07   -0.39  0.69506    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 
## 
## Residual standard error: 0.203 on 10765 degrees of freedom
## Multiple R-squared: 0.782,	Adjusted R-squared: 0.78 
## F-statistic:  390 on 99 and 10765 DF,  p-value: <2e-16
```

