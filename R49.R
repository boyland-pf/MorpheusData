# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 52
dat <- data.frame(
  Scenario = c('base','stress','extreme'),
  x_min = c(-3,-2, -2.5),
  x_mean = c(0,0.25, 1),
  x_max = c(2, 1, 3),
  y_min = c(-1.5, -2, -3),
  y_mean = c(1, 2, 3),
  y_max = c(5, 3, 3.5),
  z_min = c(0, 1, 3),
  z_mean = c(0.25, 2, 5),
  z_max = c(2, 4, 7)
)

write.csv(dat, "data-raw/r49_input1.csv", row.names=FALSE)

df_out = dat %>%
    gather(var, val, -Scenario) %>% 
    separate(var, into = c('varNew', 'stat')) %>% 
    spread(stat, val)

write.csv(df_out, "data-raw/r49_output1.csv", row.names=FALSE)

r49_output1 <- read.csv("data-raw/r49_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r49_output1, is.factor)
int.cols <- sapply(r49_output1, is.integer)

r49_output1[, fctr.cols] <- sapply(r49_output1[, fctr.cols], as.character)
r49_output1[, int.cols] <- sapply(r49_output1[, int.cols], as.numeric)
save(r49_output1, file = "data/r49_output1.rdata")

r49_input1 <- read.csv("data-raw/r49_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r49_input1, is.factor)
int.cols <- sapply(r49_input1, is.integer)

r49_input1[, fctr.cols] <- sapply(r49_input1[, fctr.cols], as.character)
r49_input1[, int.cols] <- sapply(r49_input1[, int.cols], as.numeric)
save(r49_input1, file = "data/r49_input1.rdata")
