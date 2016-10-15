# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
scotland_weather <- data.frame(
    Jan = c(294, 292, 276),
    Year.1 = c(1993, 1928, 2008),
    Feb = c(278, 259, 245),
    Year.2 = c(1990, 1997, 2002)
)

# split it into two data frames
df1 <- scotland_weather[seq(1, 4, 2)]
df2 <- scotland_weather[seq(2, 4, 2)]

write.csv(df1, "data-raw/p17_input1.csv", row.names=FALSE)
write.csv(df2, "data-raw/p17_input2.csv", row.names=FALSE)


month=gather(df1, month, rainfall)
year=gather(df2, yearId, year)
tmp=cbind(year, month)
df_out = select(tmp,-yearId)

write.csv(df_out, "data-raw/p17_output1.csv", row.names=FALSE)

output1 <- read.csv("data-raw/p17_output1.csv", check.names = FALSE)
fctr.cols <- sapply(output1, is.factor)
int.cols <- sapply(output1, is.integer)

output1[, fctr.cols] <- sapply(output1[, fctr.cols], as.character)
output1[, int.cols] <- sapply(output1[, int.cols], as.numeric)
save(output1, file = "data/p17_output1.rdata")

input1 <- read.csv("data-raw/p17_input1.csv", check.names = FALSE)
fctr.cols <- sapply(input1, is.factor)
int.cols <- sapply(input1, is.integer)

input1[, fctr.cols] <- sapply(input1[, fctr.cols], as.character)
input1[, int.cols] <- sapply(input1[, int.cols], as.numeric)
save(input1, file = "data/p17_input1.rdata")


input2 <- read.csv("data-raw/p17_input2.csv", check.names = FALSE)
fctr.cols <- sapply(input2, is.factor)
int.cols <- sapply(input2, is.integer)

input2[, fctr.cols] <- sapply(input2[, fctr.cols], as.character)
input2[, int.cols] <- sapply(input2[, int.cols], as.numeric)
save(input2, file = "data/p17_input2.rdata")
