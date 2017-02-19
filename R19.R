# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
 dat =   structure(c("nuclear", "nuclear", "child", "child", "child", 
"acquaintance", "nuclear and acquaintance", "nuclear and acquaintance", 
"notnotnot", "nuclear", "nuclear", "nuclear", "child", "child", 
"child", "alone", "nuclear and acquaintance", "nuclear and acquaintance", 
"notnotnot", "nuclear", "nuclear", "child", "child", "child", 
"child", "nuclear", "nuclear and acquaintance", "nuclear and acquaintance", 
"notnotnot", "nuclear", "nuclear", "child", "child", "child", 
"nuclear", "nuclear", "nuclear and acquaintance", "nuclear and acquaintance", 
"notnotnot", "nuclear", "nuclear", "nuclear", "child", "child", 
 "nuclear", "nuclear", "nuclear and acquaintance", "nuclear and acquaintance", 
"notnotnot", "nuclear", "nuclear", "nuclear", "nuclear", "nuclear", 
"nuclear", "nuclear", "nuclear and acquaintance", "nuclear and acquaintance", 
"notnotnot", "nuclear", "nuclear", "nuclear", "nuclear", "nuclear", 
"nuclear", "nuclear", "nuclear and acquaintance", "nuclear and acquaintance", 
"notnotnot", "nuclear", "nuclear", "nuclear", "nuclear", "nuclear", 
"nuclear", "nuclear", "nuclear and acquaintance", "nuclear and acquaintance", 
"notnotnot", "nuclear", "nuclear", "nuclear", "nuclear", "nuclear", 
"nuclear", "nuclear", "nuclear and acquaintance", "nuclear and acquaintance", 
"notnotnot", "nuclear", "nuclear", "nuclear", "nuclear", "nuclear", 
"nuclear", "nuclear", "nuclear and acquaintance", "nuclear and acquaintance", 
"notnotnot", "nuclear", "nuclear", "nuclear", "nuclear", "nuclear", 
"nuclear", "nuclear", "nuclear and acquaintance", "nuclear and acquaintance", 
"notnotnot", "nuclear", "nuclear", "nuclear", "nuclear", "nuclear", 
"nuclear", "nuclear", "nuclear and acquaintance", "nuclear and acquaintance", 
"partner", "nuclear", "nuclear", "nuclear", "nuclear", "nuclear", 
"nuclear", "nuclear", "nuclear and acquaintance", "nuclear and acquaintance", 
 "partner", "nuclear", "nuclear", "nuclear", "nuclear", "nuclear and acquaintance", 
 "nuclear", "nuclear", "nuclear and acquaintance", "nuclear and  acquaintance", 
 "notnotnot", "nuclear", "nuclear", "nuclear", "nuclear", "nuclear and     acquaintance", 
 "nuclear", "nuclear", "nuclear and acquaintance", "nuclear and acquaintance", 
 "notnotnot", "nuclear", "nuclear", "nuclear", "nuclear", "nuclear and    acquaintance", 
 "nuclear", "nuclear", "nuclear", "nuclear", "notnotnot", "nuclear", 
  "nuclear", "nuclear", "nuclear", "nuclear and acquaintance", 
 "nuclear", "nuclear", "nuclear", "nuclear", "notnotnot", "nuclear", 
"nuclear", "nuclear", "nuclear", "nuclear and acquaintance", 
"nuclear", "nuclear", "nuclear", "nuclear", "notnotnot", "nuclear", 
"nuclear", "nuclear", "nuclear", "nuclear and acquaintance", 
"nuclear", "nuclear", "nuclear", "nuclear", "notnotnot", "nuclear", 
"nuclear", "nuclear", "nuclear", "nuclear and acquaintance", 
"nuclear", "nuclear", "child", "nuclear", "notnotnot", "nuclear", 
"nuclear", "nuclear", "nuclear", "nuclear and acquaintance", 
"nuclear", "nuclear", "child", "alone", "notnotnot", "nuclear"
), .Dim = c(10L, 21L), .Dimnames = list(c("1", "2", "3", "4", 
"5", "6", "7", "8", "9", "10"), c("12:10", "12:20", "12:30", 
"12:40", "12:50", "13:00", "13:10", "13:20", "13:30", "13:40", 
"13:50", "14:00", "14:10", "14:20", "14:30", "14:40", "14:50", 
"15:00", "15:10", "15:20", "15:30")))  %>% as.data.frame  %>% select(1,2,3)  %>% filter(`12:20` != "alone")

write.csv(dat, "data-raw/r19_input1.csv", row.names=FALSE)

df_out = dat %>% gather %>% 
  group_by(key, value) %>% 
  summarise(N = n()) %>% 
  spread(key, N)

write.csv(df_out, "data-raw/r19_output1.csv", row.names=FALSE)

r19_output1 <- read.csv("data-raw/r19_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r19_output1, is.factor)
int.cols <- sapply(r19_output1, is.integer)

r19_output1[, fctr.cols] <- sapply(r19_output1[, fctr.cols], as.character)
r19_output1[, int.cols] <- sapply(r19_output1[, int.cols], as.numeric)
save(r19_output1, file = "data/r19_output1.rdata")

r19_input1 <- read.csv("data-raw/r19_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r19_input1, is.factor)
int.cols <- sapply(r19_input1, is.integer)

r19_input1[, fctr.cols] <- sapply(r19_input1[, fctr.cols], as.character)
r19_input1[, int.cols] <- sapply(r19_input1[, int.cols], as.numeric)
save(r19_input1, file = "data/r19_input1.rdata")
