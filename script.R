###########################
# K-means Clustering
###########################

###########################
# Load and prepare data set
###########################

# load the data from "data/wholesale_customers.csv"

# examine the data structure

# check for missing values

# laod ggplot2 library

# plot boxplots for all numeric variables

# split the dataset into two subsets based on the value of the Channel variable

# print the summary of the retail.data

# remove the Channel variable

# compute the number of outliers for all numeric variables
 # all variables except Region

# install.packages('DescTools')

# Start with the *Grocery* variable. 

# Winsorize the Grocary variable using Winsorize f. from DescTools

# Plot the Grocery values after Winsorizing

# Now, do the same for the *Frozen* variable

# update *retail.data* with the winsorized values

# print the summary of the retail.data dataset

##############################
# Clustering with 2 Features
##############################

# print the matrix of scatterplots for all numeric variables

# plot the scatterplot for the variables Frozen and Milk

# create a subset of the data with variables Frozen and Milk

# print the summary of the new dataset

# function for performing the normalization

# normalize both variables

# print the summary

# open the documentation for the kmeans function

# set the seed to assure replicability of the results

# run the clustering with 4 clusters, iter.max=20, nstart=1000

# print the model

# add the cluster as a new variable to the dataset

# print several instances of the dataset

# plot the clusters along with their centroids

#################################
# Selecting the Best Value for K
#################################

# create an empty data frame for storing evaluation measures for different k values

# remove the column with cluster assignments

# run kmeans for all K values in the range 2:8

  # combine cluster number and the error measure, write to df

# assign more meaningful column names

# print the evaluation metrics

# plot the line chart for K values vs. tot.within.ss 

# load the source code from the Utility.R file

# calculate the difference in tot.within.ss and in ratio for each two consecutive K values


# We'll examine the solution with k=3, as that seems to be the best K value

# set the seed value

# run the clustering for 3 clusters, iter.max=20, nstart=1000

# store the (factorized) cluster value in a new variable 

# plot the clusters along with their centroids

# calculate the mean and sd values for all three clusters 

###########################################
# Clustering with several numeric features
###########################################

# compute correlations (avoid the Region variable)

# create correlations plot (as was done in the linear regression lab)

# Remove Grocery due to its high correlation with both Detergents_Paper and Milk


# normalize all numeric variables from the retail.data dataset

# print the summary

# create an empty data frame to store evaluation measures

# run kmeans for K values in the range 2:8

# assign meaningful column names

# plot the line chart for K values vs. tot.within.ss 

# the plot suggests 3 clusters, but we'll also calculate
# the difference in tot.within.ss and in ratio for each two consecutive K values


# set the seed

# run the clustering for 3 clusters, iter.max=20, nstart=1000

# calculate and compare summary statistics (mean and st. deviation) for the three clusters 

# plot the distribution of the attributes across the 3 clusters

