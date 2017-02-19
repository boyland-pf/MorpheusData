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
", header=T)

write.csv(dat, "data-raw/r24_input1.csv", row.names=FALSE)

df_out = dat %>% gather(year, value, yr1:yr4) %>% filter(year != "yr1" ) %>% select(-year) %>% arrange(id)

write.csv(df_out, "data-raw/r24_output1.csv", row.names=FALSE)

r24_output1 <- read.csv("data-raw/r24_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r24_output1, is.factor)
int.cols <- sapply(r24_output1, is.integer)

r24_output1[, fctr.cols] <- sapply(r24_output1[, fctr.cols], as.character)
r24_output1[, int.cols] <- sapply(r24_output1[, int.cols], as.numeric)
save(r24_output1, file = "data/r24_output1.rdata")

r24_input1 <- read.csv("data-raw/r24_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r24_input1, is.factor)
int.cols <- sapply(r24_input1, is.integer)

r24_input1[, fctr.cols] <- sapply(r24_input1[, fctr.cols], as.character)
r24_input1[, int.cols] <- sapply(r24_input1[, int.cols], as.numeric)
save(r24_input1, file = "data/r24_input1.rdata")
