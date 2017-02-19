# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"ID    T    P.1 P.2 Q.1
1   24.3    10.2    5.5  4.5
2   23.4    10.4    5.7  3.2
", header=T)

write.csv(dat, "data-raw/r5_input1.csv", row.names=FALSE)

df_out = dat %>% gather(Channel, P, P.1:Q.1) %>% 
    separate(Channel, into=c("dummy","Channel")) %>%
    select(c(1,4,2,5))

write.csv(df_out, "data-raw/r5_output1.csv", row.names=FALSE)

r5_output1 <- read.csv("data-raw/r5_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r5_output1, is.factor)
int.cols <- sapply(r5_output1, is.integer)

r5_output1[, fctr.cols] <- sapply(r5_output1[, fctr.cols], as.character)
r5_output1[, int.cols] <- sapply(r5_output1[, int.cols], as.numeric)
save(r5_output1, file = "data/r5_output1.rdata")

r5_input1 <- read.csv("data-raw/r5_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r5_input1, is.factor)
int.cols <- sapply(r5_input1, is.integer)

r5_input1[, fctr.cols] <- sapply(r5_input1[, fctr.cols], as.character)
r5_input1[, int.cols] <- sapply(r5_input1[, int.cols], as.numeric)
save(r5_input1, file = "data/r5_input1.rdata")
