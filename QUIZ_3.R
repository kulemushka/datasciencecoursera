setwd("~/Documents/Experiments_2014/Coursera_R_programing")
### Question 1
if(!file.exists("./Quiz_3")){dir.create("./Quiz_3")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "
download.file(fileUrl,destfile="./Quiz_3/microdata.csv",method="curl")
microData <- read.csv("./Quiz_3/microdata.csv")
head(microData, n=3)
summary(microData)
str(microData)

microData[(microData$ACR ==3 & microData$AGS ==6),]
agricultureLogical<- microData$ACR ==3 & microData$AGS ==6
answer_1 <- which(agricultureLogical)[1:3]
answer_1

#2
install.packages("jpeg")
library(jpeg)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(url,destfile="./Quiz_3/jeff.jpg",method="curl")
img <- readJPEG("./Quiz_3/jeff.jpg", native = TRUE)
quantile(img, probs = c(0.3, 0.8))

#3
install.packages("data.table")
library(data.table)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl,destfile="./Quiz_3/FGDP.csv",method="curl")
FGDP_Data <- data.table(read.csv("./Quiz_3/FGDP.csv", , skip=4, nrows=215))
head(FGDP_Data,2)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl,destfile="./Quiz_3/FEDSTATS_country.csv",method="curl")
FEDSTATS_country <- data.table(read.csv("./Quiz_3/FEDSTATS_country.csv"))

head(FEDSTATS_country,2)
names(FGDP_Data)
names(FEDSTATS_country)
intersect(names(FGDP_Data), names(FEDSTATS_country))

FGDP_Data <- FGDP_Data[X != ""]
names(FGDP_Data)
FGDP_Data <- FGDP_Data[, list(X, X.1, X.3, X.4)]
setnames(FGDP_Data, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))
names(FGDP_Data)
mergeDS <- merge(FGDP_Data, FEDSTATS_country, all=TRUE, by=c("CountryCode"))
sum(!is.na(unique(mergeDS$rankingGDP)))
library(plyr)
mergeDS<- arrange(mergeDS, desc(rankingGDP))
mergeDS[13,]

#4

tapply(mergeDS$rankingGDP,mergeDS$Income.Group,mean, na.rm =TRUE)

#5
quantile(mergeDS$rankingGDP,probs=c(0, 1, 0.2, 0.5,0.75,0.9), na.rm=TRUE)
breaks <- quantile(mergeDS$rankingGDP, probs = seq(0, 1, 0.2), na.rm = TRUE)
breaks
mergeDS$quantileGDP <- cut(mergeDS$rankingGDP, breaks = breaks)
table <- table(mergeDS$quantileGDP, mergeDS$Income.Group)
table
