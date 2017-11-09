# making table data sets
library(dplyr)
library(tidyr)
library(data.table)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
      Title    Rating    Action    Sci.Fi    Animation
      Carrie    4    0    1    1
      Fried-Green-Tomatoes    2    0    0    0
      Amadeus    5    1    0    1
      Amityville-Horror    1    0    0    0
      Dracula    2    0    1    1
      Speed    4    1    0    0
", header=T)

write.csv(dat, "data-raw/r98_input1.csv", row.names=FALSE)

df_out <- read.table(text=
"
      genre    average
      Action    4.5
      Animation    3.66667
      Sci.Fi    3.0
", header=T)


##df_out = dat %>% gather(var, val, -1) %>% filter(val!=0) %>% select(-3) 
#%>% arrange(order_id)

write.csv(df_out, "data-raw/r98_output1.csv", row.names=FALSE)

r98_output1 <- read.csv("data-raw/r98_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r98_output1, is.factor)
int.cols <- sapply(r98_output1, is.integer)

r98_output1[, fctr.cols] <- sapply(r98_output1[, fctr.cols], as.character)
r98_output1[, int.cols] <- sapply(r98_output1[, int.cols], as.numeric)
save(r98_output1, file = "data/r98_output1.rdata")

r98_input1 <- read.csv("data-raw/r98_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r98_input1, is.factor)
int.cols <- sapply(r98_input1, is.integer)

r98_input1[, fctr.cols] <- sapply(r98_input1[, fctr.cols], as.character)
r98_input1[, int.cols] <- sapply(r98_input1[, int.cols], as.numeric)
save(r98_input1, file = "data/r98_input1.rdata")
