# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
      name    metric    values
      Eric    height    6
      Bob    height    5
      Mark    height    4
      Bob    weight    120
      Bob    weight    118
      Eric    weight    100
      Mark    weight    180
      Eric    grade    A
      Bob    grade    B
      Mark    grade    C
", header=T)

write.csv(dat, "data-raw/r85_input1.csv", row.names=FALSE)

df_out <- read.table(text=
"
      name    grade    height    weight
      Bob    1    1    2
      Eric    1    1    1
", header=T)


##df_out = dat %>% gather(var, val, -1) %>% filter(val!=0) %>% select(-3) 
#%>% arrange(order_id)

write.csv(df_out, "data-raw/r85_output1.csv", row.names=FALSE)

r85_output1 <- read.csv("data-raw/r85_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r85_output1, is.factor)
int.cols <- sapply(r85_output1, is.integer)

r85_output1[, fctr.cols] <- sapply(r85_output1[, fctr.cols], as.character)
r85_output1[, int.cols] <- sapply(r85_output1[, int.cols], as.numeric)
save(r85_output1, file = "data/r85_output1.rdata")

r85_input1 <- read.csv("data-raw/r85_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r85_input1, is.factor)
int.cols <- sapply(r85_input1, is.integer)

r85_input1[, fctr.cols] <- sapply(r85_input1[, fctr.cols], as.character)
r85_input1[, int.cols] <- sapply(r85_input1[, int.cols], as.numeric)
save(r85_input1, file = "data/r85_input1.rdata")
