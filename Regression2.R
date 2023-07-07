#Load necessary libraries
library(readr)
library(ggplot2)
library(dplyr)
library(car)
library(lmtest)
library(stats)

#Read the data
df <- read_csv('Code/R4Stats/regression_data.csv')

#Create scatter plots of all x variables against y
df_numeric <- df[sapply(df, is.numeric)]
pairs(df_numeric)

#Transforming Variables - Logs, Squares, and Inverses
df$log_x <- log(df$x) #Log(x)
df$x_squared <- df$x * df$x #x^2
df$x_inverse <- 1/df$x #1/x

#Transforming Variables - Interaction Terms
df$xINTERACTd1 <- df$x * df$d1 #Categorical
df$xINTERACTz <- df$x * df$z #Continuous

#Transforming Variables - Lagged X Variables
df$x_lag_1 <- lag(df$x, 1) #1 Period Lag
df$x_lag_2 <- lag(df$x, 2) #2 Period Lag 
df$x_lag_3 <- lag(df$x, 3) #3 Period Lag 

#Lagged Y Variable
df$y_lag_1 <- lag(df$y, 1) #1 Period Lag 
df$y_lag_2 <- lag(df$y, 2) #2 Period Lag 
df$y_lag_3 <- lag(df$y, 3) #3 Period Lag 

#Remove NA rows
df <- na.omit(df)

#Regression
model <- lm(y ~ x + z + x2 + y2, data = df)

#Print summary
summary(model)

#Gather Regression Statistics and Values
rsquared <- summary(model)$r.squared
adj_rsquared <- summary(model)$adj.r.squared
fstat <- summary(model)$fstatistic[1]
aic <- AIC(model)
bic <- BIC(model)
parameters <- coef(model)
tvalues <- summary(model)$coefficients[, "t value"]
pvalues <- summary(model)$coefficients[, "Pr(>|t|)"]
ci <- confint(model)
yhat <- fitted(model)
e <- residuals(model)

#Add fitted values and residuals to original dataframe
df$yhat <- yhat
df$e <- e

#Plot Y vs fitted values (yhat)
ggplot(df, aes(x = y, y = yhat)) + geom_point() + geom_smooth(method = "lm")

#Plot fitted values (yhat) vs residuals (e)
ggplot(df, aes(x = e, y = yhat)) + geom_point() + geom_smooth(method = "lm")

#Plot residuals against x values
ggplot(df, aes(x = x, y = e)) + geom_point() + geom_smooth(method = "lm")

#Correlation matrix 
correlation_matrix <- cor(df_numeric)
print(correlation_matrix)

#Multicollinearity test
vif <- car::vif(model)
print(vif)

#Histogram to check for normally distributed residuals
hist(e)

#Fitted values vs residuals to check for nonconstant error variance
plot(yhat, e)

#Heteroskedasticity tests
bptest(model)

#Ramsey Reset test
resettest(model)

#Jarque-Bera test for normality of residuals
jarque.bera.test(e)

#QQ Plot for normality of residuals
qqnorm(e)
qqline(e)

#Comparing Models with F-Tests
model1 <- lm(y ~ x + z, data = df)
model2 <- lm(y ~ x + z + x2 + y2, data = df)
anova(model1, model2)

#Comparing Models with Cross Validation - Incomplete

# Stepwise Variable Selection - Forward - Incomplete
step(lm(y ~ x + z + x2 + y2, data = df), direction = "forward")

# Outlier Detection
outlierTest(model)

# Cook's distance
cooksd <- cooks.distance(model)
plot(cooksd, pch="*", cex=2, main="Influential Obs by Cooks distance")  # plot cook's distance
abline(h = 4/((length(df$x))-length(coef(model))), col="red")  # add cutoff line
text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>4/((length(df$x))-length(coef(model))),names(cooksd),""), col="red")  # add labels
