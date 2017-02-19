# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"GeneID     D.1     T.1      D.8     T.8
A2M 8876.5 510.5 4318.3 8957.7 4092.4
ABL1 2120.8 480.3 1694.6   2471 1784.1
ACP1 1266.6 213.8 1337.9  831.5  814.1
", header=T)

write.csv(dat, "data-raw/r6_input1.csv", row.names=FALSE)

df_out = dat %>% 
  gather(pt.num.type, value, 2:4) %>%
  separate(pt.num.type, c("type", "pt.num")) %>%
  group_by(GeneID, type) %>%
  summarise(sum = sum(value))

write.csv(df_out, "data-raw/r6_output1.csv", row.names=FALSE)

r6_output1 <- read.csv("data-raw/r6_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r6_output1, is.factor)
int.cols <- sapply(r6_output1, is.integer)

r6_output1[, fctr.cols] <- sapply(r6_output1[, fctr.cols], as.character)
r6_output1[, int.cols] <- sapply(r6_output1[, int.cols], as.numeric)
save(r6_output1, file = "data/r6_output1.rdata")

r6_input1 <- read.csv("data-raw/r6_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r6_input1, is.factor)
int.cols <- sapply(r6_input1, is.integer)

r6_input1[, fctr.cols] <- sapply(r6_input1[, fctr.cols], as.character)
r6_input1[, int.cols] <- sapply(r6_input1[, int.cols], as.numeric)
save(r6_input1, file = "data/r6_input1.rdata")
