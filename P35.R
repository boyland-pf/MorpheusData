# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 35
m <- data.frame(
    K = 230, 
    M = 128, 
    G = 420 
)

s <- data.frame(
    size = 1:3,
    mult = c('K', 'M', 'G')
)

m = as.data.frame(t(m))
m$mult = rownames(m)
colnames(m)[which(colnames(m) == "V1")] = "value"


write.csv(s, "data-raw/p35_input1.csv", row.names=FALSE)
write.csv(m, "data-raw/p35_input2.csv", row.names=FALSE)

df_out = s %>% 
  inner_join(m) %>% 
  mutate(total = value/size) %>% 
  select(size, mult, total)

write.csv(df_out, "data-raw/p35_output1.csv", row.names=FALSE)

p35_output1 <- read.csv("data-raw/p35_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p35_output1, is.factor)
int.cols <- sapply(p35_output1, is.integer)

p35_output1[, fctr.cols] <- sapply(p35_output1[, fctr.cols], as.character)
p35_output1[, int.cols] <- sapply(p35_output1[, int.cols], as.numeric)
save(p35_output1, file = "data/p35_output1.rdata")

p35_input1 <- read.csv("data-raw/p35_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p35_input1, is.factor)
int.cols <- sapply(p35_input1, is.integer)

p35_input1[, fctr.cols] <- sapply(p35_input1[, fctr.cols], as.character)
p35_input1[, int.cols] <- sapply(p35_input1[, int.cols], as.numeric)
save(p35_input1, file = "data/p35_input1.rdata")

p35_input2 <- read.csv("data-raw/p35_input2.csv", check.names = FALSE)
fctr.cols <- sapply(p35_input2, is.factor)
int.cols <- sapply(p35_input2, is.integer)

p35_input2[, fctr.cols] <- sapply(p35_input2[, fctr.cols], as.character)
p35_input2[, int.cols] <- sapply(p35_input2[, int.cols], as.numeric)
save(p35_input2, file = "data/p35_input2.rdata")
