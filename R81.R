# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
      ID    a    b    d    O
      bo    1    -36    -11    Nn
      bo    4    -16    -10    Nn
      bo    2    -18    -9    Nn
      co    9    48    -8    Nn
      co    6    59    -7    Nn
      co    5    12    -6    Nn
      do    7    -7    -5    Hy
      do    8    36    -4    Hy
      do    11    -34    -3    Hy
      fo    3    57    -2    Hy
      fo    10    -21    -1    Hy
      fo    12    17    0    Hy
", header=T)

write.csv(dat, "data-raw/r81_input1.csv", row.names=FALSE)

df_out <- read.table(text=
"
      O    value
      Nn    1.388889
", header=T)


##df_out = dat %>% gather(var, val, -1) %>% filter(val!=0) %>% select(-3) 
#%>% arrange(order_id)

write.csv(df_out, "data-raw/r81_output1.csv", row.names=FALSE)

r81_output1 <- read.csv("data-raw/r81_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r81_output1, is.factor)
int.cols <- sapply(r81_output1, is.integer)

r81_output1[, fctr.cols] <- sapply(r81_output1[, fctr.cols], as.character)
r81_output1[, int.cols] <- sapply(r81_output1[, int.cols], as.numeric)
save(r81_output1, file = "data/r81_output1.rdata")

r81_input1 <- read.csv("data-raw/r81_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r81_input1, is.factor)
int.cols <- sapply(r81_input1, is.integer)

r81_input1[, fctr.cols] <- sapply(r81_input1[, fctr.cols], as.character)
r81_input1[, int.cols] <- sapply(r81_input1[, int.cols], as.numeric)
save(r81_input1, file = "data/r81_input1.rdata")
