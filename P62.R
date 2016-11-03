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



write.csv(dat, "data-raw/p62_input1.csv", row.names=FALSE)

df_out = dat %>%
    spread(V3, V4) %>% 
    mutate(wtimRes = BranchDBMS / CacheDBMS) %>% 
    gather(key, value, -V2)

write.csv(df_out, "data-raw/p62_output1.csv", row.names=FALSE)

p62_output1 <- read.csv("data-raw/p62_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p62_output1, is.factor)
int.cols <- sapply(p62_output1, is.integer)

p62_output1[, fctr.cols] <- sapply(p62_output1[, fctr.cols], as.character)
p62_output1[, int.cols] <- sapply(p62_output1[, int.cols], as.numeric)
save(p62_output1, file = "data/p62_output1.rdata")

p62_input1 <- read.csv("data-raw/p62_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p62_input1, is.factor)
int.cols <- sapply(p62_input1, is.integer)

p62_input1[, fctr.cols] <- sapply(p62_input1[, fctr.cols], as.character)
p62_input1[, int.cols] <- sapply(p62_input1[, int.cols], as.numeric)
save(p62_input1, file = "data/p62_input1.rdata")
