# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
      Timepoint    Group1    Error1_Group1    Group2    Error2_Group1
      7    60    4    60    14
      14    66    6    90    16
      21    88    8    120    13
      28    90    2    150    25
", header=T)

write.csv(dat, "data-raw/r83_input1.csv", row.names=FALSE)

df_out <- read.table(text=
"
      Group1    Group2    Error1    mGroup    Error2
      60    60    4    Group1    14
      66    90    6    Group1    16
      88    120    8    Group1    13
      90    150    2    Group1    25
", header=T)


##df_out = dat %>% gather(var, val, -1) %>% filter(val!=0) %>% select(-3) 
#%>% arrange(order_id)

write.csv(df_out, "data-raw/r83_output1.csv", row.names=FALSE)

r83_output1 <- read.csv("data-raw/r83_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r83_output1, is.factor)
int.cols <- sapply(r83_output1, is.integer)

r83_output1[, fctr.cols] <- sapply(r83_output1[, fctr.cols], as.character)
r83_output1[, int.cols] <- sapply(r83_output1[, int.cols], as.numeric)
save(r83_output1, file = "data/r83_output1.rdata")

r83_input1 <- read.csv("data-raw/r83_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r83_input1, is.factor)
int.cols <- sapply(r83_input1, is.integer)

r83_input1[, fctr.cols] <- sapply(r83_input1[, fctr.cols], as.character)
r83_input1[, int.cols] <- sapply(r83_input1[, int.cols], as.numeric)
save(r83_input1, file = "data/r83_input1.rdata")
