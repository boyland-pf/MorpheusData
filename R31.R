# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 32
dat <- data.frame(id=c(101,102,103), a=c(1,2,3), b=c(2,2,2), c=c(3,3,3))


write.csv(dat, "data-raw/r31_input1.csv", row.names=FALSE)

tidy_data = tidyr::gather(dat, name, value, -id)

df_out = tidy_data %>%
    group_by(id) %>%
    summarize(mean = mean(value)) %>%
    inner_join(dat)

write.csv(df_out, "data-raw/r31_output1.csv", row.names=FALSE)

r31_output1 <- read.csv("data-raw/r31_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r31_output1, is.factor)
int.cols <- sapply(r31_output1, is.integer)

r31_output1[, fctr.cols] <- sapply(r31_output1[, fctr.cols], as.character)
r31_output1[, int.cols] <- sapply(r31_output1[, int.cols], as.numeric)
save(r31_output1, file = "data/r31_output1.rdata")

r31_input1 <- read.csv("data-raw/r31_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r31_input1, is.factor)
int.cols <- sapply(r31_input1, is.integer)

r31_input1[, fctr.cols] <- sapply(r31_input1[, fctr.cols], as.character)
r31_input1[, int.cols] <- sapply(r31_input1[, int.cols], as.numeric)
save(r31_input1, file = "data/r31_input1.rdata")
