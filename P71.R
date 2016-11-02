# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"   ID  a   b   O   H
1  bo 10 -10  Nn In+
2  bo  9 -47  Hy In+
3  bo  3  13  Nn In+
4  co  1 -86  Nn In-
5  co  5 -64  Hy In-
6  co  8  73  Nn In-
", header=T)

write.csv(dat, "data-raw/p71_input1.csv", row.names=FALSE)

df_out = dat %>% 
  gather(int, value, a, b) %>%
  filter(int == "a") %>%
  group_by(O, H) %>%
  summarise(value = mean(value))

write.csv(df_out, "data-raw/p71_output1.csv", row.names=FALSE)

p71_output1 <- read.csv("data-raw/p71_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p71_output1, is.factor)
int.cols <- sapply(p71_output1, is.integer)

p71_output1[, fctr.cols] <- sapply(p71_output1[, fctr.cols], as.character)
p71_output1[, int.cols] <- sapply(p71_output1[, int.cols], as.numeric)
save(p71_output1, file = "data/p71_output1.rdata")

p71_input1 <- read.csv("data-raw/p71_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p71_input1, is.factor)
int.cols <- sapply(p71_input1, is.integer)

p71_input1[, fctr.cols] <- sapply(p71_input1[, fctr.cols], as.character)
p71_input1[, int.cols] <- sapply(p71_input1[, int.cols], as.numeric)
save(p71_input1, file = "data/p71_input1.rdata")
