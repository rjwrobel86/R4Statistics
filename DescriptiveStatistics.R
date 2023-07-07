#Descriptive Statistics (the hard way)

#Load necessary libraries
library(readr)
library(dplyr)
library(stats)

#Function to calculate mean
calculate_mean <- function(series_x) {
  mean <- sum(series_x)/length(series_x)
  return(mean)
}

#Function to calculate median
calculate_median <- function(values) {
  return(median(values))
}

#Function to calculate mode
calculate_mode <- function(values) {
  uniqv <- unique(values)
  return(uniqv[which.max(tabulate(match(values, uniqv)))])
}

#Function to calculate range
calculate_range <- function(values) {
  return(max(values) - min(values))
}

#Function to calculate variance
calculate_variance <- function(values) {
  return(var(values))
}

#Function to calculate standard deviation
calculate_stdev <- function(values) {
  return(sd(values))
}

#Function to calculate covariance
calculate_covariance <- function(series_x, series_y) {
  return(cov(series_x, series_y))
}

#Function to calculate correlation
calculate_correlation <- function(series_x, series_y) {
  return(cor(series_x, series_y))
}

#Function to calculate confidence intervals
confidence_intervals <- function(series, level) {
  ci <- t.test(series, conf.level = level)$conf.int
  return(ci)
}

#Read the data
df <- read_csv('monthly_sales.csv')

#Calculate descriptive statistics for each column
columns <- c('Sales', 'Cost', 'Revenue')
for (column in columns) {
  values <- df[[column]]
  print(paste("Descriptive Statistics for", column, ":"))
  print(paste("Mean:", calculate_mean(values)))
  print(paste("Median:", calculate_median(values)))
  print(paste("Mode:", calculate_mode(values)))
  print(paste("Range:", calculate_range(values)))
  print(paste("Variance:", calculate_variance(values)))
  print(paste("Standard Deviation:", calculate_stdev(values)))
  print("\n")
}

#Use built-in functions to calculate descriptive statistics
print(mean(df$Sales))
print(median(df$Sales))
print(calculate_mode(df$Sales))
print(max(df$Sales))
print(min(df$Sales))
print(var(df$Sales))
print(sd(df$Sales))

#Use summary function to get descriptive statistics
print(summary(df))
