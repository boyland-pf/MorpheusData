# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)
library(data.table)

#############benchmark 1
dat<-data.frame(drug=c(1,1,1,1,2),age=c(1,2,3,2,1),bfat=c(10,30,3,4,7))

write.csv(dat, "data-raw/p68_input1.csv", row.names=FALSE)

df_out = dat %>% 
   filter(drug==1) %>%
   group_by(age) %>% 
   summarise(bfat= mean(bfat))

write.csv(df_out, "data-raw/p68_output1.csv", row.names=FALSE)

p68_output1 <- read.csv("data-raw/p68_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p68_output1, is.factor)
int.cols <- sapply(p68_output1, is.integer)

p68_output1[, fctr.cols] <- sapply(p68_output1[, fctr.cols], as.character)
p68_output1[, int.cols] <- sapply(p68_output1[, int.cols], as.numeric)
save(p68_output1, file = "data/p68_output1.rdata")

p68_input1 <- read.csv("data-raw/p68_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p68_input1, is.factor)
int.cols <- sapply(p68_input1, is.integer)

p68_input1[, fctr.cols] <- sapply(p68_input1[, fctr.cols], as.character)
p68_input1[, int.cols] <- sapply(p68_input1[, int.cols], as.numeric)
save(p68_input1, file = "data/p68_input1.rdata")
