# 


require(foreign)

HouseData = read.dbf("../Data/DataFromARCMAP.dbf")

str(HouseData)
summary(HouseData)
names(HouseData)

# Create date variables: year of sale, calendar month of sale, and then 
HouseData$SALE_YEAR = 1900 + as.POSIXlt(HouseData$SALE_DATE)$year
HouseData$SALE_MONTH = 1 + as.POSIXlt(HouseData$SALE_DATE)$mon
HouseData$YEARMON = 12*(HouseData$SALE_YEAR - 2009) + HouseData$SALE_MONTH # number of months since january 1, 2009

table(HouseData$SALE_YEAR)
table(HouseData$YEARMON)


plot(HouseData$SALE_DATE, log(HouseData$SALE_VALUE), cex = .25)
summary(lm(SALE_VALUE ~ factor(SALE_YEAR) + factor(SALE_MONTH), data = HouseData))

model1 = lm(HouseData$SALE_VALUE ~ factor(YEARMON)-1)

plot(model1$coefficients, 
     type = "l") #,
     log = "y")

