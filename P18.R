# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- data.frame(message.id = c(1,1,2,3,3),
                 sender = c("C","A","D","B","B"),
                 recipient = c("B","C","B","A","D"))

# data to reproduce unsoundness of spec3.
#dat <- data.frame(message.id = c(1,2,3),
#                 sender = c("C","A","B"),
#                 recipient = c("B","C","A"))


write.csv(dat, "data-raw/p18_input1.csv", row.names=FALSE)

df_out = dat %>% 
gather(messages, address, 2:3) %>%
          group_by(messages, address) %>%
          summarise(n=n()) %>% 
          spread(messages, n)

write.csv(df_out, "data-raw/p18_output1.csv", row.names=FALSE)

p18_output1 <- read.csv("data-raw/p18_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p18_output1, is.factor)
int.cols <- sapply(p18_output1, is.integer)

p18_output1[, fctr.cols] <- sapply(p18_output1[, fctr.cols], as.character)
p18_output1[, int.cols] <- sapply(p18_output1[, int.cols], as.numeric)
save(p18_output1, file = "data/p18_output1.rdata")

p18_input1 <- read.csv("data-raw/p18_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p18_input1, is.factor)
int.cols <- sapply(p18_input1, is.integer)

p18_input1[, fctr.cols] <- sapply(p18_input1[, fctr.cols], as.character)
p18_input1[, int.cols] <- sapply(p18_input1[, int.cols], as.numeric)
save(p18_input1, file = "data/p18_input1.rdata")
