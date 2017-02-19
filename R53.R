# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 56
dat <- read.table(text=
"
  posture code HR EE  a   
  cycling A03 102 100 3   
  standing A03 99  99  4  
  sitting A03 98  67  5  
  walking A03 97  78  3 
  cycling B01 111 76  5
  standing B01 100 88  4
  sitting B01 78  34  4
  walking B01 99  99  2
", header=T)



write.csv(dat, "data-raw/r53_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(var, val, HR:a) %>%
  unite(v1, posture, var) %>%
  spread(v1, val)

write.csv(df_out, "data-raw/r53_output1.csv", row.names=FALSE)

r53_output1 <- read.csv("data-raw/r53_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r53_output1, is.factor)
int.cols <- sapply(r53_output1, is.integer)

r53_output1[, fctr.cols] <- sapply(r53_output1[, fctr.cols], as.character)
r53_output1[, int.cols] <- sapply(r53_output1[, int.cols], as.numeric)
save(r53_output1, file = "data/r53_output1.rdata")

r53_input1 <- read.csv("data-raw/r53_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r53_input1, is.factor)
int.cols <- sapply(r53_input1, is.integer)

r53_input1[, fctr.cols] <- sapply(r53_input1[, fctr.cols], as.character)
r53_input1[, int.cols] <- sapply(r53_input1[, int.cols], as.numeric)
save(r53_input1, file = "data/r53_input1.rdata")
