# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
      expr    time
      base_1d4    20
      base_1d4    40
      base_1d5    40
      base_1d5    80
      dplyr_1d4    2
      dplyr_1d4    4
      dplyr_1d5    8
      dplyr_1d5    12
", header=T)

write.csv(dat, "data-raw/r87_input1.csv", row.names=FALSE)

df_out <- read.table(text=
"
      size    base    dplyr    ratio
      1d4    30    3    10
      1d5    60    10    6
", header=T)


##df_out = dat %>% gather(var, val, -1) %>% filter(val!=0) %>% select(-3) 
#%>% arrange(order_id)

write.csv(df_out, "data-raw/r87_output1.csv", row.names=FALSE)

r87_output1 <- read.csv("data-raw/r87_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r87_output1, is.factor)
int.cols <- sapply(r87_output1, is.integer)

r87_output1[, fctr.cols] <- sapply(r87_output1[, fctr.cols], as.character)
r87_output1[, int.cols] <- sapply(r87_output1[, int.cols], as.numeric)
save(r87_output1, file = "data/r87_output1.rdata")

r87_input1 <- read.csv("data-raw/r87_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r87_input1, is.factor)
int.cols <- sapply(r87_input1, is.integer)

r87_input1[, fctr.cols] <- sapply(r87_input1[, fctr.cols], as.character)
r87_input1[, int.cols] <- sapply(r87_input1[, int.cols], as.numeric)
save(r87_input1, file = "data/r87_input1.rdata")
