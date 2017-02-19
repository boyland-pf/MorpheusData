# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
r1_output1 <- read.csv("data-raw/r1_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r1_output1, is.factor)
int.cols <- sapply(r1_output1, is.integer)

r1_output1[, fctr.cols] <- sapply(r1_output1[, fctr.cols], as.character)
r1_output1[, int.cols] <- sapply(r1_output1[, int.cols], as.numeric)
save(r1_output1, file = "data/r1_output1.rdata")

r1_input1 <- read.csv("data-raw/r1_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r1_input1, is.factor)
int.cols <- sapply(r1_input1, is.integer)

r1_input1[, fctr.cols] <- sapply(r1_input1[, fctr.cols], as.character)
r1_input1[, int.cols] <- sapply(r1_input1[, int.cols], as.numeric)
save(r1_input1, file = "data/r1_input1.rdata")


