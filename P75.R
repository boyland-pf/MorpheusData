# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
 X1    X2    X3
 S1   0.1     1
 S2   0.2     1
 S3   0.3     1
 S4   0.4     2
 S5   0.5     2
 S1   0.6     2
 S2   0.7     3
 S3   0.8     3
 S4   0.9     3
 S5   1.0     4
", header=T)

write.csv(dat, "data-raw/p75_input1.csv", row.names=FALSE)

df_out = dat %>% group_by(X1, X3) %>%
  summarize(X2.avg = mean(X2)) %>% 
  spread(X1, X2.avg) %>% 
  filter(X3 < 3)

write.csv(df_out, "data-raw/p75_output1.csv", row.names=FALSE)

p75_output1 <- read.csv("data-raw/p75_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p75_output1, is.factor)
int.cols <- sapply(p75_output1, is.integer)

p75_output1[, fctr.cols] <- sapply(p75_output1[, fctr.cols], as.character)
p75_output1[, int.cols] <- sapply(p75_output1[, int.cols], as.numeric)
save(p75_output1, file = "data/p75_output1.rdata")

p75_input1 <- read.csv("data-raw/p75_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p75_input1, is.factor)
int.cols <- sapply(p75_input1, is.integer)

p75_input1[, fctr.cols] <- sapply(p75_input1[, fctr.cols], as.character)
p75_input1[, int.cols] <- sapply(p75_input1[, int.cols], as.numeric)
save(p75_input1, file = "data/p75_input1.rdata")
