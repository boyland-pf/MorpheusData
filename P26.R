# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
firstname <- c('Doug','Tom','Glenn','Billy','Angelo')
city <- c('Tulsa','Unknown','Miami','Houston','Unknown')
state <- c('OK','CA','FL','Unknown','Unknown')
job <- c('Unknown','Plumber','Professor','Unknown','Unknown')
dat <- data.frame(firstname, city, state, job)

write.csv(dat, "data-raw/p26_input1.csv", row.names=FALSE)

df_out = dat %>% 
gather(field, value, -firstname) %>% 
filter(value == "Unknown") %>% 
select(-value) %>% 
arrange(firstname)

write.csv(df_out, "data-raw/p26_output1.csv", row.names=FALSE)

output1 <- read.csv("data-raw/p26_output1.csv", check.names = FALSE)
fctr.cols <- sapply(output1, is.factor)
int.cols <- sapply(output1, is.integer)

output1[, fctr.cols] <- sapply(output1[, fctr.cols], as.character)
output1[, int.cols] <- sapply(output1[, int.cols], as.numeric)
save(output1, file = "data/p26_output1.rdata")

input1 <- read.csv("data-raw/p26_input1.csv", check.names = FALSE)
fctr.cols <- sapply(input1, is.factor)
int.cols <- sapply(input1, is.integer)

input1[, fctr.cols] <- sapply(input1[, fctr.cols], as.character)
input1[, int.cols] <- sapply(input1[, int.cols], as.numeric)
save(input1, file = "data/p26_input1.rdata")
