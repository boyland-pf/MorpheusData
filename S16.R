# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 43
catalog <- read.table(text=
"sid part_key
S1 P1
S2 P1
S1 P2
S2 P2
S3 P2
S3 P3
S1 P4
S3 P3
S2 P5
S3 P5
S3 P6
S1 P7
S2 P8
S4 P9
S3 P9", header=T)

parts <- read.table(text=
"part_key pname
P1 PN1
P2 PN2
P3 PN3
P4 PN4
P5 PN5
P6 PN6
P7 PN7
P8 PN8
P9 PN9", header=T)

suppliers <- read.table(text=
"sid sname
S1 SN1
S2 SN2
S3 AWS
S4 AWS", header=T)

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

# 5.2.4
df1=inner_join(parts,catalog) %>% 
	inner_join(suppliers) %>% 
	group_by(pname,sname) %>% 
	summarise(n = n()) %>% 
	filter(sname == "AWS")
df2=inner_join(parts,catalog) %>% 
	inner_join(suppliers) %>% 
	group_by(pname) %>% 
	summarise(n = n())
inner_join(df1,df2) %>%
select(pname)