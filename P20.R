# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat = data.frame(group=c('a', 'a', 'b', 'b'),
                  times=c('before', 'after', 'before', 'after'),
                  action_rate=c(0.1,0.15, 0.2, 0.18),
                  action_rate2=c(0.2,0.25, 0.3, 0.28))

write.csv(dat, "data-raw/p20_input1.csv", row.names=FALSE)

df_out = dat %>% gather(key, value, -group, -times) %>%
unite(col, key, times) %>%
spread(col, value)

write.csv(df_out, "data-raw/p20_output1.csv", row.names=FALSE)

p20_output1 <- read.csv("data-raw/p20_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p20_output1, is.factor)
int.cols <- sapply(p20_output1, is.integer)

p20_output1[, fctr.cols] <- sapply(p20_output1[, fctr.cols], as.character)
p20_output1[, int.cols] <- sapply(p20_output1[, int.cols], as.numeric)
save(p20_output1, file = "data/p20_output1.rdata")

p20_input1 <- read.csv("data-raw/p20_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p20_input1, is.factor)
int.cols <- sapply(p20_input1, is.integer)

p20_input1[, fctr.cols] <- sapply(p20_input1[, fctr.cols], as.character)
p20_input1[, int.cols] <- sapply(p20_input1[, int.cols], as.numeric)
save(p20_input1, file = "data/p20_input1.rdata")
