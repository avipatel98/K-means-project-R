### iris data set for k means clustering
### 1. make a randomizer to select half the data points for training data
### 2. make a clustering model to determine what species a plant is based on the values of the leaf lengths
### 3. test the test data to determine if the model can correctly identify the plant specie

df <- iris
pairs(~Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, data = df, main = "Iris matrix", col = df$Species)### make a matrix to see what factors show correlation
#df <- df[, -5]
df.values_scaled <- select(df, Sepal.Length, Petal.Length)
df.values_scaled <- scale(df.values_scaled)

### 1.
### to cross validate the data we need to split the data set randomly into training data and testing data and see how effective it is on any number of combinations

#picked = sample(nrow(df), 50) ### takes a random sample of 50 rows from the data frame and stores into a training data set
#train_sample = df[picked,] 
#test_sample = df[-picked,] ### assigns unpicked rows to the test data set
#train_sample
#test_sample

### 2.

### creat scatter plot to visualise iris data set to see how it may cluster the data
### change shape and color for each different specie and plot graph of sepal length against petal length
ggplot(df, aes(x=Sepal.Length, y=Petal.Length, color=Species, shape=Species)) +
  geom_point()
ggplot(df, aes(x=Sepal.Width, y=Petal.Width, color=Species, shape=Species)) +
  geom_point()
ggplot(df, aes(x=Petal.Length, y=Petal.Width, color=Species, shape=Species)) +
  geom_point()
ggplot(df, aes(x=Sepal.Width, y=Sepal.Length, color=Species, shape=Species)) +
  geom_point()

### Cluster algorithm 
df.values <- df[1:4] ### remove the column of species to allow k-means to run
df.values
iris_kmean <- kmeans(df.values, centers = 3, iter.max = 15, nstart = 4) ### calculate kmeans using built in R function on all values

iris_clust <- 0
iris_clust$cluster <- as.numeric(iris_kmean$cluster)
iris_clust
iris_kmean$centers
ggplot(df, aes(x=Petal.Length, y=Petal.Width, color=, shape=Species)) +
  geom_point() ### trying to plot the kmeans clustering result
col_X = c("red", "blue", "green")
ggplot(df, aes(x=Sepal.Length, y=Petal.Length, color = col_X[iris_clust$cluster])) +
  geom_point()
table(df$Species, iris_clust$cluster) ###show which points are in which cluster based on species
table(df$Species) ### showing the original number of data points per species
col_X[iris_clust$cluster]

kmean.df <- eclust(df, "kmeans", k = 3, nstart = 25, graph = FALSE)

fviz_cluster(kmean.df, geom = "point", ellipse.type = "norm", palette = "jco", ggtheme = theme_minimal())


iris_kmean_scaled <- kmeans(df.values_scaled, centers = 3, iter.max = 15, nstart = 4)
iris_clust_scaled <- 0
iris_clust_scaled <- as.numeric(iris_kmean_scaled$cluster)
ggplot(df, aes(x=Sepal.Length, y=Petal.Length, color = col_X[iris_clust_scaled])) +
  geom_point()
