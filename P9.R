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
summarize(Freq = sum(Frequency))

write.csv(df_out, "data-raw/p9_output1.csv", row.names=FALSE)

p9_output1 <- read.csv("data-raw/p9_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p9_output1, is.factor)
int.cols <- sapply(p9_output1, is.integer)

p9_output1[, fctr.cols] <- sapply(p9_output1[, fctr.cols], as.character)
p9_output1[, int.cols] <- sapply(p9_output1[, int.cols], as.numeric)
save(p9_output1, file = "data/p9_output1.rdata")

p9_input1 <- read.csv("data-raw/p9_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p9_input1, is.factor)
int.cols <- sapply(p9_input1, is.integer)

p9_input1[, fctr.cols] <- sapply(p9_input1[, fctr.cols], as.character)
p9_input1[, int.cols] <- sapply(p9_input1[, int.cols], as.numeric)
save(p9_input1, file = "data/p9_input1.rdata")
