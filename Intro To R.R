#The Basics of R

#Comments
#Write notes to yourself and other users
#The "#" character allows you to write comments that are not treated as code

#Finding and setting your "working directory"
#Find out the directory your files are stored in using getwd()
#Set a new working directory with setwd('PATH\TO\FILE')
getwd()

#Basic arithmatic
200 + 70
150 - 10
210 * 7 
400 / 10
400 + 100 / 5
(400 + 100) / 5

#Comments again
1 + 1 # Comments can also come after commands

#Data types - A) Numeric, B) Character / String, C) Logical, D) Vectors, E) NA
#Checking class types: "class(x)"
class(4)
class(TRUE)
class('Hello World')
class('4')
class(NA)

#"Equals" =/= "="
#By conventions "<-" is used instead of "=" in R.  I don't know why.

#Variables
var1 <- "Statistics"
var2 <- FALSE
var3 <- 4
var4 <- c(1,2,3)

#Vectors
#List of several elements typically of the same datatype
#Created by wrapping elements in "c()"
vec1 <- c(3 ,6, 9)
#Check type of data within vector using "typeof()"
typeof(vec1)
#Check the length of a vector with "length()"
length(vec1)
#Access elements within vector using VECTOR[NUMBER]
vec1[1]
#Vector with sequence of integers START:FINISH
vec2 <- 1:5
#Vector with sequence by steps seq(START,FINISH,STEP)
vec3 <- seq(1,10,0.25)

#Selecting Vector Elements
vec2[5] #Get 5th element in sequence
vec3[-5] #Get all elements except the 5th 
vec3[4:10] #Get 4th through 10th elements in sequence
vec3[c(1,3,5)] #Get elements 1, 3, and 5 of a sequence
#Create vector of unique values from first vector
vec4 <- c(1, 2, 4, 4, 5, 6, 7, 7, 10)
vec5 <- unique(vec4)
vec5

#Conditionals
#For "if" statements, A) type "if" followed by a "condition" withing parentheses
#If the condition is True, the code below will execute, otherwise it will not.

if (TRUE) {
  print('I\'M TELLING THE TRUTH, I SWEAR')
}

# Escape Characters - Some characters are special to R.  To type the apostrophe, I had to show R I wasn't ending the statement by using a \ first.

#More Conditionals
#If / Else

if (TRUE) {
  print("True dat")
} else {
  print("Liar!")
}

#Comparison Operators
#>, <, >=, <=, ==, !=
#Statements evaluate as True or False
4 < 3 

#Logical Operators
#And = "&"
#Or = "|"
#Not = "!"

x <- 4
y <- 5

if (x == 4 & y == 5)
{
  print('That is true')
} else {
  print('That is not true at all')
}

if (x == 4 & y != 5)
{
  print('That is true')
} else {
  print('That is not true at all')
}

#Negation
a <- FALSE
print(!a)

#Misc mathematical operators
#Can be used on individual numbers, variables, or vectors
sqrt(3.14) 
sqrt(vec1)

x = 2.7

log(x) #for the natural logarithm of x
exp(x) #to raise e to the x'th power
round(x) #to round x to the nearest whole number
sum(x) #to calculate the sum of numbers in vector x

#Installing Packages / Libraries
#First install using "install.packages('X')
#Then load the package / library using "library(X)
#Installing and loading the "dplyr" package for data manipulation
install.packages("dplyr")
library(dplyr)

#Creating a dataframe from vectors
vec1 <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
vec2 <- c(2, 4, 6, 8, 10, 11, 12, 14, 16)  
vec3 <- c(10, 20, 30, 40, 50, 60, 70, 80, 90) 
df <- data.frame(vec1, vec2, vec3)
class(df)
#Selecting specific columns (vec2 and vec3) from a dataframe
newframe <- select(df, vec2, vec3)
#Selecting specific columns (vec1) to omit from a dataframe
newframe2 <- select(df, -vec1) 

#Filtering
newframe3 <- filter(df, vec1 > 4) # Filter dataframe so it includes only observations where v1 exceeds 8
newframe3

#Create new dataframe from altered old columns using "transmute()"
newframe4 <- transmute(df, vec2 = vec2*2)
summary(newframe4)

#Create new columns within an existing dataframe using "mutate()"
newframe5 <- mutate(df, vec2 = vec2*2)
summary(newframe5)

#summary(X) prints the summary statistics of data "X"
#head(X) prints the top 6 rows of data "X" or head(X,Y) for Y number of rows instead
summary(df)
head(df)

#Date / Time
#Get system time
Sys.time()
#Set variable dt to system time
dt <- Sys.time()
#Coerce string into date/time object using "as.Date(DATE)"
d1 <- as.Date("2017-12-27")
d1
#Coerce string with format
d2 <- as.Date("27-12-2017", format="%d-%m-%Y")
d2

#Create time series vector
dtvec <- seq(as.Date("2017-12-27"), as.Date("2021-10-3"), by="months")
dtvec
length(dtvec)
#Create two other vectors of the same length and combine them with the date / time vector into data frame
vec6 <- rnorm(length(dtvec))
vec7 <- 1:length(dtvec)
df_ts <- data.frame(dtvec,vec6,vec7)

df4 <- data.frame(vec6,vec7)
newlyTS <- ts(df4$vec6, start = c(2017, 12), frequency = 12) # Frequency is 12 for monthly data
newlyTS
class(newlyTS)

#Importing data via command line
#data <- read.table(FILE, header=TRUE, sep=",", na.rm=TRUE)

#Exporting a CSV data file with readr
#Use "write_csv(YOURDATASETNAME, 'PATHTONEWFILE/NEWFILE.csv')

#Omitting rows with missing data
#dataminusmissing <- na.omit(data)
df2 <- df
df2[2,2] <- NA
df2
df2 <- na.omit(df2)
df2

#Subsetting
#Get columns "df[ , COLUMN#]"
df_c <- df[, 3]
df_c
#Get rows "df[ROW#, ]"
df_r <- df[2, ]
df_r
#Get specific element "df[ROW#, COLUMN#]"
datapoint <- df[2,2]
datapoint
#Get set of columns "df[ , 1:3]"
df_cs <- df[, 2:3]
df_rs <- df[3:5, ]

#Loops
#Loop adding numbers 1 - 20 to a vector
vector <- c()
for (i in 1:20) {
  vector <- c(vector, i)  
}
vector

#Loop squaring a numbers 1 - 20 then adding it to a vector
vector <- c()
for (i in 1:20) {
  i = i * i
  vector <- c(vector, i)  
}
vector
