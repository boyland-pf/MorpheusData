# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 28
set.seed(42)
NumObsTrain=8 # this can be as much as 70 000 000
NumObsTest=4 # this can be as much as 6 000 000

#create the TRAIN data set
train1=floor(runif(NumObsTrain, min=0, max=NumObsTrain+1))
train1=matrix(train1,ncol = 2)
train=cbind(8,train1) #week
train=rbind(train,cbind(9,train1)) #week
train=cbind(train,runif(NumObsTrain,min=1,max=10)) #order
train=cbind(c(1:nrow(train)),train)# id number of each row
colnames(train)=c("id","week","prod","clnt","order")
train=as.data.frame(train)
train=train[sample(nrow(train)),] # reflush the rows of train

# Create the TEST dataset
test=train[1:NumObsTest,]
test[,"week"][1:{NumObsTest/2}]=10
test[,"week"][{(NumObsTest/2)+1}:NumObsTest]=11

write.csv(train, "data-raw/p28_input1.csv", row.names=FALSE)
write.csv(test, "data-raw/p28_input2.csv", row.names=FALSE)

newtrain <- select(train, 3:5)
newtest <- select(test, 1,3,4)
x <- dplyr::inner_join(newtest, newtrain)
y <- dplyr::group_by(x, prod, clnt)
df_out <- dplyr::summarise(y, mean.order=mean(order))

write.csv(df_out, "data-raw/p28_output1.csv", row.names=FALSE)

p28_output1 <- read.csv("data-raw/p28_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p28_output1, is.factor)
int.cols <- sapply(p28_output1, is.integer)

p28_output1[, fctr.cols] <- sapply(p28_output1[, fctr.cols], as.character)
p28_output1[, int.cols] <- sapply(p28_output1[, int.cols], as.numeric)
save(p28_output1, file = "data/p28_output1.rdata")

p28_input1 <- read.csv("data-raw/p28_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p28_input1, is.factor)
int.cols <- sapply(p28_input1, is.integer)

p28_input1[, fctr.cols] <- sapply(p28_input1[, fctr.cols], as.character)
p28_input1[, int.cols] <- sapply(p28_input1[, int.cols], as.numeric)
save(p28_input1, file = "data/p28_input1.rdata")

p28_input2 <- read.csv("data-raw/p28_input2.csv", check.names = FALSE)
fctr.cols <- sapply(p28_input2, is.factor)
int.cols <- sapply(p28_input2, is.integer)

p28_input2[, fctr.cols] <- sapply(p28_input2[, fctr.cols], as.character)
p28_input2[, int.cols] <- sapply(p28_input2[, int.cols], as.numeric)
save(p28_input2, file = "data/p28_input2.rdata")
