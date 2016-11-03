# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 62
dat <- read.table(text=
"
   V2     V3            V4 
CCRG10  BranchDBMS         2.1845122
CCRG10  CacheDBMS          0.8619093
CCRG20  BranchDBMS         7.3522605
CCRG20  CacheDBMS          2.5523066
CCRG30  BranchDBMS        15.7628869
CCRG30  CacheDBMS          5.1411876
CCRG40  BranchDBMS        62.7625724
CCRG40  CacheDBMS          7.6714212
CCRG50  BranchDBMS        58.0909133
CCRG50  CacheDBMS         11.3979914
CCRG60  BranchDBMS        78.5095645
CCRG60  CacheDBMS         15.5988044
CCRG70  BranchDBMS        94.0637485
CCRG70  CacheDBMS         20.2977642
CCRG80  BranchDBMS       102.8716548
CCRG80  CacheDBMS         25.0142898
CCRG90  BranchDBMS       100.5247555
CCRG90  CacheDBMS         28.3753977
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
