# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
idx_key upedonid
k1 id2
k2 id2
k3 id2
k4 null
k5 id3
k6 id3
k7 id4
k8 id5
k9 id5
k10 null
k11 id6
", header=T)

write.csv(dat, "data-raw/f1_input1.csv", row.names=FALSE)

df_out = dat %>% 
    group_by(upedonid) %>% summarise(cnt=n()) %>% filter(upedonid != 'null' & cnt > 1)

write.csv(df_out, "data-raw/f1_output1.csv", row.names=FALSE)

f1_output1 <- read.csv("data-raw/f1_output1.csv", check.names = FALSE)
fctr.cols <- sapply(f1_output1, is.factor)
int.cols <- sapply(f1_output1, is.integer)

f1_output1[, fctr.cols] <- sapply(f1_output1[, fctr.cols], as.character)
f1_output1[, int.cols] <- sapply(f1_output1[, int.cols], as.numeric)
save(f1_output1, file = "data/f1_output1.rdata")

f1_input1 <- read.csv("data-raw/f1_input1.csv", check.names = FALSE)
fctr.cols <- sapply(f1_input1, is.factor)
int.cols <- sapply(f1_input1, is.integer)

f1_input1[, fctr.cols] <- sapply(f1_input1[, fctr.cols], as.character)
f1_input1[, int.cols] <- sapply(f1_input1[, int.cols], as.numeric)
save(f1_input1, file = "data/f1_input1.rdata")
