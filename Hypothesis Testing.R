#Hypothesis Testing

set.seed(12345) #Set seed to allow replication of random data

#Sampling

#Sampling from population
population <- rnorm(500, 50, 25)
sample1 <- sample(population, 100)
sample2 <- sample(population, 100)
mean(pop)
mean(sample1)
mean(sample2)
boxplot(population,sample1,sample2)

#Use Z test if sample size is > 30 and population standard deviation is known

#Z test of given value vs mean of data
data <- rnorm(1000,50,12) #Generate normally distributed data
meand = mean(data) #Mean
stdevd = sd(data) #Standard deviation
xval = 35 #A random value to test
z = (xval - meand) / stdevd
z
#Z equals number of standard deviations away from the mean, negative for less than mean, positive for greater than the mean


#One Sample Z Test - Comparing a sample mean to a population mean 
#Z = (Sample Mean - Population Mean) / Population Standard Deviation
s1 <- sample(data,50) #Take a sample from the population
s2 <- sample(data,50) #Take another sample
mean(data) 
mean(s1) 
mean(s2)  
boxplot(data,s1,s2)

z = ((mean(s1)-mean(data)))/(var(data)/sqrt(length(s1)))
cv1t = qnorm(.05) #qnorm(alpha) gives us our critical value for a Z test
cv2t = qnorm(.05/2) #If two tailed test, alpha is divided by two
cv1t
cv2t
#If left tailed test, Z must be less than CV to reject the null
#If right tailed test, Z must be greater than CV to reject the null
#If two tailed test, the absolute value of Z must be greater than the absolute value of CV


###Two Sample Z Test - Comparing two sample means 
#If (mean1 = mean2) then (mean1-mean2 = 0)
Z = (Mean1 - Mean2 - Difference(0)) / (sqrt(((var1/n1)+(var2/n2))))
Zn = (mean(s1) - mean(s2) - 0)
Zd = sqrt(((var(s1)/length(s1))+(var(s2)/length(s2))))
Z = Zn / Zd
Z
cv = qnorm(1-0.05)
cv
"Reject the null?"
print(abs(z) > abs(cv))

#Creating a function to conduct a two sample Z test
ztester2sample <- function(sample1,sample2,diff,alpha) {
  numerator <- mean(sample1) - mean(sample2) - diff
  denominator <- sqrt((var(sample1)/length(sample1)) + (var(sample2)/length(sample2)))
  z = (numerator/denominator)
  cv = qnorm(0.05)
  absz = abs(z)
  abscv = abs(cv)
  print("Reject the null?")
  print(absz > abscv)
}
ztester2sample(s1,s2,0) #Calling our function


##########T - TESTING - TIME##########
# One Sample T-Test
pop = rnorm(1000,45000,900) #Population data
s20 = sample(pop,20) #Sample 20 members of pop
boxplot(pop,s20) #Boxplot of population vs sample 
mean(pop) #Population mean
mean(s20)#Small sample mean
res20 <- t.test(s20, mu=44973) # T Test
res20 # Test results
s50 <- sample(pop,50) # Small Sample
boxplot(pop,s50) # Boxplot
mean(s50) #Less-small sample
res50 <- t.test(s50, mu=44973) 
res50 # results 

# Two Sample T-Test
# Generate fake data from a normal distribution, 20k difference
v1 <- rnorm(100, 25000, 1000)
v2 <- rnorm(100, 45000, 1000)
boxplot(v1,v2)
#Means
mean(v1)
mean(v2)
# Run a "two-sample t-test" to assess difference in means between two samples
t1 <- t.test(v1,v2)
t1 # If p<2.2e-16, we reject the null with extreme confidence

#1k difference
v3 <- rnorm(100, 25000, 1000)
v4 <- rnorm(100, 26000, 1000)
boxplot(v3,v4)
mean(v3)
mean(v4)
t2 <- t.test(v3,v4)
t2

#10 difference
v5 <- rnorm(100, 25010, 1000)
v6 <- rnorm(100, 25000, 1000)
boxplot(v5,v6)
t3 <- t.test(v5,v6)
t3 

#0 difference
v7 <- rnorm(100, 25000, 1000)
v8 <- rnorm(100, 25000, 1000)
boxplot(v7,v8)
mean(v7)
mean(v8)
t4 <- t.test(v7,v8)
t4

#Paired T Test used when samples don't change
#Sample pre-treatment is same sample post-treatment
#Example: Group begins diet program

before <- c(200,210,199,180,250,155,300)
after1 <- c(175,205,188,160,210,145,220)
after2 <- c(190,208,195,177,250,155,301)
boxplot(before,after1,after2)
t.test(before,after1,paired=TRUE)
t.test(before,after2,paired=TRUE)


# one sample t-test
# t.test(y,mu=3)
### optional parameters: 
#1) var.equal=TRUE if variance between samples is equal
#2) alternative="less" or alternative="greater" for one tail

moredata <- rnorm(500,25,3)
moreS1 <- sample(moredata,25)
moreS2 <- sample(moredata,25)
moreS1
meanmores1 <- mean(moreS1)
moreS2
t.test(moreS1,mu=meanmores1)

# independent 2-group t-test
# t.text(y~x), where y is numeric and x is binary
binvar <- rbinom(n=100,size=1,prob=0.5)
t.test(moreS1,binvar)

# independent 2-group t-test
# t.text(y1,y2), where y1 and y2 are numeric
t.test(moreS1,moreS2)



##################################
#Testing for noramlity using Shapiro-Wilk Test
moreS1 = rnorm(100,100,10)
moreS2 = rnorm(100,100,20)
binvar = rbinom(100,50,0.2)
poisvar = rpois(100,5)

shapiro.test(moreS1) #normal
shapiro.test(moreS2) #normal
shapiro.test(binvar) #binomial
shapiro.test(poisvar) #poisson 

#Testing for normality using qq-plot
qqnorm(moreS1)
qqline(moreS1)
qqnorm(moreS2)
qqline(moreS2)
qqnorm(binvar)
qqline(binvar)
qqnorm(poisvar)
qqline(poisvar)
