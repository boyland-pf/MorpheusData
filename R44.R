# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 45
dat <- read.table(header=T, text='
 sbj f1.avg f1.sd f2.avg f2.sd  blabla
   A   10    6     50     10      bA
   B   12    5     70     11      bB
   C   20    7     20     8       bC
   D   22    8     22     9       bD
 ')


write.csv(dat, "data-raw/r44_input1.csv", row.names=FALSE)

df_out = dat %>% 
  gather(v, value, f1.avg:f2.sd) %>% 
  separate(v, c("var", "col")) %>% 
  spread(col, value)

write.csv(df_out, "data-raw/r44_output1.csv", row.names=FALSE)

r44_output1 <- read.csv("data-raw/r44_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r44_output1, is.factor)
int.cols <- sapply(r44_output1, is.integer)

r44_output1[, fctr.cols] <- sapply(r44_output1[, fctr.cols], as.character)
r44_output1[, int.cols] <- sapply(r44_output1[, int.cols], as.numeric)
save(r44_output1, file = "data/r44_output1.rdata")

r44_input1 <- read.csv("data-raw/r44_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r44_input1, is.factor)
int.cols <- sapply(r44_input1, is.integer)

r44_input1[, fctr.cols] <- sapply(r44_input1[, fctr.cols], as.character)
r44_input1[, int.cols] <- sapply(r44_input1[, int.cols], as.numeric)
save(r44_input1, file = "data/r44_input1.rdata")
