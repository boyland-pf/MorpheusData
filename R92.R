# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
      Geotype    Strategy    Year.1    Year.2
      A    Demand    1    5
      A    Strategy_1    2    6
      A    Strategy_2    3    7
      B    Demand    8    8
      B    Strategy_1    9    9
      B    Strategy_2    10    10
      C    Demand    8    8
      C    Strategy_1    9    9
      C    Strategy_2    10    10
", header=T)

write.csv(dat, "data-raw/r92_input1.csv", row.names=FALSE)

df_out <- read.table(text=
"
      Geotype    Year.1    Year.2
      A    5    13
      B    19    19
      C    19    19
", header=T)


##df_out = dat %>% gather(var, val, -1) %>% filter(val!=0) %>% select(-3) 
#%>% arrange(order_id)

write.csv(df_out, "data-raw/r92_output1.csv", row.names=FALSE)

r92_output1 <- read.csv("data-raw/r92_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r92_output1, is.factor)
int.cols <- sapply(r92_output1, is.integer)

r92_output1[, fctr.cols] <- sapply(r92_output1[, fctr.cols], as.character)
r92_output1[, int.cols] <- sapply(r92_output1[, int.cols], as.numeric)
save(r92_output1, file = "data/r92_output1.rdata")

r92_input1 <- read.csv("data-raw/r92_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r92_input1, is.factor)
int.cols <- sapply(r92_input1, is.integer)

r92_input1[, fctr.cols] <- sapply(r92_input1[, fctr.cols], as.character)
r92_input1[, int.cols] <- sapply(r92_input1[, int.cols], as.numeric)
save(r92_input1, file = "data/r92_input1.rdata")
