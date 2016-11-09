# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat1 <- read.table(text=
"
 T1Column1  T1Column2  T1Column3  T1Column4 
 101  2001  3020  01-01-11 
 101  2002  3002  02-01-11 
 101  2001  3001  03-01-11 
 102  2002  3002  01-01-11 
", header=T)

dat2 <- read.table(text=
"
 T2Column1  T1Column2  T2Column3 
 20011  2001  200131 
 20012  2001  200132 
 20013  2001  200133 
", header=T)

dat3 <- read.table(text=
"
 T2Column1  T3Column2 
 20011      Site      
 20012      Site      
 20013      Site      
", header=T)

dat <- inner_join(dat1,dat2) %>% inner_join(dat3) %>% select(1,3,4,5,6,7)

write.csv(dat, "data-raw/f4_input1.csv", row.names=FALSE)

df_out = dat %>% 
  filter(T1Column4 == '01-01-11') %>% 
  select(-T1Column3,-T2Column3)

write.csv(df_out, "data-raw/f4_output1.csv", row.names=FALSE)

f4_output1 <- read.csv("data-raw/f4_output1.csv", check.names = FALSE)
fctr.cols <- sapply(f4_output1, is.factor)
int.cols <- sapply(f4_output1, is.integer)

f4_output1[, fctr.cols] <- sapply(f4_output1[, fctr.cols], as.character)
f4_output1[, int.cols] <- sapply(f4_output1[, int.cols], as.numeric)
save(f4_output1, file = "data/f4_output1.rdata")

f4_input1 <- read.csv("data-raw/f4_input1.csv", check.names = FALSE)
fctr.cols <- sapply(f4_input1, is.factor)
int.cols <- sapply(f4_input1, is.integer)

f4_input1[, fctr.cols] <- sapply(f4_input1[, fctr.cols], as.character)
f4_input1[, int.cols] <- sapply(f4_input1[, int.cols], as.numeric)
save(f4_input1, file = "data/f4_input1.rdata")
