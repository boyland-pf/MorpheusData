# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 91
dat <- read.table(text=
" Name Score 
John  10
John   2
James  5", header=T)

write.csv(dat, "data-raw/p91_input1.csv", row.names=FALSE)

df_out = dat %>% filter(Name=="John") %>%
  group_by(Name) %>%
  summarise(Value=mean(Score))

write.csv(df_out, "data-raw/p91_output1.csv", row.names=FALSE)

p91_output1 <- read.csv("data-raw/p91_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p91_output1, is.factor)
int.cols <- sapply(p91_output1, is.integer)

p91_output1[, fctr.cols] <- sapply(p91_output1[, fctr.cols], as.character)
p91_output1[, int.cols] <- sapply(p91_output1[, int.cols], as.numeric)
save(p91_output1, file = "data/p91_output1.rdata")

p91_input1 <- read.csv("data-raw/p91_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p91_input1, is.factor)
int.cols <- sapply(p91_input1, is.integer)

p91_input1[, fctr.cols] <- sapply(p91_input1[, fctr.cols], as.character)
p91_input1[, int.cols] <- sapply(p91_input1[, int.cols], as.numeric)
save(p91_input1, file = "data/p91_input1.rdata")
