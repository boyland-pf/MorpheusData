# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 61
dat <- read.table(text=
"
  ID p_2012 p_2010 p_2008 p_2006 c_2012 c_2010 c_2008 c_2006
1   160   162   163   165  37.3  37.3  37.1  37.1
2   163   164   164   163   2.6   2.6   2.6   2.6
", header=T)



write.csv(dat, "data-raw/p61_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(key,value,-ID) %>%
  separate(key,c("category","year")) %>%
  spread(category,value)

write.csv(df_out, "data-raw/p61_output1.csv", row.names=FALSE)

p61_output1 <- read.csv("data-raw/p61_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p61_output1, is.factor)
int.cols <- sapply(p61_output1, is.integer)

p61_output1[, fctr.cols] <- sapply(p61_output1[, fctr.cols], as.character)
p61_output1[, int.cols] <- sapply(p61_output1[, int.cols], as.numeric)
save(p61_output1, file = "data/p61_output1.rdata")

p61_input1 <- read.csv("data-raw/p61_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p61_input1, is.factor)
int.cols <- sapply(p61_input1, is.integer)

p61_input1[, fctr.cols] <- sapply(p61_input1[, fctr.cols], as.character)
p61_input1[, int.cols] <- sapply(p61_input1[, int.cols], as.numeric)
save(p61_input1, file = "data/p61_input1.rdata")
