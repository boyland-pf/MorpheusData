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

write.csv(dat, "data-raw/r63_input1.csv", row.names=FALSE)

df_out = dat %>% group_by(qs,Ans) %>% 
summarize(total=n()) %>% 
mutate(frac=total/sum(total)) %>% select(-total) %>% spread(Ans,frac)

write.csv(df_out, "data-raw/r63_output1.csv", row.names=FALSE)

r63_output1 <- read.csv("data-raw/r63_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r63_output1, is.factor)
int.cols <- sapply(r63_output1, is.integer)

r63_output1[, fctr.cols] <- sapply(r63_output1[, fctr.cols], as.character)
r63_output1[, int.cols] <- sapply(r63_output1[, int.cols], as.numeric)
save(r63_output1, file = "data/r63_output1.rdata")

r63_input1 <- read.csv("data-raw/r63_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r63_input1, is.factor)
int.cols <- sapply(r63_input1, is.integer)

r63_input1[, fctr.cols] <- sapply(r63_input1[, fctr.cols], as.character)
r63_input1[, int.cols] <- sapply(r63_input1[, int.cols], as.numeric)
save(r63_input1, file = "data/r63_input1.rdata")
