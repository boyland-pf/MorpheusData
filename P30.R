# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 30
dat <- data.frame(sym=c(rep('a', 4), rep('b', 4)), a1=rep(1:2, 4), 
                 a2=rep(2:1, each=4), b1=rep(1:8), b2=rep(1:8))

write.csv(dat, "data-raw/p30_input1.csv", row.names=FALSE)

df_out = inner_join(dat %>% group_by(sym, a1) %>% summarise(b1.mean=mean(b1)),
           dat %>% group_by(sym, a2) %>% summarise(b2.mean=mean(b2)))

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
