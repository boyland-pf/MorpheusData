# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- data.frame(
    id = c(1,1,1,2,2,2),
    Year = c(2007, 2008, 2009, 2007, 2008, 2009),
    A = c(5, 2, 3, 7, 5, 6),
    B = c(10, 0, 50, 13, 17, 17) 
)

write.csv(dat, "data-raw/p4_input1.csv", row.names=FALSE)

df_out = gather(dat, Var, Val, A:B) %>% 
    unite(YearVar, Var, Year) %>% 
    spread(YearVar, Val)

write.csv(df_out, "data-raw/p4_output1.csv", row.names=FALSE)

output1 <- read.csv("data-raw/p4_output1.csv", check.names = FALSE)
fctr.cols <- sapply(output1, is.factor)
int.cols <- sapply(output1, is.integer)

output1[, fctr.cols] <- sapply(output1[, fctr.cols], as.character)
output1[, int.cols] <- sapply(output1[, int.cols], as.numeric)
save(output1, file = "data/p4_output1.rdata")

input1 <- read.csv("data-raw/p4_input1.csv", check.names = FALSE)
fctr.cols <- sapply(input1, is.factor)
int.cols <- sapply(input1, is.integer)

input1[, fctr.cols] <- sapply(input1[, fctr.cols], as.character)
input1[, int.cols] <- sapply(input1[, int.cols], as.numeric)
save(input1, file = "data/p4_input1.rdata")
