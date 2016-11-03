# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 54
dat <- read.table(text=
"
   Geotype   Strategy Year.1 Year.2 Year.3 Year.4
1     Demand      1      1      1      1
1 Strategy_1      2      2      2      2
1 Strategy_2      3      3      3      3
1 Strategy_3      4      4      4      4
2     Demand      8      8      8      8
2 Strategy_1      9      9      9      9
2 Strategy_2     10     10     10     10
2 Strategy_3     11     11     11     11
", header=T)


write.csv(dat, "data-raw/p54_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(key, value, - Geotype, - Strategy) %>%
  filter(Strategy!="Demand") %>% group_by(Geotype, key) %>%
  summarize(sumVal = sum(value))

write.csv(df_out, "data-raw/p54_output1.csv", row.names=FALSE)

p54_output1 <- read.csv("data-raw/p54_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p54_output1, is.factor)
int.cols <- sapply(p54_output1, is.integer)

p54_output1[, fctr.cols] <- sapply(p54_output1[, fctr.cols], as.character)
p54_output1[, int.cols] <- sapply(p54_output1[, int.cols], as.numeric)
save(p54_output1, file = "data/p54_output1.rdata")

p54_input1 <- read.csv("data-raw/p54_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p54_input1, is.factor)
int.cols <- sapply(p54_input1, is.integer)

p54_input1[, fctr.cols] <- sapply(p54_input1[, fctr.cols], as.character)
p54_input1[, int.cols] <- sapply(p54_input1[, int.cols], as.numeric)
save(p54_input1, file = "data/p54_input1.rdata")
