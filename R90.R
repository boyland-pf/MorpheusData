# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
      name1    con1_1    con1_2    con1_3    con2_1    con2_2    con2_3
      a    23    33    22    23    40    40
      b    25    34    22    22    50    40
      c    28    29    22    30    60    40
", header=T)

write.csv(dat, "data-raw/r90_input1.csv", row.names=FALSE)

df_out <- read.table(text=
"
      name1    con1    con2
      a    26.0    34.3333333333333
      b    27.0    37.3333333333333
      c    26.3333333333333    43.3333333333333
", header=T)


##df_out = dat %>% gather(var, val, -1) %>% filter(val!=0) %>% select(-3) 
#%>% arrange(order_id)

write.csv(df_out, "data-raw/r90_output1.csv", row.names=FALSE)

r90_output1 <- read.csv("data-raw/r90_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r90_output1, is.factor)
int.cols <- sapply(r90_output1, is.integer)

r90_output1[, fctr.cols] <- sapply(r90_output1[, fctr.cols], as.character)
r90_output1[, int.cols] <- sapply(r90_output1[, int.cols], as.numeric)
save(r90_output1, file = "data/r90_output1.rdata")

r90_input1 <- read.csv("data-raw/r90_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r90_input1, is.factor)
int.cols <- sapply(r90_input1, is.integer)

r90_input1[, fctr.cols] <- sapply(r90_input1[, fctr.cols], as.character)
r90_input1[, int.cols] <- sapply(r90_input1[, int.cols], as.numeric)
save(r90_input1, file = "data/r90_input1.rdata")
