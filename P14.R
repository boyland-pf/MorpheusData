# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"ID   Diagnosis_1   Diagnosis_2   Diagnosis_3   Diagnosis_4
A        1             0             0             0
A        1             0             0             0
A        1             0             0             0
B        0             1             0             0
C        0             0             0             1
C        0             1             0             0
D        0             0             0             1
E        0             0             1             0
E        0             1             0             0
E        0             0             1             0
", header=T)

write.csv(dat, "data-raw/p14_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(var, val, -ID) %>%
  separate(var, into = c("var", "value")) %>%
  filter(val == 1) %>%
  select(ID, value)

write.csv(df_out, "data-raw/p14_output1.csv", row.names=FALSE)

p14_output1 <- read.csv("data-raw/p14_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p14_output1, is.factor)
int.cols <- sapply(p14_output1, is.integer)

p14_output1[, fctr.cols] <- sapply(p14_output1[, fctr.cols], as.character)
p14_output1[, int.cols] <- sapply(p14_output1[, int.cols], as.numeric)
save(p14_output1, file = "data/p14_output1.rdata")

p14_input1 <- read.csv("data-raw/p14_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p14_input1, is.factor)
int.cols <- sapply(p14_input1, is.integer)

p14_input1[, fctr.cols] <- sapply(p14_input1[, fctr.cols], as.character)
p14_input1[, int.cols] <- sapply(p14_input1[, int.cols], as.numeric)
save(p14_input1, file = "data/p14_input1.rdata")
