# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 62
dat <- read.table(text=
"
   V2     V3            V4 
CCRG10  BranchDBMS         2
CCRG10  CacheDBMS          3
CCRG20  BranchDBMS         7
CCRG20  CacheDBMS          2
CCRG30  BranchDBMS        15
CCRG30  CacheDBMS          5
CCRG40  BranchDBMS        62
CCRG40  CacheDBMS          7
CCRG50  BranchDBMS        58
CCRG50  CacheDBMS         11
", header=T)



write.csv(dat, "data-raw/r59_input1.csv", row.names=FALSE)

df_out = dat %>%
    spread(V3, V4) %>% 
    mutate(wtimRes = BranchDBMS / CacheDBMS) %>% 
    gather(key, value, -V2)

write.csv(df_out, "data-raw/r59_output1.csv", row.names=FALSE)

r59_output1 <- read.csv("data-raw/r59_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r59_output1, is.factor)
int.cols <- sapply(r59_output1, is.integer)

r59_output1[, fctr.cols] <- sapply(r59_output1[, fctr.cols], as.character)
r59_output1[, int.cols] <- sapply(r59_output1[, int.cols], as.numeric)
save(r59_output1, file = "data/r59_output1.rdata")

r59_input1 <- read.csv("data-raw/r59_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r59_input1, is.factor)
int.cols <- sapply(r59_input1, is.integer)

r59_input1[, fctr.cols] <- sapply(r59_input1[, fctr.cols], as.character)
r59_input1[, int.cols] <- sapply(r59_input1[, int.cols], as.numeric)
save(r59_input1, file = "data/r59_input1.rdata")
