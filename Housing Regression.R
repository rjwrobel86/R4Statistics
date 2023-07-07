#Modeling Housing Price Determinants
library(MASS)
#data <- read.csv(FILE.csv)
#attach(data)
names(data)
head(data)
summary(data)

smod1 <- lm(price ~ area)
smod2 <- lm(price ~ bedrooms)
smod3 <- lm(price ~ bathrooms)

smod1
smod2
smod3

mod1 <- lm(price ~ bedrooms + bathrooms + stories + parking + guestroom + mainroad + hotwater + aircondition)
summary(mod1)
plot(mod1)

lprice <- log(price)

mod2 <- lm(lprice ~ bedrooms + bathrooms + stories + parking + guestroom + mainroad + hotwater + aircondition)
summary(mod2)
plot(mod2)

lbedrooms <- log(bedrooms)
lbathrooms <- log(bathrooms)
lstories <- log(stories)
lparking <- log(parking)

#Lin-Lin
mod2 <- lm(price ~ bedrooms + bathrooms)
#Log-Log
mod3 <-lm(lprice ~ lbedrooms + lbathrooms) 
#Lin-Log
mod4 <- lm(price ~ lbedrooms + lbathrooms)
#Log-Lin
mod5 <- lm(lprice ~ bedrooms + bathrooms)

AIC(mod2,mod3,mod4,mod5)
BIC(mod2,mod3,mod4,mod5)

coefplot(mod2,mod3)
pairs(mod1)
