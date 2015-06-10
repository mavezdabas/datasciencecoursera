########################################
## Loading and preprocessing the data
########################################
# reading the file 
activity <- read.csv("activity.csv",header = TRUE,sep = ",")
head(activity)
str(activity)


###################################################
# Q1: What is mean total number of steps taken per day?
###################################################
activity$date <- as.factor(activity$date)
str(activity$date)

## Calculate the total number of steps taken per day 
steps_day <- data.frame(aggregate( cbind( activity$steps ) ~ activity$date , data = activity ,
                                   FUN = sum))
colnames(steps_day) <- c("Date","Steps") 
head(steps_day)

## Make a histogram of the total number of steps taken each day
hist(steps_day$Steps,main = "Steps each day",
     xlab = "Steps",col = "blue")

## Calculate and report the mean and median of the total number of steps taken per day
mean(steps_day$Steps)
median(steps_day$Steps)

###################################################
# Q2: What is the average daily activity pattern?
###################################################

## Make a time series plot (i.e. type = "l") of the 5-minute interval 
## (x-axis) and the average number of steps taken, averaged across all
## days (y-axis)
library(lattice)
xyplot(activity$steps ~ activity$interval | activity$date,type = "l",
       xlab = "Interval",ylab = "Steps")


## Which 5-minute interval, on average across all the days 
## in the dataset, contains the maximum number of steps?

steps_interval <- aggregate( cbind( activity$steps ) ~ activity$interval, data = activity ,
            FUN = sum )
colnames(steps_interval) <- c("Interval","Steps") 
max_value <- max(steps_interval$Steps)
max_value
max_step <- filter(steps_interval,max_value == steps_interval$Steps)
max_step[1,1]



#=====================================================================
###################################################
# Imputing missing values
###################################################

## Calculate and report the total number of missing values in
## the dataset (i.e. the total number of rows with NAs)

NA_number <- sum(is.na(activity$steps))
NA_number

## Devise a strategy for filling in all of the missing values in the 
## dataset. The strategy does not need to be sophisticated. 
## For example, you could use the mean/median for that day, 
## or the mean for that 5-minute interval, etc.

# We only have the missing values in the steps column
# I choose to replace all the missing values with 0

activity[is.na(activity)] <- 0

## Create a new dataset that is equal to the original dataset but 
## with the missing data filled in.
activity_new <- activity


## Make a histogram of the total number of steps taken each day and 
## Calculate and report the mean and median total number of steps
## taken per day. Do these values differ from the estimates from 
## the first part of the assignment? What is the impact of imputing
## missing data on the estimates of the total daily number of steps?


steps_day_new <- data.frame(aggregate( cbind( activity_new$steps ) ~ activity_new$date ,
                                       data = activity_new ,
                                   FUN = sum))
colnames(steps_day_new) <- c("Date","Steps") 
head(steps_day_new)


hist(steps_day_new$Steps,main = "Steps each day (NEW Data frame)",
     xlab = "Steps",col = "Red")

mean(steps_day$Steps)
median(steps_day$Steps)

# After imputing the missing values in the data set the 
# mean and median still remain the same as it was before
## ** But I have only imputed the missing values to 0.
## ** Which is not the right way to do.



#=====================================================================
###################################################
# Are there differences in activity patterns between weekdays and weekends?
###################################################

## Create a new factor variable in the dataset with 
## two levels – “weekday” and “weekend” indicating whether a given 
## date is a weekday or weekend day.
str(activity_new)
activity_new$date <- as.Date(activity_new$date)
str(activity_new)
activity_new$day <- weekdays(activity_new$date)
head(activity_new,n =1)

activity_new$datType <- ifelse(activity_new$day == "Sunday" | activity_new$day == "Saturday",
                               "Weekend","Weekday")
activity_new$datType <- as.factor(activity_new$datType)
str(activity_new)

## Make a panel plot containing a time series plot (i.e. type = "l")
## of the 5-minute interval (x-axis) and the average number of steps
## taken, averaged across all weekday days or weekend days (y-axis). 
## See the README file in the GitHub repository to see an example of
## what this plot should look like using simulated data.
       
xyplot(activity_new$steps ~ activity_new$interval | activity_new$datType,type = "l",
       xlab = "Interval",ylab = "Steps")
       
## Now we have to create a RMarkdown file for this       
       
