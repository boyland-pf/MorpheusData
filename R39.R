# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 40
dat <- read.table(text=
"
event_id income location
A      1   PlaceX
B      2   PlaceY
A      3   PlaceX
A      4   PlaceX
B      5   PlaceY
", header=T)

write.csv(dat, "data-raw/r39_input1.csv", row.names=FALSE)

df_out = dat %>%
   group_by(event_id) %>%
   summarise(mean_inc = mean(income)) %>% inner_join(dat)

write.csv(df_out, "data-raw/r39_output1.csv", row.names=FALSE)

r39_output1 <- read.csv("data-raw/r39_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r39_output1, is.factor)
int.cols <- sapply(r39_output1, is.integer)

r39_output1[, fctr.cols] <- sapply(r39_output1[, fctr.cols], as.character)
r39_output1[, int.cols] <- sapply(r39_output1[, int.cols], as.numeric)
save(r39_output1, file = "data/r39_output1.rdata")

r39_input1 <- read.csv("data-raw/r39_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r39_input1, is.factor)
int.cols <- sapply(r39_input1, is.integer)

r39_input1[, fctr.cols] <- sapply(r39_input1[, fctr.cols], as.character)
r39_input1[, int.cols] <- sapply(r39_input1[, int.cols], as.numeric)
save(r39_input1, file = "data/r39_input1.rdata")
