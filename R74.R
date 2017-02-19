# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 87
dat <- read.table(text=
"Which Color Response Count
Control Red 2 10
Control Blue 3 20
Treatment Red 1 14
Treatment Blue 4 21", header=T)

write.csv(dat, "data-raw/r74_input1.csv", row.names=FALSE)

  df_out = dat %>%
  gather(var, val, Response:Count) %>%
  unite(RN, var, Which) %>%           
  spread(RN, val)                     

write.csv(df_out, "data-raw/r74_output1.csv", row.names=FALSE)

r74_output1 <- read.csv("data-raw/r74_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r74_output1, is.factor)
int.cols <- sapply(r74_output1, is.integer)

r74_output1[, fctr.cols] <- sapply(r74_output1[, fctr.cols], as.character)
r74_output1[, int.cols] <- sapply(r74_output1[, int.cols], as.numeric)
save(r74_output1, file = "data/r74_output1.rdata")

r74_input1 <- read.csv("data-raw/r74_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r74_input1, is.factor)
int.cols <- sapply(r74_input1, is.integer)

r74_input1[, fctr.cols] <- sapply(r74_input1[, fctr.cols], as.character)
r74_input1[, int.cols] <- sapply(r74_input1[, int.cols], as.numeric)
save(r74_input1, file = "data/r74_input1.rdata")
