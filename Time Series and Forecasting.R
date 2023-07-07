library(zoo)
library(xts)
library(forecast)
library(dplyr)
library(ggplot2)
library(stargazer)

sold <- rnorm(100,250,50)
sold <- sort(sold)
inventory <- 1:100
inventory[1:33] <- rnorm(33,500)
inventory[34:66] <- rnorm(33,750)
inventory[67:100] <- rnorm(34,1000)
random <- rnorm(100,200,40)
index <- 1:length(random)
soldlag1 <- lag(sold,1)
soldlag2 <- lag(sold,2)


df <- data.frame(sold,inventory,random,index,soldlag1,soldlag2)
colnames(df)
df <- na.omit(df)

#Missing data interpolation
data <- na_interpolation(data, option = "linear", maxgap = Inf) #Linear interpolation
locf <- na_locf(data, option = "locf", na_remaining = "rev", maxgap = Inf) #Last value
plot(locf$sold)
mean <- na_mean(data, option = "mean", maxgap = Inf)
plot(mean)
m1 <- lm(sold ~ totalinventory + daysminholiday + STLUR + CARDEMAND + CHEVYDEMAND + otherDIVjack + averageinteractivetime + googleads)
summary(m1)

#Declare data as time series
dfts <- ts(df,start=c(2000,4),frequency=12)
sold <- dfts[,"sold"]
inventory <- dfts[,'inventory']
random <- dfts[,'random']
index <- dfts[,'index']
#Create lagged variables 
soldlag1 <- dfts[,'soldlag1']
soldlag2 <- dfts[,'soldlag2']

seaonsal <- seasonaldummy(sold)
seasonal

#Moving Average
ma2 <- ma(sold,2)
ma3 <- ma(sold,3)
ma4 <- ma(sold,4)
ma5 <- ma(sold,5)

plot(ma2)
lines(ma3,col="green")
lines(ma4,col="red")
lines(ma5,col="yellow")


#Simple forecasting
#Average of series
meanf(sold,h=10)

#Last value of series
a <- naive(sold, 10)
plot(a)

#Seasonal Naive
#Last value of same season
b <- snaive(sold,10)
plot(b)

#Drift
c <- rwf(sold, 10, drift=TRUE)
plot(c)

#Box-Cox Transformation
lambda <- BoxCox.lambda(sold)
lambda
boxcoxmod <- lm(((sold^lambda-1)/lambda) ~ users)
nonboxmod <- lm(sold ~ users)
summary(boxcoxmod)
summary(nonboxmod)

#Get dataframe details
class(dfts)
start(dfts)
end(dfts)
frequency(dfts)
summary(dfts)
seasonplot(sold)
monthplot(sold)


acf(sold)
pacf(sold)
solddiff <- diff(sold)
sold
solddiff
plot(sold)
plot(solddiff)

#Differencing to get data stationary 
adf.test(sold) #Null is non-stationary
solddiff <- diff(sold)
solddiff2 <- diff(solddiff)
plot(sold)
plot(solddiff)
plot(solddiff2)
adf.test(sold)
adf.test(solddiff)
adf.test(solddiff2)


#Linear Model
m1 <- lm(sold ~ inventory + random + index)
m1ts <- tslm(sold ~ inventory + random + index + season)
summary(m1)
summary(m1ts)
yhat <- fitted(m1)
e <- residuals(m1)
plot(yhat)
lagmod1 <- lm(sold ~ soldlag1 + inventory)
lagmod2 <- lm(sold ~ soldlag1 + soldlag2 + inventory)

#Compare models
stargazer(m1,lagmod1,lagmod2, type="text")
AIC(m1,lagmod1,lagmod2)
BIC(m1,lagmod1,lagmod2)

#Decomposition
stls <- stl(sold,s.window="periodic")
plot(stls)
seasonal(stls)
plot(seasonal(stls))
plot(trendcycle(stls))
plot(remainder(stls))


#Training and Testing
dfts2 <- dfts
dftr <- dfts2[1:10,]
dftr2
dfte <- dfts2[11:20,]
dfte

trmod <- lm(sold~inventory, data=dfts2)
yhat <- fitted(trmod)
plot(yhat,sold)
lines(sold)

#Forecasting
m2 <- HoltWinters(sold, beta=FALSE, gamma=FALSE)
m3 <- HoltWinters(sold, gamma=FALSE)
m4 <- HoltWinters(sold, beta=FALSE)
m5 <- HoltWinters(sold)
plot(m3)
plot(m4)
plot(m5)

predict(m4,5)
predicted <- predict(m4,5)
plot(predicted)

forecast(m5,5)
plot(forecast(m5,5))
plot(sold)
plot(forecast(m5,5),sold)

yhat <- fitted(m5)
plot(yhat,sold)

#Exponential Model
mod6 <- ets(sold)
mod6
forecast(mod6,10)
plot(forecast(mod6,10))
etsfit <- fitted(mod6)

#Automatic Arima Models
aa1 <- auto.arima(sold)
forecast(aa1,10)
aa2 <- auto.arima(sold, seasonal=TRUE, stationary=FALSE)
forecast(aa2,10)
aa1fit <- fitted(aa1)
aa2fit <- fitted(aa2)
plot(df$sold)

autoplot(inventory)

#Diagnostic plots
pacf(sold)
acf(sold)

plot(residuals(mod5,yhat))

#Leads and Lags
lead(sold,n=3) #Shift values forward 3 periods
lag(sold,n=3) #Shift values backward 3 periods


#Turn ts back to df
reframe <- data.frame(dfts)
reframe
