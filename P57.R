# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 57
dat <- 
  data.table(
    data.frame(
      key = c("id1","id2","id3","id4","id5"),
      c1.min = 1:5,
      c2.min = 10:14,
      c1.max = 1:5,
      c2.max = 1:5))



write.csv(dat, "data-raw/p57_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(k, v, -key) %>%
  separate(k, into = c("l", "s")) %>%
  group_by(key, l) %>% 
  summarise(value = sum(v)) %>%
  spread(l, value)

write.csv(df_out, "data-raw/p57_output1.csv", row.names=FALSE)

p57_output1 <- read.csv("data-raw/p57_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p57_output1, is.factor)
int.cols <- sapply(p57_output1, is.integer)

p57_output1[, fctr.cols] <- sapply(p57_output1[, fctr.cols], as.character)
p57_output1[, int.cols] <- sapply(p57_output1[, int.cols], as.numeric)
save(p57_output1, file = "data/p57_output1.rdata")

p57_input1 <- read.csv("data-raw/p57_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p57_input1, is.factor)
int.cols <- sapply(p57_input1, is.integer)

p57_input1[, fctr.cols] <- sapply(p57_input1[, fctr.cols], as.character)
p57_input1[, int.cols] <- sapply(p57_input1[, int.cols], as.numeric)
save(p57_input1, file = "data/p57_input1.rdata")
