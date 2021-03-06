# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 43
dat <- read.table(text=
"
          Exposure Signal  Noise ill ADC
          201     0.01  185.0 0.6744   1  12
          471     0.03  210.2 0.7683   4  12
          101     0.01  218.2 0.8356   1  10
          381     0.03  249.5 0.8609   4  10
          1       0.01  258.4 0.8988   1   9
          301     0.03  292.7 0.8326   4   9
", header=T)


map=data.frame(ill=c(1,4,10), factor=c(1,3,11.5))


write.csv(dat, "data-raw/r42_input1.csv", row.names=FALSE)
write.csv(map, "data-raw/r42_input2.csv", row.names=FALSE)

df_out = dat %>% inner_join(map) %>% mutate(ExposureNew=Exposure/factor) %>% select(-factor,-Exposure)

write.csv(df_out, "data-raw/r42_output1.csv", row.names=FALSE)

r42_output1 <- read.csv("data-raw/r42_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r42_output1, is.factor)
int.cols <- sapply(r42_output1, is.integer)

r42_output1[, fctr.cols] <- sapply(r42_output1[, fctr.cols], as.character)
r42_output1[, int.cols] <- sapply(r42_output1[, int.cols], as.numeric)
save(r42_output1, file = "data/r42_output1.rdata")

r42_input1 <- read.csv("data-raw/r42_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r42_input1, is.factor)
int.cols <- sapply(r42_input1, is.integer)

r42_input1[, fctr.cols] <- sapply(r42_input1[, fctr.cols], as.character)
r42_input1[, int.cols] <- sapply(r42_input1[, int.cols], as.numeric)
save(r42_input1, file = "data/r42_input1.rdata")


r42_input2 <- read.csv("data-raw/r42_input2.csv", check.names = FALSE)
fctr.cols <- sapply(r42_input2, is.factor)
int.cols <- sapply(r42_input2, is.integer)

r42_input2[, fctr.cols] <- sapply(r42_input2[, fctr.cols], as.character)
r42_input2[, int.cols] <- sapply(r42_input2[, int.cols], as.numeric)
save(r42_input2, file = "data/r42_input2.rdata")
