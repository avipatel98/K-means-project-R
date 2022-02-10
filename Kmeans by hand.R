rm(list = ls())  ### deletes all the data in my environment

df <- iris
df <- na.omit(df)   ### remove any incomplete observations


### try finding the optimum number of clusters using elbow method

### clean my data to only have the 2 variables i want

df_cleaned <- select(df, Sepal.Length, Petal.Length) ### only want variables for length of sepal and petal
df_cleaned <- scale(df_cleaned)  ### scales all the values so they contribute evenly to the kmeans algorithm


### assigning a center

picked_center = df_cleaned[1:3, ]  ### I wanted the first three rows and all of the data in the columns for those rows

### calculate the distance from each center for each data point
### create a function with two inputs that calculates the distance between each data point
Distance_data = function(d1, d2){ 
  return((d1[1] - d2[1])^2 + (d1[2] - d2[2])^2)  
}

### loop over all the data points
cluster = c(0) * nrow(df_cleaned)
cluster_old = c(0) * nrow(df_cleaned) ### stores a list of the clusters for each value
cluster_similarity = Inf   ### the value needs to be greater than 0

### create a while loop that cycles through each center and point in the data frame that updates the centers each loop until the centers no longer move and the cluster groups are the same as the previous itteration

while (cluster_similarity > 0) {

  ### 
  
cluster_old = cluster
for(i in 1:nrow(df_cleaned)){
  min_dist = Inf
  for(j in 1:nrow(picked_center)){
    cDist <- Distance_data(df_cleaned[i, ], picked_center[j, ])
    if(cDist < min_dist){
      min_dist = cDist
      cluster[i] = j
    } 
      
  }
  
}

### loop over all clustered points and get an average for new clusters

average_center_x = c(0) 
average_center_y = c(0)


for(i in 1:nrow(picked_center)){
  average_center_x = mean(df_cleaned[which(cluster==i), 1])
  average_center_y = mean(df_cleaned[which(cluster==i), 2])
  picked_center[i, ] = c(average_center_x, average_center_y) 
}  
cluster_similarity = sum(cluster_old != cluster) ### counts the number of values that are not in the same cluster as the prior iteration
}

### plot results of clustering algorithm

col_X = c("red", "blue", "green")

plot(df_cleaned[ , 1], df_cleaned[, 2], col = col_X[cluster], xlab = "Sepal Length", ylab = "Petal Length") + #### scatter plot of data frame split by cluster showing cluster
  points(picked_center, pch = 16)
plot(df_cleaned[ , 1], df_cleaned[, 2], col = col_X[df$Species], xlab = "Sepal Length", ylab = "Petal Length") #### scatter plot of data frame split by species

### calculate my errors, compare against original

base::table(row.names(df$Species), cluster)
table(df$Species)
table(cluster)
### crossvalidation - choose different starting points for the centers, testing and training data
