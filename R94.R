# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
      ID    c_Al    c_D    c_Hy    occ
      C    0    0    1    2581
      D    1    0    1    1917
      E    0    0    1    2708
      F    0    1    0    2751
      G    1    1    0    1522
      H    0    1    0    657
      I    0    1    1    469
      J    0    1    1    2629
", header=T)

write.csv(dat, "data-raw/r94_input1.csv", row.names=FALSE)

df_out <- read.table(text=
"
      0    1
      1965.833333    1719.5
      2402.0    1605.6
      1643.333333    2060.8
", header=T)


##df_out = dat %>% gather(var, val, -1) %>% filter(val!=0) %>% select(-3) 
#%>% arrange(order_id)

write.csv(df_out, "data-raw/r94_output1.csv", row.names=FALSE)

r94_output1 <- read.csv("data-raw/r94_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r94_output1, is.factor)
int.cols <- sapply(r94_output1, is.integer)

r94_output1[, fctr.cols] <- sapply(r94_output1[, fctr.cols], as.character)
r94_output1[, int.cols] <- sapply(r94_output1[, int.cols], as.numeric)
save(r94_output1, file = "data/r94_output1.rdata")

r94_input1 <- read.csv("data-raw/r94_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r94_input1, is.factor)
int.cols <- sapply(r94_input1, is.integer)

r94_input1[, fctr.cols] <- sapply(r94_input1[, fctr.cols], as.character)
r94_input1[, int.cols] <- sapply(r94_input1[, int.cols], as.numeric)
save(r94_input1, file = "data/r94_input1.rdata")
