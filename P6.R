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

p6_output1 <- read.csv("data-raw/p6_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p6_output1, is.factor)
int.cols <- sapply(p6_output1, is.integer)

p6_output1[, fctr.cols] <- sapply(p6_output1[, fctr.cols], as.character)
p6_output1[, int.cols] <- sapply(p6_output1[, int.cols], as.numeric)
save(p6_output1, file = "data/p6_output1.rdata")

p6_input1 <- read.csv("data-raw/p6_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p6_input1, is.factor)
int.cols <- sapply(p6_input1, is.integer)

p6_input1[, fctr.cols] <- sapply(p6_input1[, fctr.cols], as.character)
p6_input1[, int.cols] <- sapply(p6_input1[, int.cols], as.numeric)
save(p6_input1, file = "data/p6_input1.rdata")
