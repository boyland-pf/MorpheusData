# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"id  yr1  yr2  yr3  yr4   var
1 1090 2066 3050 4012 yr3
2 1026 2062 3071 4026 yr2
3 1036 2006 3098 4038 yr1
4 1056 2020 3037 4001 yr4
5 1088 2017 3075 4037 yr3
6 1019 2065 3089 4083 yr4
7 1085 2036 3020 4032 yr1
8 1096 2072 3061 4045 yr3
", header=T)

write.csv(dat, "data-raw/p24_input1.csv", row.names=FALSE)

df_out = dat %>% gather(year, value, yr1:yr4) %>% filter(var == year) %>% select(-year) %>% arrange(id)

write.csv(df_out, "data-raw/p24_output1.csv", row.names=FALSE)

p24_output1 <- read.csv("data-raw/p24_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p24_output1, is.factor)
int.cols <- sapply(p24_output1, is.integer)

p24_output1[, fctr.cols] <- sapply(p24_output1[, fctr.cols], as.character)
p24_output1[, int.cols] <- sapply(p24_output1[, int.cols], as.numeric)
save(p24_output1, file = "data/p24_output1.rdata")

p24_input1 <- read.csv("data-raw/p24_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p24_input1, is.factor)
int.cols <- sapply(p24_input1, is.integer)

p24_input1[, fctr.cols] <- sapply(p24_input1[, fctr.cols], as.character)
p24_input1[, int.cols] <- sapply(p24_input1[, int.cols], as.numeric)
save(p24_input1, file = "data/p24_input1.rdata")
