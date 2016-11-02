# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 90
dat <- read.table(text=
"  x y value.1 value.2
    red a       1      13
    red b       2      14
    red c       3      15
    red d       4      16
   blue a       5      17
   blue b       6      18
   blue c       7      19
  blue d       8      20", header=T)

write.csv(dat, "data-raw/p90_input1.csv", row.names=FALSE)

df_out = dat %>%
      gather(Var, val, value.1, value.2) %>% 
      unite(Var1,Var, y) %>% 
      spread(Var1, val)

write.csv(df_out, "data-raw/p90_output1.csv", row.names=FALSE)

p90_output1 <- read.csv("data-raw/p90_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p90_output1, is.factor)
int.cols <- sapply(p90_output1, is.integer)

p90_output1[, fctr.cols] <- sapply(p90_output1[, fctr.cols], as.character)
p90_output1[, int.cols] <- sapply(p90_output1[, int.cols], as.numeric)
save(p90_output1, file = "data/p90_output1.rdata")

p90_input1 <- read.csv("data-raw/p90_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p90_input1, is.factor)
int.cols <- sapply(p90_input1, is.integer)

p90_input1[, fctr.cols] <- sapply(p90_input1[, fctr.cols], as.character)
p90_input1[, int.cols] <- sapply(p90_input1[, int.cols], as.numeric)
save(p90_input1, file = "data/p90_input1.rdata")
