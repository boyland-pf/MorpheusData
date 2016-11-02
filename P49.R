# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 49
dat <- read.table(text=
"
     id      age_1 age_2 favCol_1 favCol_2
   user1        20        21         blue          red
   user2        25        34          red          blue 
   user3        32        33         blue          red
", header=T)



write.csv(dat, "data-raw/p49_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(key, value, -id) %>% 
  separate(key, c("key", "panel")) %>%
  spread(key, value)

write.csv(df_out, "data-raw/p49_output1.csv", row.names=FALSE)

p49_output1 <- read.csv("data-raw/p49_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p49_output1, is.factor)
int.cols <- sapply(p49_output1, is.integer)

p49_output1[, fctr.cols] <- sapply(p49_output1[, fctr.cols], as.character)
p49_output1[, int.cols] <- sapply(p49_output1[, int.cols], as.numeric)
save(p49_output1, file = "data/p49_output1.rdata")

p49_input1 <- read.csv("data-raw/p49_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p49_input1, is.factor)
int.cols <- sapply(p49_input1, is.integer)

p49_input1[, fctr.cols] <- sapply(p49_input1[, fctr.cols], as.character)
p49_input1[, int.cols] <- sapply(p49_input1[, int.cols], as.numeric)
save(p49_input1, file = "data/p49_input1.rdata")
