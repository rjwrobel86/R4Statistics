#Generate data from muiltiple probability distributions

n <- 10000
normal_data <- rnorm(n, mean=0, sd=1)
uniform_data <- runif(n, min=0, max=10)
poisson_data <- rpois(n, lambda=3)
par(mfrow = c(1, 3))
hist(normal_data)
hist(uniform_data)
hist(poisson_data)

normal_sample_means <- vector("numeric", 20)
uniform_sample_means <- vector("numeric", 20)
poisson_sample_means <- vector("numeric", 20)

for (i in 1:50) {
  sample <- sample(normal_data, size = 50)
  sample_mean <- mean(sample)
  normal_sample_means[i] <- sample_mean
}

for (i in 1:50) {
  sample <- sample(uniform_data, size = 50)
  sample_mean <- mean(sample)
  uniform_sample_means[i] <- sample_mean
}

for (i in 1:50) {
  sample <- sample(poisson_data, size = 50)
  sample_mean <- mean(sample)
  poisson_sample_means[i] <- sample_mean
}

par(mfrow = c(2, 3))  #Arrange plots in a 2x3 grid
hist(normal_data, main = "Normal Distribution", xlab = "X")
hist(uniform_data, main = "Uniform Distribution", xlab = "X")
hist(poisson_data, main = "Poisson Distribution", xlab = "X")
hist(normal_sample_means, main = "Normal Distribution", xlab = "Sample Means")
hist(poisson_sample_means, main = "Poisson Distribution", xlab = "Sample Means")
hist(uniform_sample_means, main = "Uniform Distribution", xlab = "Sample Means")

