# Bike-Sharing-Demand-Prediction
##Self-Project on Bike-Sharing-Demand-Prediction##
##This was a course project of Data Science and Machine Learning Bootcamp with R by Jose Portilla, took some help in EDA by Jose Portilla Solutions##

First, we do some basic EDA to understand the relationships between different predictors and the
response variable we are interested in that is count.

We apply feature engineering to get the hour data from the date time data and then we draw some
scatter plots between the hour and count using different aesthetics under geom_point()

We use the package of dplyr and catools to split the data randomly into training and testing. We then
apply linear regression to the suitable predictors we got in EDA. We optimize this model using the
backward stepwise selection algorithm function in R.

We then predict the bike share counts on test data and compute the MSE.

----------------------------------------------------------------------------------------------


