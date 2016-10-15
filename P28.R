# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"id name value
101    a     1
102    a     2
103    a     3
101    b     2
102    b     2
103    b     2
", header=T)

write.csv(dat, "data-raw/p28_input1.csv", row.names=FALSE)

df_out = dat %>% group_by(id) %>%
summarize(mean = mean(value)) %>%
inner_join(dat)
#inner_join(dat, by = 'id')

write.csv(df_out, "data-raw/p28_output1.csv", row.names=FALSE)

p28_output1 <- read.csv("data-raw/p28_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p28_output1, is.factor)
int.cols <- sapply(p28_output1, is.integer)

p28_output1[, fctr.cols] <- sapply(p28_output1[, fctr.cols], as.character)
p28_output1[, int.cols] <- sapply(p28_output1[, int.cols], as.numeric)
save(p28_output1, file = "data/p28_output1.rdata")

p28_input1 <- read.csv("data-raw/p28_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p28_input1, is.factor)
int.cols <- sapply(p28_input1, is.integer)

p28_input1[, fctr.cols] <- sapply(p28_input1[, fctr.cols], as.character)
p28_input1[, int.cols] <- sapply(p28_input1[, int.cols], as.numeric)
save(p28_input1, file = "data/p28_input1.rdata")
