###########################
# K-means Clustering
###########################

###########################
# Load and prepare data set
###########################

# load the data from "data/wholesale_customers.csv"


# print the structure


# check for missing values


# laod ggplot2 library


# plot boxplots for all numeric variables


# split the dataset into two subsets based on the value of the Channel variable


# print the summary of the retail.data


# remove the Channel variable


# check for outliers for all numeric variables


# sort all outliers of the Grocery variable


# examine percentiles of the Grocery variable higher than the 90th percentile


# store the 95th percentile of the Grocery variable to a new variable


# to all outliers of the Grocery variable assing the value of the 95th percentile


# print a boxplot for the Grocery variable


# sort all outliers of the Frozen variable


# examine percentiles of the Frozen variable higher than the 90th percentile


# store the 92.5th percentile of the Frozen variable to a new variable


# to all outliers of the Frozen variable assing the value of the 92.5th percentile


# print a boxplot for the Frozen variable


# print the sumary of the retail.data dataset


##############################
# Clustering with 2 Features
##############################

# print the matrix of scatterplots for all numeric variables


# plot the scatterplot for the variablesFrozen and Milk


# create a subset of the data with variables Frozen and Milk


# print the summary of the new dataset


# function for performing the normalization
normalize.feature <- function( feature ) {
  if ( sum(feature, na.rm = T) == 0 ) feature
  else ((feature - min(feature, na.rm = T))/(max(feature, na.rm = T) - min(feature, na.rm = T)))
}

# normalize both variables


# print the summary


# set the seed


# run the clustering with 4 clusters, iter.max=20, nstart=1000


# print the model


# add the cluster as a new variable to the dataset


# print several instances of the dataset


# plot the clusters along with their centroids


#################################
# Selecting the Best Value for K
#################################

# create an empty data frame


# remove the column with clusters


# run kmeans for all K values in the range 2:8


# update the column names


# print the metrics


# plot the line chart for cluster vs. tot.within.ss 


# load the source code from the Utility.R file


# calculate the ratio difference for different K values (from 2 to 8) 


# set the seed value


# run the clustering for 3 clusters, iter.max=20, nstart=1000


# store the (factorized) cluster value in a new variable 


# plot the clusters along with their centroids


# calculate the mean and sd values for all three clusters 


#######################################
# Clustering with All Numeric Features
#######################################

# normalize all numeric variables from the retail.data dataset


# print the summary


# create an empty data frame


# run kmeans for all K values in the range 2:8


# update the column names


# plot the clusters along with their centroids


# calculate the ratio difference for different K values (from 2 to 8) 


# set the seed


# run the clustering for 3 clusters, iter.max=20, nstart=1000


# examine cluster centers

