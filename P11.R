# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <-data.frame(
   clientid=1:7,
   ProductA=c("chair","table","plate","table","chair","table","plate"),
   QuantityA=c(1,2,1,1,2,3,2),
   ProductB=c("table","doll","shoes","door","computer","computer","plate"),
   QuantityB=c(3,1,2,2,1,1,1)
)

write.csv(dat, "data-raw/p11_input1.csv", row.names=FALSE)

df1 <- dat %>% gather(key1, value1, c(2,4)) %>% select(-c(2,3))
df2 <- dat %>% gather(key2, value2, c(3,5)) %>% select(c(5))
df_out = cbind(df1,df2)

write.csv(df_out, "data-raw/p11_output1.csv", row.names=FALSE)

p11_output1 <- read.csv("data-raw/p11_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p11_output1, is.factor)
int.cols <- sapply(p11_output1, is.integer)

p11_output1[, fctr.cols] <- sapply(p11_output1[, fctr.cols], as.character)
p11_output1[, int.cols] <- sapply(p11_output1[, int.cols], as.numeric)
save(p11_output1, file = "data/p11_output1.rdata")

p11_input1 <- read.csv("data-raw/p11_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p11_input1, is.factor)
int.cols <- sapply(p11_input1, is.integer)

p11_input1[, fctr.cols] <- sapply(p11_input1[, fctr.cols], as.character)
p11_input1[, int.cols] <- sapply(p11_input1[, int.cols], as.numeric)
save(p11_input1, file = "data/p11_input1.rdata")
