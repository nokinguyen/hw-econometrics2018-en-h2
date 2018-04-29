# Homework 2
# Problem 2

# Install the following packages if necessary
# install.packages(c('ggplot2', 'dplyr'))

library(dplyr)
library(ggplot2)

# Enter your student ID in set.seed() so that your results are reproducible, i.e. run set.seed(3304)
## and replace 3304 with your student id.
set.seed()

# use the rnorm function to generate values from the standard normal distribution
# you can compute e^x with the exp function, e.g. e^2 = exp(2).
mu <- 1
sigma <- 1.3

## Draw n * R values at random from the standard normal distribution
## Note: you need to define n, R and furthermore mu and sigma.
z <- rnorm(n * R)
x <- exp(mu + sigma * z)

## x is now a sample of log-normally distibuted population and you can apply
## the methods used in the simulation in Problme set 2/Problem 1.

## a)
mux <- exp((mu) + sigma^2/2)
varx <- (exp(sigma^2) - 1) * exp(2*mu + sigma^2)

## b)
B <- 5000
n <- 1000
z <- rnorm(B * n)
x <- exp(mu + sigma * z)
sampleB <- sample(x, size = n*B, replace = TRUE)

## c)
samplesData <- data.frame(
  minutes = sampleB, 
  r = rep(1:B, each = n)
)

groupedSamples <- group_by(samplesData, r)

sampleMeansbySample <- summarise(
  groupedSamples,
  sampleMean = mean(minutes)
)

## d)
ggplot(data = sampleMeansbySample, aes(x = sampleMean)) + 
  geom_histogram(bins=50) + geom_vline(xintercept = mean(x), color = 'orange1')

## The distribution resembles a normal distribution. It isn't skewed. It's centered around the ## mean value.

## e)
mean(sampleMeansbySample$sampleMean)
sd(sampleMeansbySample$sampleMean)
