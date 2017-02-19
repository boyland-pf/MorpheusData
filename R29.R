# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 30
dat <- data.frame(sym=c(rep('a', 3), rep('b', 3)), a1=rep(1:2, 3), 
                 a2=rep(2:1, each=3), b1=rep(1:6), b2=rep(1:6))

write.csv(dat, "data-raw/r29_input1.csv", row.names=FALSE)

df_out = inner_join(dat %>% group_by(sym, a1) %>% summarise(b1.mean=mean(b1)),
           dat %>% group_by(sym, a2) %>% summarise(b2.mean=mean(b2)))

write.csv(df_out, "data-raw/r29_output1.csv", row.names=FALSE)

r29_output1 <- read.csv("data-raw/r29_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r29_output1, is.factor)
int.cols <- sapply(r29_output1, is.integer)

r29_output1[, fctr.cols] <- sapply(r29_output1[, fctr.cols], as.character)
r29_output1[, int.cols] <- sapply(r29_output1[, int.cols], as.numeric)
save(r29_output1, file = "data/r29_output1.rdata")

r29_input1 <- read.csv("data-raw/r29_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r29_input1, is.factor)
int.cols <- sapply(r29_input1, is.integer)

r29_input1[, fctr.cols] <- sapply(r29_input1[, fctr.cols], as.character)
r29_input1[, int.cols] <- sapply(r29_input1[, int.cols], as.numeric)
save(r29_input1, file = "data/r29_input1.rdata")
