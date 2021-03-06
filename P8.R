# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"Name     Month  Rate1     Rate2
Aira       1      12        23
Aira       2      18        73
Ben        1      53        19
Ben        2      22        87
Cat        1      22        87
Cat        2      67        43
", header=T)

write.csv(dat, "data-raw/p8_input1.csv", row.names=FALSE)

a1 = group_by(dat, Name) %>% summarize(avg1=mean(Rate1))
a2 = group_by(dat, Name) %>% summarize(avg2=mean(Rate2))
df_out = inner_join(a1,a2)

write.csv(df_out, "data-raw/p8_output1.csv", row.names=FALSE)

p8_output1 <- read.csv("data-raw/p8_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p8_output1, is.factor)
int.cols <- sapply(p8_output1, is.integer)

p8_output1[, fctr.cols] <- sapply(p8_output1[, fctr.cols], as.character)
p8_output1[, int.cols] <- sapply(p8_output1[, int.cols], as.numeric)
save(p8_output1, file = "data/p8_output1.rdata")

p8_input1 <- read.csv("data-raw/p8_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p8_input1, is.factor)
int.cols <- sapply(p8_input1, is.integer)

p8_input1[, fctr.cols] <- sapply(p8_input1[, fctr.cols], as.character)
p8_input1[, int.cols] <- sapply(p8_input1[, int.cols], as.numeric)
save(p8_input1, file = "data/p8_input1.rdata")
