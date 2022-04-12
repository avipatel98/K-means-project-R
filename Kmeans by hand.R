rm(list = ls())  ### deletes all the data in my environment

df <- iris
df <- na.omit(df)   ### remove any incomplete observations


### try finding the optimum number of clusters using elbow method

### clean my data to only have the 2 variables i want

df_cleaned <- select(df, Sepal.Length, Petal.Length) ### only want variables for length of sepal and petal
df_cleaned <- scale(df_cleaned)  ### scales all the values so they contribute evenly to the kmeans algorithm


### assigning a center
# picked_center = df_cleaned[1:3, ]  ### I wanted the first three rows and all of the data in the columns for those rows

### Once the algorithm worked I wanted to randomly select 3 rows so everytime I run the clustering algorithm I use new starting centers
picked_center <- df_cleaned[sample(nrow(df_cleaned), 3), ]

### calculate the distance from each center for each data point
### create a function with two inputs that calculates the distance between each data point
Distance_data = function(d1, d2){ 
  return((d1[1] - d2[1])^2 + (d1[2] - d2[2])^2)  
}

### loop over all the data points

cluster = c(0) * nrow(df_cleaned) ### create a list of values for assigned cluster
cluster_old = c(0) * nrow(df_cleaned) ### stores the previous list of the assigned clusters for last loop
cluster_similarity = Inf ### the value needs to be greater than 0 so when it is 0 there is no change in assigned cluster 

### create a while loop that cycles through each center and point in the data frame that updates the centers each loop 
### until the centers no longer move and the cluster groups are the same as the previous iteration

while (cluster_similarity > 0) {
  
cluster_old = cluster  ### at the start of each loop the previous loops cluster list is transferred to the old cluster list

  for(i in 1:nrow(df_cleaned)){    ### for each observation this for loop will iterate through
    min_dist = Inf   ### needs to be the largest value possible 
      for(j in 1:nrow(picked_center)){  ### for each observation we need to check the distance against each of the 3 centers (K)
        cDist <- Distance_data(df_cleaned[i, ], picked_center[j, ])  ### create a list with the distance of the 
          if(cDist < min_dist){                                        ### observation from each center
            min_dist = cDist ### minimum distance updated with newest shortest distance 
            cluster[i] = j ### if the value is shorter than the previous iteration then the cluster is updated 
          } 
      }
  }

  ### loop over all clustered points and get an average for new clusters
  
  average_center_x = c(0) 
  average_center_y = c(0)

  for(i in 1:nrow(picked_center)){ ### For each observation sorted by each cluster
    average_center_x = mean(df_cleaned[which(cluster==i), 1]) ### Calculates the mean of all the x values for each cluster
    average_center_y = mean(df_cleaned[which(cluster==i), 2]) ### Calculates the mean of all the y values for each cluster
    picked_center[i, ] = c(average_center_x, average_center_y) ### updates each center with it's new x and y values 
  }
  
  ### counts the number of values that are not in the same cluster as the prior iteration, if the value is 0 then the centres can no longer move
  cluster_similarity = sum(cluster_old != cluster) 
}

### plot results of clustering algorithm

col_X = c("red", "blue", "green")

plot(df_cleaned[ , 1], df_cleaned[, 2], col = col_X[cluster], xlab = "Sepal Length", ylab = "Petal Length") + #### scatter plot of data frame split by cluster showing cluster
  points(picked_center, pch = 16)
plot(df_cleaned[ , 1], df_cleaned[, 2], col = col_X[df$Species], xlab = "Sepal Length", ylab = "Petal Length") #### scatter plot of data frame split by species

### calculate my errors, compare against original

table(df$Species, cluster)
table(df$Species)
table(cluster)

### cross-validation - choose different starting points for the centers, testing and training data
