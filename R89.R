# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
      rowname    CA    DATE_1    TIME_1    ENTRIES_1    DATE_2    TIME_2    ENTRIES_2    DATE_3    TIME_3    ENTRIES_3
      1    A002    07-27-13    00:00:00    4209603    07-27-13    08:00:00    4209663    07-27-17    18:00:00    1209663
      2    A002    07-28-13    08:00:00    4210490    07-28-13    16:00:00    4210775    07-28-17    06:00:00    1210775
      3    A002    07-29-13    16:00:00    4211586    07-30-13    00:00:00    4212845    07-30-17    10:00:00    1212845
", header=T)

write.csv(dat, "data-raw/r89_input1.csv", row.names=FALSE)

df_out <- read.table(text=
"
      CA    DATE    ENTRIES    TIME
      A002    07-27-13    4209603    00:00:00
      A002    07-27-13    4209663    08:00:00
      A002    07-27-17    1209663    18:00:00
      A002    07-28-13    4210490    08:00:00
      A002    07-28-13    4210775    16:00:00
      A002    07-28-17    1210775    06:00:00
      A002    07-29-13    4211586    16:00:00
      A002    07-30-13    4212845    00:00:00
      A002    07-30-17    1212845    10:00:00
", header=T)


##df_out = dat %>% gather(var, val, -1) %>% filter(val!=0) %>% select(-3) 
#%>% arrange(order_id)

write.csv(df_out, "data-raw/r89_output1.csv", row.names=FALSE)

r89_output1 <- read.csv("data-raw/r89_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r89_output1, is.factor)
int.cols <- sapply(r89_output1, is.integer)

r89_output1[, fctr.cols] <- sapply(r89_output1[, fctr.cols], as.character)
r89_output1[, int.cols] <- sapply(r89_output1[, int.cols], as.numeric)
save(r89_output1, file = "data/r89_output1.rdata")

r89_input1 <- read.csv("data-raw/r89_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r89_input1, is.factor)
int.cols <- sapply(r89_input1, is.integer)

r89_input1[, fctr.cols] <- sapply(r89_input1[, fctr.cols], as.character)
r89_input1[, int.cols] <- sapply(r89_input1[, int.cols], as.numeric)
save(r89_input1, file = "data/r89_input1.rdata")
