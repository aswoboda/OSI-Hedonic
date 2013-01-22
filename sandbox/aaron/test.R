# This is a test file. 
# 1) It loads the data, 
# 2) asks a couple basic questions about the data
# 3) makes a couple figures,
# 4) runs a simple regression and summarizes the regression results


require(foreign)

HouseData = read.dbf("../Data/DataFromARCMAP.dbf")

str(HouseData)

summary(HouseData)

names(HouseData)

hist(HouseData$SALE_VALUE)
hist(log(HouseData$SALE_VALUE))

pdf("figures/summaryHists.pdf", width = 10, height = 8)
  hist(HouseData$SALE_VALUE)
  hist(log(HouseData$SALE_VALUE))
  hist(HouseData$FIN_SQ_FT)
  plot(HouseData$EMV_TOTAL, HouseData$SALE_VALUE)
dev.off()

regression1 = lm(SALE_VALUE ~ FIN_SQ_FT + twokmSUM, data = HouseData)
summary(regression1)
