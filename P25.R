# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"user  blue green   red
1 Y N N
2 N N Y
3 Y N N
4 N Y N
", header=T)

write.csv(dat, "data-raw/p25_input1.csv", row.names=FALSE)

df_out = dat %>% gather(color, TF, -user) %>% 
filter(TF == "Y") %>% 
select(-TF) %>% 
arrange(user)

write.csv(df_out, "data-raw/p25_output1.csv", row.names=FALSE)

output1 <- read.csv("data-raw/p25_output1.csv", check.names = FALSE)
fctr.cols <- sapply(output1, is.factor)
int.cols <- sapply(output1, is.integer)

output1[, fctr.cols] <- sapply(output1[, fctr.cols], as.character)
output1[, int.cols] <- sapply(output1[, int.cols], as.numeric)
save(output1, file = "data/p25_output1.rdata")

input1 <- read.csv("data-raw/p25_input1.csv", check.names = FALSE)
fctr.cols <- sapply(input1, is.factor)
int.cols <- sapply(input1, is.integer)

input1[, fctr.cols] <- sapply(input1[, fctr.cols], as.character)
input1[, int.cols] <- sapply(input1[, int.cols], as.numeric)
save(input1, file = "data/p25_input1.rdata")
