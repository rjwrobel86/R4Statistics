#Data Wrangling
library(dplyr)
data = read.csv(url("https://raw.githubusercontent.com/deepanshu88/data/master/sampledata.csv"))

#Selecting a random sample of rows
n5a <- sample_n(data,5) #Select 5 rows from the dataset randomly
n5b <- sample_n(data,5) #Select another 5 rows randomly
n40a <- sample_n(data,40) #Select 40 rows randomly

#Select a random fraction of rows
sample_frac(data,0.25) #Select 25% of the data set's rows randomly

#Remove duplicate rows (all columns)
sansdups <- distinct(data)
#Remove duplicat rows (based on specific columns)
sansdups2 <- distinct(data,VAR1,.keep_all=TRUE) 
sansdups3 <- distinct(data, VAR1, VAR2, .keep_all=TRUE)

#Select data based on columns
df2 <- select(data,"Y2010","Y2011")
df2 <- select(data,"Y2010":"Y2015")

#Remove data based on columns
df3 <- select(data,-"Y2011", -"Y2015")

#Selection functions: starts_with(), ends_with(), contains(), matches(), num_range(),one_of()

#Rename columns
data <- rename(data, NewVar="Y2011")
names(data)

#Filter by Value
astates <- filter(data, Index=="A")
astates

#Sort Data
arrange(data, Y2011)
arrange(data, Y2011,Y2015)
arrange(data, desc(Index),Y2015)

#Grouping
group_by(data,Index)
#Create new variables
mutate(data,newvar=Y2003-Y2002)
#Create new variables from all columns
mutate_all(data, funs("newvars"=.*100))

#Create new data
df1 = data.frame(ID = c(1, 2, 3, 4, 5),
                 w = c('a', 'b', 'c', 'd', 'e'),
                 x = c(1, 1, 0, 0, 1),
                 y=rnorm(5),
                 z=letters[1:5])
df1

df2 = data.frame(ID = c(1, 7, 3, 6, 8),
                 a = c('z', 'b', 'k', 'd', 'l'),
                 b = c(1, 2, 3, 0, 4),
                 c =rnorm(5),
                 d =letters[2:6])
df2

#Joins

#Inner Join: Merge on variables common to both tables
inner <- inner_join(df1,df2,by="ID")
inner

#Left Join: All rows from left table are returned regardless of a matching row from right
left_join(df1,df2,by="ID")
#Right Join is opposite of left join
right_join(df1,df2,by="ID")
#Full join returns all values, regardless of match or not, matchin values it can
full_join(df1,df2,by="ID")
