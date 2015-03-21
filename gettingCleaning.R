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




















































