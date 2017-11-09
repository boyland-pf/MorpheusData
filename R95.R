# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
      ID    name    MGW.one    MGW.two    HEL.one    HEL.two
      A    Tom    10.0    19    12    13.0
      B    Jim    -13.29    13    12    -0.12
      C    Kate    -6.95    10    15    4.0
", header=T)

write.csv(dat, "data-raw/r95_input1.csv", row.names=FALSE)

df_out <- read.table(text=
"
      ID    HEL    MGW
      A    12.5    14.5
      B    5.94    -0.145
      C    9.5    1.525
", header=T)


##df_out = dat %>% gather(var, val, -1) %>% filter(val!=0) %>% select(-3) 
#%>% arrange(order_id)

write.csv(df_out, "data-raw/r95_output1.csv", row.names=FALSE)

r95_output1 <- read.csv("data-raw/r95_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r95_output1, is.factor)
int.cols <- sapply(r95_output1, is.integer)

r95_output1[, fctr.cols] <- sapply(r95_output1[, fctr.cols], as.character)
r95_output1[, int.cols] <- sapply(r95_output1[, int.cols], as.numeric)
save(r95_output1, file = "data/r95_output1.rdata")

r95_input1 <- read.csv("data-raw/r95_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r95_input1, is.factor)
int.cols <- sapply(r95_input1, is.integer)

r95_input1[, fctr.cols] <- sapply(r95_input1[, fctr.cols], as.character)
r95_input1[, int.cols] <- sapply(r95_input1[, int.cols], as.numeric)
save(r95_input1, file = "data/r95_input1.rdata")
