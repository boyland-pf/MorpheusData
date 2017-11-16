# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
      expr    time    ext    misc
      base_1d4    20    100    A
      base_1d4    40    200    B
      base_1d5    40    300    C
      base_1d5    80    400    D
      dplyr_1d4    2    500    E
      dplyr_1d4    4    600    F
      dplyr_1d5    8    700    G
      dplyr_1d5    12    800    H
", header=T)

write.csv(dat, "data-raw/r87_input1.csv", row.names=FALSE)

df_out <- read.table(text=
"
      col2    base    dplyr    ratio
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
