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

output1 <- read.csv("data-raw/p28_output1.csv", check.names = FALSE)
fctr.cols <- sapply(output1, is.factor)
int.cols <- sapply(output1, is.integer)

output1[, fctr.cols] <- sapply(output1[, fctr.cols], as.character)
output1[, int.cols] <- sapply(output1[, int.cols], as.numeric)
save(output1, file = "data/p28_output1.rdata")

input1 <- read.csv("data-raw/p28_input1.csv", check.names = FALSE)
fctr.cols <- sapply(input1, is.factor)
int.cols <- sapply(input1, is.integer)

input1[, fctr.cols] <- sapply(input1[, fctr.cols], as.character)
input1[, int.cols] <- sapply(input1[, int.cols], as.numeric)
save(input1, file = "data/p28_input1.rdata")
