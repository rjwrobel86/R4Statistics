# Descriptive Statistics
# Taking the mean, "by hand"
# Take the mean of numbers 1-5
vec1 <- c(1,2,3,4,5) #using "c"
vec2 <- 1:5
# Add all values in vector and divide by number of values
sum(vec2) / length(vec2)
# Alternatively...
mean(vec2)

# Median
# 2, 5, 6, 7, 10, 12, 20, 40, 41
vec3 <- c(2, 15, 6, 71, 10, 120, 2, 40, 14)
vec4 <- sort(vec3) 
lendiv2 <- length(vec3) / 2
lendiv2 #if uneven, round up, if even, round up and take mean of value and next value

vec5 <- c(2, 15, 6, 71, 10, 120, 4, 4, 2, 40, 14, 1)
vec6 <- sort(vec5)
vec6
length(vec6) / 2
(vec6[5] + vec6[6]) / 2

median(vec6)

# Mode
# Count by hand?
table(vec6) # count of unique values in vector
mode(vec6) # DOESNT WORK - NO FUNCTION - CREATE YOUR OWN?


# Measures of Dispursion - aka Spread
# Generating random numbers for example data / simulation
# rnorm() generates random data from the "normal distribution"
# rnorm(NUMBER OF OBSERVATIONS, MEAN, STDEV)
v1 <- rnorm(50)
hist(v1)
v2 <- v1 - mean(v1)
v2
v3 <- v2**2
v3
v4 <- sum(v3)
v4
v5 <- v4 / (length(v3)-1)
v5
var(v1) # Or use the "var()" function

# Standard deviation is the square root of variance
stdev <- sqrt(var(v1))
stdev

sd(v1) # Or use the "sd()" function

#quantiles & percentiles
quantile(data$WA, 0.25) # 1st quantile
quantile(data$WA, 0.50) # 2nd Quantile
quantile(data$WA, 0.75) # 3rd quantile

quantile(data$WA, 0.95) # 95th percentile

#Tables

# Load one of R's built in datasets
data <- mtcars
attach(data)

#Frequency by axis, 2 vars
table <- table(mpg,cyl)
table
margin.table(table,1)
margin.table(table,2)

#Relative frequency by axis, 2 vars
prop.table(table)
prop.table(table, 1)
x <- prop.table(table, 2)
round(x,3)

#Frequency and relative frequency, 3 vars
table2 <- table(cyl,gear,am)
ftable(table2)
prop.table(table2)

#correlation
install.packages('corrgram')
library(corrgram)
corrgram(mtcars)
