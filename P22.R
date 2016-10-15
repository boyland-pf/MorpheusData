# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"subject  cohort    replicate val1   val2
  A     control       1       10     0.1
  A     control       2       15     0.3
  A     experim       1       40     0.7
  A     experim       2       45     0.9
  B     control       1        5     0.3     
  B     experim       1       30     0.0
", header=T)

write.csv(dat, "data-raw/p22_input1.csv", row.names=FALSE)

df_out = dat %>%
   gather(Var, Val, val1:val2) %>%
   spread(cohort, Val) %>% 
   group_by(subject, replicate, Var) %>%
   summarise(ratio = experim/control) %>% spread(Var, ratio)

write.csv(df_out, "data-raw/p22_output1.csv", row.names=FALSE)

p22_output1 <- read.csv("data-raw/p22_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p22_output1, is.factor)
int.cols <- sapply(p22_output1, is.integer)

p22_output1[, fctr.cols] <- sapply(p22_output1[, fctr.cols], as.character)
p22_output1[, int.cols] <- sapply(p22_output1[, int.cols], as.numeric)
save(p22_output1, file = "data/p22_output1.rdata")

p22_input1 <- read.csv("data-raw/p22_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p22_input1, is.factor)
int.cols <- sapply(p22_input1, is.integer)

p22_input1[, fctr.cols] <- sapply(p22_input1[, fctr.cols], as.character)
p22_input1[, int.cols] <- sapply(p22_input1[, int.cols], as.numeric)
save(p22_input1, file = "data/p22_input1.rdata")
