# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
p1_output1 <- read.csv("data-raw/p1_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p1_output1, is.factor)
int.cols <- sapply(p1_output1, is.integer)

p1_output1[, fctr.cols] <- sapply(p1_output1[, fctr.cols], as.character)
p1_output1[, int.cols] <- sapply(p1_output1[, int.cols], as.numeric)
save(p1_output1, file = "data/p1_output1.rdata")

p1_input1 <- read.csv("data-raw/p1_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p1_input1, is.factor)
int.cols <- sapply(p1_input1, is.integer)

p1_input1[, fctr.cols] <- sapply(p1_input1[, fctr.cols], as.character)
p1_input1[, int.cols] <- sapply(p1_input1[, int.cols], as.numeric)
save(p1_input1, file = "data/p1_input1.rdata")


