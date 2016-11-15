# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 45
dat <- read.table(text=
"
       X       Y      Z          cluster
245 256882.0 4115 426.50          20
246 256882.7 4115 426.42          57
247 256883.9 4945 429.30         114
248 256884.6 4115 428.93         114
249 256885.4 4945 429.50          98
250 256886.1 4945 429.67          33
", header=T)



write.csv(dat, "data-raw/p45_input1.csv", row.names=FALSE)

df_out = dat %>%
  group_by(cluster) %>%
  summarise(Z = min(Z)) %>%
  inner_join(dat) %>% select(-Z)

write.csv(df_out, "data-raw/p45_output1.csv", row.names=FALSE)

p45_output1 <- read.csv("data-raw/p45_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p45_output1, is.factor)
int.cols <- sapply(p45_output1, is.integer)

p45_output1[, fctr.cols] <- sapply(p45_output1[, fctr.cols], as.character)
p45_output1[, int.cols] <- sapply(p45_output1[, int.cols], as.numeric)
save(p45_output1, file = "data/p45_output1.rdata")

p45_input1 <- read.csv("data-raw/p45_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p45_input1, is.factor)
int.cols <- sapply(p45_input1, is.integer)

p45_input1[, fctr.cols] <- sapply(p45_input1[, fctr.cols], as.character)
p45_input1[, int.cols] <- sapply(p45_input1[, int.cols], as.numeric)
save(p45_input1, file = "data/p45_input1.rdata")
