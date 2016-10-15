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

p15_output1 <- read.csv("data-raw/p15_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p15_output1, is.factor)
int.cols <- sapply(p15_output1, is.integer)

p15_output1[, fctr.cols] <- sapply(p15_output1[, fctr.cols], as.character)
p15_output1[, int.cols] <- sapply(p15_output1[, int.cols], as.numeric)
save(p15_output1, file = "data/p15_output1.rdata")

p15_input1 <- read.csv("data-raw/p15_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p15_input1, is.factor)
int.cols <- sapply(p15_input1, is.integer)

p15_input1[, fctr.cols] <- sapply(p15_input1[, fctr.cols], as.character)
p15_input1[, int.cols] <- sapply(p15_input1[, int.cols], as.numeric)
save(p15_input1, file = "data/p15_input1.rdata")
