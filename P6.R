# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"country   attitude   count  
china   a   52  
china   b   58  
india   b   28  
india   c   13  
england e   18  
england f   3  
usa         e   10  
usa         f   3 
", header=T)

write.csv(dat, "data-raw/p6_input1.csv", row.names=FALSE)

df_out = dat %>% group_by(attitude) %>%
summarize(sum1=sum(count))

write.csv(df_out, "data-raw/p6_output1.csv", row.names=FALSE)

output1 <- read.csv("data-raw/p6_output1.csv", check.names = FALSE)
fctr.cols <- sapply(output1, is.factor)
int.cols <- sapply(output1, is.integer)

output1[, fctr.cols] <- sapply(output1[, fctr.cols], as.character)
output1[, int.cols] <- sapply(output1[, int.cols], as.numeric)
save(output1, file = "data/p6_output1.rdata")

input1 <- read.csv("data-raw/p6_input1.csv", check.names = FALSE)
fctr.cols <- sapply(input1, is.factor)
int.cols <- sapply(input1, is.integer)

input1[, fctr.cols] <- sapply(input1[, fctr.cols], as.character)
input1[, int.cols] <- sapply(input1[, int.cols], as.numeric)
save(input1, file = "data/p6_input1.rdata")
