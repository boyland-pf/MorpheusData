# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)
library(data.table)
#############benchmark 85
set.seed(14592)

    dat <- data.frame(
      vial_id      = 1:6, 
      band         = sample(0:2, 6, replace = TRUE), 
      non_spec     = sample(0:2, 6, replace = TRUE), 
      reads        = rnorm(6)
    )

write.csv(dat, "data-raw/r73_input1.csv", row.names=FALSE)

  df_out = dat %>% 
      unite(group_id, band, non_spec) %>% 
      group_by(group_id) %>% 
      summarize(group_mean = mean(reads))

write.csv(df_out, "data-raw/r73_output1.csv", row.names=FALSE)

r73_output1 <- read.csv("data-raw/r73_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r73_output1, is.factor)
int.cols <- sapply(r73_output1, is.integer)

r73_output1[, fctr.cols] <- sapply(r73_output1[, fctr.cols], as.character)
r73_output1[, int.cols] <- sapply(r73_output1[, int.cols], as.numeric)
save(r73_output1, file = "data/r73_output1.rdata")

r73_input1 <- read.csv("data-raw/r73_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r73_input1, is.factor)
int.cols <- sapply(r73_input1, is.integer)

r73_input1[, fctr.cols] <- sapply(r73_input1[, fctr.cols], as.character)
r73_input1[, int.cols] <- sapply(r73_input1[, int.cols], as.numeric)
save(r73_input1, file = "data/r73_input1.rdata")
