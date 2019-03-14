# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
demo_output1 <- read.csv("data-raw/demo_output1.csv", check.names = FALSE)
fctr.cols <- sapply(demo_output1, is.factor)
int.cols <- sapply(demo_output1, is.integer)

demo_output1[, fctr.cols] <- sapply(demo_output1[, fctr.cols], as.character)
demo_output1[, int.cols] <- sapply(demo_output1[, int.cols], as.numeric)
save(demo_output1, file = "data/demo_output1.rdata")

demo_input1 <- read.csv("data-raw/demo_input1.csv", check.names = FALSE)
fctr.cols <- sapply(demo_input1, is.factor)
int.cols <- sapply(demo_input1, is.integer)

demo_input1[, fctr.cols] <- sapply(demo_input1[, fctr.cols], as.character)
demo_input1[, int.cols] <- sapply(demo_input1[, int.cols], as.numeric)
save(demo_input1, file = "data/demo_input1.rdata")


