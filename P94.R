# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
employee <- c('Yossi ','Pitt ','Deepak','Golan')
salary <- c(21000, 23400, 26800,91000)
dat <- data.frame(employee,salary)

write.csv(dat, "data-raw/p94_input1.csv", row.names=FALSE)

df_out = dat %>%
  select(employee, salary) %>%
  filter(salary > 25000) %>%
  summarise(mean = mean(salary))

write.csv(df_out, "data-raw/p94_output1.csv", row.names=FALSE)

p94_output1 <- read.csv("data-raw/p94_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p94_output1, is.factor)
int.cols <- sapply(p94_output1, is.integer)

p94_output1[, fctr.cols] <- sapply(p94_output1[, fctr.cols], as.character)
p94_output1[, int.cols] <- sapply(p94_output1[, int.cols], as.numeric)
save(p94_output1, file = "data/p94_output1.rdata")

p94_input1 <- read.csv("data-raw/p94_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p94_input1, is.factor)
int.cols <- sapply(p94_input1, is.integer)

p94_input1[, fctr.cols] <- sapply(p94_input1[, fctr.cols], as.character)
p94_input1[, int.cols] <- sapply(p94_input1[, int.cols], as.numeric)
save(p94_input1, file = "data/p94_input1.rdata")
