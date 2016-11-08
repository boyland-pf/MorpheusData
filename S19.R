# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 43
catalog <- read.table(text=
"supplier_key part_id
S1 P1
S1 P4
S2 P1
S2 P3
S3 P1
S4 P4
S5 P4
S5 P2
S6 P5
S7 P6
S8 P4", header=T)

parts <- read.table(text=
"part_id color
P1 red
P2 green
P3 yellow
P4 red
P5 green
P6 yellow", header=T)

suppliers <- read.table(text=
"supplier_key sname
S1 SN1
S2 SN2
S3 SN3
S4 SN4
S5 SN5
S6 SN6
S7 SN7
S8 SN8", header=T)

# write.csv(catalog, "sql/catalog.csv", row.names=FALSE)

# catalog <- read.csv("sql/catalog.csv", check.names = FALSE)
# fctr.cols <- sapply(catalog, is.factor)
# int.cols <- sapply(catalog, is.integer)
# catalog[, fctr.cols] <- sapply(catalog[, fctr.cols], as.character)
# catalog[, int.cols] <- sapply(catalog[, int.cols], as.numeric)
# save(catalog, file = "sql/catalog.rdata")


# write.csv(suppliers, "sql/suppliers.csv", row.names=FALSE)

# suppliers <- read.csv("sql/suppliers.csv", check.names = FALSE)
# fctr.cols <- sapply(suppliers, is.factor)
# int.cols <- sapply(suppliers, is.integer)
# suppliers[, fctr.cols] <- sapply(suppliers[, fctr.cols], as.character)
# suppliers[, int.cols] <- sapply(suppliers[, int.cols], as.numeric)
# save(suppliers, file = "sql/suppliers.rdata")

# write.csv(parts, "sql/parts.csv", row.names=FALSE)

# parts <- read.csv("sql/parts.csv", check.names = FALSE)
# fctr.cols <- sapply(parts, is.factor)
# int.cols <- sapply(parts, is.integer)
# parts[, fctr.cols] <- sapply(parts[, fctr.cols], as.character)
# parts[, int.cols] <- sapply(parts[, int.cols], as.numeric)
# save(parts, file = "sql/parts.rdata")

input=inner_join(catalog,suppliers) %>% inner_join(parts)
write.csv(input, "data-raw/s19_input1.csv", row.names=FALSE)
s19_input1 <- read.csv("data-raw/s19_input1.csv", check.names = FALSE)
fctr.cols <- sapply(s19_input1, is.factor)
int.cols <- sapply(s19_input1, is.integer)
s19_input1[, fctr.cols] <- sapply(s19_input1[, fctr.cols], as.character)
s19_input1[, int.cols] <- sapply(s19_input1[, int.cols], as.numeric)
save(s19_input1, file = "data/s19_input1.rdata")

df1=inner_join(catalog,suppliers) %>%
	inner_join(parts) %>% 
	filter(color == "red") %>%
	select(sname)
df2=inner_join(catalog,suppliers) %>%
	inner_join(parts) %>% 
	filter(color != "red") %>%
	select(sname)
output=setdiff(df1,df2)
write.csv(output, "data-raw/s19_output1.csv", row.names=FALSE)
s19_output1 <- read.csv("data-raw/s19_output1.csv", check.names = FALSE)
fctr.cols <- sapply(s19_output1, is.factor)
int.cols <- sapply(s19_output1, is.integer)
s19_output1[, fctr.cols] <- sapply(s19_output1[, fctr.cols], as.character)
s19_output1[, int.cols] <- sapply(s19_output1[, int.cols], as.numeric)
save(s19_output1, file = "data/s19_output1.rdata")

# 5.2.7
df1=inner_join(catalog,suppliers) %>%
	inner_join(parts) %>% 
	filter(color == "red") %>%
	select(sname)
df2=inner_join(catalog,suppliers) %>%
	inner_join(parts) %>% 
	filter(color != "red") %>%
	select(sname)
setdiff(df1,df2)

#without setdiff -- too complicated
#df1=inner_join(catalog,suppliers) %>% 
#	inner_join(parts) %>% 
#	group_by(color,sname) %>% 
#	summarize(n = n())
#df2=inner_join(catalog,suppliers) %>% 
#	inner_join(parts) %>% 
#	group_by(sname) %>% 
#	summarize(n2 = n())
#inner_join(df1,df2) %>% 
#filter(n == n2 & color == "red") %>%
#ungroup() %>%
#select(sname)
