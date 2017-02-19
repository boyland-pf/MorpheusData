# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"order_id    Prod1   prod2   Prod3   Prod4   Prod5
   A             1     0     1      1     1
   B             0     0     1      1     0
   C             1     1     0      1     1
", header=T)

write.csv(dat, "data-raw/r80_input1.csv", row.names=FALSE)

df_out = dat %>% gather(var, val, -1) %>% filter(val!=0) %>% select(-3) 
#%>% arrange(order_id)

write.csv(df_out, "data-raw/r80_output1.csv", row.names=FALSE)

r80_output1 <- read.csv("data-raw/r80_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r80_output1, is.factor)
int.cols <- sapply(r80_output1, is.integer)

r80_output1[, fctr.cols] <- sapply(r80_output1[, fctr.cols], as.character)
r80_output1[, int.cols] <- sapply(r80_output1[, int.cols], as.numeric)
save(r80_output1, file = "data/r80_output1.rdata")

r80_input1 <- read.csv("data-raw/r80_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r80_input1, is.factor)
int.cols <- sapply(r80_input1, is.integer)

r80_input1[, fctr.cols] <- sapply(r80_input1[, fctr.cols], as.character)
r80_input1[, int.cols] <- sapply(r80_input1[, int.cols], as.numeric)
save(r80_input1, file = "data/r80_input1.rdata")
