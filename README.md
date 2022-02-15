# K-means-project-R
Machine learning projects
Iris dataset for clustering then k-means testing (unsupervised learning)
I would have used the package “VIM” to use the “aggr” function to determine if there was any missing datapoints in the data set.
First I created some graphs to see which factors showed correlation with each other. Help decide what factors to use in the clustering algorithm.
 
 
 
Both show setosa will be easy to cluster but there is some noise between the two clusters of versicolor and virginica
Need to determine the number of clusters for k-means testing
1st tried using the built in k-means function in R to understand what information I’m trying to get
•	K-means function in R – define the number of centres you have – chose 3 as there are 3 species
•	Use iter.max to make the centroids move and repeat the cluster assignment
•	Have to remove the column with species name as it throws an error when trying to compute kmeans as species values are text not numerical
Gives kmeans values for all variable combinations
 
Accurately clustered Setosa and almost all of the versicolor flowers but was incorrect in classifying virginica.
Calculating K-means by hand – to see how my clustering algorithm compares to a built in function
•	First, step was too import the iris data set and check the data for any n/a values, and omit them from the dataset
 
•	Second, I selected the two variables I wanted to test my clustering algorithm on, which was decided previously to be sepal length vs petal length, I also scaled my data to ensure all the values in the data frame where contributing equally to the k-means algorithm.
 
•	Third, since there were three species of iris I chose to use a k of 3 to determine if my algorithm could accurately group the data by species, initially I selected the first 3 entries of the dataset. However I could have set a seed and had it select 3 random observations from the data frame.
 
•	Fourth, I needed to create a function that could calculate the distance between the observation and cluster centre for all the data points, calculating Euclidean distance.
 
•	Fifth, I created lists which contained each observations assigned cluster which would get replaced each cycle of the loop
 
•	Sixth, I needed to put everything together in a loop that iterated through each observation for each centre and calculate the distance from each of the centres, it needed to also select the smallest value (shortest distance), and assign that observation to the closest centres cluster. I achieved this by creating a while loop which would not end until the cluster similarity between the previous loop and current loop was exactly the same so the position of the centres would not be changing.
 
•	Seventh, I plotted the results of the clustering algorithm by plotting a simple scatter plot with the centres overlayed onto the plot and the clusters were separated by different colours, I also created a plot of what the clusters should look like if they were split by species
 
 
 
•	To quantify which species where classified in which cluster I created a table which showed it.
 

Since there is noise between two of the species there is overlap and incorrect classification of some of the data points. Choosing a K of 2 clusters the data by separating one species away from the other two, whereas with a K of 3 some of the points get incorrectly clustered.
