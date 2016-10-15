# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"Category     Frequency
First        10
First        15
First        5
Second       2
Third        14
Third        20
Second       3
", header=T)

write.csv(dat, "data-raw/p9_input1.csv", row.names=FALSE)

df_out = dat %>% group_by(Category) %>% 
summarize(Frequency = sum(Frequency))

write.csv(df_out, "data-raw/p9_output1.csv", row.names=FALSE)

output1 <- read.csv("data-raw/p9_output1.csv", check.names = FALSE)
fctr.cols <- sapply(output1, is.factor)
int.cols <- sapply(output1, is.integer)

output1[, fctr.cols] <- sapply(output1[, fctr.cols], as.character)
output1[, int.cols] <- sapply(output1[, int.cols], as.numeric)
save(output1, file = "data/p9_output1.rdata")

input1 <- read.csv("data-raw/p9_input1.csv", check.names = FALSE)
fctr.cols <- sapply(input1, is.factor)
int.cols <- sapply(input1, is.integer)

input1[, fctr.cols] <- sapply(input1[, fctr.cols], as.character)
input1[, int.cols] <- sapply(input1[, int.cols], as.numeric)
save(input1, file = "data/p9_input1.rdata")
