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



write.csv(dat, "data-raw/r56_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(var, value, -sample, -BMI) %>%
  separate(var, c("varNew", "variable")) %>%
  spread(variable, value)

write.csv(df_out, "data-raw/r56_output1.csv", row.names=FALSE)

r56_output1 <- read.csv("data-raw/r56_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r56_output1, is.factor)
int.cols <- sapply(r56_output1, is.integer)

r56_output1[, fctr.cols] <- sapply(r56_output1[, fctr.cols], as.character)
r56_output1[, int.cols] <- sapply(r56_output1[, int.cols], as.numeric)
save(r56_output1, file = "data/r56_output1.rdata")

r56_input1 <- read.csv("data-raw/r56_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r56_input1, is.factor)
int.cols <- sapply(r56_input1, is.integer)

r56_input1[, fctr.cols] <- sapply(r56_input1[, fctr.cols], as.character)
r56_input1[, int.cols] <- sapply(r56_input1[, int.cols], as.numeric)
save(r56_input1, file = "data/r56_input1.rdata")
