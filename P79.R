# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 79
dat <- read.table(text="
   mpg cyl vs am
21.0   6  0  1
21.0   6  0  1
22.8   4  1  1
21.4   6  1  0
18.7   8  0  0
18.1   6  1  0
14.3   8  0  0
24.4   4  1  0", header=T)

write.csv(dat, "data-raw/p79_input1.csv", row.names=FALSE)

df_out = dat %>%
      unite(vs_am, vs, am) %>%
      group_by(vs_am) %>% 
      summarise(countofvalues = n())

write.csv(df_out, "data-raw/p79_output1.csv", row.names=FALSE)

p79_output1 <- read.csv("data-raw/p79_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p79_output1, is.factor)
int.cols <- sapply(p79_output1, is.integer)

p79_output1[, fctr.cols] <- sapply(p79_output1[, fctr.cols], as.character)
p79_output1[, int.cols] <- sapply(p79_output1[, int.cols], as.numeric)
save(p79_output1, file = "data/p79_output1.rdata")

p79_input1 <- read.csv("data-raw/p79_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p79_input1, is.factor)
int.cols <- sapply(p79_input1, is.integer)

p79_input1[, fctr.cols] <- sapply(p79_input1[, fctr.cols], as.character)
p79_input1[, int.cols] <- sapply(p79_input1[, int.cols], as.numeric)
save(p79_input1, file = "data/p79_input1.rdata")
