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


write.csv(dat, "data-raw/p37_input1.csv", row.names=FALSE)

df_out = dat %>%
  mutate(percent = n / sum(n)) %>%
  gather(variable, value, n, percent) %>%
  unite("new_variable", am, variable) %>%
  spread(new_variable, value)

write.csv(df_out, "data-raw/p37_output1.csv", row.names=FALSE)

p37_output1 <- read.csv("data-raw/p37_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p37_output1, is.factor)
int.cols <- sapply(p37_output1, is.integer)

p37_output1[, fctr.cols] <- sapply(p37_output1[, fctr.cols], as.character)
p37_output1[, int.cols] <- sapply(p37_output1[, int.cols], as.numeric)
save(p37_output1, file = "data/p37_output1.rdata")

p37_input1 <- read.csv("data-raw/p37_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p37_input1, is.factor)
int.cols <- sapply(p37_input1, is.integer)

p37_input1[, fctr.cols] <- sapply(p37_input1[, fctr.cols], as.character)
p37_input1[, int.cols] <- sapply(p37_input1[, int.cols], as.numeric)
save(p37_input1, file = "data/p37_input1.rdata")
