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



write.csv(dat, "data-raw/r47_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(key, value, -id) %>% 
  separate(key, c("key", "panel")) %>%
  spread(key, value)

write.csv(df_out, "data-raw/r47_output1.csv", row.names=FALSE)

r47_output1 <- read.csv("data-raw/r47_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r47_output1, is.factor)
int.cols <- sapply(r47_output1, is.integer)

r47_output1[, fctr.cols] <- sapply(r47_output1[, fctr.cols], as.character)
r47_output1[, int.cols] <- sapply(r47_output1[, int.cols], as.numeric)
save(r47_output1, file = "data/r47_output1.rdata")

r47_input1 <- read.csv("data-raw/r47_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r47_input1, is.factor)
int.cols <- sapply(r47_input1, is.integer)

r47_input1[, fctr.cols] <- sapply(r47_input1[, fctr.cols], as.character)
r47_input1[, int.cols] <- sapply(r47_input1[, int.cols], as.numeric)
save(r47_input1, file = "data/r47_input1.rdata")
