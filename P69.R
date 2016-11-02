# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"Category              qs Ans
       Cat1           Q1.a-Some-Text   1
       Cat2           Q1.b-Some-Text   2
       Cat2           Q1.a-Some-Text   2
       Cat2           Q1.a-Some-Text   1
       Cat1           Q1.b-Some-Text   1
       Cat2           Q1.a-Some-Text   1
       Cat1           Q1.b-Some-Text   2
       Cat1           Q1.a-Some-Text   2
       Cat2           Q1.b-Some-Text   1
", header=T)

write.csv(dat, "data-raw/p69_input1.csv", row.names=FALSE)

df_out = dat %>% group_by(qs,Ans) %>% 
summarize(total=n()) %>% 
mutate(frac=total/sum(total)) %>% select(-total) %>% spread(Ans,frac)

write.csv(df_out, "data-raw/p69_output1.csv", row.names=FALSE)

p69_output1 <- read.csv("data-raw/p69_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p69_output1, is.factor)
int.cols <- sapply(p69_output1, is.integer)

p69_output1[, fctr.cols] <- sapply(p69_output1[, fctr.cols], as.character)
p69_output1[, int.cols] <- sapply(p69_output1[, int.cols], as.numeric)
save(p69_output1, file = "data/p69_output1.rdata")

p69_input1 <- read.csv("data-raw/p69_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p69_input1, is.factor)
int.cols <- sapply(p69_input1, is.integer)

p69_input1[, fctr.cols] <- sapply(p69_input1[, fctr.cols], as.character)
p69_input1[, int.cols] <- sapply(p69_input1[, int.cols], as.numeric)
save(p69_input1, file = "data/p69_input1.rdata")
