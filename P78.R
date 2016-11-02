# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"year	sex 	name 	n
1955     F Kerry   615
1955     M Kerry  1600
1980     F Kerry  1000
1980     M Kerry   432
1988     F Kerry   598
1988     M Kerry   421
1980     F Sherry  234
1980     M Sherry  1200
", header=T)

write.csv(dat, "data-raw/p78_input1.csv", row.names=FALSE)

df_out = 
  dat %>%
  filter(name == "Kerry") %>%
  select(-`name`) %>%
  spread(sex, n)

write.csv(df_out, "data-raw/p78_output1.csv", row.names=FALSE)

p78_output1 <- read.csv("data-raw/p78_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p78_output1, is.factor)
int.cols <- sapply(p78_output1, is.integer)

p78_output1[, fctr.cols] <- sapply(p78_output1[, fctr.cols], as.character)
p78_output1[, int.cols] <- sapply(p78_output1[, int.cols], as.numeric)
save(p78_output1, file = "data/p78_output1.rdata")

p78_input1 <- read.csv("data-raw/p78_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p78_input1, is.factor)
int.cols <- sapply(p78_input1, is.integer)

p78_input1[, fctr.cols] <- sapply(p78_input1[, fctr.cols], as.character)
p78_input1[, int.cols] <- sapply(p78_input1[, int.cols], as.numeric)
save(p78_input1, file = "data/p78_input1.rdata")
