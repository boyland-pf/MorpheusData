# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
#original version.
#dat <- data.frame(message.id = c(1,1,2,3,3),
#                 sender = c("C","A","D","B","B"),
#                 recipient = c("B","C","B","A","D"))

dat <- data.frame(message.id = c(1,1,2,3,3,3),
                 sender = c("A","A","A","B","C","D"),
                 recipient = c("A","C","B","C","D","B"))

# data to reproduce unsoundness of spec3.
#dat <- data.frame(message.id = c(1,2,3),
#                 sender = c("C","A","B"),
#                 recipient = c("B","C","A"))


write.csv(dat, "data-raw/r18_input1.csv", row.names=FALSE)

df_out = dat %>% 
gather(messages, address, 2:3) %>%
          group_by(messages, address) %>%
          summarise(n=n()) %>% 
          spread(messages, n)

write.csv(df_out, "data-raw/r18_output1.csv", row.names=FALSE)

r18_output1 <- read.csv("data-raw/r18_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r18_output1, is.factor)
int.cols <- sapply(r18_output1, is.integer)

r18_output1[, fctr.cols] <- sapply(r18_output1[, fctr.cols], as.character)
r18_output1[, int.cols] <- sapply(r18_output1[, int.cols], as.numeric)
save(r18_output1, file = "data/r18_output1.rdata")

r18_input1 <- read.csv("data-raw/r18_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r18_input1, is.factor)
int.cols <- sapply(r18_input1, is.integer)

r18_input1[, fctr.cols] <- sapply(r18_input1[, fctr.cols], as.character)
r18_input1[, int.cols] <- sapply(r18_input1[, int.cols], as.numeric)
save(r18_input1, file = "data/r18_input1.rdata")
