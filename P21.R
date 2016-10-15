# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"obs pre.data1   post.data1  pre.data2   post.data2  pre.data3   post.data3
1   0.40    0.12    0.61    0.15    0.58    0.06
2   0.21    0.05    0.18    0.49    0.35    0.24
3   0.48    0.85    0.00    0.62    0.96    0.37
4   0.66    0.29    0.88    0.56    0.13    0.72
", header=T)

write.csv(dat, "data-raw/p21_input1.csv", row.names=FALSE)

df_out = dat %>% gather(var, val, -obs) %>% 
    # separate into key and test labels
    separate(var, c('key', 'var')) %>% 
    # spread to wide form
    spread(var, val) %>%
    # make it pretty so pre is before post for each obs
    arrange(obs, desc(key))

write.csv(df_out, "data-raw/p21_output1.csv", row.names=FALSE)

output1 <- read.csv("data-raw/p21_output1.csv", check.names = FALSE)
fctr.cols <- sapply(output1, is.factor)
int.cols <- sapply(output1, is.integer)

output1[, fctr.cols] <- sapply(output1[, fctr.cols], as.character)
output1[, int.cols] <- sapply(output1[, int.cols], as.numeric)
save(output1, file = "data/p21_output1.rdata")

input1 <- read.csv("data-raw/p21_input1.csv", check.names = FALSE)
fctr.cols <- sapply(input1, is.factor)
int.cols <- sapply(input1, is.integer)

input1[, fctr.cols] <- sapply(input1[, fctr.cols], as.character)
input1[, int.cols] <- sapply(input1[, int.cols], as.numeric)
save(input1, file = "data/p21_input1.rdata")
