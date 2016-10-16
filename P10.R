# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
p10_output1 <- read.csv("data-raw/p10_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p10_output1, is.factor)
int.cols <- sapply(p10_output1, is.integer)

p10_output1[, fctr.cols] <- sapply(p10_output1[, fctr.cols], as.character)
p10_output1[, int.cols] <- sapply(p10_output1[, int.cols], as.numeric)
save(p10_output1, file = "data/p10_output1.rdata")

p10_input1 <- read.csv("data-raw/p10_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p10_input1, is.factor)
int.cols <- sapply(p10_input1, is.integer)

p10_input1[, fctr.cols] <- sapply(p10_input1[, fctr.cols], as.character)
p10_input1[, int.cols] <- sapply(p10_input1[, int.cols], as.numeric)
save(p10_input1, file = "data/p10_input1.rdata")


