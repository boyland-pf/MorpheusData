# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 34
df <- tbl_df(mtcars)

dat <- df %>%
  select(mpg, cyl, vs, am, gear, carb) %>% # select variables to summarise
  summarise_each(funs(min = min, 
                      q25 = quantile(., 0.25), 
                      median = median, 
                      q75 = quantile(., 0.75), 
                      max = max,
                      mean = mean, 
                      sd = sd)) %>% select(1:12)



write.csv(dat, "data-raw/r33_input1.csv", row.names=FALSE)

df_out = dat %>% gather(stat, val) %>%
  separate(stat, into = c("var", "stat")) %>%
  spread(stat, val)

write.csv(df_out, "data-raw/r33_output1.csv", row.names=FALSE)

r33_output1 <- read.csv("data-raw/r33_output1.csv", check.names = FALSE)
fctr.cols <- sapply(r33_output1, is.factor)
int.cols <- sapply(r33_output1, is.integer)

r33_output1[, fctr.cols] <- sapply(r33_output1[, fctr.cols], as.character)
r33_output1[, int.cols] <- sapply(r33_output1[, int.cols], as.numeric)
save(r33_output1, file = "data/r33_output1.rdata")

r33_input1 <- read.csv("data-raw/r33_input1.csv", check.names = FALSE)
fctr.cols <- sapply(r33_input1, is.factor)
int.cols <- sapply(r33_input1, is.integer)

r33_input1[, fctr.cols] <- sapply(r33_input1[, fctr.cols], as.character)
r33_input1[, int.cols] <- sapply(r33_input1[, int.cols], as.numeric)
save(r33_input1, file = "data/r33_input1.rdata")
