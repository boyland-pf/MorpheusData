# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#b31_input1 <- read.csv("data-raw/b31_input1.csv")
#b31_input2 <- read.csv("data-raw/b31_input2.csv")
#b31_output1 <- read.csv("data-raw/b31_output1.csv")
#b31_output1 <- read.csv("data-raw/b31_output1.csv")
#b1_output1 <- spread(b1_input1, key, value)

#############benchmark 1
#write.csv(b1_output1, file = "data-raw/b1_output1.csv", row.names = FALSE)
#b1_input1 <- read.csv("data-raw/b1_input1.csv")
#save(b1_input1, file = "data/b1_input1.rdata")
#b1_input1

#b1_output1 <- read.csv("data-raw/b1_output1.csv")
#save(b1_output1, file = "data/b1_output1.rdata")

#save(b31_input2, file = "data/b31_input2.rdata")
#save(b31_output1, file = "data/b31_output1.rdata")

############benchmark 4
b4_input1 <- read.table(textConnection(
                "Code Country        1950    1951    1952    1953    1954
                AFG  Afghanistan    20,249  21,352  22,532  23,557  24,555
                ALB  Albania        8,097   8,986   10,058  11,123  12,246"), header=TRUE)

b4_output1 <- gather(b4_input1, year, value, -c(Code, Country))

############benchmark 5
b5_input1 <- read.table(textConnection(
"uniqueid   seq   response    detailed   treatment 
a            N1     123.23     descr1     T1
a            N2     231.12     descr2     T1
a            N3     231.23     descr3     T1
b            N1     343.23     descr1     T2
b            N2     281.13     descr2     T2
b            N3     901.23     descr3     T2"), header=TRUE)
b5_output1 <- spread(b5_input1[-1], treatment, response)

#############benchmark 7
b7_input1 <- data.frame(round = c("round1", "round2", "round1", "round2"),
                 var1 = c(22, 11, 22, 11),
                 var2 = c(33, 44, 33, 44),
                 nam = c("foo", "foo", "bar", "bar"),
                 val = runif(4))

b7_output1 <- gather(b7_input1, variable, value, var1, var2, val) %>%
                    unite(var, variable, round) %>%
                    spread(var, value)
write.csv(b7_input1, file = "data-raw/b7_input1.csv", row.names = FALSE)
save(b7_input1, file = "data/b7_input1.rdata")
write.csv(b7_output1, file = "data-raw/b7_output1.csv", row.names = FALSE)
save(b7_output1, file = "data/b7_output1.rdata")


############benchmark 19
b19_input1 = structure(list(date = structure(c(1L, 1L, 1L, 1L, 1L, 1L, 1L, 
1L, 1L, 1L, 1L, 1L), .Label = "Jan-97", class = "factor"), day = c(1L, 
1L, 1L, 1L, 2L, 2L, 2L, 2L, 3L, 3L, 3L, 3L), hour = c(1L, 2L, 
3L, 4L, 1L, 2L, 3L, 4L, 1L, 2L, 3L, 4L), Value = c(65L, 29L, 
31L, 42L, 42L, 52L, 61L, 57L, 55L, 52L, 57L, 46L)), .Names = c("date", 
"day", "hour", "Value"), class = "data.frame", row.names = c(NA, 
-12L))

b19_output1 <- b19_input1 %>% spread(hour, Value)

############benchmark 22
b22_input1 <- data.frame(variable=c(rep('Males', 10), rep('Females', 10)), value=sample(1:1000, 20))
b22_output1 <- b22_input1 %>% group_by(variable) %>% summarise(mean=mean (value)) 

#############benchmark 25
library(lubridate)
b25_input1 <- data.frame(
  date  =dmy(c(     "12/6/2012",           "13/7/2012",    "4/8/2012")),
  days  =    c(               1,                     6,           0.5),
  name  =    c("Intro to stats", "Stats Winter school", "TidyR tools"),
  topics=    c( "probability|R", "R|regression|ggplot", "tidyR|dplyr"),
  stringsAsFactors=FALSE
  )

b25_output1 <- b25_input1 %>% separate(topics,into=c("key", "value")) %>% 
                                gather(key1,value2, 4:5) %>% select(-c(4))

#############benchmark 28
b28_input1 <- data.frame(month=rep(1:3,2),
                 student=rep(c("Amy", "Bob"), each=3),
                                  A=c(9, 7, 6, 8, 6, 9),
                                                   B=c(6, 7, 8, 5, 6, 7))

b28_output1 <-  b28_input1 %>% gather(variable, value, -(month:student)) %>%
                unite(temp, student, variable) %>%
                spread(temp, value)

#############benchmark 29
b29_input1 <- structure(list(name = c("A", "A", "A", "B", "B", "B"), information = c("300 USD", 
"70 kg", "2 cm", "400 USD", "90 kg", "5 cm")), .Names = c("name", 
"information"), class = "data.frame", row.names = c(NA, -6L))
b29_output1 <- b29_input1 %>% separate(information, c("tmp1","tmp2")) %>% 
spread(tmp2, tmp1) %>% select(c(1,4,3,2))

