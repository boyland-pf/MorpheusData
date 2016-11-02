# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 42
dat <- read.table(text=
"
test1_rater1 test2_rater1 test1_rater2 test2_rater2 row
1            1          2  1   1
3            3          3  3   3
2            3          4  4   4
3            2          1  3   5
4            3          2  4   6
3            1          1  3  10
", header=T)


write.csv(dat, "data-raw/p42_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(column, value, -row) %>%
  separate(column, c("test", "rater")) %>%
  spread(rater, value)

write.csv(df_out, "data-raw/p42_output1.csv", row.names=FALSE)

p42_output1 <- read.csv("data-raw/p42_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p42_output1, is.factor)
int.cols <- sapply(p42_output1, is.integer)

p42_output1[, fctr.cols] <- sapply(p42_output1[, fctr.cols], as.character)
p42_output1[, int.cols] <- sapply(p42_output1[, int.cols], as.numeric)
save(p42_output1, file = "data/p42_output1.rdata")

p42_input1 <- read.csv("data-raw/p42_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p42_input1, is.factor)
int.cols <- sapply(p42_input1, is.integer)

p42_input1[, fctr.cols] <- sapply(p42_input1[, fctr.cols], as.character)
p42_input1[, int.cols] <- sapply(p42_input1[, int.cols], as.numeric)
save(p42_input1, file = "data/p42_input1.rdata")
