# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)
library(data.table)
#############benchmark 84
set.seed(14592)

dat <- read.table(text=
 " a    b       d
     1    1       0
     1    1       200
     1    1       300
     1    1       0
     1    1       600
     1    2       0
     1    2       100
     1    2       200
     1    3       0",header=T)

write.csv(dat, "data-raw/p84_input1.csv", row.names=FALSE)

  df_out = dat %>% filter(d != 0) %>% group_by(a, b) %>% summarise(mean_d = mean(d))

write.csv(df_out, "data-raw/p84_output1.csv", row.names=FALSE)

p84_output1 <- read.csv("data-raw/p84_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p84_output1, is.factor)
int.cols <- sapply(p84_output1, is.integer)

p84_output1[, fctr.cols] <- sapply(p84_output1[, fctr.cols], as.character)
p84_output1[, int.cols] <- sapply(p84_output1[, int.cols], as.numeric)
save(p84_output1, file = "data/p84_output1.rdata")

p84_input1 <- read.csv("data-raw/p84_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p84_input1, is.factor)
int.cols <- sapply(p84_input1, is.integer)

p84_input1[, fctr.cols] <- sapply(p84_input1[, fctr.cols], as.character)
p84_input1[, int.cols] <- sapply(p84_input1[, int.cols], as.numeric)
save(p84_input1, file = "data/p84_input1.rdata")
