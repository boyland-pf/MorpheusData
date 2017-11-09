# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
      GeneID    D_1    T_1    D_2    T_2    D_3    T_3    D_4    T_4    D_5    T_5    D_6    T_6    D_7    T_7    D_8    T_8
      A2M    8876.5    8857.9    10246.8    9453.9    6279.6    3846.5    8735.3    6609.9    7732.95    2452.4    8705.2    6679.0    7510.5    4318.3    8957.7    4092.4
      ABL1    2120.8    1664.9    2525.0    1546.4    1993.0    1713.7    1849.7    1761.9    2297.7    2462.5    2698.2    1975.8    2480.3    1694.6    2471.0    1784.1
      ACP1    1266.6    1347.1    910.95    725.1    1327.6    1589.5    1175.0    1086.9    1187.3    1065.15    1080.0    1048.2    1213.8    1337.9    831.5    814.1
", header=T)

write.csv(dat, "data-raw/r84_input1.csv", row.names=FALSE)

df_out <- read.table(text=
"
      GeneID    type    sum
      A2M    D    67044.55
      A2M    T    46310.3
      ABL1    D    18435.7
      ABL1    T    14603.9
      ACP1    D    8992.75
      ACP1    T    9013.95
", header=T)


##df_out = dat %>% gather(var, val, -1) %>% filter(val!=0) %>% select(-3) 
#%>% arrange(order_id)

write.csv(df_out, "data-raw/r84_output1.csv", row.names=FALSE)

r84_output1 <- read.csv("data-raw/r84_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r84_output1, is.factor)
int.cols <- sapply(r84_output1, is.integer)

r84_output1[, fctr.cols] <- sapply(r84_output1[, fctr.cols], as.character)
r84_output1[, int.cols] <- sapply(r84_output1[, int.cols], as.numeric)
save(r84_output1, file = "data/r84_output1.rdata")

r84_input1 <- read.csv("data-raw/r84_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r84_input1, is.factor)
int.cols <- sapply(r84_input1, is.integer)

r84_input1[, fctr.cols] <- sapply(r84_input1[, fctr.cols], as.character)
r84_input1[, int.cols] <- sapply(r84_input1[, int.cols], as.numeric)
save(r84_input1, file = "data/r84_input1.rdata")
