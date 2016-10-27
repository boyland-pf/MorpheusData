# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)
library(data.table)

#############benchmark 26
dat <- as.data.table(data.frame(date = c("2015-08-01","2015-08-02","2015-08-05","2015-08-01","2015-08-09","2015-08-10"),
                                 directorName = c("Sergey","Sergey","Mike","Mike","Jay","Jay"),
                                 companyName = c("vino","vino","bolder","bolder","bolder","bolder"),
                                 rank = c(29,42,29,27,2,10)))

write.csv(dat, "data-raw/p26_input1.csv", row.names=FALSE)

df_out = inner_join(dat,dat %>% group_by(companyName) %>% summarise(min = min(rank)) %>% filter(min > 10) %>% select(companyName))

write.csv(df_out, "data-raw/p26_output1.csv", row.names=FALSE)

p26_output1 <- read.csv("data-raw/p26_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p26_output1, is.factor)
int.cols <- sapply(p26_output1, is.integer)

p26_output1[, fctr.cols] <- sapply(p26_output1[, fctr.cols], as.character)
p26_output1[, int.cols] <- sapply(p26_output1[, int.cols], as.numeric)
save(p26_output1, file = "data/p26_output1.rdata")

p26_input1 <- read.csv("data-raw/p26_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p26_input1, is.factor)
int.cols <- sapply(p26_input1, is.integer)

p26_input1[, fctr.cols] <- sapply(p26_input1[, fctr.cols], as.character)
p26_input1[, int.cols] <- sapply(p26_input1[, int.cols], as.numeric)
save(p26_input1, file = "data/p26_input1.rdata")
