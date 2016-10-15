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

p17_output1 <- read.csv("data-raw/p17_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p17_output1, is.factor)
int.cols <- sapply(p17_output1, is.integer)

p17_output1[, fctr.cols] <- sapply(p17_output1[, fctr.cols], as.character)
p17_output1[, int.cols] <- sapply(p17_output1[, int.cols], as.numeric)
save(p17_output1, file = "data/p17_output1.rdata")

p17_input1 <- read.csv("data-raw/p17_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p17_input1, is.factor)
int.cols <- sapply(p17_input1, is.integer)

p17_input1[, fctr.cols] <- sapply(p17_input1[, fctr.cols], as.character)
p17_input1[, int.cols] <- sapply(p17_input1[, int.cols], as.numeric)
save(p17_input1, file = "data/p17_input1.rdata")


p17_input2 <- read.csv("data-raw/p17_input2.csv", check.names = FALSE)
fctr.cols <- sapply(p17_input2, is.factor)
int.cols <- sapply(p17_input2, is.integer)

p17_input2[, fctr.cols] <- sapply(p17_input2[, fctr.cols], as.character)
p17_input2[, int.cols] <- sapply(p17_input2[, int.cols], as.numeric)
save(p17_input2, file = "data/p17_input2.rdata")
