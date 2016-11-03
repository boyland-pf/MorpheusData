# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 59
dat <- read.table(text=
"
sample  BMI  var1_LRR   var1_BAF    var2_LRR    var2_BAF    var3_LRR var3_BAF  var200_LRR var200_BAF
AA     18.9    0.27       0.99        0.18        0.99        0.11         1     0.20        0.99
BB     27.1    0.23       1           0.13        0.99        0.17         1     0.23        0.99
", header=T)



write.csv(dat, "data-raw/p59_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(var, value, -sample, -BMI) %>%
  separate(var, c("varNew", "variable")) %>%
  spread(variable, value)

write.csv(df_out, "data-raw/p59_output1.csv", row.names=FALSE)

p59_output1 <- read.csv("data-raw/p59_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p59_output1, is.factor)
int.cols <- sapply(p59_output1, is.integer)

p59_output1[, fctr.cols] <- sapply(p59_output1[, fctr.cols], as.character)
p59_output1[, int.cols] <- sapply(p59_output1[, int.cols], as.numeric)
save(p59_output1, file = "data/p59_output1.rdata")

p59_input1 <- read.csv("data-raw/p59_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p59_input1, is.factor)
int.cols <- sapply(p59_input1, is.integer)

p59_input1[, fctr.cols] <- sapply(p59_input1[, fctr.cols], as.character)
p59_input1[, int.cols] <- sapply(p59_input1[, int.cols], as.numeric)
save(p59_input1, file = "data/p59_input1.rdata")
