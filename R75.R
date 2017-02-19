# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 88
dat <- read.table(text=
"id       time     Q1.1     Q1.2        Q2.1       Q2.2
  1 2009-01-01  0.48742885 -0.01618826  1.52718069  -0.29177677
  2 2009-01-02  0.73832471  0.94383621  -0.40380049 -1.19813815", header=T)

write.csv(dat, "data-raw/r75_input1.csv", row.names=FALSE)

	  df_out = dat %>% gather(loop, value, -`id`, -`time`) %>% 
	  		   separate(loop,c("L1","L2")) %>% 
	  		   spread(L1,value) %>% 
	  		   select(-L2)

write.csv(df_out, "data-raw/r75_output1.csv", row.names=FALSE)

r75_output1 <- read.csv("data-raw/r75_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r75_output1, is.factor)
int.cols <- sapply(r75_output1, is.integer)

r75_output1[, fctr.cols] <- sapply(r75_output1[, fctr.cols], as.character)
r75_output1[, int.cols] <- sapply(r75_output1[, int.cols], as.numeric)
save(r75_output1, file = "data/r75_output1.rdata")

r75_input1 <- read.csv("data-raw/r75_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r75_input1, is.factor)
int.cols <- sapply(r75_input1, is.integer)

r75_input1[, fctr.cols] <- sapply(r75_input1[, fctr.cols], as.character)
r75_input1[, int.cols] <- sapply(r75_input1[, int.cols], as.numeric)
save(r75_input1, file = "data/r75_input1.rdata")
