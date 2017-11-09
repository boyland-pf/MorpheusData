# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
      Title    Rating    Action    Sci.Fi    Animation    Crime
      Carrie    4    0    1    1    1
      Fried-Green-Tomatoes    2    0    0    0    0
      Amadeus    5    1    0    1    1
      Amityville-Horror    1    0    0    0    1
      Dracula    2    0    1    1    0
      Speed    4    1    0    0    0
      Zootopia    5    0    0    1    0
      BreakingBad    5    1    0    0    1
", header=T)

write.csv(dat, "data-raw/r97_input1.csv", row.names=FALSE)

df_out <- read.table(text=
"
      genre    average
      Action    4.6666667
      Animation    4.0
      Crime    3.75
      Sci.Fi    3.0
", header=T)


##df_out = dat %>% gather(var, val, -1) %>% filter(val!=0) %>% select(-3) 
#%>% arrange(order_id)

write.csv(df_out, "data-raw/r97_output1.csv", row.names=FALSE)

r97_output1 <- read.csv("data-raw/r97_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r97_output1, is.factor)
int.cols <- sapply(r97_output1, is.integer)

r97_output1[, fctr.cols] <- sapply(r97_output1[, fctr.cols], as.character)
r97_output1[, int.cols] <- sapply(r97_output1[, int.cols], as.numeric)
save(r97_output1, file = "data/r97_output1.rdata")

r97_input1 <- read.csv("data-raw/r97_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r97_input1, is.factor)
int.cols <- sapply(r97_input1, is.integer)

r97_input1[, fctr.cols] <- sapply(r97_input1[, fctr.cols], as.character)
r97_input1[, int.cols] <- sapply(r97_input1[, int.cols], as.numeric)
save(r97_input1, file = "data/r97_input1.rdata")
