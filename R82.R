# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
      Color    Type    W1    W2    W3    W4
      red    Outdoor    2    3    4    5
      red    Indoor    5    6    7    8
      blue    Both    6    7    8    9
      green    Indoor    8    9    10    11
      blue    Indoor    11    12    13    14
      blue    Both    12    13    14    15
      red    Indoor    14    15    16    17
      red    Outdoor    14    15    16    17
      yellow    Outdoor    12    13    14    15
      green    Indoor    2    3    4    5
", header=T)

write.csv(dat, "data-raw/r82_input1.csv", row.names=FALSE)

df_out <- read.table(text=
"
      Color    Week    Count
      blue    W1    2
      blue    W2    2
      blue    W3    2
      blue    W4    2
      green    W4    1
      red    W1    2
      red    W2    2
      red    W3    2
      red    W4    2
      yellow    W1    1
      yellow    W2    1
      yellow    W3    1
      yellow    W4    1
", header=T)


##df_out = dat %>% gather(var, val, -1) %>% filter(val!=0) %>% select(-3) 
#%>% arrange(order_id)

write.csv(df_out, "data-raw/r82_output1.csv", row.names=FALSE)

r82_output1 <- read.csv("data-raw/r82_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r82_output1, is.factor)
int.cols <- sapply(r82_output1, is.integer)

r82_output1[, fctr.cols] <- sapply(r82_output1[, fctr.cols], as.character)
r82_output1[, int.cols] <- sapply(r82_output1[, int.cols], as.numeric)
save(r82_output1, file = "data/r82_output1.rdata")

r82_input1 <- read.csv("data-raw/r82_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r82_input1, is.factor)
int.cols <- sapply(r82_input1, is.integer)

r82_input1[, fctr.cols] <- sapply(r82_input1[, fctr.cols], as.character)
r82_input1[, int.cols] <- sapply(r82_input1[, int.cols], as.numeric)
save(r82_input1, file = "data/r82_input1.rdata")
