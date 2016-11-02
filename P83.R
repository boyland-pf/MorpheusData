# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 83

dat <- read.table(text=
"id p1         p2 p3
1 -0.7833568  0.6383588  1
2 -0.4073465  0.3480860  1
1  0.2799414 -0.1938586  2
2 -1.3496633 -0.5271080  2
1 -0.1030045  0.8642336  3
2  0.5839070 -0.9723264  3",header=T)

write.csv(dat, "data-raw/p83_input1.csv", row.names=FALSE)

  df_out = dat %>% gather(Var, Val, p1,p2) %>% 
                            unite(p3Var, p3, Var) %>%
                            spread(p3Var,Val)

write.csv(df_out, "data-raw/p83_output1.csv", row.names=FALSE)

p83_output1 <- read.csv("data-raw/p83_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p83_output1, is.factor)
int.cols <- sapply(p83_output1, is.integer)

p83_output1[, fctr.cols] <- sapply(p83_output1[, fctr.cols], as.character)
p83_output1[, int.cols] <- sapply(p83_output1[, int.cols], as.numeric)
save(p83_output1, file = "data/p83_output1.rdata")

p83_input1 <- read.csv("data-raw/p83_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p83_input1, is.factor)
int.cols <- sapply(p83_input1, is.integer)

p83_input1[, fctr.cols] <- sapply(p83_input1[, fctr.cols], as.character)
p83_input1[, int.cols] <- sapply(p83_input1[, int.cols], as.numeric)
save(p83_input1, file = "data/p83_input1.rdata")
