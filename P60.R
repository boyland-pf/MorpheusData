# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 60
dat <- data.frame(
         Test = 1:6, 
         temperature_sensor1=rnorm(6,25,5), 
         temperature_sensor2 = rnorm(6,25,5), 
         pressure_sensor1 = rnorm(6,10,2),
         pressure_sensor2 = rnorm(6,10,2))



write.csv(dat, "data-raw/p60_input1.csv", row.names=FALSE)

df_out = dat %>%
   gather("variable", "value", -Test) %>% 
   separate(variable, c("variableNew", "sensor")) %>%
   spread(variableNew, value)

write.csv(df_out, "data-raw/p60_output1.csv", row.names=FALSE)

p60_output1 <- read.csv("data-raw/p60_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p60_output1, is.factor)
int.cols <- sapply(p60_output1, is.integer)

p60_output1[, fctr.cols] <- sapply(p60_output1[, fctr.cols], as.character)
p60_output1[, int.cols] <- sapply(p60_output1[, int.cols], as.numeric)
save(p60_output1, file = "data/p60_output1.rdata")

p60_input1 <- read.csv("data-raw/p60_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p60_input1, is.factor)
int.cols <- sapply(p60_input1, is.integer)

p60_input1[, fctr.cols] <- sapply(p60_input1[, fctr.cols], as.character)
p60_input1[, int.cols] <- sapply(p60_input1[, int.cols], as.numeric)
save(p60_input1, file = "data/p60_input1.rdata")
