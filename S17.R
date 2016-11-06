# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 43
catalog <- read.table(text=
"sid part_key cost
S1 P1 4
S2 P1 2
S1 P2 4
S2 P2 2
S3 P2 3
S3 P3 4
S1 P4 2
S4 P3 6
S2 P5 4
S3 P5 2
S3 P6 4
S1 P7 2
S2 P8 4
S4 P9 4
S3 P9 6", header=T)

parts <- read.table(text=
"part_key sname
P1 SN1
P2 SN1
P3 SN4
P5 SN2
P9 SN3", header=T)

suppliers <- read.table(text=
"sid sname
S1 SN1
S2 SN2
S3 SN3
S4 SN4", header=T)

write.csv(catalog, "sql/catalog.csv", row.names=FALSE)

catalog <- read.csv("sql/catalog.csv", check.names = FALSE)
fctr.cols <- sapply(catalog, is.factor)
int.cols <- sapply(catalog, is.integer)
catalog[, fctr.cols] <- sapply(catalog[, fctr.cols], as.character)
catalog[, int.cols] <- sapply(catalog[, int.cols], as.numeric)
save(catalog, file = "sql/catalog.rdata")


write.csv(suppliers, "sql/suppliers.csv", row.names=FALSE)

suppliers <- read.csv("sql/suppliers.csv", check.names = FALSE)
fctr.cols <- sapply(suppliers, is.factor)
int.cols <- sapply(suppliers, is.integer)
suppliers[, fctr.cols] <- sapply(suppliers[, fctr.cols], as.character)
suppliers[, int.cols] <- sapply(suppliers[, int.cols], as.numeric)
save(suppliers, file = "sql/suppliers.rdata")

write.csv(parts, "sql/parts.csv", row.names=FALSE)

parts <- read.csv("sql/parts.csv", check.names = FALSE)
fctr.cols <- sapply(parts, is.factor)
int.cols <- sapply(parts, is.integer)
parts[, fctr.cols] <- sapply(parts[, fctr.cols], as.character)
parts[, int.cols] <- sapply(parts[, int.cols], as.numeric)
save(parts, file = "sql/parts.rdata")

# 5.2.5
#sqlsynthesizer output not consistent with textbook
df1=inner_join(catalog,suppliers) %>%
	group_by(part_key) %>% 
	summarise(mean = mean(cost))
 inner_join(catalog,suppliers) %>%
 inner_join(df1) %>% 
 filter(cost > mean) %>% 
 select(part_key,sname)