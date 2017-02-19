# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 38
dat <- read.table(text=
"
id  sex  trt.1 response.1 trt.2 response.2
1    M       A          1     B          1
2    M       A          1     B          1
3    F       A          1     B          1
4    M       A          1     B          1
5    F       A          1     B          1
6    M       A          1     B          1
", header=T)



write.csv(dat, "data-raw/r37_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(variable, value,
         -id,-sex) %>%
  separate(variable, c("variableNew", "number")) %>%
  spread(variableNew, value)

write.csv(df_out, "data-raw/r37_output1.csv", row.names=FALSE)

r37_output1 <- read.csv("data-raw/r37_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r37_output1, is.factor)
int.cols <- sapply(r37_output1, is.integer)

r37_output1[, fctr.cols] <- sapply(r37_output1[, fctr.cols], as.character)
r37_output1[, int.cols] <- sapply(r37_output1[, int.cols], as.numeric)
save(r37_output1, file = "data/r37_output1.rdata")

r37_input1 <- read.csv("data-raw/r37_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r37_input1, is.factor)
int.cols <- sapply(r37_input1, is.integer)

r37_input1[, fctr.cols] <- sapply(r37_input1[, fctr.cols], as.character)
r37_input1[, int.cols] <- sapply(r37_input1[, int.cols], as.numeric)
save(r37_input1, file = "data/r37_input1.rdata")
