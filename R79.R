# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dept <- c('CS','EE','Civil','Physics')
id <- c(1,2,3,4)
employee <- c('Yossi ','Pitt ','Deepak','Golan')
salary <- c(21000, 23400, 26800,91000)
dat <- data.frame(id,dept,employee,salary)

write.csv(dat, "data-raw/r79_input1.csv", row.names=FALSE)

df_out = dat %>%
  select(employee, salary) %>%
  filter(salary > 25000) %>%
  summarise(mean = mean(salary))

write.csv(df_out, "data-raw/r79_output1.csv", row.names=FALSE)

r79_output1 <- read.csv("data-raw/r79_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r79_output1, is.factor)
int.cols <- sapply(r79_output1, is.integer)

r79_output1[, fctr.cols] <- sapply(r79_output1[, fctr.cols], as.character)
r79_output1[, int.cols] <- sapply(r79_output1[, int.cols], as.numeric)
save(r79_output1, file = "data/r79_output1.rdata")

r79_input1 <- read.csv("data-raw/r79_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r79_input1, is.factor)
int.cols <- sapply(r79_input1, is.integer)

r79_input1[, fctr.cols] <- sapply(r79_input1[, fctr.cols], as.character)
r79_input1[, int.cols] <- sapply(r79_input1[, int.cols], as.numeric)
save(r79_input1, file = "data/r79_input1.rdata")
