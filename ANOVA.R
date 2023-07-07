#Load necessary libraries
library(ggplot2)
library(dplyr)
library(car)

#Set seed for reproducibility
set.seed(1663)

#Generate data
n <- 1000
salaries <- rnorm(n, mean = 50000, sd = 10000)
majors <- c('Engineering', 'Computer Science', 'Sociology', 'Education')
school_types <- c('Public', 'Private')
ages <- sample(22:65, n, replace = TRUE)
genders <- c('Male', 'Female')

data <- data.frame(
  Major = sample(majors, n, replace = TRUE),
  Salary = salaries,
  School_Type = sample(school_types, n, replace = TRUE),
  Age = ages,
  Gender = sample(genders, n, replace = TRUE)
)

#Box plots by factor (major)
ggplot(data, aes(x = Major, y = Salary)) +
  geom_boxplot() +
  xlab('Major') +
  ylab('Salary')

#Means by factor (major)
grouped_means <- data %>%
  group_by(Major) %>%
  summarise(mean = mean(Salary))
print(grouped_means)

#ANOVA Assumption 1: Normally distributed data
#Shapiro-Wilk test for normality
grouped_data <- data %>%
  group_by(Major)

for (group in unique(grouped_data$Major)) {
  print(paste("Shapiro-Wilk Test Results for", group))
  print(shapiro.test(grouped_data$Salary[grouped_data$Major == group]))
}

#Levene's test for homogeneity of variances
leveneTest(Salary ~ Major, data = data)

#Perform one-way ANOVA
anova_results <- aov(Salary ~ Major, data = data)
summary(anova_results)

#Create some differences
data$Salary[data$Major == 'Engineering'] <- data$Salary[data$Major == 'Engineering'] * 1.25
data$Salary[data$Major == 'Education'] <- data$Salary[data$Major == 'Education'] * 0.75
data$Salary[data$Major == 'Sociology'] <- data$Salary[data$Major == 'Sociology'] - 3000

#Box plots by factor (major) after creating differences
ggplot(data, aes(x = Major, y = Salary)) +
  geom_boxplot() +
  xlab('Major') +
  ylab('Salary')

#Means by factor (major) after creating differences
grouped_means <- data %>%
  group_by(Major) %>%
  summarise(mean = mean(Salary))
print(grouped_means)

#Perform one-way ANOVA after creating differences
anova_results <- aov(Salary ~ Major, data = data)
summary(anova_results)

#Two Way ANOVA
#Reset fake data
set.seed(1663)
data <- data.frame(
  Major = sample(majors, n, replace = TRUE),
  Salary = rnorm(n, mean = 50000, sd = 10000),
  School_Type = sample(school_types, n, replace = TRUE),
  Age = sample(22:65, n, replace = TRUE),
  Gender = sample(genders, n, replace = TRUE)
)

#Perform two-way ANOVA
anova_results <- aov(Salary ~ Major + School_Type + Major:Gender, data = data)
summary(anova_results)

#Create some differences and test again
data$Salary[data$Major == 'Engineering'] <- data$Salary[data$Major == 'Engineering'] * 1.25
data$Salary[data$Major == 'Education'] <- data$Salary[data$Major == 'Education'] * 0.75
data$Salary[data$Major == 'Sociology'] <- data$Salary[data$Major == 'Sociology'] - 3000
data$Salary[data$School_Type == 'Private'] <- data$Salary[data$School_Type == 'Private'] + 6000

#Means by Major after creating differences
grouped_means <- data %>%
  group_by(Major) %>%
  summarise(mean = mean(Salary))
print(grouped_means)

#Means by School Type after creating differences
grouped_means <- data %>%
  group_by(School_Type) %>%
  summarise(mean = mean(Salary))
print(grouped_means)

#Perform two-way ANOVA after creating differences
anova_results <- aov(Salary ~ Major + School_Type + Major:School_Type, data = data)
summary(anova_results)
