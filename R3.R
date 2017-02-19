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

write.csv(dat, "data-raw/r3_input1.csv", row.names=FALSE)

df_out = dat %>% 
    gather(temp, score, Score1, Score2) %>% 
    unite(temp1, Time, temp) %>% 
    spread(temp1, score)

write.csv(df_out, "data-raw/r3_output1.csv", row.names=FALSE)

r3_output1 <- read.csv("data-raw/r3_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r3_output1, is.factor)
int.cols <- sapply(r3_output1, is.integer)

r3_output1[, fctr.cols] <- sapply(r3_output1[, fctr.cols], as.character)
r3_output1[, int.cols] <- sapply(r3_output1[, int.cols], as.numeric)
save(r3_output1, file = "data/r3_output1.rdata")

r3_input1 <- read.csv("data-raw/r3_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r3_input1, is.factor)
int.cols <- sapply(r3_input1, is.integer)

r3_input1[, fctr.cols] <- sapply(r3_input1[, fctr.cols], as.character)
r3_input1[, int.cols] <- sapply(r3_input1[, int.cols], as.numeric)
save(r3_input1, file = "data/r3_input1.rdata")


