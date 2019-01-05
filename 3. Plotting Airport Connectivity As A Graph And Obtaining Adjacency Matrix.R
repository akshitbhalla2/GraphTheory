#install.packages("igraph")
library("igraph")

#Defining Basic Graph
size <- 7
edges <- c(1, 2, 1, 3, 1, 5, 1, 6, 1, 7,
           2, 5, 2, 7,
           3, 4, 3, 5, 3, 6,
           4, 5, 4, 6,
           5, 6,
           6, 7)
my.graph <- graph(edges, n = size, directed = FALSE)
plot(my.graph)

#Giving weightage to each edge
g.weights <- c(580,
               2878,
               10003,
               9928,
               6222,
               10562,
               5767,
               1206,
               7490,
               7250,
               6313,
               6104,
               444,
               8210)
E(my.graph)$weights <- g.weights
plot(my.graph, edge.label = g.weights)

#Constructing adjacency/cost matrix
MyMatrix <-
  matrix(get.adjacency(my.graph, attr = "weights"), size, size)
for (i in 1:size) {
  for (j in 1:size) {
    if (MyMatrix[i, j] == 0)
      MyMatrix[i, j] <- Inf
  }
}
MyMatrix