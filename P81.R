# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 81
dat <- read.table(text="
Subject Var1 Var2
A-pre   25   27   
A-post   25   26  
B-pre   30   28   
B-post   30   28", header=T)

write.csv(dat, "data-raw/p81_input1.csv", row.names=FALSE)

df_out = dat %>% 
   separate(Subject, into=c('SubjectNew', 'New')) %>%
   gather(Var, Val, Var1,Var2)%>% 
   unite(VarNew, Var, New) %>% 
   spread(VarNew, Val)

write.csv(df_out, "data-raw/p81_output1.csv", row.names=FALSE)

p81_output1 <- read.csv("data-raw/p81_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p81_output1, is.factor)
int.cols <- sapply(p81_output1, is.integer)

p81_output1[, fctr.cols] <- sapply(p81_output1[, fctr.cols], as.character)
p81_output1[, int.cols] <- sapply(p81_output1[, int.cols], as.numeric)
save(p81_output1, file = "data/p81_output1.rdata")

p81_input1 <- read.csv("data-raw/p81_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p81_input1, is.factor)
int.cols <- sapply(p81_input1, is.integer)

p81_input1[, fctr.cols] <- sapply(p81_input1[, fctr.cols], as.character)
p81_input1[, int.cols] <- sapply(p81_input1[, int.cols], as.numeric)
save(p81_input1, file = "data/p81_input1.rdata")
