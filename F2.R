# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
project_code invoice_key invoice_amount
proj1 inv1 100
proj1 inv2 200
proj2 inv3 300
proj2 inv4 400
proj3 inv5 500  
", header=T)

write.csv(dat, "data-raw/f2_input1.csv", row.names=FALSE)

df_out = dat %>% 
  group_by(project_code) %>% summarise(sum=sum(invoice_amount))

write.csv(df_out, "data-raw/f2_output1.csv", row.names=FALSE)

f2_output1 <- read.csv("data-raw/f2_output1.csv", check.names = FALSE)
fctr.cols <- sapply(f2_output1, is.factor)
int.cols <- sapply(f2_output1, is.integer)

f2_output1[, fctr.cols] <- sapply(f2_output1[, fctr.cols], as.character)
f2_output1[, int.cols] <- sapply(f2_output1[, int.cols], as.numeric)
save(f2_output1, file = "data/f2_output1.rdata")

f2_input1 <- read.csv("data-raw/f2_input1.csv", check.names = FALSE)
fctr.cols <- sapply(f2_input1, is.factor)
int.cols <- sapply(f2_input1, is.integer)

f2_input1[, fctr.cols] <- sapply(f2_input1[, fctr.cols], as.character)
f2_input1[, int.cols] <- sapply(f2_input1[, int.cols], as.numeric)
save(f2_input1, file = "data/f2_input1.rdata")
