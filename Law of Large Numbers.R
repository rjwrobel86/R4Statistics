#Law of Large Numbers Demonstration
#Set seed 
set.seed(1663)

#Generate some population data
population <- rnorm(100000, mean = 0, sd = 1)

#Initialize an empty vector to store the sample means
sample_means <- c()

#Loop over a range of different sample sizes
for (sample_size in seq(10, 10000, by = 10)) {
  #Take a sample from the population
  sample <- sample(population, size = sample_size)
  
  #Calculate the sample mean
  sample_mean <- mean(sample)
  
  #Append the sample mean to the vector of sample means
  sample_means <- c(sample_means, sample_mean)
}

#Plot the sample means
plot(seq(10, 10000, by = 10), sample_means, 
     main = "Demonstration of the Law of Large Numbers", 
     xlab = "Sample Size", 
     ylab = "Sample Mean", 
     type = "l")
abline(h = mean(population), col = "red")  #Add a horizontal line at the population mean
