## Getting the Data From the URL
#######################------ WEEK 1 --------##############################
file.url <- "https://data.baltimorecity.gov/api/views/aqgr-xx9h/rows.csv?accessType=DOWNLOAD"
download.file(file.url,destfile = "./data/cameras.csv",method = "curl")
list.files("./data")
dataDownload <- date()

## Reading the Data from the Table csv File
data.table <- read.table("./data/cameras.csv",sep = ",",header = TRUE)
summary(data.table)

## Gtting data from the Excel Sheets 
file.urlexcel <- ("https://data.baltimorecity.gov/api/views/aqgr-xx9h/rows.xlsx?accessType=DOWNLOAD")
download.file(file.urlexcel,destfile = "./data/cameras.xlsx", method = "curl")
dataDownload <- date()


## Reading the Data from the Table xlsx 
library(xlsx)

## Gtting data from the XML Sheet 
# Markup - Tags
# Contents - Actual Text
# <section>
#   </section>
#   <linebreak />
#   
#   <Getting> Hello, world </Getting>

library(XML)
file.xml <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(file.xml,useInternal = TRUE)

rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

rootNode[[1]]
rootNode[[1]][[1]]
##  Extracting parts of the XML FIle 
xmlApply(rootNode,xmlValue) ## All the elements in the rootNode
## Extracting the perticular Name and Price from the XML File using XPath Query
xpathSApply(rootNode,"//name",xmlValue)
xpathSApply(rootNode,"//price",xmlValue)


file.url.xml <- "http://www.espn.go.com/nfl/team/_/name/baltimore-ravens"
doc.xml <- htmlTreeParse(file.url.xml,useInternal= TRUE)

scores <- xpathSApply(doc.xml,"//li[@class='score']",xmlValue)
teams <- xpathSApply(doc.xml,"//li[@class='team-name']",xmlValue)


## JSON
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
names(jsonData$login)
## Converting the Iris dataset to JSON.
myjson <- toJSON(iris ,pretty = TRUE)
cat(myjson)
iris2 <- fromJSON(myjson)

## data.table Package
tables()

# keys
DT <- data.table(x = rep(c("a","b","c"),each = 100), y= rnorm(300)) 
#######################------ QUIZ 1 --------##############################
# Answer-1
ans1 <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",destfile = "./data/ans1.csv",method = "curl")
list.files("./data")
ans1.data <- read.table("./data/ans1.csv",sep = ",",header = TRUE)


  ansval <- c(ans1.data$VAL) # column to character Vector
  ansval <- ansval[!is.na(ansval)] # removing the NA
  z <- 0
  for (i in ansval){
    
    if(i >= 24){
      z <- z+1
    }
    z
  }
  
# Answer-3 XSLX Data
  
ans3 <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx",destfile = "./data/ans3.xlsx", method = "curl")
library(xlsx)
ans3.data <- read.xlsx("./data/ans3.xlsx",sheetIndex = 1,header = TRUE)
head(ans3.data)
# As i want to read pecific rows and colums from the excel sheet so
# i will have to create row index and column index
colIndex <- 7 : 15
rowIndex <- 18 : 23
# now a command from the specific rows to the specific rows.
dat <- read.xlsx("./data/ans3.xlsx",sheetIndex = 1,colIndex = colIndex,rowIndex = rowIndex)

# Answer-4 XML Data 21231
library(XML)
library(RCurl)
ans4.xml <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
ans4.data <- getURL(ans4.xml)
ans4.data.doc <- xmlParse(ans4.data)
ans4.rootNode <- xmlRoot(ans4.data.doc)
xmlName(ans4.rootNode)
names(ans4.rootNode)
ans4.rootNode[[1]]
xmlApply(ans4.rootNode,xmlValue)
ans4.zip <- xpathSApply(doc = ans4.rootNode,"//zipcode",xmlValue)
zip <- 0
for(i in ans4.zip){
  if(i == 21231){
    zip = zip +1
  }
  zip
}

# Answer-5 

ans5 <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",destfile = "./data/ans5.csv",method = "curl")
ans5.data <- read.table("./data/ans5.csv",sep = ",", header = TRUE)








#######################------ WEEK 2 --------##############################
## mySQL
install.packages("RMySQL")
library(RMySQL) 
# dbConnect This fucnction is used to create a connection to a DBMS
ucscDb <- dbConnect(MySQL(), user = "genome",host = "genome-mysql.cse.ucsc.edu")
# uscsDb shall be an Handler for the connection.
# dbGetQuery() this command is used to fire a query for the database 
result <- dbGetQuery(ucscDb,"show databases;")
# now we must disconnect with the connection that we have made
dbDisconnect(ucscDb)
# Now if we wish to gain acces to a perticular batabase in the URL
hg19 <- dbConnect(MySQL(), user = "genome", db = "hg19", host = "genome-mysql.cse.ucsc.edu")

# showing all the tables in DB hg19
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:7]
# getting Dimensions of a Specific Table
dbListFields(hg19,"affyU133Plus2") # this shall return the columns
# like dataframe has columns this will also act like the columns of 
# mysql database
# Find the Number of rows in the Datset
dbGetQuery(hg19,"select count(*) from affyU133Plus2")
# Reading from the Table
readtable <- dbReadTable(hg19,"affyU133Plus2")
head(readtable)
# As we know that the Mysql database are quite large so we only need 
# to have a subset of the data
# Select a Specific Subset:
query <- dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
query.fetch <- fetch(query)
quantile(query.fetch$misMatches)

query.small <- fetch(query, n = 10)
# we should also clear the Query which was send using the dbSendQuery
dbClearResult(query)

## DONT FORGET TO CLOSE THE CONNECTION
dbDisconnect(hg19)


## HDF5

source("http://bioconductor.org/biocLite.R")
biocLite("hdf5")
library(hdf5)

## Web
# Jeff Leek https://scholar.google.com/citations?user=HI-I6C0AAAAJ
# Getting Data off web pages readLines()
con <- url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlcode <- readLines(con)
close(con)

# Parsing with XML Package
library(XML)

url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url,useInternalNodes = TRUE)
xpathSApply(html,path = "//title",xmlValue)
xpathSApply(html,path = "//td[@id ='col-citedby']",xmlValue)

# Get command with the Httr package
library(httr)
#GET is a command to get the URL using the GET Command
html2 <- GET(url)
#now e have to extraxt the content from the HTML page
content <- content(html2,as="text")
parsehtml <- htmlParse(content,asText = TRUE)
xpathSApply(parsehtml,path = "//title",xmlValue)

#Accessing websites with passwords
# in this case we have to get the authenticatiom from the 
# we can do this by adding authenticate() function in the GET command
authenticate(user = "user",password = "passwd")

# Using Handles
# we dont have to keep authenticating if we have saved the handle.
# see R-blogger to see the examples of R blogger to see the examples
# for web scraping.


## Getting Data from the API
# API - Application Programme Interface.

#######################--QUIZ - 2--##############################################

# Answer (1)
# New application using the Github
clientID <- "e70c82ebac4e43e5f133"
clientSecret <- "4b037333bfe29746ea8cf10923fa957fbe9baef0"
tokenName <- "e70c82ebac4e43e5f133"
tokenSecret <- "656ea15413c7267d944fa5c68d670e00b4b21a04"
#
myapp <- oauth_app("newDataScientist",key = clientID,secret = clientSecret)
sig <- sign_oauth1.0(myapp,token = tokenName,token_secret = tokenSecret)

homeGIT <- GET("https://api.github.com/users/jtleek/repos",sig)
contentGit <- content(homeGIT)


#######################------ WEEK 3 --------##############################

########   Subsetting and Sorting
set.seed(13435)

X <- data.frame("var1" = sample(1:5), "var2" = sample(6:10), "var3"= sample(11:15))
#make some values as NA
X <- X[sample(1:5),]
X$var2[c(1,3)] = NA
X[,1]
X[,"var1"]
X[1:2,"var2"]

X[(X$var3 >= 14 & X$var1 >= 4),]
X[(X$var3 >= 14 | X$var1 >= 4),]
X[which(X$var1 > 3),]
X[,which(X$var1 > 3)]
#sort
sort(X$var1)
sort(X$var3,decreasing = FALSE)
sort(X$var2,na.last = TRUE)
#ordering
# if we wish to order the dataset which depends on the column 1
# will show the value of the datatable as per the column 1

X[order(X$var1),]
X[order(X$var1,X$var3),]
#plyr
library(plyr)
arrange(X,var1)
arrange(X,desc(var1))

#cbind
Y <- cbind(X,rnorm(5))
Yr <- rbind(X,rnorm(5))
Yr
Yl <- cbind(rnorm(5), X)
Yl

########   Summarizing Datasets
restData <- read.csv("Restaurants.csv")
head(restData,n = 3)
summary(restData)
str(restData)
quantile(restData$councilDistrict,na.rm = TRUE)

table(restData$zipCode,useNA = "ifany")
table(restData$councilDistrict,restData$zipCode)

#checking the missing values
sum(is.na(restData$councilDistrict))
sum(is.na(restData$zipCode))
any(is.na(restData$councilDistrict))
any(is.na(restData$policeDistrict))

colSums(is.na(restData))
all(colSums(is.na(restData)) == 0)

#values with specific values
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212", "21213"))
# subset for the above condition  data
restData[restData$zipCode %in% c("21212", "21213"),] # only the rows with 21212 and 2123 zipcodes
#size of the dataset
object.size(restData)
print(object.size(restData),units = "Mb")

########   Creating new Variables

restData$nearMe <- restData$neighborhood %in% c("Roland Park", "Homaland")
table(restData$nearMe)

#if the zipcode is wrong
restData$zipWrong <- ifelse(restData$zipCode < 0,TRUE,FALSE)
table(restData$zipWrong,restData$zipCode < 0)
#creating categorical data using cut

#creating factor variables
# Often times an experiment includes trials for different levels of some
# explanatory variable. These levels are called factors.
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:4]
class(restData$zcf)
#levels of factor variables
yesno <- sample(c("yes","no"),size = 10,replace = TRUE)
yesnofec <- factor(yesno,levels = c("yes","no"))
relevel(yesnofec,ref = "yes")
as.numeric(yesnofec)
# cutting also produces the factor variables
# using the mutate function
library(plyr)
library(Hmisc)
restData2 <- mutate(restData,zipGroups = cut2(zipCode,g = 4))
table(restData2$zipGroups)

########   Reshaping Data
# our first goal is to get a tidu data set
# 1. each variable should form own column
# 2. each observation should form a row
# 3. each table/file stores data of only one kind of abservation
# Starting with reshaping
library("reshape2")
head(mtcars)
# Melting data frames
mtcars$carname <- rownames(mtcars)
head(mtcars)
carMelt <- melt(mtcars, id = c("carname","gear","cyl"),measure.vars = c("mpg","hp"))
head(carMelt,n = 3)
tail(carMelt,n = 3)
# Casting data frames
cylData <- dcast(carMelt,carMelt$cyl ~ carMelt$variable)
dcast(carMelt,cyl ~ variable)
#This will tell us that we 4cyl have mpg values of 11 and hp of 11 and so on.
dcast(carMelt,cyl ~ variable,mean )
# Averaging Values
head(InsectSprays)
tapply(InsectSprays$count,InsectSprays$spray,sum)
# another way is by split
spIns <- split(InsectSprays$count,InsectSprays$spray)
spIns# list of the values of A and so on
# now we can use lapply
sprCount <- lapply(spIns,sum)
sprCount
unlist(sprCount)
# another way is the plyr package
library("plyr")
ddply(.data = InsectSprays,.(spray),summarize,sum=sum(count))

########   Managing Data dplyr  IMPORTANT
# select
# filter
# arrabge
# rename
# mutate
# summarize 
library(dplyr)
chicago <- readRDS("chicago.rds")
names(chicago)

#SELECT
#see the columns starting with city and till dptp
# this select statement is good as now we fdont have to use the $
# indicies we can directly use the column names as paramaners and 
# get the values out
head(select(chicago,city:dptp))
# all the columns except the given
# all the columns except city to dptp
head(select(chicago,-(city:dptp)))
#if not dplye package
i <- match("city",names(chicago))
j <- match("dptp",names(chicago))
head(chicago[,-(i:j)])

#FILTERS
# same as select we can refer the variabe names directly
chic.f <- filter(chicago,pm25tmean2 > 30)
head(chic.f)
chic.f <- filter(chicago,pm25tmean2 > 30 & tmpd > 80)

#ARRANGE 
#to order the data of the data frame
chicago <- arrange(chicago,date) # arranges the dates starting from
                                  # oldest
head(chicago)
tail(chicago)
# and if we want in the reverse order
chicago <- arrange(chicago,desc(date))

#RENAME
# this is just used to rename a variable name in r
chicago <- rename(chicago,pm25 = pm25tmean2,dewpoint = dptp)

#MUTATE 
# trasnform new variables or create new variables
chicago <- mutate(chicago,pm25mean = pm25 - mean(pm25,na.rm = TRUE))
head(select(chicago,pm25,pm25mean))
#use the pipeline operator %>%

########   Merging Data
url1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
url2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(url1,destfile = "/Users/mavezsinghdabas/datasciencecoursera/reviews-apr29.csv",method = "curl")
download.file(url2,destfile = "/Users/mavezsinghdabas/datasciencecoursera/solutions-apr29.csv",method = "curl")
reviews <- read.csv("reviews-apr29.csv")
solutions <- read.csv("solutions-apr29.csv")
head(reviews,n = 2)
# the solution id in the review table corresponds to the solutions
# table id.
head(solutions,n = 2)

mergeData <- merge(reviews,solutions,by.x = "solution_id",by.y = "id",all = TRUE)
head(mergeData)

#default : by default it merges on all common column names
intersect(names(reviews),names(solutions))
mergeData2 <- merge(reviews,solutions,all = TRUE)
head(mergeData2)

#using join in the plyr package
# this is good but not fast and it merges the data sets only based 
# on the value of the id. not like the one which we used like
# solution_id and id from different reslective tables
install.packages("base64")
library("base64")
df1 <- sample(id = sample(1:10),x = norm(10))
df1 <- sample(id = sample(1:10),y = rnorm(10))

# if we have multiple data frames we can use the join from the plyr 
# package because it is difficult to use merge for multiple dataframes









































