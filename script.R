###########################
# K-means Clustering
###########################

###########################
# Load and prepare data set
###########################

# load the data from "data/wholesale_customers.csv"


# examine the data structure


# check for missing values


# split the dataset into two subsets based on the value of the Channel variable


# print the summary of the retail.data


# remove the Channel variable


# compute the number of outliers for all numeric variables


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


# create a function for normalizing the data


# normalize all numeric variables


# print the summary of the normalised dataset



#################################################
# Clustering with arbitrarily chosen value for K
#################################################

# open the documentation for the kmeans function


# set the seed to assure replicability of the results


# run the clustering with 4 clusters, iter.max=20, nstart=1000


# print the model


# load the source code from the Utility.R file


# examine clusters using summary statistics



#################################
# Selecting the Best Value for K
#################################

# create an empty data frame for storing evaluation measures for different k values


# run kmeans for all K values in the range 2:8



# assign more meaningful column names


# print the evaluation metrics


# plot the line chart for K values vs. tot.within.ss 




# calculate the difference in tot.within.ss and in ratio for each two consecutive K values



# We'll examine the solution with k=3, as that seems to be the best K value

# set the seed value

# run the clustering for 3 clusters, iter.max=20, nstart=1000



# calculate and compare summary statistics (mean and st. dev.) for the three clusters 


# plot the distribution of the attributes across the 3 clusters