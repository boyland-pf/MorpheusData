# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"id choice  c  d
1  5  9      110 
2  6  0 2015
3  7 11 2016
", header=T)

write.csv(dat, "data-raw/p15_input1.csv", row.names=FALSE)

df_out = dat %>% spread(choice, choice) %>%
    gather(choice, drop_me, `5`:`7`) %>%
    select(-drop_me) %>%
    arrange(id, choice)

write.csv(df_out, "data-raw/p15_output1.csv", row.names=FALSE)

output1 <- read.csv("data-raw/p15_output1.csv", check.names = FALSE)
fctr.cols <- sapply(output1, is.factor)
int.cols <- sapply(output1, is.integer)

output1[, fctr.cols] <- sapply(output1[, fctr.cols], as.character)
output1[, int.cols] <- sapply(output1[, int.cols], as.numeric)
save(output1, file = "data/p15_output1.rdata")

input1 <- read.csv("data-raw/p15_input1.csv", check.names = FALSE)
fctr.cols <- sapply(input1, is.factor)
int.cols <- sapply(input1, is.integer)

input1[, fctr.cols] <- sapply(input1[, fctr.cols], as.character)
input1[, int.cols] <- sapply(input1[, int.cols], as.numeric)
save(input1, file = "data/p15_input1.rdata")
