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

write.csv(dat, "data-raw/r72_input1.csv", row.names=FALSE)

  df_out = dat %>% filter(d != 0) %>% group_by(a, b) %>% summarise(mean_d = mean(d))

write.csv(df_out, "data-raw/r72_output1.csv", row.names=FALSE)

r72_output1 <- read.csv("data-raw/r72_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r72_output1, is.factor)
int.cols <- sapply(r72_output1, is.integer)

r72_output1[, fctr.cols] <- sapply(r72_output1[, fctr.cols], as.character)
r72_output1[, int.cols] <- sapply(r72_output1[, int.cols], as.numeric)
save(r72_output1, file = "data/r72_output1.rdata")

r72_input1 <- read.csv("data-raw/r72_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r72_input1, is.factor)
int.cols <- sapply(r72_input1, is.integer)

r72_input1[, fctr.cols] <- sapply(r72_input1[, fctr.cols], as.character)
r72_input1[, int.cols] <- sapply(r72_input1[, int.cols], as.numeric)
save(r72_input1, file = "data/r72_input1.rdata")
