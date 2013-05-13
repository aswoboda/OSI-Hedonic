Full set of OSI Regressions
========================================================

Note: All scales, from 0.1 KM to 2 KM are in order. Within each scale, there are six regressions using different sets of variables. For readability, all results have been truncated between 5 and 250.


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
## [1] "/home/hillisj/OSI-Hedonic Project/OSI-Hedonic/writeup/02-AllData"
```

```r
HouseData = read.dbf("~/OSI-Hedonic Project/Data/GIS2R/allData.dbf")
```




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


Tenth Kilometer
---------



```r
osiModel01KM.1 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    parkArea01, data = HouseData)
# summary(osiModel01KM.1)
coef(summary(osiModel01KM.1))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.718e+00  2.077e-01  22.7152 1.162e-113
## FIN_SQ_FT              3.092e-04  3.266e-06  94.6933  0.000e+00
## ACRES_POLY             4.095e-02  2.008e-03  20.3983  4.037e-92
## YEAR_BUILT             3.329e-03  1.036e-04  32.1314 2.776e-224
## WhiteDense             1.960e-01  1.199e-02  16.3432  6.904e-60
## fam_income             4.617e-06  1.384e-07  33.3525 2.638e-241
## factor(SALE_YEAR)2006  6.300e-03  3.856e-03   1.6339  1.023e-01
## factor(SALE_YEAR)2009 -3.406e-01  5.675e-03 -60.0204  0.000e+00
## factor(SALE_YEAR)2010 -3.582e-01  5.847e-03 -61.2651  0.000e+00
## factor(SALE_YEAR)2011 -5.128e-01  1.025e-02 -50.0368  0.000e+00
## factor(SALE_MONTH)2   -1.355e-02  9.103e-03  -1.4880  1.368e-01
## factor(SALE_MONTH)3    1.369e-02  8.471e-03   1.6165  1.060e-01
## factor(SALE_MONTH)4    8.324e-03  8.301e-03   1.0028  3.160e-01
## factor(SALE_MONTH)5    3.903e-02  8.189e-03   4.7663  1.882e-06
## factor(SALE_MONTH)6    4.472e-02  8.017e-03   5.5776  2.452e-08
## factor(SALE_MONTH)7    4.443e-02  8.306e-03   5.3487  8.896e-08
## factor(SALE_MONTH)8    4.500e-02  8.240e-03   5.4604  4.773e-08
## factor(SALE_MONTH)9    2.732e-02  8.484e-03   3.2204  1.281e-03
## factor(SALE_MONTH)10   3.980e-02  8.551e-03   4.6548  3.251e-06
## factor(SALE_MONTH)11   6.103e-03  8.826e-03   0.6915  4.893e-01
## factor(SALE_MONTH)12  -5.747e-03  9.123e-03  -0.6300  5.287e-01
## parkArea01             3.388e-06  5.286e-07   6.4094  1.473e-10
```



```r
osiModel01KM.2 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + factor(SALE_YEAR) + factor(SALE_MONTH) + parkArea01, 
    data = HouseData)
# summary(osiModel01KM.2)
coef(summary(osiModel01KM.2))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.392e+00  2.097e-01  20.9391  6.032e-97
## FIN_SQ_FT              3.263e-04  3.260e-06 100.1049  0.000e+00
## ACRES_POLY             4.422e-02  2.027e-03  21.8185 4.677e-105
## YEAR_BUILT             3.601e-03  1.044e-04  34.4919 9.780e-258
## WhiteDense             2.613e-01  1.196e-02  21.8488 2.429e-105
## factor(SALE_YEAR)2006  5.160e-03  3.897e-03   1.3240  1.855e-01
## factor(SALE_YEAR)2009 -2.564e-01  5.137e-03 -49.9083  0.000e+00
## factor(SALE_YEAR)2010 -2.737e-01  5.326e-03 -51.3866  0.000e+00
## factor(SALE_YEAR)2011 -4.303e-01  1.005e-02 -42.8036  0.000e+00
## factor(SALE_MONTH)2   -1.458e-02  9.202e-03  -1.5847  1.130e-01
## factor(SALE_MONTH)3    1.320e-02  8.562e-03   1.5419  1.231e-01
## factor(SALE_MONTH)4    8.148e-03  8.391e-03   0.9710  3.315e-01
## factor(SALE_MONTH)5    3.951e-02  8.277e-03   4.7737  1.814e-06
## factor(SALE_MONTH)6    4.600e-02  8.104e-03   5.6766  1.381e-08
## factor(SALE_MONTH)7    4.374e-02  8.396e-03   5.2103  1.893e-07
## factor(SALE_MONTH)8    4.471e-02  8.329e-03   5.3678  8.004e-08
## factor(SALE_MONTH)9    2.767e-02  8.575e-03   3.2264  1.254e-03
## factor(SALE_MONTH)10   3.870e-02  8.643e-03   4.4780  7.549e-06
## factor(SALE_MONTH)11   6.319e-03  8.922e-03   0.7082  4.788e-01
## factor(SALE_MONTH)12  -5.451e-03  9.222e-03  -0.5910  5.545e-01
## parkArea01             3.352e-06  5.343e-07   6.2736  3.555e-10
```



```r
osiModel01KM.3 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    OSV01KM, data = HouseData)
coef(summary(osiModel01KM.3))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.694e+00  2.080e-01  22.5627 3.570e-112
## FIN_SQ_FT              3.102e-04  3.266e-06  94.9590  0.000e+00
## ACRES_POLY             4.026e-02  2.056e-03  19.5847  4.285e-85
## YEAR_BUILT             3.344e-03  1.038e-04  32.2192 1.740e-225
## WhiteDense             1.959e-01  1.200e-02  16.3324  8.234e-60
## fam_income             4.614e-06  1.385e-07  33.3118 9.969e-241
## factor(SALE_YEAR)2006  6.258e-03  3.857e-03   1.6224  1.047e-01
## factor(SALE_YEAR)2009 -3.404e-01  5.677e-03 -59.9663  0.000e+00
## factor(SALE_YEAR)2010 -3.584e-01  5.849e-03 -61.2681  0.000e+00
## factor(SALE_YEAR)2011 -5.136e-01  1.025e-02 -50.0924  0.000e+00
## factor(SALE_MONTH)2   -1.351e-02  9.107e-03  -1.4830  1.381e-01
## factor(SALE_MONTH)3    1.355e-02  8.474e-03   1.5990  1.098e-01
## factor(SALE_MONTH)4    8.284e-03  8.305e-03   0.9975  3.185e-01
## factor(SALE_MONTH)5    3.919e-02  8.192e-03   4.7844  1.720e-06
## factor(SALE_MONTH)6    4.460e-02  8.021e-03   5.5604  2.705e-08
## factor(SALE_MONTH)7    4.416e-02  8.310e-03   5.3135  1.080e-07
## factor(SALE_MONTH)8    4.490e-02  8.244e-03   5.4463  5.166e-08
## factor(SALE_MONTH)9    2.712e-02  8.487e-03   3.1953  1.398e-03
## factor(SALE_MONTH)10   3.987e-02  8.554e-03   4.6604  3.164e-06
## factor(SALE_MONTH)11   5.905e-03  8.830e-03   0.6687  5.037e-01
## factor(SALE_MONTH)12  -6.054e-03  9.127e-03  -0.6633  5.071e-01
## OSV01KM                8.021e-09  1.782e-08   0.4500  6.527e-01
```



```r
osiModel01KM.4 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + factor(SALE_YEAR) + factor(SALE_MONTH) + OSV01KM, 
    data = HouseData)
coef(summary(osiModel01KM.4))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.374e+00  2.101e-01  20.8250  6.443e-96
## FIN_SQ_FT              3.272e-04  3.261e-06 100.3246  0.000e+00
## ACRES_POLY             4.326e-02  2.076e-03  20.8364  5.080e-96
## YEAR_BUILT             3.612e-03  1.046e-04  34.5306 2.647e-258
## WhiteDense             2.612e-01  1.196e-02  21.8361 3.195e-105
## factor(SALE_YEAR)2006  5.107e-03  3.899e-03   1.3098  1.903e-01
## factor(SALE_YEAR)2009 -2.563e-01  5.139e-03 -49.8710  0.000e+00
## factor(SALE_YEAR)2010 -2.739e-01  5.328e-03 -51.4107  0.000e+00
## factor(SALE_YEAR)2011 -4.311e-01  1.006e-02 -42.8664  0.000e+00
## factor(SALE_MONTH)2   -1.450e-02  9.205e-03  -1.5751  1.152e-01
## factor(SALE_MONTH)3    1.308e-02  8.565e-03   1.5267  1.268e-01
## factor(SALE_MONTH)4    8.131e-03  8.394e-03   0.9686  3.327e-01
## factor(SALE_MONTH)5    3.971e-02  8.280e-03   4.7962  1.622e-06
## factor(SALE_MONTH)6    4.596e-02  8.107e-03   5.6683  1.450e-08
## factor(SALE_MONTH)7    4.355e-02  8.400e-03   5.1850  2.169e-07
## factor(SALE_MONTH)8    4.467e-02  8.333e-03   5.3603  8.346e-08
## factor(SALE_MONTH)9    2.750e-02  8.579e-03   3.2055  1.349e-03
## factor(SALE_MONTH)10   3.880e-02  8.647e-03   4.4879  7.210e-06
## factor(SALE_MONTH)11   6.173e-03  8.925e-03   0.6917  4.892e-01
## factor(SALE_MONTH)12  -5.693e-03  9.226e-03  -0.6170  5.372e-01
## OSV01KM                1.921e-08  1.801e-08   1.0667  2.861e-01
```



```r
osiModel01 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    parkArea01 + OSV01KM, data = HouseData)
coef(summary(osiModel01))[-(5:250), ]
```

```
##                         Estimate Std. Error   t value   Pr(>|t|)
## (Intercept)            4.718e+00  2.080e-01  22.68563 2.260e-113
## FIN_SQ_FT              3.092e-04  3.268e-06  94.62495  0.000e+00
## ACRES_POLY             4.096e-02  2.058e-03  19.90278  8.291e-88
## YEAR_BUILT             3.329e-03  1.038e-04  32.07956 1.423e-223
## WhiteDense             1.960e-01  1.199e-02  16.34242  6.992e-60
## fam_income             4.617e-06  1.385e-07  33.34642 3.217e-241
## factor(SALE_YEAR)2006  6.300e-03  3.856e-03   1.63394  1.023e-01
## factor(SALE_YEAR)2009 -3.406e-01  5.675e-03 -60.01969  0.000e+00
## factor(SALE_YEAR)2010 -3.582e-01  5.847e-03 -61.26424  0.000e+00
## factor(SALE_YEAR)2011 -5.128e-01  1.025e-02 -50.03324  0.000e+00
## factor(SALE_MONTH)2   -1.355e-02  9.104e-03  -1.48807  1.367e-01
## factor(SALE_MONTH)3    1.369e-02  8.471e-03   1.61646  1.060e-01
## factor(SALE_MONTH)4    8.324e-03  8.301e-03   1.00269  3.160e-01
## factor(SALE_MONTH)5    3.903e-02  8.189e-03   4.76595  1.885e-06
## factor(SALE_MONTH)6    4.471e-02  8.018e-03   5.57677  2.463e-08
## factor(SALE_MONTH)7    4.443e-02  8.307e-03   5.34792  8.935e-08
## factor(SALE_MONTH)8    4.499e-02  8.241e-03   5.45995  4.785e-08
## factor(SALE_MONTH)9    2.732e-02  8.484e-03   3.22026  1.282e-03
## factor(SALE_MONTH)10   3.980e-02  8.551e-03   4.65457  3.255e-06
## factor(SALE_MONTH)11   6.102e-03  8.827e-03   0.69129  4.894e-01
## factor(SALE_MONTH)12  -5.749e-03  9.124e-03  -0.63008  5.286e-01
## parkArea01             3.389e-06  5.300e-07   6.39355  1.635e-10
## OSV01KM               -2.850e-10  1.786e-08  -0.01595  9.873e-01
```



```r
osiModel01int = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + fam_income + factor(SALE_MONTH) + parkArea01 * 
    factor(SALE_YEAR) + OSV01KM * factor(SALE_YEAR), data = HouseData)
coef(summary(osiModel01int))[-(5:250), ]
```

```
##                                    Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)                       4.718e+00  2.080e-01  22.6805 2.535e-113
## FIN_SQ_FT                         3.092e-04  3.268e-06  94.6415  0.000e+00
## ACRES_POLY                        4.145e-02  2.080e-03  19.9348  4.397e-88
## YEAR_BUILT                        3.332e-03  1.038e-04  32.0905 1.010e-223
## WhiteDense                        1.955e-01  1.199e-02  16.3070  1.246e-59
## fam_income                        4.612e-06  1.385e-07  33.3142 9.226e-241
## factor(SALE_MONTH)2              -1.328e-02  9.101e-03  -1.4593  1.445e-01
## factor(SALE_MONTH)3               1.415e-02  8.469e-03   1.6710  9.474e-02
## factor(SALE_MONTH)4               8.969e-03  8.300e-03   1.0807  2.798e-01
## factor(SALE_MONTH)5               3.990e-02  8.189e-03   4.8730  1.102e-06
## factor(SALE_MONTH)6               4.535e-02  8.016e-03   5.6566  1.552e-08
## factor(SALE_MONTH)7               4.512e-02  8.305e-03   5.4331  5.563e-08
## factor(SALE_MONTH)8               4.560e-02  8.239e-03   5.5344  3.139e-08
## factor(SALE_MONTH)9               2.785e-02  8.482e-03   3.2828  1.029e-03
## factor(SALE_MONTH)10              4.054e-02  8.549e-03   4.7421  2.121e-06
## factor(SALE_MONTH)11              6.895e-03  8.825e-03   0.7814  4.346e-01
## factor(SALE_MONTH)12             -5.097e-03  9.122e-03  -0.5587  5.763e-01
## parkArea01                        1.230e-06  8.734e-07   1.4086  1.590e-01
## factor(SALE_YEAR)2006             8.975e-04  5.826e-03   0.1540  8.776e-01
## factor(SALE_YEAR)2009            -3.465e-01  7.337e-03 -47.2285  0.000e+00
## factor(SALE_YEAR)2010            -3.776e-01  7.614e-03 -49.5923  0.000e+00
## factor(SALE_YEAR)2011            -5.413e-01  1.417e-02 -38.2120  0.000e+00
## OSV01KM                          -3.872e-08  3.052e-08  -1.2685  2.046e-01
## parkArea01:factor(SALE_YEAR)2006  1.374e-07  1.295e-06   0.1061  9.155e-01
## parkArea01:factor(SALE_YEAR)2009  6.470e-06  1.461e-06   4.4274  9.557e-06
## parkArea01:factor(SALE_YEAR)2010  4.250e-06  1.555e-06   2.7331  6.276e-03
## parkArea01:factor(SALE_YEAR)2011  1.134e-05  3.381e-06   3.3542  7.965e-04
## factor(SALE_YEAR)2006:OSV01KM     5.303e-08  4.293e-08   1.2352  2.168e-01
## factor(SALE_YEAR)2009:OSV01KM    -2.695e-08  4.662e-08  -0.5780  5.633e-01
## factor(SALE_YEAR)2010:OSV01KM     1.468e-07  4.845e-08   3.0297  2.449e-03
## factor(SALE_YEAR)2011:OSV01KM     1.856e-07  1.080e-07   1.7188  8.565e-02
```



Quarter Kilometer
---------



```r
osiModel025KM.1 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    parkArea02, data = HouseData)
# summary(osiModel025KM.1)
coef(summary(osiModel025KM.1))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.695e+00  2.077e-01  22.6021 1.475e-112
## FIN_SQ_FT              3.099e-04  3.264e-06  94.9617  0.000e+00
## ACRES_POLY             4.048e-02  2.007e-03  20.1746  3.678e-90
## YEAR_BUILT             3.345e-03  1.036e-04  32.2855 2.131e-226
## WhiteDense             1.950e-01  1.200e-02  16.2528  3.008e-59
## fam_income             4.603e-06  1.385e-07  33.2424 9.563e-240
## factor(SALE_YEAR)2006  6.272e-03  3.857e-03   1.6262  1.039e-01
## factor(SALE_YEAR)2009 -3.435e-01  5.717e-03 -60.0873  0.000e+00
## factor(SALE_YEAR)2010 -3.615e-01  5.889e-03 -61.3853  0.000e+00
## factor(SALE_YEAR)2011 -5.167e-01  1.027e-02 -50.3011  0.000e+00
## factor(SALE_MONTH)2   -1.384e-02  9.105e-03  -1.5199  1.285e-01
## factor(SALE_MONTH)3    1.339e-02  8.472e-03   1.5807  1.140e-01
## factor(SALE_MONTH)4    8.283e-03  8.303e-03   0.9976  3.185e-01
## factor(SALE_MONTH)5    3.903e-02  8.190e-03   4.7657  1.887e-06
## factor(SALE_MONTH)6    4.456e-02  8.019e-03   5.5576  2.748e-08
## factor(SALE_MONTH)7    4.400e-02  8.308e-03   5.2968  1.183e-07
## factor(SALE_MONTH)8    4.485e-02  8.242e-03   5.4415  5.306e-08
## factor(SALE_MONTH)9    2.718e-02  8.485e-03   3.2026  1.363e-03
## factor(SALE_MONTH)10   3.982e-02  8.552e-03   4.6554  3.241e-06
## factor(SALE_MONTH)11   5.957e-03  8.828e-03   0.6748  4.998e-01
## factor(SALE_MONTH)12  -6.071e-03  9.125e-03  -0.6653  5.058e-01
## parkArea02             2.257e-11  4.996e-12   4.5169  6.290e-06
```



```r
osiModel025KM.2 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + factor(SALE_YEAR) + factor(SALE_MONTH) + parkArea02, 
    data = HouseData)
# summary(osiModel025KM.2)
coef(summary(osiModel025KM.2))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.370e+00  2.097e-01  20.8389  4.833e-96
## FIN_SQ_FT              3.269e-04  3.258e-06 100.3449  0.000e+00
## ACRES_POLY             4.375e-02  2.026e-03  21.5979 5.433e-103
## YEAR_BUILT             3.615e-03  1.044e-04  34.6339 8.047e-260
## WhiteDense             2.599e-01  1.196e-02  21.7279 3.320e-104
## factor(SALE_YEAR)2006  5.137e-03  3.898e-03   1.3178  1.876e-01
## factor(SALE_YEAR)2009 -2.600e-01  5.190e-03 -50.0903  0.000e+00
## factor(SALE_YEAR)2010 -2.777e-01  5.380e-03 -51.6235  0.000e+00
## factor(SALE_YEAR)2011 -4.349e-01  1.008e-02 -43.1437  0.000e+00
## factor(SALE_MONTH)2   -1.491e-02  9.203e-03  -1.6205  1.051e-01
## factor(SALE_MONTH)3    1.288e-02  8.563e-03   1.5046  1.324e-01
## factor(SALE_MONTH)4    8.110e-03  8.392e-03   0.9663  3.339e-01
## factor(SALE_MONTH)5    3.949e-02  8.278e-03   4.7708  1.840e-06
## factor(SALE_MONTH)6    4.585e-02  8.105e-03   5.6572  1.546e-08
## factor(SALE_MONTH)7    4.331e-02  8.397e-03   5.1584  2.500e-07
## factor(SALE_MONTH)8    4.456e-02  8.330e-03   5.3496  8.853e-08
## factor(SALE_MONTH)9    2.753e-02  8.576e-03   3.2104  1.326e-03
## factor(SALE_MONTH)10   3.872e-02  8.644e-03   4.4789  7.518e-06
## factor(SALE_MONTH)11   6.187e-03  8.923e-03   0.6934  4.881e-01
## factor(SALE_MONTH)12  -5.768e-03  9.223e-03  -0.6254  5.317e-01
## parkArea02             2.568e-11  5.049e-12   5.0851  3.687e-07
```



```r
osiModel025KM.3 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    OSV025KM, data = HouseData)
coef(summary(osiModel025KM.3))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.726e+00  2.081e-01  22.7130 1.220e-113
## FIN_SQ_FT              3.095e-04  3.270e-06  94.6465  0.000e+00
## ACRES_POLY             3.904e-02  2.058e-03  18.9639  6.391e-80
## YEAR_BUILT             3.325e-03  1.039e-04  32.0113 1.218e-222
## WhiteDense             1.961e-01  1.200e-02  16.3486  6.325e-60
## fam_income             4.604e-06  1.385e-07  33.2416 9.822e-240
## factor(SALE_YEAR)2006  6.209e-03  3.857e-03   1.6096  1.075e-01
## factor(SALE_YEAR)2009 -3.407e-01  5.677e-03 -60.0139  0.000e+00
## factor(SALE_YEAR)2010 -3.585e-01  5.849e-03 -61.3035  0.000e+00
## factor(SALE_YEAR)2011 -5.134e-01  1.025e-02 -50.0858  0.000e+00
## factor(SALE_MONTH)2   -1.322e-02  9.107e-03  -1.4519  1.465e-01
## factor(SALE_MONTH)3    1.377e-02  8.474e-03   1.6247  1.042e-01
## factor(SALE_MONTH)4    8.499e-03  8.304e-03   1.0235  3.061e-01
## factor(SALE_MONTH)5    3.944e-02  8.192e-03   4.8141  1.483e-06
## factor(SALE_MONTH)6    4.498e-02  8.021e-03   5.6076  2.062e-08
## factor(SALE_MONTH)7    4.447e-02  8.309e-03   5.3522  8.726e-08
## factor(SALE_MONTH)8    4.521e-02  8.244e-03   5.4843  4.170e-08
## factor(SALE_MONTH)9    2.736e-02  8.487e-03   3.2243  1.264e-03
## factor(SALE_MONTH)10   4.001e-02  8.554e-03   4.6781  2.903e-06
## factor(SALE_MONTH)11   6.202e-03  8.830e-03   0.7024  4.824e-01
## factor(SALE_MONTH)12  -5.705e-03  9.127e-03  -0.6251  5.319e-01
## OSV025KM               1.114e-08  3.581e-09   3.1116  1.862e-03
```



```r
osiModel025KM.4 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + factor(SALE_YEAR) + factor(SALE_MONTH) + OSV025KM, 
    data = HouseData)
coef(summary(osiModel025KM.4))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.411e+00  2.101e-01  20.9932  1.952e-97
## FIN_SQ_FT              3.264e-04  3.266e-06  99.9497  0.000e+00
## ACRES_POLY             4.192e-02  2.079e-03  20.1680  4.201e-90
## YEAR_BUILT             3.590e-03  1.047e-04  34.2964 7.039e-255
## WhiteDense             2.613e-01  1.196e-02  21.8410 2.876e-105
## factor(SALE_YEAR)2006  5.057e-03  3.898e-03   1.2973  1.945e-01
## factor(SALE_YEAR)2009 -2.568e-01  5.140e-03 -49.9647  0.000e+00
## factor(SALE_YEAR)2010 -2.744e-01  5.329e-03 -51.4887  0.000e+00
## factor(SALE_YEAR)2011 -4.311e-01  1.005e-02 -42.8809  0.000e+00
## factor(SALE_MONTH)2   -1.417e-02  9.204e-03  -1.5397  1.236e-01
## factor(SALE_MONTH)3    1.334e-02  8.565e-03   1.5575  1.194e-01
## factor(SALE_MONTH)4    8.385e-03  8.393e-03   0.9990  3.178e-01
## factor(SALE_MONTH)5    3.999e-02  8.280e-03   4.8296  1.372e-06
## factor(SALE_MONTH)6    4.637e-02  8.107e-03   5.7203  1.069e-08
## factor(SALE_MONTH)7    4.390e-02  8.399e-03   5.2266  1.734e-07
## factor(SALE_MONTH)8    4.502e-02  8.332e-03   5.4032  6.575e-08
## factor(SALE_MONTH)9    2.778e-02  8.578e-03   3.2388  1.201e-03
## factor(SALE_MONTH)10   3.897e-02  8.645e-03   4.5071  6.586e-06
## factor(SALE_MONTH)11   6.508e-03  8.924e-03   0.7292  4.659e-01
## factor(SALE_MONTH)12  -5.301e-03  9.225e-03  -0.5747  5.655e-01
## OSV025KM               1.410e-08  3.618e-09   3.8974  9.734e-05
```



```r
osiModel025 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    parkArea02 + OSV025KM, data = HouseData)
coef(summary(osiModel025))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.731e+00  2.080e-01  22.7385 6.862e-114
## FIN_SQ_FT              3.093e-04  3.270e-06  94.5610  0.000e+00
## ACRES_POLY             3.910e-02  2.058e-03  19.0001  3.220e-80
## YEAR_BUILT             3.323e-03  1.038e-04  32.0029 1.585e-222
## WhiteDense             1.952e-01  1.200e-02  16.2723  2.190e-59
## fam_income             4.593e-06  1.385e-07  33.1620 1.310e-238
## factor(SALE_YEAR)2006  6.215e-03  3.856e-03   1.6115  1.071e-01
## factor(SALE_YEAR)2009 -3.437e-01  5.717e-03 -60.1263  0.000e+00
## factor(SALE_YEAR)2010 -3.616e-01  5.889e-03 -61.4093  0.000e+00
## factor(SALE_YEAR)2011 -5.165e-01  1.027e-02 -50.2795  0.000e+00
## factor(SALE_MONTH)2   -1.353e-02  9.105e-03  -1.4862  1.372e-01
## factor(SALE_MONTH)3    1.361e-02  8.472e-03   1.6069  1.081e-01
## factor(SALE_MONTH)4    8.506e-03  8.303e-03   1.0245  3.056e-01
## factor(SALE_MONTH)5    3.929e-02  8.190e-03   4.7978  1.609e-06
## factor(SALE_MONTH)6    4.497e-02  8.019e-03   5.6084  2.053e-08
## factor(SALE_MONTH)7    4.436e-02  8.308e-03   5.3400  9.334e-08
## factor(SALE_MONTH)8    4.518e-02  8.242e-03   5.4821  4.222e-08
## factor(SALE_MONTH)9    2.743e-02  8.485e-03   3.2329  1.226e-03
## factor(SALE_MONTH)10   3.998e-02  8.552e-03   4.6752  2.944e-06
## factor(SALE_MONTH)11   6.278e-03  8.828e-03   0.7111  4.770e-01
## factor(SALE_MONTH)12  -5.693e-03  9.125e-03  -0.6238  5.327e-01
## parkArea02             2.219e-11  4.998e-12   4.4401  9.012e-06
## OSV025KM               1.074e-08  3.582e-09   2.9990  2.710e-03
```



```r
osiModel025int = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + fam_income + factor(SALE_MONTH) + parkArea02 * 
    factor(SALE_YEAR) + OSV025KM * factor(SALE_YEAR), data = HouseData)
coef(summary(osiModel025int))[-(5:250), ]
```

```
##                                    Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)                       4.731e+00  2.082e-01  22.7222 9.923e-114
## FIN_SQ_FT                         3.093e-04  3.275e-06  94.4681  0.000e+00
## ACRES_POLY                        3.985e-02  2.094e-03  19.0313  1.783e-80
## YEAR_BUILT                        3.325e-03  1.040e-04  31.9730 4.059e-222
## WhiteDense                        1.950e-01  1.200e-02  16.2584  2.745e-59
## fam_income                        4.584e-06  1.386e-07  33.0743 2.256e-237
## factor(SALE_MONTH)2              -1.283e-02  9.105e-03  -1.4090  1.589e-01
## factor(SALE_MONTH)3               1.405e-02  8.471e-03   1.6583  9.725e-02
## factor(SALE_MONTH)4               9.288e-03  8.302e-03   1.1187  2.633e-01
## factor(SALE_MONTH)5               4.021e-02  8.192e-03   4.9091  9.180e-07
## factor(SALE_MONTH)6               4.562e-02  8.019e-03   5.6893  1.282e-08
## factor(SALE_MONTH)7               4.507e-02  8.308e-03   5.4248  5.829e-08
## factor(SALE_MONTH)8               4.593e-02  8.241e-03   5.5730  2.517e-08
## factor(SALE_MONTH)9               2.812e-02  8.485e-03   3.3143  9.194e-04
## factor(SALE_MONTH)10              4.075e-02  8.552e-03   4.7652  1.892e-06
## factor(SALE_MONTH)11              7.008e-03  8.828e-03   0.7939  4.272e-01
## factor(SALE_MONTH)12             -4.713e-03  9.125e-03  -0.5165  6.055e-01
## parkArea02                        1.587e-07  1.363e-07   1.1644  2.443e-01
## factor(SALE_YEAR)2006             3.216e-03  7.341e-03   0.4380  6.614e-01
## factor(SALE_YEAR)2009            -3.386e-01  8.545e-03 -39.6258  0.000e+00
## factor(SALE_YEAR)2010            -3.772e-01  8.884e-03 -42.4564  0.000e+00
## factor(SALE_YEAR)2011            -5.469e-01  1.619e-02 -33.7798 2.100e-247
## OSV025KM                          2.768e-09  6.310e-09   0.4387  6.609e-01
## parkArea02:factor(SALE_YEAR)2006 -4.451e-08  1.956e-07  -0.2276  8.200e-01
## parkArea02:factor(SALE_YEAR)2009 -1.587e-07  1.363e-07  -1.1642  2.443e-01
## parkArea02:factor(SALE_YEAR)2010 -1.587e-07  1.363e-07  -1.1644  2.443e-01
## parkArea02:factor(SALE_YEAR)2011 -1.586e-07  1.363e-07  -1.1639  2.445e-01
## factor(SALE_YEAR)2006:OSV025KM    4.977e-09  8.426e-09   0.5907  5.548e-01
## factor(SALE_YEAR)2009:OSV025KM   -4.145e-09  8.960e-09  -0.4626  6.436e-01
## factor(SALE_YEAR)2010:OSV025KM    2.716e-08  9.270e-09   2.9293  3.399e-03
## factor(SALE_YEAR)2011:OSV025KM    3.793e-08  1.863e-08   2.0366  4.170e-02
```



Half Kilometer
----------



```r
osiModel05KM.1 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    parkArea05, data = HouseData)
# summary(osiModel05KM.1)
coef(summary(osiModel05KM.1))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.709e+00  2.079e-01  22.6551 4.489e-113
## FIN_SQ_FT              3.100e-04  3.264e-06  94.9634  0.000e+00
## ACRES_POLY             4.073e-02  2.009e-03  20.2748  4.902e-91
## YEAR_BUILT             3.335e-03  1.037e-04  32.1558 1.286e-224
## WhiteDense             1.954e-01  1.200e-02  16.2859  1.754e-59
## fam_income             4.608e-06  1.385e-07  33.2701 3.886e-240
## factor(SALE_YEAR)2006  6.347e-03  3.857e-03   1.6455  9.988e-02
## factor(SALE_YEAR)2009 -3.399e-01  5.680e-03 -59.8445  0.000e+00
## factor(SALE_YEAR)2010 -3.579e-01  5.851e-03 -61.1634  0.000e+00
## factor(SALE_YEAR)2011 -5.131e-01  1.025e-02 -50.0493  0.000e+00
## factor(SALE_MONTH)2   -1.366e-02  9.106e-03  -1.4996  1.337e-01
## factor(SALE_MONTH)3    1.349e-02  8.473e-03   1.5920  1.114e-01
## factor(SALE_MONTH)4    8.186e-03  8.304e-03   0.9858  3.243e-01
## factor(SALE_MONTH)5    3.904e-02  8.191e-03   4.7662  1.883e-06
## factor(SALE_MONTH)6    4.450e-02  8.020e-03   5.5487  2.892e-08
## factor(SALE_MONTH)7    4.402e-02  8.309e-03   5.2979  1.176e-07
## factor(SALE_MONTH)8    4.493e-02  8.243e-03   5.4513  5.023e-08
## factor(SALE_MONTH)9    2.709e-02  8.486e-03   3.1918  1.415e-03
## factor(SALE_MONTH)10   3.984e-02  8.554e-03   4.6583  3.197e-06
## factor(SALE_MONTH)11   5.861e-03  8.829e-03   0.6639  5.068e-01
## factor(SALE_MONTH)12  -5.978e-03  9.126e-03  -0.6550  5.125e-01
## parkArea05             6.883e-08  2.388e-08   2.8821  3.952e-03
```



```r
osiModel05KM.2 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + factor(SALE_YEAR) + factor(SALE_MONTH) + parkArea05, 
    data = HouseData)
# summary(osiModel05KM.2)
coef(summary(osiModel05KM.2))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.387e+00  2.099e-01  20.9064  1.189e-96
## FIN_SQ_FT              3.270e-04  3.259e-06 100.3449  0.000e+00
## ACRES_POLY             4.406e-02  2.028e-03  21.7240 3.608e-104
## YEAR_BUILT             3.603e-03  1.045e-04  34.4801 1.455e-257
## WhiteDense             2.604e-01  1.196e-02  21.7672 1.419e-104
## factor(SALE_YEAR)2006  5.227e-03  3.899e-03   1.3408  1.800e-01
## factor(SALE_YEAR)2009 -2.557e-01  5.140e-03 -49.7545  0.000e+00
## factor(SALE_YEAR)2010 -2.734e-01  5.329e-03 -51.3142  0.000e+00
## factor(SALE_YEAR)2011 -4.307e-01  1.006e-02 -42.8323  0.000e+00
## factor(SALE_MONTH)2   -1.472e-02  9.204e-03  -1.5987  1.099e-01
## factor(SALE_MONTH)3    1.299e-02  8.564e-03   1.5168  1.293e-01
## factor(SALE_MONTH)4    7.993e-03  8.393e-03   0.9523  3.410e-01
## factor(SALE_MONTH)5    3.950e-02  8.279e-03   4.7703  1.845e-06
## factor(SALE_MONTH)6    4.577e-02  8.106e-03   5.6468  1.643e-08
## factor(SALE_MONTH)7    4.332e-02  8.398e-03   5.1588  2.494e-07
## factor(SALE_MONTH)8    4.467e-02  8.332e-03   5.3612  8.303e-08
## factor(SALE_MONTH)9    2.743e-02  8.578e-03   3.1981  1.384e-03
## factor(SALE_MONTH)10   3.875e-02  8.645e-03   4.4820  7.409e-06
## factor(SALE_MONTH)11   6.077e-03  8.924e-03   0.6810  4.959e-01
## factor(SALE_MONTH)12  -5.652e-03  9.224e-03  -0.6127  5.401e-01
## parkArea05             8.347e-08  2.413e-08   3.4585  5.437e-04
```



```r
osiModel05KM.3 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    OSV05KM, data = HouseData)
coef(summary(osiModel05KM.3))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.724e+00  2.080e-01  22.7125 1.234e-113
## FIN_SQ_FT              3.095e-04  3.271e-06  94.6231  0.000e+00
## ACRES_POLY             3.928e-02  2.037e-03  19.2835  1.453e-82
## YEAR_BUILT             3.325e-03  1.038e-04  32.0287 7.043e-223
## WhiteDense             1.958e-01  1.200e-02  16.3212  9.880e-60
## fam_income             4.602e-06  1.385e-07  33.2192 2.034e-239
## factor(SALE_YEAR)2006  6.221e-03  3.857e-03   1.6130  1.068e-01
## factor(SALE_YEAR)2009 -3.405e-01  5.677e-03 -59.9748  0.000e+00
## factor(SALE_YEAR)2010 -3.583e-01  5.848e-03 -61.2592  0.000e+00
## factor(SALE_YEAR)2011 -5.133e-01  1.025e-02 -50.0747  0.000e+00
## factor(SALE_MONTH)2   -1.331e-02  9.106e-03  -1.4621  1.437e-01
## factor(SALE_MONTH)3    1.374e-02  8.473e-03   1.6212  1.050e-01
## factor(SALE_MONTH)4    8.522e-03  8.304e-03   1.0262  3.048e-01
## factor(SALE_MONTH)5    3.938e-02  8.191e-03   4.8077  1.531e-06
## factor(SALE_MONTH)6    4.499e-02  8.020e-03   5.6090  2.046e-08
## factor(SALE_MONTH)7    4.445e-02  8.309e-03   5.3496  8.851e-08
## factor(SALE_MONTH)8    4.519e-02  8.243e-03   5.4821  4.223e-08
## factor(SALE_MONTH)9    2.726e-02  8.486e-03   3.2126  1.316e-03
## factor(SALE_MONTH)10   4.000e-02  8.553e-03   4.6765  2.925e-06
## factor(SALE_MONTH)11   6.149e-03  8.829e-03   0.6965  4.861e-01
## factor(SALE_MONTH)12  -5.684e-03  9.127e-03  -0.6228  5.334e-01
## OSV05KM                2.828e-09  8.368e-10   3.3790  7.281e-04
```



```r
osiModel05KM.4 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + factor(SALE_YEAR) + factor(SALE_MONTH) + OSV05KM, 
    data = HouseData)
coef(summary(osiModel05KM.4))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.409e+00  2.100e-01  20.9937  1.933e-97
## FIN_SQ_FT              3.263e-04  3.266e-06  99.9096  0.000e+00
## ACRES_POLY             4.221e-02  2.057e-03  20.5213  3.303e-93
## YEAR_BUILT             3.590e-03  1.046e-04  34.3105 4.382e-255
## WhiteDense             2.608e-01  1.196e-02  21.8012 6.800e-105
## factor(SALE_YEAR)2006  5.074e-03  3.898e-03   1.3015  1.931e-01
## factor(SALE_YEAR)2009 -2.566e-01  5.138e-03 -49.9297  0.000e+00
## factor(SALE_YEAR)2010 -2.741e-01  5.327e-03 -51.4482  0.000e+00
## factor(SALE_YEAR)2011 -4.311e-01  1.005e-02 -42.8742  0.000e+00
## factor(SALE_MONTH)2   -1.428e-02  9.204e-03  -1.5520  1.207e-01
## factor(SALE_MONTH)3    1.331e-02  8.564e-03   1.5536  1.203e-01
## factor(SALE_MONTH)4    8.418e-03  8.393e-03   1.0030  3.159e-01
## factor(SALE_MONTH)5    3.992e-02  8.279e-03   4.8219  1.426e-06
## factor(SALE_MONTH)6    4.639e-02  8.106e-03   5.7229  1.053e-08
## factor(SALE_MONTH)7    4.387e-02  8.398e-03   5.2241  1.757e-07
## factor(SALE_MONTH)8    4.500e-02  8.332e-03   5.4011  6.653e-08
## factor(SALE_MONTH)9    2.766e-02  8.577e-03   3.2244  1.263e-03
## factor(SALE_MONTH)10   3.895e-02  8.645e-03   4.5056  6.633e-06
## factor(SALE_MONTH)11   6.446e-03  8.924e-03   0.7223  4.701e-01
## factor(SALE_MONTH)12  -5.268e-03  9.225e-03  -0.5711  5.679e-01
## OSV05KM                3.625e-09  8.454e-10   4.2874  1.811e-05
```



```r
osiModel05 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    parkArea05 + OSV05KM, data = HouseData)
coef(summary(osiModel05))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.738e+00  2.081e-01  22.7707 3.323e-114
## FIN_SQ_FT              3.093e-04  3.271e-06  94.5772  0.000e+00
## ACRES_POLY             3.963e-02  2.042e-03  19.4074  1.337e-83
## YEAR_BUILT             3.317e-03  1.039e-04  31.9315 1.490e-221
## WhiteDense             1.953e-01  1.200e-02  16.2846  1.793e-59
## fam_income             4.597e-06  1.385e-07  33.1818 6.873e-239
## factor(SALE_YEAR)2006  6.294e-03  3.857e-03   1.6318  1.027e-01
## factor(SALE_YEAR)2009 -3.400e-01  5.679e-03 -59.8645  0.000e+00
## factor(SALE_YEAR)2010 -3.579e-01  5.851e-03 -61.1656  0.000e+00
## factor(SALE_YEAR)2011 -5.129e-01  1.025e-02 -50.0319  0.000e+00
## factor(SALE_MONTH)2   -1.344e-02  9.106e-03  -1.4759  1.400e-01
## factor(SALE_MONTH)3    1.367e-02  8.473e-03   1.6139  1.066e-01
## factor(SALE_MONTH)4    8.426e-03  8.304e-03   1.0147  3.103e-01
## factor(SALE_MONTH)5    3.925e-02  8.191e-03   4.7922  1.655e-06
## factor(SALE_MONTH)6    4.490e-02  8.020e-03   5.5981  2.178e-08
## factor(SALE_MONTH)7    4.434e-02  8.309e-03   5.3370  9.489e-08
## factor(SALE_MONTH)8    4.522e-02  8.243e-03   5.4858  4.136e-08
## factor(SALE_MONTH)9    2.724e-02  8.486e-03   3.2097  1.329e-03
## factor(SALE_MONTH)10   3.999e-02  8.553e-03   4.6752  2.944e-06
## factor(SALE_MONTH)11   6.115e-03  8.829e-03   0.6926  4.885e-01
## factor(SALE_MONTH)12  -5.623e-03  9.126e-03  -0.6161  5.378e-01
## parkArea05             5.874e-08  2.411e-08   2.4359  1.486e-02
## OSV05KM                2.541e-09  8.450e-10   3.0075  2.636e-03
```



```r
osiModel05int = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + fam_income + factor(SALE_MONTH) + parkArea05 * 
    factor(SALE_YEAR) + OSV05KM * factor(SALE_YEAR), data = HouseData)
coef(summary(osiModel05int))[-(5:250), ]
```

```
##                                    Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)                       4.746e+00  2.080e-01  22.8151 1.216e-114
## FIN_SQ_FT                         3.096e-04  3.272e-06  94.6327  0.000e+00
## ACRES_POLY                        4.001e-02  2.053e-03  19.4866  2.886e-84
## YEAR_BUILT                        3.318e-03  1.039e-04  31.9412 1.099e-221
## WhiteDense                        1.935e-01  1.200e-02  16.1278  2.270e-58
## fam_income                        4.586e-06  1.386e-07  33.0839 1.653e-237
## factor(SALE_MONTH)2              -1.297e-02  9.102e-03  -1.4254  1.540e-01
## factor(SALE_MONTH)3               1.419e-02  8.469e-03   1.6752  9.389e-02
## factor(SALE_MONTH)4               9.592e-03  8.301e-03   1.1555  2.479e-01
## factor(SALE_MONTH)5               4.054e-02  8.189e-03   4.9508  7.416e-07
## factor(SALE_MONTH)6               4.586e-02  8.017e-03   5.7208  1.066e-08
## factor(SALE_MONTH)7               4.535e-02  8.305e-03   5.4602  4.778e-08
## factor(SALE_MONTH)8               4.602e-02  8.239e-03   5.5854  2.344e-08
## factor(SALE_MONTH)9               2.825e-02  8.482e-03   3.3306  8.671e-04
## factor(SALE_MONTH)10              4.094e-02  8.549e-03   4.7891  1.680e-06
## factor(SALE_MONTH)11              7.414e-03  8.826e-03   0.8401  4.009e-01
## factor(SALE_MONTH)12             -4.480e-03  9.123e-03  -0.4911  6.234e-01
## parkArea05                        2.250e-08  3.859e-08   0.5830  5.599e-01
## factor(SALE_YEAR)2006            -2.477e-04  8.121e-03  -0.0305  9.757e-01
## factor(SALE_YEAR)2009            -3.573e-01  9.711e-03 -36.7890 1.870e-292
## factor(SALE_YEAR)2010            -3.803e-01  1.031e-02 -36.8971 3.844e-294
## factor(SALE_YEAR)2011            -5.967e-01  1.906e-02 -31.3090 3.685e-213
## OSV05KM                           3.455e-10  1.371e-09   0.2519  8.011e-01
## parkArea05:factor(SALE_YEAR)2006 -5.125e-08  5.436e-08  -0.9428  3.458e-01
## parkArea05:factor(SALE_YEAR)2009  2.370e-07  6.281e-08   3.7739  1.609e-04
## parkArea05:factor(SALE_YEAR)2010 -3.747e-08  6.548e-08  -0.5723  5.671e-01
## parkArea05:factor(SALE_YEAR)2011  5.812e-07  1.252e-07   4.6406  3.483e-06
## factor(SALE_YEAR)2006:OSV05KM     2.657e-09  1.818e-09   1.4619  1.438e-01
## factor(SALE_YEAR)2009:OSV05KM     5.255e-10  2.031e-09   0.2587  7.958e-01
## factor(SALE_YEAR)2010:OSV05KM     6.537e-09  2.140e-09   3.0543  2.257e-03
## factor(SALE_YEAR)2011:OSV05KM     1.410e-08  4.223e-09   3.3388  8.421e-04
```


One Kilometer
---------



```r
osiModel1KM.1 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    parkArea10, data = HouseData)
# summary(osiModel1KM.1)
coef(summary(osiModel1KM.1))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.689e+00  2.078e-01  22.5696 3.059e-112
## FIN_SQ_FT              3.102e-04  3.264e-06  95.0478  0.000e+00
## ACRES_POLY             4.047e-02  2.008e-03  20.1523  5.749e-90
## YEAR_BUILT             3.347e-03  1.037e-04  32.2884 1.944e-226
## WhiteDense             1.959e-01  1.200e-02  16.3203  1.003e-59
## fam_income             4.614e-06  1.386e-07  33.3006 1.437e-240
## factor(SALE_YEAR)2006  6.268e-03  3.857e-03   1.6250  1.042e-01
## factor(SALE_YEAR)2009 -3.404e-01  5.677e-03 -59.9652  0.000e+00
## factor(SALE_YEAR)2010 -3.584e-01  5.849e-03 -61.2697  0.000e+00
## factor(SALE_YEAR)2011 -5.136e-01  1.025e-02 -50.1019  0.000e+00
## factor(SALE_MONTH)2   -1.354e-02  9.107e-03  -1.4872  1.370e-01
## factor(SALE_MONTH)3    1.354e-02  8.474e-03   1.5973  1.102e-01
## factor(SALE_MONTH)4    8.265e-03  8.305e-03   0.9952  3.197e-01
## factor(SALE_MONTH)5    3.916e-02  8.192e-03   4.7803  1.755e-06
## factor(SALE_MONTH)6    4.455e-02  8.020e-03   5.5553  2.786e-08
## factor(SALE_MONTH)7    4.410e-02  8.309e-03   5.3072  1.118e-07
## factor(SALE_MONTH)8    4.486e-02  8.244e-03   5.4421  5.289e-08
## factor(SALE_MONTH)9    2.709e-02  8.487e-03   3.1924  1.412e-03
## factor(SALE_MONTH)10   3.984e-02  8.554e-03   4.6575  3.208e-06
## factor(SALE_MONTH)11   5.865e-03  8.830e-03   0.6642  5.066e-01
## factor(SALE_MONTH)12  -6.100e-03  9.127e-03  -0.6683  5.039e-01
## parkArea10             1.136e-09  8.020e-09   0.1417  8.873e-01
```



```r
osiModel1KM.2 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + factor(SALE_YEAR) + factor(SALE_MONTH) + parkArea10, 
    data = HouseData)
# summary(osiModel05KM.2)
coef(summary(osiModel1KM.2))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.366e+00  2.098e-01  20.8133  8.196e-96
## FIN_SQ_FT              3.272e-04  3.258e-06 100.4303  0.000e+00
## ACRES_POLY             4.384e-02  2.027e-03  21.6209 3.317e-103
## YEAR_BUILT             3.615e-03  1.045e-04  34.6103 1.791e-259
## WhiteDense             2.607e-01  1.197e-02  21.7788 1.106e-104
## factor(SALE_YEAR)2006  5.135e-03  3.899e-03   1.3170  1.879e-01
## factor(SALE_YEAR)2009 -2.563e-01  5.139e-03 -49.8768  0.000e+00
## factor(SALE_YEAR)2010 -2.740e-01  5.329e-03 -51.4222  0.000e+00
## factor(SALE_YEAR)2011 -4.313e-01  1.006e-02 -42.8876  0.000e+00
## factor(SALE_MONTH)2   -1.464e-02  9.205e-03  -1.5909  1.116e-01
## factor(SALE_MONTH)3    1.302e-02  8.565e-03   1.5202  1.285e-01
## factor(SALE_MONTH)4    8.059e-03  8.394e-03   0.9601  3.370e-01
## factor(SALE_MONTH)5    3.960e-02  8.280e-03   4.7820  1.741e-06
## factor(SALE_MONTH)6    4.588e-02  8.107e-03   5.6591  1.530e-08
## factor(SALE_MONTH)7    4.340e-02  8.399e-03   5.1669  2.388e-07
## factor(SALE_MONTH)8    4.458e-02  8.332e-03   5.3498  8.845e-08
## factor(SALE_MONTH)9    2.742e-02  8.578e-03   3.1966  1.392e-03
## factor(SALE_MONTH)10   3.874e-02  8.646e-03   4.4810  7.445e-06
## factor(SALE_MONTH)11   6.053e-03  8.925e-03   0.6782  4.976e-01
## factor(SALE_MONTH)12  -5.811e-03  9.225e-03  -0.6299  5.287e-01
## parkArea10             1.052e-08  8.101e-09   1.2983  1.942e-01
```



```r
osiModel1KM.3 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    OSV1KM, data = HouseData)
coef(summary(osiModel1KM.3))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.702e+00  2.079e-01  22.6207 9.710e-113
## FIN_SQ_FT              3.099e-04  3.268e-06  94.8190  0.000e+00
## ACRES_POLY             3.994e-02  2.025e-03  19.7293  2.537e-86
## YEAR_BUILT             3.338e-03  1.037e-04  32.1745 7.143e-225
## WhiteDense             1.959e-01  1.200e-02  16.3265  9.069e-60
## fam_income             4.609e-06  1.385e-07  33.2710 3.763e-240
## factor(SALE_YEAR)2006  6.260e-03  3.857e-03   1.6228  1.046e-01
## factor(SALE_YEAR)2009 -3.404e-01  5.677e-03 -59.9661  0.000e+00
## factor(SALE_YEAR)2010 -3.584e-01  5.849e-03 -61.2701  0.000e+00
## factor(SALE_YEAR)2011 -5.135e-01  1.025e-02 -50.0946  0.000e+00
## factor(SALE_MONTH)2   -1.341e-02  9.107e-03  -1.4721  1.410e-01
## factor(SALE_MONTH)3    1.364e-02  8.474e-03   1.6102  1.074e-01
## factor(SALE_MONTH)4    8.372e-03  8.304e-03   1.0081  3.134e-01
## factor(SALE_MONTH)5    3.932e-02  8.192e-03   4.7993  1.597e-06
## factor(SALE_MONTH)6    4.470e-02  8.020e-03   5.5738  2.504e-08
## factor(SALE_MONTH)7    4.423e-02  8.309e-03   5.3228  1.026e-07
## factor(SALE_MONTH)8    4.498e-02  8.244e-03   5.4563  4.884e-08
## factor(SALE_MONTH)9    2.713e-02  8.487e-03   3.1972  1.389e-03
## factor(SALE_MONTH)10   3.990e-02  8.554e-03   4.6643  3.105e-06
## factor(SALE_MONTH)11   5.939e-03  8.830e-03   0.6726  5.012e-01
## factor(SALE_MONTH)12  -5.940e-03  9.127e-03  -0.6509  5.151e-01
## OSV1KM                 3.468e-10  1.786e-10   1.9414  5.222e-02
```



```r
osiModel1KM.4 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + factor(SALE_YEAR) + factor(SALE_MONTH) + OSV1KM, 
    data = HouseData)
coef(summary(osiModel1KM.4))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.381e+00  2.099e-01  20.8773  2.180e-96
## FIN_SQ_FT              3.268e-04  3.263e-06 100.1496  0.000e+00
## ACRES_POLY             4.300e-02  2.044e-03  21.0339  8.346e-98
## YEAR_BUILT             3.605e-03  1.045e-04  34.4844 1.261e-257
## WhiteDense             2.610e-01  1.196e-02  21.8165 4.883e-105
## factor(SALE_YEAR)2006  5.120e-03  3.899e-03   1.3132  1.891e-01
## factor(SALE_YEAR)2009 -2.564e-01  5.139e-03 -49.8920  0.000e+00
## factor(SALE_YEAR)2010 -2.740e-01  5.328e-03 -51.4344  0.000e+00
## factor(SALE_YEAR)2011 -4.312e-01  1.005e-02 -42.8830  0.000e+00
## factor(SALE_MONTH)2   -1.439e-02  9.205e-03  -1.5630  1.181e-01
## factor(SALE_MONTH)3    1.320e-02  8.565e-03   1.5412  1.233e-01
## factor(SALE_MONTH)4    8.239e-03  8.394e-03   0.9816  3.263e-01
## factor(SALE_MONTH)5    3.986e-02  8.280e-03   4.8137  1.486e-06
## factor(SALE_MONTH)6    4.605e-02  8.106e-03   5.6808  1.348e-08
## factor(SALE_MONTH)7    4.360e-02  8.399e-03   5.1917  2.091e-07
## factor(SALE_MONTH)8    4.474e-02  8.332e-03   5.3700  7.907e-08
## factor(SALE_MONTH)9    2.750e-02  8.578e-03   3.2055  1.349e-03
## factor(SALE_MONTH)10   3.883e-02  8.646e-03   4.4906  7.118e-06
## factor(SALE_MONTH)11   6.185e-03  8.925e-03   0.6931  4.883e-01
## factor(SALE_MONTH)12  -5.576e-03  9.225e-03  -0.6044  5.456e-01
## OSV1KM                 4.896e-10  1.805e-10   2.7128  6.674e-03
```



```r
osiModel1 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    parkArea10 + OSV1KM, data = HouseData)
coef(summary(osiModel1))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.702e+00  2.079e-01  22.6188 1.014e-112
## FIN_SQ_FT              3.099e-04  3.268e-06  94.8181  0.000e+00
## ACRES_POLY             3.992e-02  2.028e-03  19.6807  6.576e-86
## YEAR_BUILT             3.338e-03  1.038e-04  32.1727 7.554e-225
## WhiteDense             1.959e-01  1.200e-02  16.3257  9.189e-60
## fam_income             4.609e-06  1.386e-07  33.2600 5.387e-240
## factor(SALE_YEAR)2006  6.259e-03  3.857e-03   1.6226  1.047e-01
## factor(SALE_YEAR)2009 -3.404e-01  5.677e-03 -59.9657  0.000e+00
## factor(SALE_YEAR)2010 -3.583e-01  5.849e-03 -61.2677  0.000e+00
## factor(SALE_YEAR)2011 -5.135e-01  1.025e-02 -50.0937  0.000e+00
## factor(SALE_MONTH)2   -1.339e-02  9.107e-03  -1.4707  1.414e-01
## factor(SALE_MONTH)3    1.365e-02  8.474e-03   1.6109  1.072e-01
## factor(SALE_MONTH)4    8.378e-03  8.305e-03   1.0089  3.130e-01
## factor(SALE_MONTH)5    3.933e-02  8.192e-03   4.8003  1.589e-06
## factor(SALE_MONTH)6    4.470e-02  8.020e-03   5.5734  2.511e-08
## factor(SALE_MONTH)7    4.423e-02  8.309e-03   5.3234  1.023e-07
## factor(SALE_MONTH)8    4.498e-02  8.244e-03   5.4565  4.878e-08
## factor(SALE_MONTH)9    2.714e-02  8.487e-03   3.1976  1.387e-03
## factor(SALE_MONTH)10   3.990e-02  8.554e-03   4.6643  3.104e-06
## factor(SALE_MONTH)11   5.945e-03  8.830e-03   0.6732  5.008e-01
## factor(SALE_MONTH)12  -5.936e-03  9.127e-03  -0.6504  5.155e-01
## parkArea10            -1.514e-09  8.134e-09  -0.1861  8.524e-01
## OSV1KM                 3.524e-10  1.812e-10   1.9451  5.177e-02
```



```r
osiModel1int = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + fam_income + factor(SALE_MONTH) + parkArea10 * 
    factor(SALE_YEAR) + OSV1KM * factor(SALE_YEAR), data = HouseData)
coef(summary(osiModel1int))[-(5:250), ]
```

```
##                                    Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)                       4.723e+00  2.078e-01  22.7243 9.456e-114
## FIN_SQ_FT                         3.100e-04  3.269e-06  94.8279  0.000e+00
## ACRES_POLY                        3.993e-02  2.033e-03  19.6348  1.615e-85
## YEAR_BUILT                        3.333e-03  1.038e-04  32.1259 3.304e-224
## WhiteDense                        1.952e-01  1.200e-02  16.2656  2.442e-59
## fam_income                        4.598e-06  1.387e-07  33.1545 1.669e-238
## factor(SALE_MONTH)2              -1.283e-02  9.104e-03  -1.4092  1.588e-01
## factor(SALE_MONTH)3               1.411e-02  8.470e-03   1.6655  9.582e-02
## factor(SALE_MONTH)4               9.259e-03  8.302e-03   1.1152  2.648e-01
## factor(SALE_MONTH)5               4.052e-02  8.191e-03   4.9471  7.556e-07
## factor(SALE_MONTH)6               4.544e-02  8.018e-03   5.6670  1.461e-08
## factor(SALE_MONTH)7               4.527e-02  8.306e-03   5.4494  5.076e-08
## factor(SALE_MONTH)8               4.580e-02  8.241e-03   5.5578  2.745e-08
## factor(SALE_MONTH)9               2.804e-02  8.484e-03   3.3050  9.503e-04
## factor(SALE_MONTH)10              4.072e-02  8.551e-03   4.7616  1.926e-06
## factor(SALE_MONTH)11              7.032e-03  8.827e-03   0.7967  4.256e-01
## factor(SALE_MONTH)12             -4.907e-03  9.125e-03  -0.5377  5.908e-01
## parkArea10                       -3.115e-08  1.215e-08  -2.5628  1.039e-02
## factor(SALE_YEAR)2006            -2.377e-03  8.810e-03  -0.2698  7.873e-01
## factor(SALE_YEAR)2009            -3.641e-01  1.070e-02 -34.0428 3.392e-251
## factor(SALE_YEAR)2010            -3.727e-01  1.130e-02 -32.9949 2.948e-236
## factor(SALE_YEAR)2011            -6.152e-01  2.072e-02 -29.6916 4.257e-192
## OSV1KM                            2.779e-10  2.865e-10   0.9699  3.321e-01
## parkArea10:factor(SALE_YEAR)2006  7.454e-09  1.620e-08   0.4601  6.455e-01
## parkArea10:factor(SALE_YEAR)2009  8.781e-08  1.895e-08   4.6338  3.599e-06
## parkArea10:factor(SALE_YEAR)2010  2.812e-08  1.934e-08   1.4538  1.460e-01
## parkArea10:factor(SALE_YEAR)2011  2.034e-07  3.558e-08   5.7182  1.082e-08
## factor(SALE_YEAR)2006:OSV1KM      3.229e-10  3.651e-10   0.8843  3.766e-01
## factor(SALE_YEAR)2009:OSV1KM     -2.461e-10  4.211e-10  -0.5844  5.590e-01
## factor(SALE_YEAR)2010:OSV1KM      2.461e-10  4.376e-10   0.5624  5.739e-01
## factor(SALE_YEAR)2011:OSV1KM      2.004e-09  8.536e-10   2.3476  1.890e-02
```



Two Kilometer
--------



```r
osiModel2KM.1 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    parkArea20, data = HouseData)
# summary(osiModel2KM.1)
coef(summary(osiModel2KM.1))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.699e+00  2.078e-01  22.6149 1.107e-112
## FIN_SQ_FT              3.105e-04  3.265e-06  95.1130  0.000e+00
## ACRES_POLY             4.025e-02  2.008e-03  20.0448  4.934e-89
## YEAR_BUILT             3.349e-03  1.036e-04  32.3229 6.521e-227
## WhiteDense             1.970e-01  1.200e-02  16.4163  2.087e-60
## fam_income             4.623e-06  1.385e-07  33.3828 9.793e-242
## factor(SALE_YEAR)2006  6.228e-03  3.857e-03   1.6146  1.064e-01
## factor(SALE_YEAR)2009 -3.402e-01  5.678e-03 -59.9123  0.000e+00
## factor(SALE_YEAR)2010 -3.580e-01  5.849e-03 -61.2083  0.000e+00
## factor(SALE_YEAR)2011 -5.134e-01  1.025e-02 -50.0819  0.000e+00
## factor(SALE_MONTH)2   -1.338e-02  9.106e-03  -1.4695  1.417e-01
## factor(SALE_MONTH)3    1.361e-02  8.473e-03   1.6068  1.081e-01
## factor(SALE_MONTH)4    8.411e-03  8.304e-03   1.0129  3.111e-01
## factor(SALE_MONTH)5    3.916e-02  8.191e-03   4.7813  1.747e-06
## factor(SALE_MONTH)6    4.448e-02  8.020e-03   5.5470  2.921e-08
## factor(SALE_MONTH)7    4.413e-02  8.309e-03   5.3115  1.092e-07
## factor(SALE_MONTH)8    4.485e-02  8.243e-03   5.4405  5.337e-08
## factor(SALE_MONTH)9    2.707e-02  8.486e-03   3.1902  1.422e-03
## factor(SALE_MONTH)10   3.974e-02  8.554e-03   4.6463  3.387e-06
## factor(SALE_MONTH)11   5.902e-03  8.829e-03   0.6685  5.038e-01
## factor(SALE_MONTH)12  -5.968e-03  9.126e-03  -0.6540  5.131e-01
## parkArea20            -8.479e-09  2.842e-09  -2.9836  2.850e-03
```



```r
osiModel2KM.2 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + factor(SALE_YEAR) + factor(SALE_MONTH) + parkArea20, 
    data = HouseData)
# summary(osiModel2KM.2)
coef(summary(osiModel2KM.2))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.369e+00  2.098e-01  20.8294  5.875e-96
## FIN_SQ_FT              3.276e-04  3.260e-06 100.4918  0.000e+00
## ACRES_POLY             4.358e-02  2.027e-03  21.4966 4.752e-102
## YEAR_BUILT             3.621e-03  1.044e-04  34.6774 1.844e-260
## WhiteDense             2.621e-01  1.197e-02  21.8988 8.192e-106
## factor(SALE_YEAR)2006  5.096e-03  3.899e-03   1.3072  1.912e-01
## factor(SALE_YEAR)2009 -2.559e-01  5.141e-03 -49.7777  0.000e+00
## factor(SALE_YEAR)2010 -2.735e-01  5.330e-03 -51.3139  0.000e+00
## factor(SALE_YEAR)2011 -4.308e-01  1.006e-02 -42.8450  0.000e+00
## factor(SALE_MONTH)2   -1.445e-02  9.205e-03  -1.5703  1.163e-01
## factor(SALE_MONTH)3    1.311e-02  8.565e-03   1.5304  1.259e-01
## factor(SALE_MONTH)4    8.202e-03  8.394e-03   0.9772  3.285e-01
## factor(SALE_MONTH)5    3.965e-02  8.280e-03   4.7883  1.687e-06
## factor(SALE_MONTH)6    4.579e-02  8.106e-03   5.6485  1.627e-08
## factor(SALE_MONTH)7    4.345e-02  8.399e-03   5.1730  2.313e-07
## factor(SALE_MONTH)8    4.457e-02  8.332e-03   5.3487  8.898e-08
## factor(SALE_MONTH)9    2.743e-02  8.578e-03   3.1974  1.388e-03
## factor(SALE_MONTH)10   3.867e-02  8.646e-03   4.4720  7.765e-06
## factor(SALE_MONTH)11   6.113e-03  8.925e-03   0.6849  4.934e-01
## factor(SALE_MONTH)12  -5.697e-03  9.225e-03  -0.6176  5.369e-01
## parkArea20            -6.549e-09  2.872e-09  -2.2803  2.259e-02
```



```r
osiModel2KM.3 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    OSV2KM, data = HouseData)
coef(summary(osiModel2KM.3))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.694e+00  2.078e-01  22.5909 1.897e-112
## FIN_SQ_FT              3.101e-04  3.265e-06  94.9904  0.000e+00
## ACRES_POLY             4.023e-02  2.015e-03  19.9665  2.344e-88
## YEAR_BUILT             3.342e-03  1.037e-04  32.2316 1.174e-225
## WhiteDense             1.959e-01  1.200e-02  16.3307  8.460e-60
## fam_income             4.617e-06  1.385e-07  33.3380 4.235e-241
## factor(SALE_YEAR)2006  6.259e-03  3.857e-03   1.6227  1.047e-01
## factor(SALE_YEAR)2009 -3.406e-01  5.678e-03 -59.9808  0.000e+00
## factor(SALE_YEAR)2010 -3.585e-01  5.850e-03 -61.2852  0.000e+00
## factor(SALE_YEAR)2011 -5.137e-01  1.025e-02 -50.1087  0.000e+00
## factor(SALE_MONTH)2   -1.345e-02  9.107e-03  -1.4772  1.396e-01
## factor(SALE_MONTH)3    1.359e-02  8.474e-03   1.6040  1.087e-01
## factor(SALE_MONTH)4    8.277e-03  8.304e-03   0.9967  3.189e-01
## factor(SALE_MONTH)5    3.923e-02  8.192e-03   4.7887  1.683e-06
## factor(SALE_MONTH)6    4.462e-02  8.020e-03   5.5639  2.652e-08
## factor(SALE_MONTH)7    4.417e-02  8.309e-03   5.3163  1.064e-07
## factor(SALE_MONTH)8    4.489e-02  8.243e-03   5.4458  5.180e-08
## factor(SALE_MONTH)9    2.712e-02  8.487e-03   3.1952  1.398e-03
## factor(SALE_MONTH)10   3.987e-02  8.554e-03   4.6611  3.153e-06
## factor(SALE_MONTH)11   5.874e-03  8.830e-03   0.6653  5.059e-01
## factor(SALE_MONTH)12  -6.045e-03  9.127e-03  -0.6623  5.078e-01
## OSV2KM                 5.662e-11  4.219e-11   1.3421  1.796e-01
```



```r
osiModel2KM.4 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + factor(SALE_YEAR) + factor(SALE_MONTH) + OSV2KM, 
    data = HouseData)
coef(summary(osiModel2KM.4))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.366e+00  2.098e-01  20.8126  8.325e-96
## FIN_SQ_FT              3.272e-04  3.259e-06 100.4145  0.000e+00
## ACRES_POLY             4.356e-02  2.034e-03  21.4162 2.633e-101
## YEAR_BUILT             3.615e-03  1.045e-04  34.6001 2.530e-259
## WhiteDense             2.612e-01  1.196e-02  21.8336 3.372e-105
## factor(SALE_YEAR)2006  5.122e-03  3.899e-03   1.3137  1.889e-01
## factor(SALE_YEAR)2009 -2.563e-01  5.139e-03 -49.8715  0.000e+00
## factor(SALE_YEAR)2010 -2.740e-01  5.329e-03 -51.4152  0.000e+00
## factor(SALE_YEAR)2011 -4.312e-01  1.006e-02 -42.8789  0.000e+00
## factor(SALE_MONTH)2   -1.451e-02  9.205e-03  -1.5762  1.150e-01
## factor(SALE_MONTH)3    1.309e-02  8.565e-03   1.5283  1.264e-01
## factor(SALE_MONTH)4    8.099e-03  8.394e-03   0.9648  3.346e-01
## factor(SALE_MONTH)5    3.970e-02  8.280e-03   4.7939  1.640e-06
## factor(SALE_MONTH)6    4.589e-02  8.107e-03   5.6612  1.512e-08
## factor(SALE_MONTH)7    4.348e-02  8.399e-03   5.1766  2.268e-07
## factor(SALE_MONTH)8    4.460e-02  8.333e-03   5.3528  8.698e-08
## factor(SALE_MONTH)9    2.746e-02  8.579e-03   3.2011  1.370e-03
## factor(SALE_MONTH)10   3.877e-02  8.646e-03   4.4835  7.359e-06
## factor(SALE_MONTH)11   6.091e-03  8.925e-03   0.6825  4.950e-01
## factor(SALE_MONTH)12  -5.757e-03  9.225e-03  -0.6241  5.326e-01
## OSV2KM                 4.318e-11  4.264e-11   1.0128  3.112e-01
```



```r
osiModel2 = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + fam_income + factor(SALE_YEAR) + factor(SALE_MONTH) + 
    parkArea20 + OSV2KM, data = HouseData)
coef(summary(osiModel2))[-(5:250), ]
```

```
##                         Estimate Std. Error  t value   Pr(>|t|)
## (Intercept)            4.707e+00  2.078e-01  22.6507 4.961e-113
## FIN_SQ_FT              3.104e-04  3.266e-06  95.0542  0.000e+00
## ACRES_POLY             3.989e-02  2.017e-03  19.7757  1.019e-86
## YEAR_BUILT             3.342e-03  1.037e-04  32.2350 1.053e-225
## WhiteDense             1.972e-01  1.200e-02  16.4282  1.719e-60
## fam_income             4.627e-06  1.385e-07  33.4055 4.658e-242
## factor(SALE_YEAR)2006  6.212e-03  3.857e-03   1.6105  1.073e-01
## factor(SALE_YEAR)2009 -3.403e-01  5.678e-03 -59.9352  0.000e+00
## factor(SALE_YEAR)2010 -3.582e-01  5.850e-03 -61.2315  0.000e+00
## factor(SALE_YEAR)2011 -5.135e-01  1.025e-02 -50.0897  0.000e+00
## factor(SALE_MONTH)2   -1.325e-02  9.106e-03  -1.4548  1.457e-01
## factor(SALE_MONTH)3    1.370e-02  8.473e-03   1.6167  1.059e-01
## factor(SALE_MONTH)4    8.439e-03  8.304e-03   1.0163  3.095e-01
## factor(SALE_MONTH)5    3.925e-02  8.191e-03   4.7922  1.655e-06
## factor(SALE_MONTH)6    4.458e-02  8.020e-03   5.5591  2.726e-08
## factor(SALE_MONTH)7    4.424e-02  8.309e-03   5.3244  1.017e-07
## factor(SALE_MONTH)8    4.489e-02  8.243e-03   5.4455  5.189e-08
## factor(SALE_MONTH)9    2.710e-02  8.486e-03   3.1935  1.406e-03
## factor(SALE_MONTH)10   3.977e-02  8.553e-03   4.6501  3.326e-06
## factor(SALE_MONTH)11   5.915e-03  8.829e-03   0.6699  5.029e-01
## factor(SALE_MONTH)12  -5.878e-03  9.126e-03  -0.6441  5.195e-01
## parkArea20            -9.402e-09  2.884e-09  -3.2601  1.114e-03
## OSV2KM                 8.040e-11  4.281e-11   1.8782  6.036e-02
```



```r
osiModel2int = lm(logPRICE ~ FIN_SQ_FT + ACRES_POLY + YEAR_BUILT + HomeStyle + 
    ELEMENTARY + WhiteDense + fam_income + factor(SALE_MONTH) + parkArea20 * 
    factor(SALE_YEAR) + OSV2KM * factor(SALE_YEAR), data = HouseData)
coef(summary(osiModel2int))[-(5:250), ]
```

```
##                                    Estimate Std. Error   t value
## (Intercept)                       4.736e+00  2.079e-01  22.78376
## FIN_SQ_FT                         3.106e-04  3.266e-06  95.13053
## ACRES_POLY                        3.993e-02  2.019e-03  19.77716
## YEAR_BUILT                        3.334e-03  1.037e-04  32.15681
## WhiteDense                        1.958e-01  1.200e-02  16.31470
## fam_income                        4.621e-06  1.386e-07  33.34251
## factor(SALE_MONTH)2              -1.289e-02  9.103e-03  -1.41584
## factor(SALE_MONTH)3               1.364e-02  8.470e-03   1.61090
## factor(SALE_MONTH)4               8.943e-03  8.301e-03   1.07734
## factor(SALE_MONTH)5               3.983e-02  8.191e-03   4.86233
## factor(SALE_MONTH)6               4.495e-02  8.017e-03   5.60608
## factor(SALE_MONTH)7               4.466e-02  8.306e-03   5.37730
## factor(SALE_MONTH)8               4.526e-02  8.241e-03   5.49245
## factor(SALE_MONTH)9               2.755e-02  8.484e-03   3.24717
## factor(SALE_MONTH)10              4.006e-02  8.551e-03   4.68551
## factor(SALE_MONTH)11              6.267e-03  8.827e-03   0.70999
## factor(SALE_MONTH)12             -5.200e-03  9.124e-03  -0.56989
## parkArea20                       -1.557e-08  3.981e-09  -3.91184
## factor(SALE_YEAR)2006             1.006e-02  1.023e-02   0.98347
## factor(SALE_YEAR)2009            -3.695e-01  1.261e-02 -29.30717
## factor(SALE_YEAR)2010            -3.777e-01  1.318e-02 -28.66308
## factor(SALE_YEAR)2011            -6.393e-01  2.473e-02 -25.85527
## OSV2KM                            6.710e-11  6.427e-11   1.04402
## parkArea20:factor(SALE_YEAR)2006 -3.039e-09  5.020e-09  -0.60538
## parkArea20:factor(SALE_YEAR)2009  2.454e-08  6.062e-09   4.04839
## parkArea20:factor(SALE_YEAR)2010  8.349e-09  6.263e-09   1.33309
## parkArea20:factor(SALE_YEAR)2011  5.248e-08  1.223e-08   4.29103
## factor(SALE_YEAR)2006:OSV2KM      1.354e-12  7.736e-11   0.01751
## factor(SALE_YEAR)2009:OSV2KM     -5.174e-11  8.910e-11  -0.58061
## factor(SALE_YEAR)2010:OSV2KM      7.014e-11  9.217e-11   0.76103
## factor(SALE_YEAR)2011:OSV2KM      5.887e-10  1.821e-10   3.23265
##                                    Pr(>|t|)
## (Intercept)                      2.472e-114
## FIN_SQ_FT                         0.000e+00
## ACRES_POLY                        9.897e-87
## YEAR_BUILT                       1.248e-224
## WhiteDense                        1.099e-59
## fam_income                       3.659e-241
## factor(SALE_MONTH)2               1.568e-01
## factor(SALE_MONTH)3               1.072e-01
## factor(SALE_MONTH)4               2.813e-01
## factor(SALE_MONTH)5               1.164e-06
## factor(SALE_MONTH)6               2.080e-08
## factor(SALE_MONTH)7               7.594e-08
## factor(SALE_MONTH)8               3.983e-08
## factor(SALE_MONTH)9               1.166e-03
## factor(SALE_MONTH)10              2.800e-06
## factor(SALE_MONTH)11              4.777e-01
## factor(SALE_MONTH)12              5.688e-01
## parkArea20                        9.171e-05
## factor(SALE_YEAR)2006             3.254e-01
## factor(SALE_YEAR)2009            3.004e-187
## factor(SALE_YEAR)2010            2.910e-179
## factor(SALE_YEAR)2011            1.865e-146
## OSV2KM                            2.965e-01
## parkArea20:factor(SALE_YEAR)2006  5.449e-01
## parkArea20:factor(SALE_YEAR)2009  5.165e-05
## parkArea20:factor(SALE_YEAR)2010  1.825e-01
## parkArea20:factor(SALE_YEAR)2011  1.782e-05
## factor(SALE_YEAR)2006:OSV2KM      9.860e-01
## factor(SALE_YEAR)2009:OSV2KM      5.615e-01
## factor(SALE_YEAR)2010:OSV2KM      4.466e-01
## factor(SALE_YEAR)2011:OSV2KM      1.227e-03
```

