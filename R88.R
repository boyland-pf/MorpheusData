# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
      Id    Group    Var1    Var2
      1    A    good    10
      2    A    good    2
      3    A    bad    3
      4    A    bad    2
      5    B    good    10
      6    B    bad    9
      7    B    good    2
      8    B    good    8
      9    C    bad    7
      10    C    good    5
      11    C    bad    7
      12    C    bad    9
", header=T)

write.csv(dat, "data-raw/r88_input1.csv", row.names=FALSE)

df_out <- read.table(text=
"
      Group    bad    good
      B    9    20
", header=T)


##df_out = dat %>% gather(var, val, -1) %>% filter(val!=0) %>% select(-3) 
#%>% arrange(order_id)

write.csv(df_out, "data-raw/r88_output1.csv", row.names=FALSE)

r88_output1 <- read.csv("data-raw/r88_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r88_output1, is.factor)
int.cols <- sapply(r88_output1, is.integer)

r88_output1[, fctr.cols] <- sapply(r88_output1[, fctr.cols], as.character)
r88_output1[, int.cols] <- sapply(r88_output1[, int.cols], as.numeric)
save(r88_output1, file = "data/r88_output1.rdata")

r88_input1 <- read.csv("data-raw/r88_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r88_input1, is.factor)
int.cols <- sapply(r88_input1, is.integer)

r88_input1[, fctr.cols] <- sapply(r88_input1[, fctr.cols], as.character)
r88_input1[, int.cols] <- sapply(r88_input1[, int.cols], as.numeric)
save(r88_input1, file = "data/r88_input1.rdata")
