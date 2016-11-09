# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
loginid provider city
l1 p5 a
l1 p4 b
l1 p3 c
l1 p2 d
l1 p1 e
l1 p0 f
l2 p5 g
l2 p4 h
l2 p3 i
l2 p2 j
l2 p1 k
l3 p1 h
l2 p1 l
l4 p1 c
l4 p2 d
l4 p3 e
l4 p0 k
l4 p4 l
l6 p0 a
l6 p1 c
l6 p2 d
l6 p3 a
l6 p4 d
l6 p5 l
", header=T)

write.csv(dat, "data-raw/f3_input1.csv", row.names=FALSE)

df_out = dat %>% 
  group_by(loginid) %>% summarise(cnt=n_distinct(provider)) %>% filter(cnt > 5) %>% select(loginid)

write.csv(df_out, "data-raw/f3_output1.csv", row.names=FALSE)

f3_output1 <- read.csv("data-raw/f3_output1.csv", check.names = FALSE)
fctr.cols <- sapply(f3_output1, is.factor)
int.cols <- sapply(f3_output1, is.integer)

f3_output1[, fctr.cols] <- sapply(f3_output1[, fctr.cols], as.character)
f3_output1[, int.cols] <- sapply(f3_output1[, int.cols], as.numeric)
save(f3_output1, file = "data/f3_output1.rdata")

f3_input1 <- read.csv("data-raw/f3_input1.csv", check.names = FALSE)
fctr.cols <- sapply(f3_input1, is.factor)
int.cols <- sapply(f3_input1, is.integer)

f3_input1[, fctr.cols] <- sapply(f3_input1[, fctr.cols], as.character)
f3_input1[, int.cols] <- sapply(f3_input1[, int.cols], as.numeric)
save(f3_input1, file = "data/f3_input1.rdata")
