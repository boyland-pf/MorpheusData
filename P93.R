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

write.csv(dat, "data-raw/p93_input1.csv", row.names=FALSE)

df_out = inner_join(dat,
            dat %>% 
                 filter(x2==1) %>%
                 group_by(x) %>%
                 summarise(a=mean(y))) %>% mutate(z=y/a)

write.csv(df_out, "data-raw/p93_output1.csv", row.names=FALSE)

p93_output1 <- read.csv("data-raw/p93_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p93_output1, is.factor)
int.cols <- sapply(p93_output1, is.integer)

p93_output1[, fctr.cols] <- sapply(p93_output1[, fctr.cols], as.character)
p93_output1[, int.cols] <- sapply(p93_output1[, int.cols], as.numeric)
save(p93_output1, file = "data/p93_output1.rdata")

p93_input1 <- read.csv("data-raw/p93_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p93_input1, is.factor)
int.cols <- sapply(p93_input1, is.integer)

p93_input1[, fctr.cols] <- sapply(p93_input1[, fctr.cols], as.character)
p93_input1[, int.cols] <- sapply(p93_input1[, int.cols], as.numeric)
save(p93_input1, file = "data/p93_input1.rdata")
