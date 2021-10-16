df <- read.csv('bikeshare.csv')
library(ggplot2)
#EDA#
ggplot(df,aes(temp,count)) + geom_point(alpha=0.7, aes(color=temp)) + theme_bw()
df$datetime <- as.POSIXct(df$datetime)
ggplot(df,aes(datetime,count)) + geom_point(aes(color=temp),alpha=0.7)  + scale_color_continuous(low='#55D8CE',high='#FF6E2E') +theme_bw()
cor(df[,c('temp','count')])
ggplot(df,aes(factor(season),count)) + geom_boxplot(aes(color=factor(season))) +theme_bw()
#Feature Engineering#
df$hour <- sapply(df$datetime,function(x){format(x,"%H")})
library(dplyr)
#Scatter Plot for Working Days
pl <- ggplot(filter(df,workingday==1),aes(hour,count)) 
pl <- pl + geom_point(position=position_jitter(w=1, h=0),aes(color=temp),alpha=0.7)
pl <- pl + scale_color_gradientn(colours = c('dark blue','blue','light blue','light green','yellow','orange','red'))
pl + theme_bw()
#Scatter Plot for Non-Working Days
pl <- ggplot(filter(df,workingday==0),aes(hour,count)) 
pl <- pl + geom_point(position=position_jitter(w=1, h=0),aes(color=temp),alpha=0.5)
pl <- pl + scale_color_gradientn(colours = c('dark blue','blue','light blue','light green','yellow','orange','red'))
pl + theme_bw()
df$hour <- sapply(df$hour,as.numeric)
#Split the data into train and test
library(caTools)
set.seed(10)
sam <- sample.split(df$datetime,SplitRatio = 0.7)
train <- subset(df,sam==T)
test <- subset(df,sam==F)
# Apply Linear Regression
model <- lm(count ~ . -datetime -atemp,train)
#Backward Stepwise Selection
model <- step(model,direction = 'backward')
summary(model)
#Predict on test data
pred <- predict(model,test)
actual <- test$count
df1 <- data.frame(pred,actual)
MSE <- mean((pred-actual)^2)
MSE
