
# Homework 2
# Problem 1

# Install the following packages if necessary. Uncomment the following line and execute it.
# install.packages(c('dplyr', 'ggplot2'))

# Load the packages

library(dplyr)
library(ggplot2)

# Download and read the data
wines <- read.csv(file='https://s3.eu-central-1.amazonaws.com/sf-timeseries/data/wine.csv')

## a)
wines <- within(wines, {
  Price <- exp(LogPrice)
})

## b)
hotorcold <- ifelse(wines$Temperature > mean(wines$Temperature), "hot", "cold")
# Example using ifelse
ifelse(c(TRUE, TRUE, FALSE, TRUE), 'condition TRUE', 'condition FALSE')


## c)
table(hotorcold)
# Example using table
table(c('category1', 'category1', 'category2'))

## d)
wines <- within.data.frame(wines,{
  hotorcold=hotorcold
})
groupedPrice <- group_by(wines, hotorcold)
summarisedPrice <- summarise(
  groupedPrice, 
  meanPrice = mean(Price),
  sdPrice = sd(Price),
  minPrice = min(Price),
  maxPrice = max(Price),
  medianPrice = median(Price)
)

## e)
ggplot(
  data = wines,
  aes(y = Price, x = hotorcold)
) + geom_boxplot() + xlab("Type of year") + ylab("Price") + coord_flip() + geom_point(y = wines$Price)

## f)
ggplot(
  data = wines,
  aes(sample = Price)
) + stat_qq()
#The points are not in a straight line, we know that the distribution of prices does not follow a normal distribution.

## g)
summarisedPriceCI <- within(summarisedPrice, {
  lowerCIlimit <- meanPrice - sdPrice * qnorm(0.95) / sqrt(27)
  upperCIlimit <- meanPrice + sdPrice * qnorm(0.95) / sqrt(27)
})
summarisedPriceCI

