# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 36
dat <- read.table(text=
"
name1 con1_1 con1_2 con2_1 con2_2 
a     23     33     23      40 
b     25     34     22      50
c     28     29     30      60
", header=T)



write.csv(dat, "data-raw/r35_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(var, val, -name1) %>%
  separate(var, c("var", "time")) %>%
  group_by(name1, var) %>%
  summarise(mVal = mean(val)) %>%
  spread(var, mVal)

write.csv(df_out, "data-raw/r35_output1.csv", row.names=FALSE)

r35_output1 <- read.csv("data-raw/r35_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r35_output1, is.factor)
int.cols <- sapply(r35_output1, is.integer)

r35_output1[, fctr.cols] <- sapply(r35_output1[, fctr.cols], as.character)
r35_output1[, int.cols] <- sapply(r35_output1[, int.cols], as.numeric)
save(r35_output1, file = "data/r35_output1.rdata")

r35_input1 <- read.csv("data-raw/r35_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r35_input1, is.factor)
int.cols <- sapply(r35_input1, is.integer)

r35_input1[, fctr.cols] <- sapply(r35_input1[, fctr.cols], as.character)
r35_input1[, int.cols] <- sapply(r35_input1[, int.cols], as.numeric)
save(r35_input1, file = "data/r35_input1.rdata")
