###########################
# K-means Clustering
###########################

###########################
# Load and prepare data set
###########################

# load the data from "data/wholesale_customers.csv"
customers.data <- read.csv(file = "data/wholesale_customers.csv")

# examine the data structure
str(customers.data)

# check for missing values
which(complete.cases(customers.data)==FALSE)

# laod ggplot2 library
library(ggplot2)

# plot boxplots for all numeric variables
ggplot(customers.data, aes(x=Channel, y=Grocery, fill=Channel)) + geom_boxplot()
ggplot(customers.data, aes(x=Channel, y=Milk, fill=Channel)) + geom_boxplot()
ggplot(customers.data, aes(x=Channel, y=Delicatessen, fill=Channel)) + geom_boxplot()
ggplot(customers.data, aes(x=Channel, y=Frozen, fill=Channel)) + geom_boxplot()
ggplot(customers.data, aes(x=Channel, y=Fresh, fill=Channel)) + geom_boxplot()
ggplot(customers.data, aes(x=Channel, y=Detergents_Paper, fill=Channel)) + geom_boxplot()

# split the dataset into two subsets based on the value of the Channel variable
retail.data <- subset(customers.data, Channel == 'Retail')
horeca.data <- subset(customers.data, Channel == 'Horeca')

# print the summary of the retail.data
summary(retail.data)

# remove the Channel variable
retail.data$Channel <- NULL

# compute the number of outliers for all numeric variables
apply(X = retail.data[,-1], # all variables except Region
      MARGIN = 2,
      FUN = function(x) length(boxplot.stats(x)$out))

# install.packages('DescTools')
library(DescTools)

# Start with the *Grocery* variable. 
boxplot(retail.data$Grocery, xlab='Grocery')

# Winsorize the Grocary variable using Winsorize f. from DescTools
grocery_w <- Winsorize(retail.data$Grocery, 
                       probs = c(0,0.95)) 

# Plot the Grocery values after Winsorizing
boxplot(grocery_w, xlab='Grocery winsorized')

# Now, do the same for the *Frozen* variable
boxplot(retail.data$Frozen, xlab='Frozen')

frozen_w <- Winsorize(retail.data$Frozen, 
                      probs = c(0,0.94)) 

boxplot(frozen_w, xlab='Frozen winsorized')

# update *retail.data* with the winsorized values
retail.data$Grocery <- grocery_w
retail.data$Frozen <- frozen_w

# print the summary of the retail.data dataset
summary(retail.data)

##############################
# Clustering with 2 Features
##############################

# print the matrix of scatterplots for all numeric variables
pairs(~Fresh+Frozen+Grocery+Milk+Delicatessen+Detergents_Paper, data = retail.data)

# plot the scatterplot for the variables Frozen and Milk
ggplot(data=retail.data, aes(x=Frozen, y=Milk)) + 
  geom_point() +
  theme_bw()

# create a subset of the data with variables Frozen and Milk
retail.data1 <- retail.data[, c("Frozen", "Milk")]

# print the summary of the new dataset
summary(retail.data1)

# function for performing the normalization
normalize.feature <- function( feature ) {
  if ( sum(feature, na.rm = T) == 0 ) feature
  else ((feature - min(feature, na.rm = T))/(max(feature, na.rm = T) - min(feature, na.rm = T)))
}

# normalize both variables
retail.data1.norm <- as.data.frame(apply(retail.data1, 2, normalize.feature))

# print the summary
summary(retail.data1.norm)

# open the documentation for the kmeans function
?kmeans

# set the seed to assure replicability of the results
set.seed(5320)

# run the clustering with 4 clusters, iter.max=20, nstart=1000
simple.4k <- kmeans(x = retail.data1.norm, centers=4, iter.max=20, nstart=1000)

# print the model
simple.4k

# add the cluster as a new variable to the dataset
retail.data1.norm$cluster <- factor(simple.4k$cluster)

# print several instances of the dataset
head(retail.data1.norm)

# plot the clusters along with their centroids
ggplot(data=retail.data1.norm, aes(x=Frozen, y=Milk, colour=cluster)) + 
  geom_point() + 
  labs(x = "Annual spending on frozen products",
       y = "Annual spending on dairy products",
       title = "Retail customers annual spending") + 
  theme_bw() +
  geom_point(data=as.data.frame(simple.4k$centers), 
             colour="black", size=4, shape="triangle") # add cluster centers

#################################
# Selecting the Best Value for K
#################################

# create an empty data frame for storing evaluation measures for different k values
eval.metrics.2var <- data.frame()

# remove the column with cluster assignments
retail.data1.norm$cluster <- NULL

# run kmeans for all K values in the range 2:8
for (k in 2:8) {
  set.seed(5320)
  km.res <- kmeans(x=retail.data1.norm, centers=k, iter.max=20, nstart = 1000)

  # combine cluster number and the error measure, write to df
  eval.metrics.2var <- rbind(eval.metrics.2var, 
                             c(k, km.res$tot.withinss, km.res$betweenss/km.res$totss)) 
}

# assign more meaningful column names
names(eval.metrics.2var) <- c("k", "tot.within.ss", "ratio")

# print the evaluation metrics
eval.metrics.2var

# plot the line chart for K values vs. tot.within.ss 
ggplot(data=eval.metrics.2var, aes(x=k, y=tot.within.ss)) + 
  geom_line() +
  labs(x = "\nK (cluster number)", 
       y = "Total Within Cluster Sum of Squares\n",
       title = "Reduction in error for different values of K\n") + 
  theme_bw() +
  scale_x_continuous(breaks=seq(from=0, to=8, by=1))

# load the source code from the Utility.R file
source("Utility.R")

# calculate the difference in tot.within.ss and in ratio for each two consecutive K values
data.frame(K=2:8, 
           tot.within.ss.delta=compute.difference(eval.metrics.2var$tot.within.ss),
           ratio.delta=compute.difference(eval.metrics.2var$ratio))


# We'll examine the solution with k=3, as that seems to be the best K value

# set the seed value
set.seed(5320)

# run the clustering for 3 clusters, iter.max=20, nstart=1000
simple.3k <- kmeans(x = retail.data1.norm, centers=3, iter.max=20, nstart=1000)

# store the (factorized) cluster value in a new variable 
retail.data1.norm$cluster <- factor(simple.3k$cluster)

# plot the clusters along with their centroids
ggplot(data=retail.data1.norm, aes(x=Frozen, y=Milk, colour=cluster)) + 
  geom_point() +
  xlab("Annual spending on frozen products") +
  ylab("Annual spending on dairy products") +
  ggtitle("Retail customers annual spending") +
  geom_point(data=as.data.frame(simple.3k$centers),
             colour="black",size=4, shape="triangle")

# calculate the mean and sd values for all three clusters 
sum.stats <- summary.stats(feature.set = retail.data1, 
                           clusters = simple.3k$cluster, 
                           cl.num = 3)
sum.stats

###########################################
# Clustering with several numeric features
###########################################

library(corrplot)
# compute correlations (avoid the Region variable)
corr.matrix <- cor(retail.data[,-1])
# create correlations plot (as was done in the linear regression lab)
corrplot.mixed(corr.matrix, tl.cex=0.75, number.cex=0.75)

# Remove Grocery due to its high correlation with both Detergents_Paper and Milk
retail.data <- retail.data[,-4]

summary(retail.data)

# normalize all numeric variables from the retail.data dataset
retail.norm <- as.data.frame(apply(retail.data[,c(2:6)], 2, normalize.feature))

# print the summary
summary(retail.norm)

# create an empty data frame to store evaluation measures
eval.metrics.5var <- data.frame()

# run kmeans for K values in the range 2:8
for (k in 2:8) {
  set.seed(5320)
  km.res <- kmeans(x=retail.norm, centers=k, iter.max=20, nstart = 1000)
  # combine the K value and the evaluation measures, write to df
  eval.metrics.5var <- rbind(eval.metrics.5var, 
                             c(k, km.res$tot.withinss, km.res$betweenss/km.res$totss)) 
}

# assign meaningful column names
names(eval.metrics.5var) <- c("cluster", "tot.within.ss", "ratio")
eval.metrics.5var

# plot the line chart for K values vs. tot.within.ss 
ggplot(data=eval.metrics.5var, aes(x=cluster, y=tot.within.ss)) + 
  geom_line() +
  labs(x = "\nK (cluster number)", 
       y = "Total Within Cluster Sum of Squares\n",
       title = "Reduction in error for different values of K\n") + 
  theme_bw() +
  scale_x_continuous(breaks=seq(from=0, to=8, by=1))

# the plot suggests 3 clusters, but we'll also calculate
# the difference in tot.within.ss and in ratio for each two consecutive K values
data.frame(k=c(2:8),
           tot.within.ss.delta=compute.difference(eval.metrics.5var$tot.within.ss),
           ration.delta=compute.difference(eval.metrics.5var$ratio))


# set the seed
set.seed(5320)

# run the clustering for 3 clusters, iter.max=20, nstart=1000
retail.3k.5var <- kmeans(x=retail.norm, centers=3, iter.max=20, nstart = 1000)

# calculate and compare summary statistics (mean and st. deviation) for the three clusters 
sum.stats <- summary.stats(feature.set = retail.norm, #retail.data[,c(2:6)], 
                           clusters = retail.3k.5var$cluster, 
                           cl.num = 3)
sum.stats

# plot the distribution of the attributes across the 3 clusters
create_comparison_plots(df = retail.norm,
                        clust = as.factor(retail.3k.5var$cluster))

