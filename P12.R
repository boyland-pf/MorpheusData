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

p12_output1 <- read.csv("data-raw/p12_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p12_output1, is.factor)
int.cols <- sapply(p12_output1, is.integer)

p12_output1[, fctr.cols] <- sapply(p12_output1[, fctr.cols], as.character)
p12_output1[, int.cols] <- sapply(p12_output1[, int.cols], as.numeric)
save(p12_output1, file = "data/p12_output1.rdata")

p12_input1 <- read.csv("data-raw/p12_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p12_input1, is.factor)
int.cols <- sapply(p12_input1, is.integer)

p12_input1[, fctr.cols] <- sapply(p12_input1[, fctr.cols], as.character)
p12_input1[, int.cols] <- sapply(p12_input1[, int.cols], as.numeric)
save(p12_input1, file = "data/p12_input1.rdata")
