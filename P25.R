# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
a <- c(1,1,4,4,1,1)
b <- c(1,2,3,3,2,2)
dat <- data.frame(a,b)

write.csv(dat, "data-raw/p25_input1.csv", row.names=FALSE)

dat %>%
  unite(key_ab, a, b) %>%
  group_by(key_ab) %>%
  summarise(e = n()) %>%
  filter(e>1) -> df_out

write.csv(df_out, "data-raw/p25_output1.csv", row.names=FALSE)

p25_output1 <- read.csv("data-raw/p25_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p25_output1, is.factor)
int.cols <- sapply(p25_output1, is.integer)

p25_output1[, fctr.cols] <- sapply(p25_output1[, fctr.cols], as.character)
p25_output1[, int.cols] <- sapply(p25_output1[, int.cols], as.numeric)
save(p25_output1, file = "data/p25_output1.rdata")

p25_input1 <- read.csv("data-raw/p25_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p25_input1, is.factor)
int.cols <- sapply(p25_input1, is.integer)

p25_input1[, fctr.cols] <- sapply(p25_input1[, fctr.cols], as.character)
p25_input1[, int.cols] <- sapply(p25_input1[, int.cols], as.numeric)
save(p25_input1, file = "data/p25_input1.rdata")
