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



write.csv(dat, "data-raw/p56_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(var, val, HR:a) %>%
  unite(v1, posture, var) %>%
  spread(v1, val)

write.csv(df_out, "data-raw/p56_output1.csv", row.names=FALSE)

p56_output1 <- read.csv("data-raw/p56_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p56_output1, is.factor)
int.cols <- sapply(p56_output1, is.integer)

p56_output1[, fctr.cols] <- sapply(p56_output1[, fctr.cols], as.character)
p56_output1[, int.cols] <- sapply(p56_output1[, int.cols], as.numeric)
save(p56_output1, file = "data/p56_output1.rdata")

p56_input1 <- read.csv("data-raw/p56_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p56_input1, is.factor)
int.cols <- sapply(p56_input1, is.integer)

p56_input1[, fctr.cols] <- sapply(p56_input1[, fctr.cols], as.character)
p56_input1[, int.cols] <- sapply(p56_input1[, int.cols], as.numeric)
save(p56_input1, file = "data/p56_input1.rdata")
