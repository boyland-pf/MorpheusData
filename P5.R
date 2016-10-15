# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"ID    T    P.1 P.2 P.3
1   24.3    10.2    5.5 2.1
2   23.4    10.4    5.7 2.8
3   22.1    10.5    5.9 3.1
4   19.9    10.2    5.2 2.4
", header=T)

write.csv(dat, "data-raw/p5_input1.csv", row.names=FALSE)

df_out = dat %>% gather(Channel, P, P.1:P.3) %>% 
    separate(Channel, into=c("dummy","Channel")) %>%
    select(c(1,4,2,5))

write.csv(df_out, "data-raw/p5_output1.csv", row.names=FALSE)

output1 <- read.csv("data-raw/p5_output1.csv", check.names = FALSE)
fctr.cols <- sapply(output1, is.factor)
int.cols <- sapply(output1, is.integer)

output1[, fctr.cols] <- sapply(output1[, fctr.cols], as.character)
output1[, int.cols] <- sapply(output1[, int.cols], as.numeric)
save(output1, file = "data/p5_output1.rdata")

input1 <- read.csv("data-raw/p5_input1.csv", check.names = FALSE)
fctr.cols <- sapply(input1, is.factor)
int.cols <- sapply(input1, is.integer)

input1[, fctr.cols] <- sapply(input1[, fctr.cols], as.character)
input1[, int.cols] <- sapply(input1[, int.cols], as.numeric)
save(input1, file = "data/p5_input1.rdata")