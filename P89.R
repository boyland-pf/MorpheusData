# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 88
set.seed(1)
dat <- data.frame("CatA" = rep(c("A","B","C"), 4), "CatNum" = rep(1:2,6),
                  "SomeVal" = runif(12))

write.csv(dat, "data-raw/p89_input1.csv", row.names=FALSE)

df_out = dat %>% 
    unite(measurevar, CatA, CatNum) %>%
    gather(key, val, -SomeVal)  %>%
    group_by(val) %>%
    summarise(sumNew = sum(SomeVal))

write.csv(df_out, "data-raw/p89_output1.csv", row.names=FALSE)

p89_output1 <- read.csv("data-raw/p89_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p89_output1, is.factor)
int.cols <- sapply(p89_output1, is.integer)

p89_output1[, fctr.cols] <- sapply(p89_output1[, fctr.cols], as.character)
p89_output1[, int.cols] <- sapply(p89_output1[, int.cols], as.numeric)
save(p89_output1, file = "data/p89_output1.rdata")

p89_input1 <- read.csv("data-raw/p89_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p89_input1, is.factor)
int.cols <- sapply(p89_input1, is.integer)

p89_input1[, fctr.cols] <- sapply(p89_input1[, fctr.cols], as.character)
p89_input1[, int.cols] <- sapply(p89_input1[, int.cols], as.numeric)
save(p89_input1, file = "data/p89_input1.rdata")
