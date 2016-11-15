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


write.csv(dat, "data-raw/p48_input1.csv", row.names=FALSE)

df_out = dat %>% 
  gather(v, value, f1.avg:f2.sd) %>% 
  separate(v, c("var", "col")) %>% 
  spread(col, value)

write.csv(df_out, "data-raw/p48_output1.csv", row.names=FALSE)

p48_output1 <- read.csv("data-raw/p48_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p48_output1, is.factor)
int.cols <- sapply(p48_output1, is.integer)

p48_output1[, fctr.cols] <- sapply(p48_output1[, fctr.cols], as.character)
p48_output1[, int.cols] <- sapply(p48_output1[, int.cols], as.numeric)
save(p48_output1, file = "data/p48_output1.rdata")

p48_input1 <- read.csv("data-raw/p48_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p48_input1, is.factor)
int.cols <- sapply(p48_input1, is.integer)

p48_input1[, fctr.cols] <- sapply(p48_input1[, fctr.cols], as.character)
p48_input1[, int.cols] <- sapply(p48_input1[, int.cols], as.numeric)
save(p48_input1, file = "data/p48_input1.rdata")
