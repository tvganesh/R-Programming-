#############################################################################
#
# R programming - The Essentials
# A quick tutorial on the essential concepts to get started in R programming
# Author: Tinniam V Ganesh
# Date : 9/1/2016
#
#############################################################################


# R programming - The essentials
myvector <- c(1,2,4,5,8,10,12) 

#or
myvector = c(1,2,4,5)


#Display the variable
myvector

# Check the class
class(myvector)

# Using a sequence
myvector <- 2:15
myvector

myvector <- seq(5,50,by=5)
myvector

# Get help on any topic using '?' 
?seq

# or
help(seq)

# Create a sequence between 6 & 43 with a period length of 7
seq(6,43,by=7)

# This is useful when we want 7 equal intervals between 6 & 43
seq(6,43,length=7)


# Get the current working directory
getwd()

#Set the working directory. Note the forward slash
setwd("c:/software/R")

#Check the directory. Also possible to use Session -> Set Working Directory-><dir>
getwd()

# Show objects
ls()

#Show contents of dir
dir()

# Subsetting vectors
myvector <- seq(2,20,by=2)
myvector

#Get elements 3 to 7 of myvector
s <- myvector[3:7]
s

# Arithmetic operations on vectors
myvector1 <- seq(3,30,by=3)
myvector1

a <- myvector + myvector1
a
b <- myvector * myvector1
b


# There are several datasets available that comes with R
# The Dataframe is a tabular form of data with many rows and columns. The 
# type of data can vary from column to column but are the same in each column
data()
class(iris)

# Create a new data frame from iris
df <- iris

# Check the size of the data
dim(df)

#Check the class
sapply(df,class)

# Get a feel of the data
summary(df)
str(df)

# Inspect the data. Display top 6 and bottom 6 of the dataframe
head(df,6)
tail(df,6)

#Subset data
#1. Display 1-6 rows and 2-4 columns
df[1:6,2:4]

#2. Display all rows  for columns 1:3
df[,1:3]

#3. Display all columns for rows 1:5
df[1:5,]

# Check the column names
names(df)

#or
colnames(df)

# Rename columns, if needed, to something more is easy to refer to
colnames(df) <- c("lengthOfSepal","widthOfSepal","lengthOfPetal","widthOfPetal","Species")
colnames(df)


View(df)

# Different ways of subsetting the data
df

df$Species

# Subset 
a <- df$Species == "setosa"

# This gives the rows for which species is 'setosa'
a

#Subset these rows. The "," indicates include all colums for these rows
b <- df[a,]

dim(b)

colnames(b)

b$widthOfSepal
# Compute the mean 
meanSepal <- mean(b$widthOfSepal)
meanSepal

# A useful function is sapply which can compute a function across a list
m <- sapply(b[1:4],mean)
m


#Plot the values of any columm. The box plot is useful
?boxplot

boxplot(b$lengthOfSepal,main="Length of Sepal")

# To get all 4 plots in a 2 x 2 matrix setup.Draw all 4 plots
par(mfrow=c(2,2))
par(mar=c(4,4,2,2))
boxplot(b$lengthOfSepal,main="Length of Sepal")
boxplot(b$widthOfSepal,main="Width of Sepal")
boxplot(b$lengthOfPetal,main="Length of Petal")
boxplot(b$widthOfPetal,main="Width of Petal")

# Reset the display with the following call. Otherwise you will get a 2 x 2 plots
dev.off()


# The problem with the IRIS data set is that it is neat and tidy. 
# Lets look at some real world data 


# Lets look at some real world dat
tendulkar <- read.csv("tendulkar.csv")
dim(tendulkar)
summary(tendulkar)
str(tendulkar)
colnames(tendulkar)

#Display top 5 and bottom 5 rows
head(tendulkar)
tail(tendulkar)

sapply(tendulkar,class)

# View the data frame
View(tendulkar)

#Check the help of read.csv
?read.csv
# The following call does not convert strings in the data frame as factors
# Also remove records which do not have values 'na.strings" where the
# NA (not available) strings can be "NA" or "-"
tendulkar <- read.csv("tendulkar.csv",stringsAsFactor=FALSE,na.strings=c(NA,"-"))
dim(tendulkar)
View(tendulkar)

# Real world data will require a lot of cleaning before you can use it
a <- tendulkar$Runs != "DNB"
tendulkar <- tendulkar[a,]
dim(tendulkar)

# Remove rows with 'TDNB'
c <- tendulkar$Runs != "TDNB"
tendulkar <- tendulkar[c,]

# Remove rows with absent
d <- tendulkar$Runs != "absent"
tendulkar <- tendulkar[d,]
dim(tendulkar)

# Remove the "* indicating not out
tendulkar$Runs <- as.numeric(gsub("\\*","",tendulkar$Runs))
View(tendulkar)

# Check if all rows are complete and have values in all columns
c <- complete.cases(tendulkar)
# Check the number of rows in th dataframe
length(c)

# Determine the number of TRUE's
sum(c)

#Subset the rows which are complete
tendulkar <- tendulkar[c,]
dim(tendulkar)

head(tendulkar,10)

# Do some base plitting
plot(tendulkar$Runs,tendulkar$BF)
#Add title and x and y labels
plot(tendulkar$Runs,tendulkar$BF, pch=18, main="Tendulkar Runs scored vs Balls Faced",
              xlab="Balls Faced", ylab='Runs')


# Compute and  plot a 
l <-lm(tendulkar$BF~tendulkar$Runs)
abline(l,lty=5,lwd=3,col="blue")

#Plot the histogram of runs for Tendulkar
hist(tendulkar$Runs, main="Tendulkar's frequency of runs vs  run ranges",
      xlab="Runs")


# A look package dplyr. One of the most useful package for manipulating data in
# data frames
install.packages("dplyr")

#Call the library to the package to include dplyr
library(dplyr)

# Select columns
colnames(tendulkar)

# Key functions select, filter, arrange, pipe

# Subset specific columns by name of column. Note there is no $ sign or quotes to refer to
# columns
df1 <- select(tendulkar, Runs,Mins,BF)
head(df1)

#Subset rows where the RUns are > 50 and less than 101
df2 <- filter(tendulkar,Runs>50 & Runs < 101)


# There are more interesting conditions with which you can filter and select rows
# columns. Check with ?select & ?filter

# Use the arrange function to arrange columns in descending order of Runs
descRuns <- arrange(tendulkar,desc(Runs))
head(descRuns)


# The Pipe function is extremely useful in dply.
a <- group_by(tendulkar, Ground)
head(a)

# The following command in a single line does the follwoing
#1. Uses the data frame tendulkar (2nd parameter)
#2. Groups the runs scored by ground
#3. Computes the mean runs in each group

meanRuns <- tendulkar %>% group_by(Ground) %>% summarise(m= mean(Runs))

# Display the meanRuns dataframe
meanRuns
colnames(meanRuns)

# Plot the result as a barplot
barplot(meanRuns$m,names=meanRuns$Ground,las=2,ylab="Average Runs", 
        col=rainbow(length(meanRuns$m)),main="Tendulkar's average runs in Grounds",cex.names=0.8)



# This summarises the bare essentials of R programming
#1. You can play around with data frames in R using data()
#2.Pick any data file  that you have access to and start playing around with the data

