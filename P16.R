# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"client year rev
A 2014  10
B 2014  20
A 2013  10
B 2013  20
A 2012  10
B 2012  20
B 2012  35
", header=T)

write.csv(dat, "data-raw/p16_input1.csv", row.names=FALSE)

df_out = dat %>% 
  group_by(year, client) %>%
  summarise(tot = sum(rev)) %>%
  arrange(year)

write.csv(df_out, "data-raw/p16_output1.csv", row.names=FALSE)

p16_output1 <- read.csv("data-raw/p16_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p16_output1, is.factor)
int.cols <- sapply(p16_output1, is.integer)

p16_output1[, fctr.cols] <- sapply(p16_output1[, fctr.cols], as.character)
p16_output1[, int.cols] <- sapply(p16_output1[, int.cols], as.numeric)
save(p16_output1, file = "data/p16_output1.rdata")

p16_input1 <- read.csv("data-raw/p16_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p16_input1, is.factor)
int.cols <- sapply(p16_input1, is.integer)

p16_input1[, fctr.cols] <- sapply(p16_input1[, fctr.cols], as.character)
p16_input1[, int.cols] <- sapply(p16_input1[, int.cols], as.numeric)
save(p16_input1, file = "data/p16_input1.rdata")
