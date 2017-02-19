# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 31
dat <- read.table(text=
"
   Factor A-measure     A-SD B-measure     B-SD C-measure     C-SD
      K  52127803  9124563  63752981 34800000 103512032 23900000
      L  63410326 21975533  68303447 22600000  65074191 20800000
      M  76455662  9864019  73250794  6090000  92686983 38300000
", header=T)



write.csv(dat, "data-raw/r30_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(measure, value, -Factor) %>%
  separate(measure, c("measure_letter", "temp_var")) %>%
  spread(temp_var, value)

write.csv(df_out, "data-raw/r30_output1.csv", row.names=FALSE)

r30_output1 <- read.csv("data-raw/r30_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r30_output1, is.factor)
int.cols <- sapply(r30_output1, is.integer)

r30_output1[, fctr.cols] <- sapply(r30_output1[, fctr.cols], as.character)
r30_output1[, int.cols] <- sapply(r30_output1[, int.cols], as.numeric)
save(r30_output1, file = "data/r30_output1.rdata")

r30_input1 <- read.csv("data-raw/r30_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r30_input1, is.factor)
int.cols <- sapply(r30_input1, is.integer)

r30_input1[, fctr.cols] <- sapply(r30_input1[, fctr.cols], as.character)
r30_input1[, int.cols] <- sapply(r30_input1[, int.cols], as.numeric)
save(r30_input1, file = "data/r30_input1.rdata")
