# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
v_key entryid result
v1 e1 N
v2 e1 L
v3 e2 L
v4 e3 L
", header=T)

write.csv(dat, "data-raw/f5_input1.csv", row.names=FALSE)

df_out = dat %>% 
  group_by(entryid) %>% summarise(cnt=n())

write.csv(df_out, "data-raw/f5_output1.csv", row.names=FALSE)

f5_output1 <- read.csv("data-raw/f5_output1.csv", check.names = FALSE)
fctr.cols <- sapply(f5_output1, is.factor)
int.cols <- sapply(f5_output1, is.integer)

f5_output1[, fctr.cols] <- sapply(f5_output1[, fctr.cols], as.character)
f5_output1[, int.cols] <- sapply(f5_output1[, int.cols], as.numeric)
save(f5_output1, file = "data/f5_output1.rdata")

f5_input1 <- read.csv("data-raw/f5_input1.csv", check.names = FALSE)
fctr.cols <- sapply(f5_input1, is.factor)
int.cols <- sapply(f5_input1, is.integer)

f5_input1[, fctr.cols] <- sapply(f5_input1[, fctr.cols], as.character)
f5_input1[, int.cols] <- sapply(f5_input1[, int.cols], as.numeric)
save(f5_input1, file = "data/f5_input1.rdata")
