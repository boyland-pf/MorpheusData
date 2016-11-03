# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 64
dat <- read.table(text=
"
year roleInDebate Clarity_1 Effort_1 Clarity_2 Effort_2 Clarity_3 Effort_3
2006            x         3        5        10        4         5        7
2009            y         2        8         3        1         6        8
2013            r         7       10         7        4         5        2
2020            q         4        4         2        9         2        8
2004            b         8        8         3        4         9        5
", header=T)



write.csv(dat, "data-raw/p64_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(var, val, -year, -roleInDebate) %>%
  separate(var, c('skill', 'person')) %>%
  spread(skill, val)

write.csv(df_out, "data-raw/p64_output1.csv", row.names=FALSE)

p64_output1 <- read.csv("data-raw/p64_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p64_output1, is.factor)
int.cols <- sapply(p64_output1, is.integer)

p64_output1[, fctr.cols] <- sapply(p64_output1[, fctr.cols], as.character)
p64_output1[, int.cols] <- sapply(p64_output1[, int.cols], as.numeric)
save(p64_output1, file = "data/p64_output1.rdata")

p64_input1 <- read.csv("data-raw/p64_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p64_input1, is.factor)
int.cols <- sapply(p64_input1, is.integer)

p64_input1[, fctr.cols] <- sapply(p64_input1[, fctr.cols], as.character)
p64_input1[, int.cols] <- sapply(p64_input1[, int.cols], as.numeric)
save(p64_input1, file = "data/p64_input1.rdata")
