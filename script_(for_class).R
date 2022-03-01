###########################
# K-means Clustering
###########################

# set the seed value to be used for initializing random processes


###########################
# Load and prepare data set
###########################

# load the data from "data/wholesale_customers.csv"


# examine the data structure


# examine the data summary


# examine the char variables


# check for missing values


# split the dataset into two subsets based on the value of the Channel variable


# From now on, we focus on the retail portion of the data
# The horeca portion of the data can be used for practicing (homework) 

# remove the Channel variable


# print the summary of the retail.data


#
# Deal with outliers (Winsorizing)
#

# compute the number of outliers for all numeric variables


# install and load DescTools package


# Start with the *Grocery* variable. 


# Winsorize the Grocery variable using Winsorize f. from DescTools


# Plot the Grocery values after Winsorizing


# Now, do the same for the *Frozen* variable



# update retail.data with the winsorized values


# print the summary of the retail.data dataset



#
# Scale (normalize) the variables
#

# function for performing the normalization

# normalize all numeric variables from the retail.data dataset


# print the summary



#
# Check for correlations among variables 
#


# compute correlations (avoid the Region variable)

# create correlations plot (as was done in the linear regression lab)

# Remove Grocery due to its high correlation with both Detergents_Paper and Milk


#############
# Clustering 
#############

# open the documentation for the kmeans function


# set the seed and run the clustering with 4 clusters, iter.max=20, nstart=1000


# print the model



#
# Selecting the Best Value for K
#

# create an empty data frame for storing evaluation measures for different k values


# run kmeans for all K values in the range 2:8


# assign more meaningful column names


# print the evaluation metrics


# plot the line chart for K values vs. tot.within.ss 



# Calculate the difference in tot.within.ss and in ratio for each two consecutive K values
# load the compute.difference f. (and other functions) from the Utility.R file



# We'll examine the solution with k=3, as that seems to be the best K value

# set the seed and run the clustering for 3 clusters, iter.max=20, nstart=1000


# calculate and compare summary statistics (mean and st. deviation) for the three clusters 



# plot the distribution of the attributes across the 3 clusters