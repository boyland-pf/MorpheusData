# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 93
dat <- read.table(text=
"x 		x2 		y
 1  1 1.41
 1  1 1.39
 1  2 1.90
 1  2 2.10
 2  1 0.90
 2  1 1.10
 2  2 1.90
 2  2 2.10
", header=T)

write.csv(dat, "data-raw/r78_input1.csv", row.names=FALSE)

df_out = inner_join(dat,
            dat %>% 
                 filter(x2==1) %>%
                 group_by(x) %>%
                 summarise(a=mean(y))) %>% mutate(z=y/a)

write.csv(df_out, "data-raw/r78_output1.csv", row.names=FALSE)

r78_output1 <- read.csv("data-raw/r78_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r78_output1, is.factor)
int.cols <- sapply(r78_output1, is.integer)

r78_output1[, fctr.cols] <- sapply(r78_output1[, fctr.cols], as.character)
r78_output1[, int.cols] <- sapply(r78_output1[, int.cols], as.numeric)
save(r78_output1, file = "data/r78_output1.rdata")

r78_input1 <- read.csv("data-raw/r78_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r78_input1, is.factor)
int.cols <- sapply(r78_input1, is.integer)

r78_input1[, fctr.cols] <- sapply(r78_input1[, fctr.cols], as.character)
r78_input1[, int.cols] <- sapply(r78_input1[, int.cols], as.numeric)
save(r78_input1, file = "data/r78_input1.rdata")
