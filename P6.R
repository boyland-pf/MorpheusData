# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"GeneID     D.1     T.1      D.2     T.2     D.3     T.3     D.4     T.4      D.5      T.5     D.6     T.6     D.7     T.7     D.8     T.8
A2M 8876.5 8857.9 10246.8 9453.9 6279.6 3846.5 8735.3 6609.9 7732.95  2452.4 8705.2   6679 7510.5 4318.3 8957.7 4092.4
ABL1 2120.8 1664.9    2525 1546.4   1993 1713.7 1849.7 1761.9  2297.7  2462.5 2698.2 1975.8 2480.3 1694.6   2471 1784.1
ACP1 1266.6 1347.1  910.95  725.1 1327.6 1589.5   1175 1086.9  1187.3 1065.15   1080 1048.2 1213.8 1337.9  831.5  814.1
", header=T)

write.csv(dat, "data-raw/p6_input1.csv", row.names=FALSE)

df_out = dat %>% 
  gather(pt.num.type, value, 2:5) %>%
  separate(pt.num.type, c("type", "pt.num")) %>%
  group_by(GeneID, type) %>%
  summarise(sum = sum(value))

write.csv(df_out, "data-raw/p6_output1.csv", row.names=FALSE)

p6_output1 <- read.csv("data-raw/p6_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p6_output1, is.factor)
int.cols <- sapply(p6_output1, is.integer)

p6_output1[, fctr.cols] <- sapply(p6_output1[, fctr.cols], as.character)
p6_output1[, int.cols] <- sapply(p6_output1[, int.cols], as.numeric)
save(p6_output1, file = "data/p6_output1.rdata")

p6_input1 <- read.csv("data-raw/p6_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p6_input1, is.factor)
int.cols <- sapply(p6_input1, is.integer)

p6_input1[, fctr.cols] <- sapply(p6_input1[, fctr.cols], as.character)
p6_input1[, int.cols] <- sapply(p6_input1[, int.cols], as.numeric)
save(p6_input1, file = "data/p6_input1.rdata")
