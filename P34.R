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



write.csv(dat, "data-raw/p34_input1.csv", row.names=FALSE)

df_out = dat %>% gather(stat, val) %>%
  separate(stat, into = c("var", "stat")) %>%
  spread(stat, val)

write.csv(df_out, "data-raw/p34_output1.csv", row.names=FALSE)

p34_output1 <- read.csv("data-raw/p34_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p34_output1, is.factor)
int.cols <- sapply(p34_output1, is.integer)

p34_output1[, fctr.cols] <- sapply(p34_output1[, fctr.cols], as.character)
p34_output1[, int.cols] <- sapply(p34_output1[, int.cols], as.numeric)
save(p34_output1, file = "data/p34_output1.rdata")

p34_input1 <- read.csv("data-raw/p34_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p34_input1, is.factor)
int.cols <- sapply(p34_input1, is.integer)

p34_input1[, fctr.cols] <- sapply(p34_input1[, fctr.cols], as.character)
p34_input1[, int.cols] <- sapply(p34_input1[, int.cols], as.numeric)
save(p34_input1, file = "data/p34_input1.rdata")
