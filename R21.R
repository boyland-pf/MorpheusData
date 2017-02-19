# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"obs pre.data1   post.data1  pre.data2   post.data2
 1   0.40    0.12    0.61    0.15
 2   0.21    0.05    0.18    0.49
 3   0.48    0.85    0.00    0.62
 4   0.66    0.29    0.88    0.56
", header=T)

write.csv(dat, "data-raw/r21_input1.csv", row.names=FALSE)

df_out = dat %>% gather(var, val, -obs) %>% 
    # separate into key and test labels
    separate(var, c('key', 'var')) %>% 
    # spread to wide form
    spread(var, val) #%>%
    # make it pretty so pre is before post for each obs
    #arrange(obs, desc(key))

write.csv(df_out, "data-raw/r21_output1.csv", row.names=FALSE)

r21_output1 <- read.csv("data-raw/r21_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r21_output1, is.factor)
int.cols <- sapply(r21_output1, is.integer)

r21_output1[, fctr.cols] <- sapply(r21_output1[, fctr.cols], as.character)
r21_output1[, int.cols] <- sapply(r21_output1[, int.cols], as.numeric)
save(r21_output1, file = "data/r21_output1.rdata")

r21_input1 <- read.csv("data-raw/r21_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r21_input1, is.factor)
int.cols <- sapply(r21_input1, is.integer)

r21_input1[, fctr.cols] <- sapply(r21_input1[, fctr.cols], as.character)
r21_input1[, int.cols] <- sapply(r21_input1[, int.cols], as.numeric)
save(r21_input1, file = "data/r21_input1.rdata")
