# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
a <- c(1,1,4,4,1,1)
b <- c(1,2,3,3,2,2)
dat <- data.frame(a,b)

write.csv(dat, "data-raw/r25_input1.csv", row.names=FALSE)

dat %>%
  unite(key_ab, a, b) %>%
  group_by(key_ab) %>%
  summarise(e = n()) %>%
  filter(e>1) -> df_out

write.csv(df_out, "data-raw/r25_output1.csv", row.names=FALSE)

r25_output1 <- read.csv("data-raw/r25_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r25_output1, is.factor)
int.cols <- sapply(r25_output1, is.integer)

r25_output1[, fctr.cols] <- sapply(r25_output1[, fctr.cols], as.character)
r25_output1[, int.cols] <- sapply(r25_output1[, int.cols], as.numeric)
save(r25_output1, file = "data/r25_output1.rdata")

r25_input1 <- read.csv("data-raw/r25_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r25_input1, is.factor)
int.cols <- sapply(r25_input1, is.integer)

r25_input1[, fctr.cols] <- sapply(r25_input1[, fctr.cols], as.character)
r25_input1[, int.cols] <- sapply(r25_input1[, int.cols], as.numeric)
save(r25_input1, file = "data/r25_input1.rdata")
