# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"score group category
     10    a1      big
      8    a1      big
      9    a1      big
      1    a1      big
      5    a1    small
      8    a2      big
      2    a2      big
      8    a2      big
      5    a2      big
     6    a2    small
     9    a3      big
     4    a3      big
     7    a3      big
     9    a3      big
     9    a3    small
", header=T)

write.csv(dat, "data-raw/r62_input1.csv", row.names=FALSE)

df_out = dat %>%
  filter(category=='big') %>%
  group_by(group) %>%
  summarise(mean = mean(score))

write.csv(df_out, "data-raw/r62_output1.csv", row.names=FALSE)

r62_output1 <- read.csv("data-raw/r62_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r62_output1, is.factor)
int.cols <- sapply(r62_output1, is.integer)

r62_output1[, fctr.cols] <- sapply(r62_output1[, fctr.cols], as.character)
r62_output1[, int.cols] <- sapply(r62_output1[, int.cols], as.numeric)
save(r62_output1, file = "data/r62_output1.rdata")

r62_input1 <- read.csv("data-raw/r62_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r62_input1, is.factor)
int.cols <- sapply(r62_input1, is.integer)

r62_input1[, fctr.cols] <- sapply(r62_input1[, fctr.cols], as.character)
r62_input1[, int.cols] <- sapply(r62_input1[, int.cols], as.numeric)
save(r62_input1, file = "data/r62_input1.rdata")
