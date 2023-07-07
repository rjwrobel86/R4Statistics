#Basic Graphics

v1 <- rnorm(50,100,25) #A normally distributed random variable, with a mean of 50, stdev of 100, and n of 25

plot(v1) #Scatter plot vs index

hist(v1) #Histogram

plot(density(v1)) #Density plot

barplot(v1) #Vertical bar graph
barplot(v1, horiz = TRUE) #Horizontal bar graph

boxplot(v1) #Box and whiskers plot

v2 <- rnorm(50,100,25) #Another random variable

plot(v1,v2) #Scatter plot (x comes first)
abline(lm(v2~v1)) #Add trendline

values <- c(10, 12, 4, 16, 8) #Made up data
labels <- c("A", "B", "C", "D", "E") #Made up labels

pie(values,labels) #Pie chart
pcts <- round(values/sum(values)*100) #Percentages
pie(values,pcts) #Pie chart based on percentages
