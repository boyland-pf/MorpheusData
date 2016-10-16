# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
tmp <- read.table(text=
"fruit1 fruit2
guava   kiwi
pear  apple
guava   kiwi
pear  guava
apple   kiwi
apple banana
", header=T)

dat = tmp %>% do(data.frame(fruita=unlist(.), fruitb=unlist(.[,2:1])))


write.csv(dat, "data-raw/p29_input1.csv", row.names=FALSE)

df_out = dat %>%
group_by(fruita) %>% 
summarise(Partners=n_distinct(fruitb)) %>% 
arrange(Partners)


write.csv(df_out, "data-raw/p29_output1.csv", row.names=FALSE)

p29_output1 <- read.csv("data-raw/p29_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p29_output1, is.factor)
int.cols <- sapply(p29_output1, is.integer)

p29_output1[, fctr.cols] <- sapply(p29_output1[, fctr.cols], as.character)
p29_output1[, int.cols] <- sapply(p29_output1[, int.cols], as.numeric)
save(p29_output1, file = "data/p29_output1.rdata")

p29_input1 <- read.csv("data-raw/p29_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p29_input1, is.factor)
int.cols <- sapply(p29_input1, is.integer)

p29_input1[, fctr.cols] <- sapply(p29_input1[, fctr.cols], as.character)
p29_input1[, int.cols] <- sapply(p29_input1[, int.cols], as.numeric)
save(p29_input1, file = "data/p29_input1.rdata")
