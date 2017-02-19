# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"V1 V2   V3          V4
a  1 High -0.62645381
a  2 High  0.18364332
a  3 High -0.83562861
a  4 High  1.59528080
a  1  Low  0.32950777
a  2  Low -0.82046838
a  3  Low  0.48742905
a  4  Low  0.73832471
b  1 High  0.57578135
b  2 High -0.30538839
b  3 High  1.51178117
b  4 High  0.38984324
b  1  Low -0.62124058
b  2  Low -2.21469989
b  3  Low  1.12493092
b  4  Low -0.04493361
", header=T)

write.csv(dat, "data-raw/r9_input1.csv", row.names=FALSE)

df_out = dat %>% spread(V3,V4) %>%
  mutate(Ratio = High/Low) %>%
  select(V1, V2, Ratio)


write.csv(df_out, "data-raw/r9_output1.csv", row.names=FALSE)

r9_output1 <- read.csv("data-raw/r9_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r9_output1, is.factor)
int.cols <- sapply(r9_output1, is.integer)

r9_output1[, fctr.cols] <- sapply(r9_output1[, fctr.cols], as.character)
r9_output1[, int.cols] <- sapply(r9_output1[, int.cols], as.numeric)
save(r9_output1, file = "data/r9_output1.rdata")

r9_input1 <- read.csv("data-raw/r9_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r9_input1, is.factor)
int.cols <- sapply(r9_input1, is.integer)

r9_input1[, fctr.cols] <- sapply(r9_input1[, fctr.cols], as.character)
r9_input1[, int.cols] <- sapply(r9_input1[, int.cols], as.numeric)
save(r9_input1, file = "data/r9_input1.rdata")
