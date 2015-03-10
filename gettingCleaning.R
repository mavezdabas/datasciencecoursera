## Getting the Data From the URL

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

