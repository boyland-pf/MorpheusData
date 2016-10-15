# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"id  type    transactions    amount
20  income       20          100
20  expense      25          95
30  income       50          300
30  expense      45          250
", header=T)

write.csv(dat, "data-raw/p13_input1.csv", row.names=FALSE)

df_out = dat %>% gather(var, val, transactions:amount) %>% 
unite(var2, type, var) %>% 
spread(var2, val)

write.csv(df_out, "data-raw/p13_output1.csv", row.names=FALSE)

output1 <- read.csv("data-raw/p13_output1.csv", check.names = FALSE)
fctr.cols <- sapply(output1, is.factor)
int.cols <- sapply(output1, is.integer)

output1[, fctr.cols] <- sapply(output1[, fctr.cols], as.character)
output1[, int.cols] <- sapply(output1[, int.cols], as.numeric)
save(output1, file = "data/p13_output1.rdata")

input1 <- read.csv("data-raw/p13_input1.csv", check.names = FALSE)
fctr.cols <- sapply(input1, is.factor)
int.cols <- sapply(input1, is.integer)

input1[, fctr.cols] <- sapply(input1[, fctr.cols], as.character)
input1[, int.cols] <- sapply(input1[, int.cols], as.numeric)
save(input1, file = "data/p13_input1.rdata")
