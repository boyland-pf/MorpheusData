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

write.csv(dat, "data-raw/p85_input1.csv", row.names=FALSE)

  df_out = dat %>% 
      unite(group_id, band, non_spec) %>% 
      group_by(group_id) %>% 
      summarize(group_mean = mean(reads))

write.csv(df_out, "data-raw/p85_output1.csv", row.names=FALSE)

p85_output1 <- read.csv("data-raw/p85_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p85_output1, is.factor)
int.cols <- sapply(p85_output1, is.integer)

p85_output1[, fctr.cols] <- sapply(p85_output1[, fctr.cols], as.character)
p85_output1[, int.cols] <- sapply(p85_output1[, int.cols], as.numeric)
save(p85_output1, file = "data/p85_output1.rdata")

p85_input1 <- read.csv("data-raw/p85_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p85_input1, is.factor)
int.cols <- sapply(p85_input1, is.integer)

p85_input1[, fctr.cols] <- sapply(p85_input1[, fctr.cols], as.character)
p85_input1[, int.cols] <- sapply(p85_input1[, int.cols], as.numeric)
save(p85_input1, file = "data/p85_input1.rdata")
