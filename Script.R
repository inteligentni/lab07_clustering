###########################
# K-means Clustering
###########################

# set the seed value to be used for initializing random processes
seed <- 9421

###########################
# Load and prepare data set
###########################

# load the data from "data/wholesale_customers.csv"
customers.data <- read.csv(file = "data/wholesale_customers.csv")

# examine the data structure
str(customers.data)

# examine the data summary
summary(customers.data)

# examine the char variables
table(customers.data$Channel)
table(customers.data$Region)

# check for missing values
which(complete.cases(customers.data)==FALSE)

# split the dataset into two subsets based on the value of the Channel variable
retail.data <- subset(customers.data, Channel == 'Retail')
horeca.data <- subset(customers.data, Channel == 'Horeca')

# From now on, we focus on the retail portion of the data
# The horeca portion of the data can be used for practicing (homework) 

# remove the Channel variable
retail.data$Channel <- NULL

# print the summary of the retail.data
summary(retail.data)

#
# Deal with outliers (Winsorizing)
#

# compute the number of outliers for all numeric variables
apply(X = retail.data[,-1], # all variables except Region
      MARGIN = 2,
      FUN = function(x) length(boxplot.stats(x)$out))

# install.packages('DescTools')
library(DescTools)

# Start with the *Grocery* variable. 
boxplot(retail.data$Grocery, xlab='Grocery')

# Winsorize the Grocery variable using Winsorize f. from DescTools
grocery_w <- Winsorize(retail.data$Grocery, 
                       probs = c(0,0.95)) 

# Plot the Grocery values after Winsorizing
boxplot(grocery_w, xlab='Grocery winsorized')

# Now, do the same for the *Frozen* variable
boxplot(retail.data$Frozen, xlab='Frozen')

frozen_w <- Winsorize(retail.data$Frozen, 
                      probs = c(0,0.94)) 

boxplot(frozen_w, xlab='Frozen winsorized')

# update retail.data with the winsorized values
retail.data$Grocery <- grocery_w
retail.data$Frozen <- frozen_w

# print the summary of the retail.data dataset
summary(retail.data)


#
# Scale (normalize) the variables
#

# function for performing the normalization
normalize.feature <- function( feature ) {
  if ( sum(feature, na.rm = T) == 0 ) feature
  else ((feature - min(feature, na.rm = T))/(max(feature, na.rm = T) - min(feature, na.rm = T)))
}

# normalize all numeric variables from the retail.data dataset
retail.norm <- as.data.frame(apply(retail.data[,c(2:7)], 2, normalize.feature))

# print the summary
summary(retail.norm)


#
# Check for correlations among variables 
#

library(corrplot)
# compute correlations (avoid the Region variable)
corr.matrix <- cor(retail.norm)
# create correlations plot (as was done in the linear regression lab)
corrplot.mixed(corr.matrix, tl.cex=0.75, number.cex=0.75)

# Remove Grocery due to its high correlation with both Detergents_Paper and Milk
retail.norm$Grocery <- NULL

summary(retail.norm)


#############
# Clustering 
#############

# open the documentation for the kmeans function
?kmeans

# set the seed and run the clustering with 4 clusters, iter.max=20, nstart=1000
set.seed(seed)
k4 <- kmeans(x = retail.norm, centers=4, iter.max=20, nstart=1000)

# print the model
k4


#
# Selecting the Best Value for K
#

# create an empty data frame for storing evaluation measures for different k values
eval.metrics <- data.frame()

# run kmeans for all K values in the range 2:8
for (k in 2:8) {
  set.seed(seed)
  km.res <- kmeans(x=retail.norm, centers=k, iter.max=20, nstart = 1000)

  # combine cluster number and the error measure, write to df
  eval.metrics <- rbind(eval.metrics, 
                        c(k, km.res$tot.withinss, km.res$betweenss/km.res$totss)) 
}

# assign more meaningful column names
names(eval.metrics) <- c("k", "tot.within.ss", "ratio")

# print the evaluation metrics
eval.metrics

# plot the line chart for K values vs. tot.within.ss 
ggplot(data=eval.metrics, aes(x=k, y=tot.within.ss)) + 
  geom_line() +
  geom_point() +
  labs(x = "\nK (cluster number)", 
       y = "Total Within Cluster Sum of Squares\n",
       title = "Reduction in error for different values of K\n") + 
  theme_bw() +
  scale_x_continuous(breaks=seq(from=0, to=8, by=1))


# Calculate the difference in tot.within.ss and in ratio for each two consecutive K values
# load the compute.difference f. (and other functions) from the Utility.R file
source("Utility.R")
data.frame(K=2:8, 
           tot.within.ss.delta=compute.difference(eval.metrics$tot.within.ss),
           ratio.delta=compute.difference(eval.metrics$ratio))

# We'll examine the solution with k=3, as that seems to be the best K value

# set the seed and run the clustering for 3 clusters, iter.max=20, nstart=1000
set.seed(seed)
k3 <- kmeans(x = retail.norm, centers=3, iter.max=20, nstart=1000)


# calculate and compare summary statistics (mean and st. deviation) for the three clusters 
sum.stats <- summary.stats(feature.set = retail.norm, #retail.data[,c(2:7)], 
                           clusters = k3$cluster, 
                           cl.num = 3)
sum.stats

# plot the distribution of the attributes across the 3 clusters
create_comparison_plots(df = retail.norm,
                        clust = as.factor(k3$cluster))

