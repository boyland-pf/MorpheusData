# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 45
dat <- read.table(text=
"
       X       Y      Z          cluster
256872.0 5114 422.50          10
256882.0 4115 526.50          20
256882.7 4115 406.42          57
256881.7 4135 321.42          57
256885.4 5945 529.50          20
256886.1 5945 629.67          33
256885.1 5942 619.67          33
", header=T)



write.csv(dat, "data-raw/p45_input1.csv", row.names=FALSE)

# needs to use the same variable in summarise
df_out = dat %>%
  group_by(cluster) %>%
  summarise(Z= min(Z)) %>% inner_join(dat) %>% select(-`Z`)

#df_out

write.csv(df_out, "data-raw/p45_output1.csv", row.names=FALSE)

p45_output1 <- read.csv("data-raw/p45_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p45_output1, is.factor)
int.cols <- sapply(p45_output1, is.integer)

p45_output1[, fctr.cols] <- sapply(p45_output1[, fctr.cols], as.character)
p45_output1[, int.cols] <- sapply(p45_output1[, int.cols], as.numeric)
save(p45_output1, file = "data/p45_output1.rdata")

p45_input1 <- read.csv("data-raw/p45_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p45_input1, is.factor)
int.cols <- sapply(p45_input1, is.integer)

p45_input1[, fctr.cols] <- sapply(p45_input1[, fctr.cols], as.character)
p45_input1[, int.cols] <- sapply(p45_input1[, int.cols], as.numeric)
save(p45_input1, file = "data/p45_input1.rdata")
