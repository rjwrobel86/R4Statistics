library(jtools)
library(stargazer)
library(leaps)
library(car)
library(lmtest)
library(stats)
library(sjPlot)
library(corrgram)
library(MASS)


data <- read_csv("schmitt-dataset.csv")
attach(data)

#par(mfrow=c(1,1)) --- (re)sets the plot window to one row and one column

names(data) #Get variable names
head(data) #See top six rows of data

#data <-na.omit(data) #Remove rows with missing data in any column

summary(data)
vars <- data.frame(sold,totalinventory,users,daysminholiday,UNRATE,CARDEMAND,CHEVYDEMAND,jackschmittindex)
pairs(vars)

hist(sold)
boxplot(sold)

plot(totalinventory,sold)
abline(lm(sold ~ totalinventory))
plot(users,sold)
abline(lm(sold~users))
plot(`Avg. Page Load Time (sec)`,sold)
abline(lm(sold~`Avg. Page Load Time (sec)`))
plot(CARDEMAND,sold)
abline(lm(sold~CARDEMAND))
plot(STLUR,sold)
abline(lm(sold~STLUR))
plot(SP500,sold)
abline(lm(sold~SP500))
plot(googleads,sold)
abline(lm(sold~googleads))
plot(daysminholiday,sold)
abline(lm(sold~daysminholiday))
plot(otherDIVjack,sold)
abline(lm(sold~otherDIVjack))
plot(contentloadtime,sold)
abline(lm(sold~contentloadtime))
plot(`Avg. Page Load Time (sec)`,sold)
abline(lm(sold~`Avg. Page Load Time (sec)`))

dlt <- lm(sold~`Avg. Page Download Time (sec)`)
plt <- lm(sold~ `Avg. Page Load Time (sec)`)
it <- lm(sold~averageinteractivetime)
clt <- lm(sold~contentloadtime)
speedmod <- stargazer(dlt,plt,it,clt, type="text")

AIC(dlt,plt,it,clt)
BIC(dlt,plt,it,clt)

mod1 <- lm(sold ~ totalinventory + newusers + daysminholiday + STLUR + SP500 + `housing starts` + `carshopping demand index` + `chevy demand index` + `Avg. Page Download Time (sec)` + googleads) 
mod2 <- lm(sold ~ usedinventory + newusers + daysminholiday + SP500 + `housing starts` + `carshopping demand index`) 
mod3 <- lm(sold ~ usedinventory + newusers + daysminholiday + `housing starts` + `carshopping demand index` + `Avg. Page Load Time (sec)` + googleads + otherbrandindex + otherdealerindex + otherDIVjack)
mod4 <- lm(sold ~ usedinventory + newusers + daysminholiday + `housing starts` + `carshopping demand index` + contentloadtime + googleads + otherDIVjack) 
mod5 <- lm(sold ~ usedinventory + users + daysminholiday + `housing starts` + `carshopping demand index` + contentloadtime + googleads + otherDIVjack) 

stargazer(mod1,mod2,mod3,mod4, type="text", out ="out.txt")

xvars <- c(totalinventory + newusers + daysminholiday + STLUR + SP500 + `housing starts` + `carshopping demand index` + `chevy demand index` + `Avg. Page Download Time (sec)` + googleads)

yhat1 <- fitted(mod1)
yhat2 <- fitted(mod2)
yhat3 <- fitted(mod3)
yhat4 <- fitted(mod4)
yhat5 <- fitted(mod5)

e1 <- resid(mod1)
e2 <- resid(mod2)
e3 <- resid(mod3)
e4 <- resid(mod4)
e5 <- resid(mod5)

#Breusch-Pagan test for Heteroskedasticity
#Null = Homoskedasticity
bptest(mod1)
bptest(mod2)
bptest(mod3)
bptest(mod4)
bptest(mod5)

#Durbin-Watson test for Autocorrelation
#Null: No Autocorrelation 
dwtest(mod1)
dwtest(mod2)
dwtest(mod3)
dwtest(mod4)
dwtest(mod5)

#Shapiro-Wilk test for Normality of Residuals
shapiro.test(e1)
shapiro.test(e2)
shapiro.test(e3)
shapiro.test(e4)
shapiro.test(e5)

par(mfrow=c(2,2))

plot(yhat1,e1)
abline(lm(e1~yhat1))
abline(h=0)
plot(yhat2,e2)
abline(lm(e1~yhat1))
abline(h=0)
plot(yhat3,e3)
abline(lm(e1~yhat1))
abline(h=0)
plot(yhat4,e4)
abline(lm(e1~yhat1))
abline(h=0)

par(mfrow=c(1,1))
plot(yhat5,e5)
abline(lm(e1~yhat5))
abline(h=0)

AIC(mod1,mod2,mod3,mod4,mod5)
BIC(mod1,mod2,mod3,mod4,mod5)

###Plot of Studentized residuals and squared residuals from mod1 and 2, testing for outliers
par(mfrow=c(2,2), oma=c(0,0,2,0))
stres1<- studres(mod1)
plot(stres1, main="Mod1")
stres2<- studres(mod2)
plot(stres2, main="Mod2")
stres3<- studres(mod3)
plot(stres3, main="Mod3")
stres4<- studres(mod4)
plot(stres4, main="Mod4")
mtext("Studentized Residuals", outer=TRUE, cex =1.5)

#Ramsey's RESET Test of functional form
reset(mod1)
reset(mod2)
reset(mod3)
reset(mod4)
reset(mod5)

#log-log
mod6 <- lm(log(sold) ~ log(usedinventory) + log(users) + log(daysminholiday) + log(`housing starts`) + log(`carshopping demand index`) + log(contentloadtime) + log(otherDIVjack))
reset(mod6)
summary(mod6)
#lin-log
mod7 <- lm(sold ~ log(usedinventory) + log(users) + log(daysminholiday) + log(`housing starts`) + log(`carshopping demand index`) + log(contentloadtime) + log(otherDIVjack))
#log-lin
mod8 <- lm(log(sold) ~ usedinventory + users + daysminholiday + `housing starts` + `carshopping demand index` + contentloadtime + otherDIVjack)

summary(mod6)
summary(mod7)
summary(mod8)

outlierTest(mod7) # Bonferonni p-value for most extreme obs
qqPlot(mod7, main="QQ Plot") #qq plot for studentized resid
leveragePlots(mod7) # leverage plots

cor(data)

avPlots(mod7)
#myts <- ts(yearmonth, start=c(2014,1, end=c(2019,8), frequency=12))
