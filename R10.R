# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
r10_output1 <- read.csv("data-raw/r10_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r10_output1, is.factor)
int.cols <- sapply(r10_output1, is.integer)

r10_output1[, fctr.cols] <- sapply(r10_output1[, fctr.cols], as.character)
r10_output1[, int.cols] <- sapply(r10_output1[, int.cols], as.numeric)
save(r10_output1, file = "data/r10_output1.rdata")

r10_input1 <- read.csv("data-raw/r10_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r10_input1, is.factor)
int.cols <- sapply(r10_input1, is.integer)

r10_input1[, fctr.cols] <- sapply(r10_input1[, fctr.cols], as.character)
r10_input1[, int.cols] <- sapply(r10_input1[, int.cols], as.numeric)
save(r10_input1, file = "data/r10_input1.rdata")


