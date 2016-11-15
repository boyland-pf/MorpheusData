# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 92
dat <- read.table(text=
"obs    year    type
 1     2015     A
 2     2015     A
 3     2015     B
 4     2014     A
 5     2014     B
 6     2014     A
 7     2015     A
 ", header=T)

write.csv(dat, "data-raw/p92_input1.csv", row.names=FALSE)

temp = dat %>% 
	filter(year == 2015) %>% 
	group_by(type) %>%
	summarize(freq = n())

df_out = dat %>% inner_join(temp)

write.csv(df_out, "data-raw/p92_output1.csv", row.names=FALSE)

p92_output1 <- read.csv("data-raw/p92_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p92_output1, is.factor)
int.cols <- sapply(p92_output1, is.integer)

p92_output1[, fctr.cols] <- sapply(p92_output1[, fctr.cols], as.character)
p92_output1[, int.cols] <- sapply(p92_output1[, int.cols], as.numeric)
save(p92_output1, file = "data/p92_output1.rdata")

p92_input1 <- read.csv("data-raw/p92_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p92_input1, is.factor)
int.cols <- sapply(p92_input1, is.integer)

p92_input1[, fctr.cols] <- sapply(p92_input1[, fctr.cols], as.character)
p92_input1[, int.cols] <- sapply(p92_input1[, int.cols], as.numeric)
save(p92_input1, file = "data/p92_input1.rdata")
