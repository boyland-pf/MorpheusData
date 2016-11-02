# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 38
dat <- read.table(text=
"
id  sex age trt.1 response.1 trt.2 response.2
1    M  15     A          1     B          1
2    M  22     A          1     B          1
3    F  43     A          1     B          1
4    M  28     A          1     B          1
5    F  39     A          1     B          1
6    M  47     A          1     B          1
", header=T)



write.csv(dat, "data-raw/p38_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(variable, value,
         trt.1:response.2) %>%
  separate(variable, c("variable", "number")) %>%
  spread(variable, value)

write.csv(df_out, "data-raw/p38_output1.csv", row.names=FALSE)

p38_output1 <- read.csv("data-raw/p38_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p38_output1, is.factor)
int.cols <- sapply(p38_output1, is.integer)

p38_output1[, fctr.cols] <- sapply(p38_output1[, fctr.cols], as.character)
p38_output1[, int.cols] <- sapply(p38_output1[, int.cols], as.numeric)
save(p38_output1, file = "data/p38_output1.rdata")

p38_input1 <- read.csv("data-raw/p38_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p38_input1, is.factor)
int.cols <- sapply(p38_input1, is.integer)

p38_input1[, fctr.cols] <- sapply(p38_input1[, fctr.cols], as.character)
p38_input1[, int.cols] <- sapply(p38_input1[, int.cols], as.numeric)
save(p38_input1, file = "data/p38_input1.rdata")
