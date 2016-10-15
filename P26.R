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
