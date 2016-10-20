# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat = subset(mtcars, gear>3 & cyl >= 4 & hp > 100 & vs==1) %>% select(mpg,cyl,disp)

write.csv(dat, "data-raw/p30_input1.csv", row.names=FALSE)

df_out = dat %>% 
gather("key", "value", 1:3) %>% group_by(key) %>% 
summarise( nMax = max(value) ) %>% arrange(nMax)

write.csv(df_out, "data-raw/p30_output1.csv", row.names=FALSE)

p30_output1 <- read.csv("data-raw/p30_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p30_output1, is.factor)
int.cols <- sapply(p30_output1, is.integer)

p30_output1[, fctr.cols] <- sapply(p30_output1[, fctr.cols], as.character)
p30_output1[, int.cols] <- sapply(p30_output1[, int.cols], as.numeric)
save(p30_output1, file = "data/p30_output1.rdata")

p30_input1 <- read.csv("data-raw/p30_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p30_input1, is.factor)
int.cols <- sapply(p30_input1, is.integer)

p30_input1[, fctr.cols] <- sapply(p30_input1[, fctr.cols], as.character)
p30_input1[, int.cols] <- sapply(p30_input1[, int.cols], as.numeric)
save(p30_input1, file = "data/p30_input1.rdata")
