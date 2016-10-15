# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"dd gg site
5  10 A
7  8  A
5  6  B 
7  9  B 
", header=T)

write.csv(dat, "data-raw/p12_input1.csv", row.names=FALSE)

df_out = dat %>% filter(site == "B") %>%
spread(key = site, value = gg) %>%
inner_join(filter(dat, site != "B"))

write.csv(df_out, "data-raw/p12_output1.csv", row.names=FALSE)

output1 <- read.csv("data-raw/p12_output1.csv", check.names = FALSE)
fctr.cols <- sapply(output1, is.factor)
int.cols <- sapply(output1, is.integer)

output1[, fctr.cols] <- sapply(output1[, fctr.cols], as.character)
output1[, int.cols] <- sapply(output1[, int.cols], as.numeric)
save(output1, file = "data/p12_output1.rdata")

input1 <- read.csv("data-raw/p12_input1.csv", check.names = FALSE)
fctr.cols <- sapply(input1, is.factor)
int.cols <- sapply(input1, is.integer)

input1[, fctr.cols] <- sapply(input1[, fctr.cols], as.character)
input1[, int.cols] <- sapply(input1[, int.cols], as.numeric)
save(input1, file = "data/p12_input1.rdata")
