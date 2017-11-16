# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
      ID    Name    A    B    C
      ID1    A1    1    5    9
      ID2    B1    2    6    10
      ID3    C1    3    7    11
      ID4    D1    4    8    12
", header=T)

write.csv(dat, "data-raw/r86_input1.csv", row.names=FALSE)

df_out <- read.table(text=
"
      ID    flag
      ID1    14
      ID2    16
      ID3    18
      ID4    20
", header=T)


##df_out = dat %>% gather(var, val, -1) %>% filter(val!=0) %>% select(-3) 
#%>% arrange(order_id)

write.csv(df_out, "data-raw/r86_output1.csv", row.names=FALSE)

r86_output1 <- read.csv("data-raw/r86_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r86_output1, is.factor)
int.cols <- sapply(r86_output1, is.integer)

r86_output1[, fctr.cols] <- sapply(r86_output1[, fctr.cols], as.character)
r86_output1[, int.cols] <- sapply(r86_output1[, int.cols], as.numeric)
save(r86_output1, file = "data/r86_output1.rdata")

r86_input1 <- read.csv("data-raw/r86_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r86_input1, is.factor)
int.cols <- sapply(r86_input1, is.integer)

r86_input1[, fctr.cols] <- sapply(r86_input1[, fctr.cols], as.character)
r86_input1[, int.cols] <- sapply(r86_input1[, int.cols], as.numeric)
save(r86_input1, file = "data/r86_input1.rdata")
