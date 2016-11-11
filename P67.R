# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)
library(data.table)

#############benchmark 1
dat <- read.table(text=
" id time
   1    1
   3    1
   3    2
   3    3
   2    1
   4    1
   4    2
   4    3
   2    2
", header=T)
  

write.csv(dat, "data-raw/p67_input1.csv", row.names=FALSE)

df_out=dat %>% group_by(id) %>% summarise(total=n()) %>% filter(total > 2) %>% select(-total) %>% inner_join(dat)

write.csv(df_out, "data-raw/p67_output1.csv", row.names=FALSE)

p67_output1 <- read.csv("data-raw/p67_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p67_output1, is.factor)
int.cols <- sapply(p67_output1, is.integer)

p67_output1[, fctr.cols] <- sapply(p67_output1[, fctr.cols], as.character)
p67_output1[, int.cols] <- sapply(p67_output1[, int.cols], as.numeric)
save(p67_output1, file = "data/p67_output1.rdata")

p67_input1 <- read.csv("data-raw/p67_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p67_input1, is.factor)
int.cols <- sapply(p67_input1, is.integer)

p67_input1[, fctr.cols] <- sapply(p67_input1[, fctr.cols], as.character)
p67_input1[, int.cols] <- sapply(p67_input1[, int.cols], as.numeric)
save(p67_input1, file = "data/p67_input1.rdata")
