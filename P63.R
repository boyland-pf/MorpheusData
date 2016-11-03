# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 63
dat <- read.table(text=
"
Market    Variables  median  lower.limit  upper.limit
 market_1   var_1      2.78    2.71         2.72
 market_1   var_2      3.21    2.96         3.44
 market_2   var_1      2.95    2.79         3.11
 market_2   var_2      2.11    1.91         2.30
", header=T)



write.csv(dat, "data-raw/p63_input1.csv", row.names=FALSE)

df_out = dat %>%
    gather(Var, Val, median:upper.limit) %>% 
    unite(VarN,Variables, Var) %>%
    spread(VarN, Val)

write.csv(df_out, "data-raw/p63_output1.csv", row.names=FALSE)

p63_output1 <- read.csv("data-raw/p63_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p63_output1, is.factor)
int.cols <- sapply(p63_output1, is.integer)

p63_output1[, fctr.cols] <- sapply(p63_output1[, fctr.cols], as.character)
p63_output1[, int.cols] <- sapply(p63_output1[, int.cols], as.numeric)
save(p63_output1, file = "data/p63_output1.rdata")

p63_input1 <- read.csv("data-raw/p63_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p63_input1, is.factor)
int.cols <- sapply(p63_input1, is.integer)

p63_input1[, fctr.cols] <- sapply(p63_input1[, fctr.cols], as.character)
p63_input1[, int.cols] <- sapply(p63_input1[, int.cols], as.numeric)
save(p63_input1, file = "data/p63_input1.rdata")
