# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)
library(data.table)

#############benchmark 1
dat <- read.table(text=
"page_views        date    caseID 
169 20080130       2007-001          
211 20080116       2007-002         
149 20080117         2007-001        
177 20080114           2007-002        
121 20080115          2007-002   
0 20080112         2007-002        
0 20080113           2007-001         
220 20080110         2007-003      
169 20080111           2007-003          
189 20080118            2007-001  
", header=T)


write.csv(dat, "data-raw/p65_input1.csv", row.names=FALSE)

df_out = dat %>%
  filter (page_views > 0) %>%
  group_by (caseID) %>%
  summarise (earliestDate = min(date))

write.csv(df_out, "data-raw/p65_output1.csv", row.names=FALSE)

p65_output1 <- read.csv("data-raw/p65_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p65_output1, is.factor)
int.cols <- sapply(p65_output1, is.integer)

p65_output1[, fctr.cols] <- sapply(p65_output1[, fctr.cols], as.character)
p65_output1[, int.cols] <- sapply(p65_output1[, int.cols], as.numeric)
save(p65_output1, file = "data/p65_output1.rdata")

p65_input1 <- read.csv("data-raw/p65_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p65_input1, is.factor)
int.cols <- sapply(p65_input1, is.integer)

p65_input1[, fctr.cols] <- sapply(p65_input1[, fctr.cols], as.character)
p65_input1[, int.cols] <- sapply(p65_input1[, int.cols], as.numeric)
save(p65_input1, file = "data/p65_input1.rdata")
