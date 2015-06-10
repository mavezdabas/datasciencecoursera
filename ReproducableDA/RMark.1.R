# Loading the spam data
# UCI Machine Learning Reprository Spam Datasets
#install.packages("kernlab")
library(kernlab)
data("spam")
str(spam)

#=====================================================================
# Dividing the data into test and training sets using the function
# splitdata
# Divide the data into the training and test set
# 80% training and 20% test
# splitdata <- function(dataframe, seed=NULL) {
#   if (!is.null(seed)) set.seed(seed)
#   index <- 1:nrow(dataframe)
#   trainindex <- sample(index, trunc(length(index)*.80))
#   trainset <- dataframe[trainindex, ]
#   testset <- dataframe[-trainindex, ]
#   list(trainset=trainset,testset=testset)
# }

# wholeDataScale <- splitdata(spam,2513)
trainSpam <- wholeDataScale$trainset
testSpam <- wholeDataScale$testset
#=====================================================================
# Exploratory Data Analysis
# summaries
# missing values
# exploratory plots
# perform clustering
##
names(trainSpam)
head(trainSpam)
# this will show the count of the numvber of type in terms of spam and
# non spam variables
table(trainSpam$type) 
##
plot(trainSpam$capitalAve ~ trainSpam$type)
plot(log(trainSpam$capitalAve + 1) ~ trainSpam$type)
# pairwise plot
## 
hcluster <- hclust(dist(t(trainSpam[,1:57])))
plot(hcluster)
# transformation and clustering
sddvsvhcluster_new <- hclust(dist(t(log10(trainSpam[,1:55] + 1))))
plot(hcluster_new)
#=====================================================================
# Statistical Prediction and Modelling
# Convert the spam and notspam as 0 and 1.
trainSpam$numType <- as.numeric(trainSpam$type) - 1

# Simple approach to start

# using every predictable variable and in the dataset and 
# finding the errors in associated
costFunction <- function(x,y) {
  sum(x != (y > 0.5))
}
cvErroe <- rep(NA,57)
#install.packages("boot")
library(boot)
for(i in 1:57){
  lmFormula <- reformulate(names(trainSpam)[i],response = "numType")
  glmFit <- glm(lmFormula,family = "binomial",data = trainSpam)
  cvErroe[i] <- cv.glm(data = trainSpam,glmFit,costFunction,2)$delta[2]  
}

# Predictor with minimul cross validation error
names(trainSpam)[which.min(cvErroe)] # best variable to fit the model with

# Use the best model from the group
predictionModel <- glm(numType ~ charDollar,
                       family = "binomial",
                       data = trainSpam)
predictionModel
predictionModel_summary <- summary(predictionModel)
predictionModel_summary
# Get prediction on the testset
predictionTest <- predict(predictionModel,testSpam)
head(predictionTest)
predictionTest
predictionSpam <- rep("nonspam",dim(testSpam)[1])
predictionSpam
# As the binomial regression gives the output as probability
# we must take in this into consideration of which values to 
# cloose and which to decline. i.e Spam and nonspam
# Classify as spam for those whose probability is more > 0.5
predictionSpam[predictionModel$fitted.values > 0.5] = "spam"
predictionSpam

## Classification Table
table(predictionSpam,trainSpam$type) 

# Error rate 
(83 + 191) / (521 + 191 + 81 + 746)
# In this model the error rate was 17%

# Challange the result










