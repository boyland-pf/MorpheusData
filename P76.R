# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"Type  Year Count
Login  2014    30
Login  2014    20
Other  2014     4
Login  2015    25
Login  2015    40
Other  2015     6
", header=T)

write.csv(dat, "data-raw/p76_input1.csv", row.names=FALSE)

df_out = dat %>% 
  filter(Type == "Login") %>% 
  group_by(Type, Year) %>% 
  summarise(TotalLogin = sum(Count))

write.csv(df_out, "data-raw/p76_output1.csv", row.names=FALSE)

p76_output1 <- read.csv("data-raw/p76_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p76_output1, is.factor)
int.cols <- sapply(p76_output1, is.integer)

p76_output1[, fctr.cols] <- sapply(p76_output1[, fctr.cols], as.character)
p76_output1[, int.cols] <- sapply(p76_output1[, int.cols], as.numeric)
save(p76_output1, file = "data/p76_output1.rdata")

p76_input1 <- read.csv("data-raw/p76_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p76_input1, is.factor)
int.cols <- sapply(p76_input1, is.integer)

p76_input1[, fctr.cols] <- sapply(p76_input1[, fctr.cols], as.character)
p76_input1[, int.cols] <- sapply(p76_input1[, int.cols], as.numeric)
save(p76_input1, file = "data/p76_input1.rdata")
