# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- subset(mtcars, gear>3 & cyl >= 4 & hp > 100)

write.csv(dat, "data-raw/p7_input1.csv", row.names=FALSE)

df_out = dat %>% group_by(gear, vs) %>% 
summarize(mean_disp = mean (disp)) %>%
spread(vs, mean_disp)

write.csv(df_out, "data-raw/p7_output1.csv", row.names=FALSE)

output1 <- read.csv("data-raw/p7_output1.csv", check.names = FALSE)
fctr.cols <- sapply(output1, is.factor)
int.cols <- sapply(output1, is.integer)

output1[, fctr.cols] <- sapply(output1[, fctr.cols], as.character)
output1[, int.cols] <- sapply(output1[, int.cols], as.numeric)
save(output1, file = "data/p7_output1.rdata")

input1 <- read.csv("data-raw/p7_input1.csv", check.names = FALSE)
fctr.cols <- sapply(input1, is.factor)
int.cols <- sapply(input1, is.integer)

input1[, fctr.cols] <- sapply(input1[, fctr.cols], as.character)
input1[, int.cols] <- sapply(input1[, int.cols], as.numeric)
save(input1, file = "data/p7_input1.rdata")
