#==============================Week1==================================
#=================Basic Plot Demonstration============================
x <- rnorm(100)
hist(x)
y <- rnorm(100)
# Setting margans
par(mar = c(2,2,1,1))
plot(x,y, pch = 19)
# example(points)
plot(x,y, pch = 19)
title("Scatter Plot")
text(-2,-1.5, "Label")
legend("topleft",legend = "Data",pch = 20)
#=====================================================================
#==============================Week2==================================
# Lattice
library(lattice)
library(datasets)
xyplot(Ozone ~ Wind, data = airquality)
head(airquality)
airquality <- transform(airquality, Month = factor(Month))
# Ozone and wind for every month
p <- xyplot(Ozone ~ Wind | Month, data = airquality, layout= c(5,1))
print(p)
# GGplot2
# TO BE DONE AGAIN
#=====================================================================
#==============================Week3==================================
# Hierarchical Clustering
set.seed(1234)
par(mar = c(4,4,4,4))
x <- rnorm(12, mean = rep(1:3,each = 4),sd = 0.2)
y <- rnorm(12, mean = rep(c(1,2,1),each = 4),sd = 0.2)
plot(x,y, col = "blue", pch = 19, cex = 2)
text(x +.05,y + .05, labels = as.character(1:12))
# Calculating the distance using the dist function
dataFrame <- data.frame(x = x, y = y)
distxy <- dist(dataFrame)
hClustering <- hclust(distxy) # By default the distance is the euclidean diatance.
plot(hClustering)

























