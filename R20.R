# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat = data.frame(group=c('a', 'a', 'b', 'b'),
                  times=c('before', 'after', 'before', 'after'),
                  action_rate=c(0.1,0.15, 0.2, 0.18),
                  action_rate2=c(0.2,0.25, 0.3, 0.28))

write.csv(dat, "data-raw/r20_input1.csv", row.names=FALSE)

df_out = dat %>% gather(key, value, -group, -times) %>%
unite(col, key, times) %>%
spread(col, value)

write.csv(df_out, "data-raw/r20_output1.csv", row.names=FALSE)

r20_output1 <- read.csv("data-raw/r20_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r20_output1, is.factor)
int.cols <- sapply(r20_output1, is.integer)

r20_output1[, fctr.cols] <- sapply(r20_output1[, fctr.cols], as.character)
r20_output1[, int.cols] <- sapply(r20_output1[, int.cols], as.numeric)
save(r20_output1, file = "data/r20_output1.rdata")

r20_input1 <- read.csv("data-raw/r20_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r20_input1, is.factor)
int.cols <- sapply(r20_input1, is.integer)

r20_input1[, fctr.cols] <- sapply(r20_input1[, fctr.cols], as.character)
r20_input1[, int.cols] <- sapply(r20_input1[, int.cols], as.numeric)
save(r20_input1, file = "data/r20_input1.rdata")
