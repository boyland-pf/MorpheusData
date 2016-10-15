# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- data_frame(
    Person = rep(c("greg", "sally"), each=2),
    Time = rep(c("Pre", "Post"), 2),
    Score1 = round(rnorm(4, mean = 80, sd=4), 0),
    Score2 = round(jitter(Score1, 15), 0)
)

write.csv(dat, "data-raw/p3_input1.csv", row.names=FALSE)

df_out = dat %>% 
    gather(temp, score, Score1, Score2) %>% 
    unite(temp1, Time, temp) %>% 
    spread(temp1, score)

write.csv(df_out, "data-raw/p3_output1.csv", row.names=FALSE)

output1 <- read.csv("data-raw/p3_output1.csv", check.names = FALSE)
fctr.cols <- sapply(output1, is.factor)
int.cols <- sapply(output1, is.integer)

output1[, fctr.cols] <- sapply(output1[, fctr.cols], as.character)
output1[, int.cols] <- sapply(output1[, int.cols], as.numeric)
save(output1, file = "data/p3_output1.rdata")

input1 <- read.csv("data-raw/p3_input1.csv", check.names = FALSE)
fctr.cols <- sapply(input1, is.factor)
int.cols <- sapply(input1, is.integer)

input1[, fctr.cols] <- sapply(input1[, fctr.cols], as.character)
input1[, int.cols] <- sapply(input1[, int.cols], as.numeric)
save(input1, file = "data/p3_input1.rdata")


