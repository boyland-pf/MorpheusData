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

write.csv(dat, "data-raw/r77_input1.csv", row.names=FALSE)

temp = dat %>% 
	filter(year == 2015) %>% 
	group_by(type) %>%
	summarize(freq = n())

df_out = dat %>% inner_join(temp)

write.csv(df_out, "data-raw/r77_output1.csv", row.names=FALSE)

r77_output1 <- read.csv("data-raw/r77_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r77_output1, is.factor)
int.cols <- sapply(r77_output1, is.integer)

r77_output1[, fctr.cols] <- sapply(r77_output1[, fctr.cols], as.character)
r77_output1[, int.cols] <- sapply(r77_output1[, int.cols], as.numeric)
save(r77_output1, file = "data/r77_output1.rdata")

r77_input1 <- read.csv("data-raw/r77_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r77_input1, is.factor)
int.cols <- sapply(r77_input1, is.integer)

r77_input1[, fctr.cols] <- sapply(r77_input1[, fctr.cols], as.character)
r77_input1[, int.cols] <- sapply(r77_input1[, int.cols], as.numeric)
save(r77_input1, file = "data/r77_input1.rdata")
