# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"   ST Rfips   zip Year  dist.km
 PA 42107 17972 2010  0.00000
 VA 51760 23226 2005 42.46894
 RI 44001  2806 2010 28.11234
 NJ 34001  8330 2008 36.85470
 PA 51061 20118 2007  0.00000
 VT 50023  5681 2006 49.72765
 NY 36029 14072 2005  0.00000
 PA 42101 19115 2008 30.19372
 NC 37019 28451 2009  0.00000
", header=T)

write.csv(dat, "data-raw/r64_input1.csv", row.names=FALSE)

df_out = dat %>%
  filter(dist.km == 0) %>%
  group_by(ST) %>%
  summarise(total=n())

write.csv(df_out, "data-raw/r64_output1.csv", row.names=FALSE)

r64_output1 <- read.csv("data-raw/r64_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r64_output1, is.factor)
int.cols <- sapply(r64_output1, is.integer)

r64_output1[, fctr.cols] <- sapply(r64_output1[, fctr.cols], as.character)
r64_output1[, int.cols] <- sapply(r64_output1[, int.cols], as.numeric)
save(r64_output1, file = "data/r64_output1.rdata")

r64_input1 <- read.csv("data-raw/r64_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r64_input1, is.factor)
int.cols <- sapply(r64_input1, is.integer)

r64_input1[, fctr.cols] <- sapply(r64_input1[, fctr.cols], as.character)
r64_input1[, int.cols] <- sapply(r64_input1[, int.cols], as.numeric)
save(r64_input1, file = "data/r64_input1.rdata")
