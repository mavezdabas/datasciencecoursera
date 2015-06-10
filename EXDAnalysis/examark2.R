#=======================K-means=====================
set.seed(1234)
par(mar = c(0,0,0,0))
x <- rnorm(12, mean = rep(1:3,each = 4),sd = 0.2)
y <- rnorm(12,mean = rep(c(1,2,3),each = 4),sd = 0.2)
plot(x,y,col = "blue",pch =19, ctx = 2)
text(x+0.05,y+0.05,labels = as.character(1:12))
dataFrame  <- data.frame(x,y)
dataFrame
# we use kmean to do kmean cluster analysis in R. here wer are working 
# with 3 centres
kmeanObj <- kmeans(dataFrame,centers = 3)
names(kmeanObj)
## Shows all the methods we can do with the kmeanObj
kmeanObj$cluster
# forst 4 points in cluster 1 the next 4 points in cluster 2 and next
# in cluster 3
plot(x,y,col = kmeanObj$cluster,pch = 19, ctx = 2)
points(kmeanObj$centers,pch =3, ctx = 3, lwd = 3,col = 1:3)
# Another way to represent the Kmean in cluster

### Heatmaps
dataMatrix <- as.matrix(dataFrame)[sample(1:12),]
kmeanObj2 <- kmeans(dataMatrix,centers = 3)
kmeanObj2
par(mfrow = c(1,2), mar = c(2,4,0.1,0.1))
image(t(dataMatrix)[,nrow(dataMatrix):1],yaxt = "n")
image(t(dataMatrix)[,order(kmeanObj$cluster)],yaxt = "n")

image(t(dataMatrix))



#================Dimensionality Reduction================
set.seed(12345)
par(mar = rep(0.2,4))
dataMatrix <- matrix(rnorm(400),nrow = 40)
image(1:10,1:40,t(dataMatrix)[,nrow(dataMatrix):1])
heatmap(dataMatrix)

set.seed(678910)
for (i in 1:40) {
  # flip a coin
  coinFlip <- rbinom(1, size = 1, prob = 0.5)
  # if coin is heads add a common pattern to that row
  if (coinFlip) {
    dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0, 3), each = 5)
  }
}
par(mar = rep(0.2,4))
image(1:10,1:40,t(dataMatrix)[,nrow(dataMatrix):1])
# Now we can see that we have a better association between the column values.
heatmap(dataMatrix)
# Pattern in rows and columns
hh <-  hclust(dist(dataMatrix))
hh
dataMatrixOrdered <- dataMatrix[hh$order,]
par(mfrow = c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(rowMeans(dataMatrixOrdered),40:1,xlab = "Row mean",pch = 19)
plot(colMeans(dataMatrixOrdered),xlab = "Column", ylab = "Column mean", pch =19)

## Components on SVD u and v
svd1 <- svd(scale(dataMatrixOrdered))
svd1$d
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(svd1$u[,1],40:1,xlab = "Row", ylab = "First left singular vector",
     pch =19)
plot(svd1$v[,1],xlab = "Column", ylab = "First right singular vector",
     pch = 20)
# Variance explained
# now we will lok at the D amtrix which is a diagonal matrix and thus
# exlains the variance of that perticular components.
par(mfrow = c(1,3))
plot(svd1$d,xlab = "Column",ylab = "Singular Value",pch = 19)
plot(svd1$d^2/sum(svd1$d^2),xlab = "Column", 
     ylab = "Proportion of variance explained", pch = 22)
# Thus by looking at the graph we can say that around 40% of the 
# variation in the model is explained due to the just a single column.

### Relationship to principal components
svd1 <- svd(scale(dataMatrixOrdered))
pca1 <- prcomp(dataMatrixOrdered,scale = TRUE)
plot(pca1$rotation[,1],svd1$v[,1],pch = 19,xlab = "Princila Components",
     ylab = "Right singular components 1")
abline(c(0,1))
# With this we see that both svd and pca have the same result in terms
# of component selection.



