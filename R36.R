# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 37
dat <- read.table(text=
"
gear    am     n
3     0    15
4     0     4
4     1     8
3     1     5
", header=T)


write.csv(dat, "data-raw/r36_input1.csv", row.names=FALSE)

df_out = dat %>%
  mutate(percent = n / sum(n)) %>%
  gather(variable, value, n, percent) %>%
  unite("new_variable", am, variable) %>%
  spread(new_variable, value)

write.csv(df_out, "data-raw/r36_output1.csv", row.names=FALSE)

r36_output1 <- read.csv("data-raw/r36_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r36_output1, is.factor)
int.cols <- sapply(r36_output1, is.integer)

r36_output1[, fctr.cols] <- sapply(r36_output1[, fctr.cols], as.character)
r36_output1[, int.cols] <- sapply(r36_output1[, int.cols], as.numeric)
save(r36_output1, file = "data/r36_output1.rdata")

r36_input1 <- read.csv("data-raw/r36_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r36_input1, is.factor)
int.cols <- sapply(r36_input1, is.integer)

r36_input1[, fctr.cols] <- sapply(r36_input1[, fctr.cols], as.character)
r36_input1[, int.cols] <- sapply(r36_input1[, int.cols], as.numeric)
save(r36_input1, file = "data/r36_input1.rdata")
